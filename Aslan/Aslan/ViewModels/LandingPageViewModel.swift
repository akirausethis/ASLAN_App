//
//  LandingPageViewModel.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// File: ViewModels/LandingPageViewModel.swift

import SwiftUI
import FirebaseAuth // <-- TAMBAHKAN

class LandingPageViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    // showForm mungkin tidak lagi relevan untuk logika navigasi utama
    // @Published var showForm: Bool = false
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        print("LandingPageViewModel: Initializing and setting up auth state listener.")
        // Set listener saat ViewModel diinisialisasi
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            DispatchQueue.main.async { // Pastikan update UI di main thread
                let isLoggedIn = (user != nil)
                if self?.isUserLoggedIn != isLoggedIn { // Hanya update jika ada perubahan
                    self?.isUserLoggedIn = isLoggedIn
                }
                print("LandingPageViewModel (Auth Listener): User logged in state changed to: \(self?.isUserLoggedIn ?? false)")
                
                // Update juga UserDefaults jika Anda masih ingin menggunakannya di tempat lain,
                // atau untuk persistensi sederhana antar sesi aplikasi.
                UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn_firebase_auth") // Gunakan key berbeda atau sama
            }
        }
    }

    // Fungsi checkUserLoginStatus dari UserDefaults bisa jadi fallback jika listener belum sempat jalan,
    // atau dihapus jika kita sepenuhnya mengandalkan listener Auth.
    // Namun, listener Auth di init() seharusnya sudah cukup.
    func checkUserLoginStatusFromUserDefaults() {
        let statusFromDefaults = UserDefaults.standard.bool(forKey: "isLoggedIn_firebase_auth")
        // Ini bisa dipanggil di onAppear View jika ingin ada pengecekan awal tambahan
        // tapi listener Auth seharusnya lebih diutamakan.
        if !self.isUserLoggedIn && statusFromDefaults && authStateDidChangeListenerHandle == nil { // Hanya jika listener belum ada & status berbeda
            // self.isUserLoggedIn = statusFromDefaults // Mungkin tidak perlu jika listener sudah berjalan
        }
        print("LandingPageViewModel: User Logged In Status from UserDefaults (checkUserLoginStatusFromUserDefaults): \(statusFromDefaults)")
    }
    
    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            print("LandingPageViewModel: Auth state listener removed on deinit.")
        }
    }
}
