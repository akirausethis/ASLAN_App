// Aslan/AslanApp.swift

import SwiftUI
import FirebaseCore

// AppDelegate untuk inisialisasi Firebase sudah benar, kita pertahankan.
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct AslanApp: App {
    // Menggunakan AppDelegate untuk Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Inisialisasi semua ViewModel di sini sebagai "source of truth"
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var progressViewModel = ProgressViewModel()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            // Memanggil ContentView dan menyuntikkan ViewModel ke environment
            // agar semua child view bisa mengaksesnya.
            ContentView()
                .environmentObject(userViewModel)
                .environmentObject(progressViewModel)
                .environmentObject(themeManager)
                .accentColor(themeManager.accentColor)
        }
    }
}
