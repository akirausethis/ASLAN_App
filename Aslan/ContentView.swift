// File: Aslan/ContentView.swift

import SwiftUI

struct ContentView: View {
    // MARK: - PERUBAHAN: Gunakan EnvironmentObject
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        // MARK: - Logika untuk menampilkan view berdasarkan status login
        // Jika pengguna sudah login, tampilkan halaman utama (AnimatedNavbar).
        // Jika tidak, tampilkan alur login/register (LandingPageView).
        if userViewModel.isUserLoggedIn {
            // Tampilkan halaman utama aplikasi setelah login berhasil.
            // AnimatedNavbar adalah root view untuk pengguna yang sudah login.
            AnimatedNavbar(userViewModel: userViewModel)
                .transition(.asymmetric(insertion: .opacity, removal: .opacity)) // Animasi transisi
        } else {
            // Jika pengguna baru saja logout, arahkan langsung ke halaman Login.
            // Jika tidak (misalnya saat pertama kali membuka aplikasi), mulai dari Landing Page.
            NavigationView {
                if userViewModel.directToLogin {
                    LoginPageView()
                } else {
                    LandingPageView()
                }
            }
            .navigationViewStyle(.stack)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity)) // Animasi transisi
        }
    }
}

#Preview {
    // MARK: - Update preview untuk menangani kedua kondisi
    let loggedInViewModel = UserViewModel()
    loggedInViewModel.isUserLoggedIn = true
    loggedInViewModel.currentUsername = "Preview User"
    loggedInViewModel.onboardingLevel = "Beginner"
    
    let loggedOutViewModel = UserViewModel()
    loggedOutViewModel.isUserLoggedIn = false

    return Group {
        ContentView()
            .environmentObject(loggedInViewModel) // Preview untuk kondisi login
            .environmentObject(ProgressViewModel())
            .environmentObject(ThemeManager())
            .previewDisplayName("Logged In")

        ContentView()
            .environmentObject(loggedOutViewModel) // Preview untuk kondisi logout
            .environmentObject(ProgressViewModel())
            .environmentObject(ThemeManager())
            .previewDisplayName("Logged Out")
    }
}
