// File: Aslan/ViewModels/UserViewModel.swift

import FirebaseAuth
import FirebaseDatabase
import Foundation

class UserViewModel: ObservableObject {
    // ... (SEMUA @Published properties ANDA TETAP SAMA, TIDAK PERLU DIUBAH) ...
    @Published var onboardingLanguage: String?
    @Published var onboardingLevel: String?
    @Published var onboardingReason: String?
    @Published var onboardingUsername: String = ""
    @Published var currentUsername: String?
    @Published var currentLanguagePreference: String?
    @Published var currentEmail: String?
    @Published var isSavingOnboardingData: Bool = false
    @Published var onboardingDataSaveError: String?
    @Published var didCompleteOnboarding: Bool = false
    @Published var isLoadingProfile: Bool = false
    @Published var isUserLoggedIn: Bool = false
    @Published var directToLogin: Bool = false
    @Published var navigateToJapaneseMain: Bool = false
    @Published var navigateToKoreanMain: Bool = false
    @Published var navigateToChineseMain: Bool = false
    @Published var determinedInitialView: Bool = false
    @Published var needsOnboarding: Bool = true

    private var dbRef: DatabaseReference!

    init() {
        self.dbRef = Database.database().reference()

        self.isUserLoggedIn = false
        self.determinedInitialView = true
        self.needsOnboarding = true

        print(
            "UserViewModel init: Initialized in a logged-out state. App will start from Landing Page."
        )
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.resetOnboardingDataForNewUser()
                self.isUserLoggedIn = false
                self.directToLogin = true
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                print("User logged out successfully. Directing to login page.")
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func saveUserOnboardingChoices() {
        guard let currentUser = Auth.auth().currentUser else {
            self.onboardingDataSaveError =
                "User not authenticated. Cannot save data."
            self.isSavingOnboardingData = false
            return
        }
        let userID = currentUser.uid

        guard
            !onboardingUsername.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        else {
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
            "onboardingCompletedTimestamp": ServerValue.timestamp(),
        ]

        isSavingOnboardingData = true
        onboardingDataSaveError = nil
        didCompleteOnboarding = false

        dbRef.child("users").child(userID).child("profileDetails").setValue(
            userData
        ) { error, _ in
            DispatchQueue.main.async {
                self.isSavingOnboardingData = false
                if let error = error {
                    self.onboardingDataSaveError =
                        "Failed to save details: \(error.localizedDescription)"
                } else {
                    print("User onboarding details saved successfully!")
                    self.currentUsername = self.onboardingUsername
                    self.currentEmail = currentUser.email
                    self.currentLanguagePreference = self.onboardingLanguage
                    UserDefaults.standard.set(
                        true, forKey: "hasCompletedOnboarding_\(userID)")
                    self.needsOnboarding = false
                    self.didCompleteOnboarding = true
                }
            }
        }
    }

    // --- FUNGSI YANG DIPERBAIKI ---
    func fetchUserProfile() {
        guard let currentUser = Auth.auth().currentUser else {
            self.needsOnboarding = true
            self.determinedInitialView = true
            self.isUserLoggedIn = false
            self.directToLogin = false
            print(
                "fetchUserProfile: No current user. Needs onboarding set to true."
            )
            return
        }
        let userID = currentUser.uid

        guard !isLoadingProfile else {
            print(
                "fetchUserProfile: Already loading profile for user \(userID).")
            return
        }

        isLoadingProfile = true
        onboardingDataSaveError = nil
        resetSpecificNavigationStates()
        self.determinedInitialView = false

        print("fetchUserProfile: Fetching profile for user \(userID)...")
        dbRef.child("users").child(userID).child("profileDetails")
            .observeSingleEvent(of: .value) { snapshot in
                DispatchQueue.main.async {
                    self.isLoadingProfile = false
                    if snapshot.exists(),
                        let value = snapshot.value as? [String: Any]
                    {
                        self.currentUsername =
                            value["username"] as? String ?? ""
                        self.currentLanguagePreference =
                            value["languagePreference"] as? String
                        self.currentEmail =
                            value["email"] as? String ?? currentUser.email
                        self.onboardingLevel =
                            value["proficiencyLevel"] as? String

                        print(
                            "User profile fetched: Lang=\(self.currentLanguagePreference ?? "N/A")"
                        )

                        if let lang = self.currentLanguagePreference,
                            !lang.isEmpty, lang != "Not set"
                        {
                            self.needsOnboarding = false
                            // JANGAN atur isUserLoggedIn di sini untuk menghindari race condition.
                            // Biarkan LoginPageView yang melakukan navigasi terlebih dahulu.
                            self.directToLogin = false
                            print(
                                "User \(userID) has a valid language preference. Onboarding NOT needed. Setting navigation flag."
                            )
                            self
                                .determineMainPageNavigationBasedOnStoredLanguage()
                        } else {
                            self.needsOnboarding = true
                            print(
                                "User \(userID) needs to set a language. Onboarding needed."
                            )
                        }
                    } else {
                        self.needsOnboarding = true
                        self.directToLogin = false
                        print(
                            "Profile details not found for user \(userID). Needs onboarding."
                        )
                    }
                    self.determinedInitialView = true
                }
            } withCancel: { error in
                DispatchQueue.main.async {
                    self.isLoadingProfile = false
                    self.onboardingDataSaveError =
                        "Failed to fetch profile: \(error.localizedDescription)"
                    self.needsOnboarding = true
                    self.determinedInitialView = true
                    self.isUserLoggedIn = false
                    self.directToLogin = false
                    print(
                        "Firebase fetch profile error: \(error.localizedDescription)"
                    )
                }
            }
    }

    func determineMainPageNavigationBasedOnStoredLanguage() {
        resetSpecificNavigationStates()

        if self.needsOnboarding {
            print(
                "UserViewModel determineMainPageNavigation: Needs onboarding is true. No language page navigation will be set."
            )
            return
        }

        let languageToUse =
            self.currentLanguagePreference ?? self.onboardingLanguage

        guard let language = languageToUse, !language.isEmpty,
            language != "Not set"
        else {
            print(
                "UserViewModel determineMainPageNavigation: Language is nil, but needsOnboarding is false. Forcing needsOnboarding."
            )
            self.needsOnboarding = true
            self.isUserLoggedIn = false
            return
        }

        print(
            "UserViewModel determineMainPageNavigation: Setting navigation for language: \(language)"
        )
        switch language {
        case "Japan":
            self.navigateToJapaneseMain = true
        case "Korea":
            self.navigateToKoreanMain = true
        case "China":
            self.navigateToChineseMain = true
        default:
            print(
                "UserViewModel determineMainPageNavigation: Unknown language '\(language)'. Setting needsOnboarding to true."
            )
            self.needsOnboarding = true
            self.isUserLoggedIn = false
        }
    }

    func resetSpecificNavigationStates() {
        navigateToJapaneseMain = false
        navigateToKoreanMain = false
        navigateToChineseMain = false
        print("UserViewModel: Language navigation flags reset.")
    }

    func resetOnboardingDataForNewUser() {
        onboardingLanguage = nil
        onboardingLevel = nil
        onboardingReason = nil
        onboardingUsername = ""
        currentUsername = nil
        currentLanguagePreference = nil
        currentEmail = Auth.auth().currentUser?.email

        isSavingOnboardingData = false
        onboardingDataSaveError = nil
        didCompleteOnboarding = false

        resetSpecificNavigationStates()

        isLoadingProfile = false
        needsOnboarding = true

        if Auth.auth().currentUser == nil {
            determinedInitialView = true
            isUserLoggedIn = false
        } else {
            determinedInitialView = false
        }

        print(
            "UserViewModel: Onboarding data reset. needsOnboarding: \(self.needsOnboarding), determinedInitialView: \(self.determinedInitialView)"
        )
    }
}
