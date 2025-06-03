//
//  UserViewModel.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

// File: ViewModels/UserViewModel.swift

//
//  UserViewModel.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

// File: ViewModels/UserViewModel.swift

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
        // Penentuan awal di init ini masih penting untuk initial state determinedInitialView
        // Ini memastikan LandingPageView tidak terus menampilkan loading spinner jika tidak ada user
        if Auth.auth().currentUser == nil {
            self.determinedInitialView = true // Tidak perlu fetch jika tidak ada user
            self.needsOnboarding = true // Dan diasumsikan perlu onboarding untuk user baru
            print("UserViewModel init: No active user. Needs onboarding. Determined initial view.")
        } else {
            self.currentEmail = Auth.auth().currentUser?.email
            self.determinedInitialView = false // Perlu fetch untuk user yang ada
            self.needsOnboarding = true // Asumsi perlu onboarding sampai data divalidasi
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
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding_\(userID)") // Ini mungkin tidak lagi digunakan secara langsung untuk navigasi utama
                    self.needsOnboarding = false // Setelah berhasil menyimpan, onboarding tidak lagi diperlukan
                    self.didCompleteOnboarding = true // Untuk navigasi dari SetUsernamePageView
                }
            }
        }
    }

    func fetchUserProfile() {
        guard let currentUser = Auth.auth().currentUser else {
            self.onboardingDataSaveError = "User not authenticated for profile fetch."
            self.needsOnboarding = true
            self.determinedInitialView = true // Selesai menentukan (gagal fetch karena no user)
            print("fetchUserProfile: No current user. Needs onboarding set to true.")
            return
        }
        let userID = currentUser.uid
        
        guard !isLoadingProfile else {
            print("fetchUserProfile: Already loading profile.")
            return
        }

        isLoadingProfile = true
        onboardingDataSaveError = nil
        resetSpecificNavigationStates() // Reset state navigasi *sebelum* fetch baru
        self.determinedInitialView = false // Set false karena proses penentuan ulang akan dimulai

        print("fetchUserProfile: Fetching profile for user \(userID)")
        dbRef.child("users").child(userID).child("profileDetails").observeSingleEvent(of: .value) { snapshot in
            DispatchQueue.main.async {
                self.isLoadingProfile = false
                if snapshot.exists(), let value = snapshot.value as? [String: Any] {
                    self.currentUsername = value["username"] as? String ?? ""
                    self.currentLanguagePreference = value["languagePreference"] as? String
                    self.onboardingUsername = self.currentUsername ?? ""
                    self.onboardingLanguage = self.currentLanguagePreference
                    self.onboardingLevel = value["proficiencyLevel"] as? String
                    self.onboardingReason = value["learningReason"] as? String
                    self.currentEmail = value["email"] as? String ?? currentUser.email
                    
                    print("User profile fetched: Lang=\(self.currentLanguagePreference ?? "N/A")")
                    
                    // Logika penentuan needsOnboarding: Jika tidak ada bahasa yang diset, atau diset sebagai "Not set"
                    if let language = self.currentLanguagePreference, !language.isEmpty, language != "Not set" {
                         self.needsOnboarding = false
                         print("User \(userID) has a language preference: \(language). Onboarding not needed.")
                    } else {
                        self.needsOnboarding = true
                        print("User \(userID) needs to complete/set language based on fetched profile/UserDefaults (no language found).")
                    }
                } else {
                    // Profil tidak ditemukan di DB, anggap perlu onboarding
                    self.needsOnboarding = true
                    print("Profile details not found for user \(userID). Needs onboarding.")
                }
                self.determinedInitialView = true // Tandai proses penentuan selesai
            }
        } withCancel: { error in
            DispatchQueue.main.async {
                self.isLoadingProfile = false
                self.onboardingDataSaveError = "Failed to fetch profile: \(error.localizedDescription)"
                self.needsOnboarding = true
                self.determinedInitialView = true // Tandai proses penentuan selesai (dengan error)
                print("Firebase fetch profile error: \(error.localizedDescription)")
            }
        }
    }
    
    func determineMainPageNavigationBasedOnStoredLanguage() {
        // Fungsi ini sekarang hanya akan mengatur state navigasi internal UserViewModel
        // dan `needsOnboarding`. View akan mengamati perubahan ini.
        resetSpecificNavigationStates()
        
        let languageToUse = self.currentLanguagePreference ?? self.onboardingLanguage
        
        guard let language = languageToUse, !language.isEmpty, language != "Not set" else {
            print("Cannot determine main page: language is nil or 'Not set'. Setting needsOnboarding to true.")
            self.needsOnboarding = true
            return
        }

        print("Determining navigation for language: \(language)")
        
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
            print("Unknown language for navigation: \(language). Defaulting to needsOnboarding.")
            self.needsOnboarding = true // Bahasa tidak dikenal, anggap perlu onboarding lagi
        }
    }
    
    func resetSpecificNavigationStates() {
        // Pastikan semua flag navigasi utama direset
        navigateToJapaneseMain = false
        navigateToKoreanMain = false
        navigateToChineseMain = false
    }

    func resetOnboardingDataForNewUser() {
        onboardingLanguage = nil
        onboardingLevel = nil
        onboardingReason = nil
        onboardingUsername = ""
        currentUsername = nil
        currentLanguagePreference = nil
        currentEmail = Auth.auth().currentUser?.email // Tetap ambil email jika ada

        isSavingOnboardingData = false
        onboardingDataSaveError = nil
        didCompleteOnboarding = false
        
        resetSpecificNavigationStates()
        
        isLoadingProfile = false
        determinedInitialView = false // Kembali ke state belum ditentukan, akan ditentukan lagi oleh init/fetch
        needsOnboarding = true
        
        print("UserViewModel: Onboarding data reset for new user/flow.")
    }

    func userPassedContinueRegisterPage() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let userID = currentUser.uid
        let statusData: [String: Any] = [ "hasSeenContinueRegisterPage": true, "timestamp": ServerValue.timestamp()]
        dbRef.child("users").child(userID).child("onboardingStatus").child("passedContinueRegister").setValue(statusData)
    }
}
