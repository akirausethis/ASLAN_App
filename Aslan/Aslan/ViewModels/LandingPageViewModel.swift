//
//  LandingPageViewModel.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// LandingPageViewModel.swift

import SwiftUI
import FirebaseAuth

class LandingPageViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        print("LandingPageViewModel: Initializing and setting up auth state listener.")
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            DispatchQueue.main.async {
                let isLoggedIn = (user != nil)
                // Hanya update jika ada perubahan status untuk menghindari pembaruan UI yang tidak perlu
                if self?.isUserLoggedIn != isLoggedIn {
                    self?.isUserLoggedIn = isLoggedIn
                }
                print("LandingPageViewModel (Auth Listener): User logged in state changed to: \(self?.isUserLoggedIn ?? false)")
                
                // Untuk debugging, kita komentari sementara interaksi UserDefaults
                // UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn_firebase_auth")
            }
        }
    }
    
    func checkUserLoginStatusFromUserDefaults_fallback() {
        // Untuk debugging, fungsi ini tidak akan melakukan apa-apa
        // agar kita hanya bergantung pada Firebase Auth listener.
        print("LandingPageViewModel: UserDefaults fallback SKIPPED for debugging.")
        // if authStateDidChangeListenerHandle == nil {
        //     self.isUserLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn_firebase_auth")
        //     print("LandingPageViewModel: Used UserDefaults as fallback. User logged in: \(self.isUserLoggedIn)")
        // }
    }
    
    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            print("LandingPageViewModel: Auth state listener removed on deinit.")
        }
    }
}
