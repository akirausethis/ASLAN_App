//
//  UserViewModel.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

// File: UserViewModel.swift (atau nama yang Anda preferensikan)

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var chosenLanguage: String?
    @Published var chosenLevel: String?
    @Published var chosenReason: String?
    @Published var username: String = ""

    @Published var isSavingOnboardingData: Bool = false
    @Published var onboardingDataSaveError: String?
    @Published var didCompleteOnboarding: Bool = false

    private var dbRef: DatabaseReference!

    init() {
        dbRef = Database.database().reference()
    }

    func saveUserOnboardingChoices() {
        guard let currentUser = Auth.auth().currentUser else {
            // Pengguna tidak terautentikasi, ini seharusnya tidak terjadi jika alur registrasi/login sudah benar
            self.onboardingDataSaveError = "User not authenticated. Cannot save data."
            print("Error: Current user is nil when trying to save onboarding choices.")
            return
        }
        let userID = currentUser.uid

        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.onboardingDataSaveError = "Username cannot be empty."
            return
        }

        let userData: [String: Any] = [
            "username": username,
            "languagePreference": chosenLanguage ?? "Not set",
            "proficiencyLevel": chosenLevel ?? "Not set",
            "learningReason": chosenReason ?? "Not set",
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
                    print("Firebase save error: \(error.localizedDescription)")
                } else {
                    print("User onboarding details saved successfully to Firebase!")
                    self.didCompleteOnboarding = true

                }
            }
        }
    }

    func resetOnboardingData() {
        chosenLanguage = nil
        chosenLevel = nil
        chosenReason = nil
        isSavingOnboardingData = false
        onboardingDataSaveError = nil
        didCompleteOnboarding = false
    }
}
