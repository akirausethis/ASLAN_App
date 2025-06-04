// AslanApp/AslanAppApp.swift
import SwiftUI
import FirebaseCore // Tambahkan ini

@main
struct AslanAppApp: App {
    @StateObject var progressViewModel = ProgressViewModel() // Buat instance di sini

    init() { // Tambahkan init ini
        FirebaseApp.configure()
        print("Firebase configured.")
    }

    var body: some Scene {
        WindowGroup {
            ContentView() //
                .environmentObject(progressViewModel) // Suntikkan ke environment
        }
    }
}
