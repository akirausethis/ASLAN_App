//
//  UserViewModel.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserViewModel: ObservableObject {
    // Properti untuk input selama onboarding
    @Published var onboardingLanguage: String?
    @Published var onboardingLevel: String?
    @Published var onboardingReason: String?
    @Published var onboardingUsername: String = ""

    // Properti untuk menyimpan data profil yang sudah ada/diambil dari Firebase
    @Published var currentUsername: String?
    @Published var currentLanguagePreference: String?
    @Published var currentEmail: String?

    // State untuk proses UI
    @Published var isSavingOnboardingData: Bool = false
    @Published var onboardingDataSaveError: String?
    @Published var didCompleteOnboarding: Bool = false // Untuk navigasi dari SetUsernamePageView ke ContinueSetUsernamePageView

    @Published var isLoadingProfile: Bool = false
    // onboardingDataSaveError bisa digunakan juga untuk error saat fetch profile

    // State untuk navigasi ke halaman utama berdasarkan bahasa
    @Published var navigateToJapaneseMain: Bool = false
    @Published var navigateToKoreanMain: Bool = false
    @Published var navigateToChineseMain: Bool = false
    
    // State untuk membantu LandingPage/LoginPage memutuskan alur
    @Published var determinedInitialView: Bool = false // Sudah selesai fetch profile atau gagal
    @Published var needsOnboarding: Bool = true      // Defaultnya true, akan jadi false jika profil ada & lengkap

    private var dbRef: DatabaseReference!

    init() {
        self.dbRef = Database.database().reference()
        if Auth.auth().currentUser == nil {
            self.determinedInitialView = true // Tidak ada user, jadi view awal sudah "ditentukan" (yaitu landing/onboarding)
            self.needsOnboarding = true
            self.navigateToJapaneseMain = false // Reset eksplisit
            self.navigateToKoreanMain = false   // Reset eksplisit
            self.navigateToChineseMain = false  // Reset eksplisit
            self.onboardingLanguage = nil       // Pastikan ini juga nil di awal jika tidak ada user
            self.currentLanguagePreference = nil// Pastikan ini juga nil
            print("UserViewModel init: No active user. States reset. Needs onboarding. Determined initial view.")
        } else {
            self.currentEmail = Auth.auth().currentUser?.email
            self.determinedInitialView = false // Ada user, perlu fetch profil
            self.needsOnboarding = true      // Asumsi awal, akan diupdate setelah fetch
            print("UserViewModel init: Active user found (\(Auth.auth().currentUser?.uid ?? "Unknown")). Awaiting fetchUserProfile to determine status.")
        }
    }

    func saveUserOnboardingChoices() {
        guard let currentUser = Auth.auth().currentUser else {
            self.onboardingDataSaveError = "User not authenticated. Cannot save data."
            self.isSavingOnboardingData = false
            return
        }
        let userID = currentUser.uid

        guard !onboardingUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.onboardingDataSaveError = "Username cannot be empty."
            self.isSavingOnboardingData = false
            return
        }

        let userData: [String: Any] = [
            "username": onboardingUsername,
            "email": currentUser.email ?? "Not set",
            "languagePreference": onboardingLanguage ?? "Not set",
            "proficiencyLevel": onboardingLevel ?? "Not set",
            "learningReason": onboardingReason ?? "Not set",
            "onboardingCompletedTimestamp": ServerValue.timestamp()
        ]

        isSavingOnboardingData = true
        onboardingDataSaveError = nil
        didCompleteOnboarding = false

        dbRef.child("users").child(userID).child("profileDetails").setValue(userData) { error, _ in
            DispatchQueue.main.async {
                self.isSavingOnboardingData = false
                if let error = error {
                    self.onboardingDataSaveError = "Failed to save details: \(error.localizedDescription)"
                } else {
                    print("User onboarding details saved successfully!")
                    self.currentUsername = self.onboardingUsername
                    self.currentLanguagePreference = self.onboardingLanguage
                    // UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding_\(userID)") // Ini mungkin tidak lagi digunakan secara langsung untuk navigasi utama
                    self.needsOnboarding = false // Setelah berhasil menyimpan, onboarding tidak lagi diperlukan
                    self.didCompleteOnboarding = true // Untuk navigasi dari SetUsernamePageView
                }
            }
        }
    }

    func fetchUserProfile() {
        guard let currentUser = Auth.auth().currentUser else {
            // self.onboardingDataSaveError = "User not authenticated for profile fetch." // Tidak perlu set error jika hanya tidak ada user
            self.needsOnboarding = true
            self.determinedInitialView = true // Selesai menentukan (tidak ada user untuk di-fetch)
            print("fetchUserProfile: No current user. Needs onboarding set to true. Determined initial view.")
            return
        }
        let userID = currentUser.uid
        
        guard !isLoadingProfile else {
            print("fetchUserProfile: Already loading profile.")
            return
        }

        isLoadingProfile = true
        onboardingDataSaveError = nil
        resetSpecificNavigationStates()
        self.determinedInitialView = false

        print("fetchUserProfile: Fetching profile for user \(userID)")
        dbRef.child("users").child(userID).child("profileDetails").observeSingleEvent(of: .value) { snapshot in
            DispatchQueue.main.async {
                self.isLoadingProfile = false
                if snapshot.exists(), let value = snapshot.value as? [String: Any] {
                    self.currentUsername = value["username"] as? String ?? ""
                    self.currentLanguagePreference = value["languagePreference"] as? String
                    self.onboardingUsername = self.currentUsername ?? "" // Sinkronkan onboardingUsername dengan currentUsername
                    self.onboardingLanguage = self.currentLanguagePreference // Sinkronkan onboardingLanguage dengan currentLanguagePreference
                    self.onboardingLevel = value["proficiencyLevel"] as? String
                    self.onboardingReason = value["learningReason"] as? String
                    self.currentEmail = value["email"] as? String ?? currentUser.email
                    
                    print("User profile fetched: Lang=\(self.currentLanguagePreference ?? "N/A")")
                    
                    if let language = self.currentLanguagePreference, !language.isEmpty, language != "Not set" {
                         self.needsOnboarding = false
                         print("User \(userID) has a language preference: \(language). Onboarding not needed.")
                    } else {
                        self.needsOnboarding = true
                        print("User \(userID) needs to complete/set language based on fetched profile (no valid language found).")
                    }
                } else {
                    self.needsOnboarding = true
                    print("Profile details not found for user \(userID). Needs onboarding.")
                }
                self.determinedInitialView = true
            }
        } withCancel: { error in
            DispatchQueue.main.async {
                self.isLoadingProfile = false
                self.onboardingDataSaveError = "Failed to fetch profile: \(error.localizedDescription)"
                self.needsOnboarding = true
                self.determinedInitialView = true
                print("Firebase fetch profile error: \(error.localizedDescription)")
            }
        }
    }
    
    func determineMainPageNavigationBasedOnStoredLanguage() {
        resetSpecificNavigationStates()
        
        let languageToUse = self.currentLanguagePreference ?? self.onboardingLanguage
        
        print("UserViewModel determineMainPageNavigation: languageToUse is '\(languageToUse ?? "nil")'")

        guard let language = languageToUse, !language.isEmpty, language != "Not set" else {
            print("UserViewModel determineMainPageNavigation: Cannot determine main page (language nil, empty, or 'Not set'). Setting needsOnboarding to true.")
            self.needsOnboarding = true
            return
        }

        print("UserViewModel determineMainPageNavigation: Determining navigation for language: \(language)")
        
        switch language {
        case "Japan":
            self.navigateToJapaneseMain = true
            self.needsOnboarding = false
        case "Korea":
            self.navigateToKoreanMain = true
            self.needsOnboarding = false
        case "China":
            self.navigateToChineseMain = true
            self.needsOnboarding = false
        default:
            print("UserViewModel determineMainPageNavigation: Unknown language '\(language)'. Defaulting to needsOnboarding.")
            self.needsOnboarding = true
        }
    }
    
    func resetSpecificNavigationStates() {
        navigateToJapaneseMain = false
        navigateToKoreanMain = false
        navigateToChineseMain = false
        print("UserViewModel resetSpecificNavigationStates: Nav flags reset.")
    }

    func resetOnboardingDataForNewUser() {
        onboardingLanguage = nil
        onboardingLevel = nil
        onboardingReason = nil
        onboardingUsername = ""
        currentUsername = nil
        currentLanguagePreference = nil
        currentEmail = nil // Reset email juga untuk state yang benar-benar bersih

        isSavingOnboardingData = false
        onboardingDataSaveError = nil
        didCompleteOnboarding = false
        
        resetSpecificNavigationStates() // Memastikan flag navigasi false
        
        isLoadingProfile = false
        needsOnboarding = true      // Selalu true setelah reset onboarding data
        
        // Atur determinedInitialView berdasarkan status otentikasi SAAT INI setelah reset
        if Auth.auth().currentUser == nil {
            determinedInitialView = true // Tidak ada user, jadi view awal sudah "ditentukan" (yaitu landing/onboarding)
        } else {
            // Jika ada user (misalnya, reset dipanggil saat user masih aktif),
            // maka view awal belum ditentukan karena perlu fetch profil lagi.
            determinedInitialView = false
        }
        
        print("UserViewModel: Onboarding data reset. needsOnboarding: \(self.needsOnboarding), determinedInitialView: \(self.determinedInitialView)")
    }

    func userPassedContinueRegisterPage() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let userID = currentUser.uid
        let statusData: [String: Any] = [ "hasSeenContinueRegisterPage": true, "timestamp": ServerValue.timestamp()]
        dbRef.child("users").child(userID).child("onboardingStatus").child("passedContinueRegister").setValue(statusData)
    }
}
