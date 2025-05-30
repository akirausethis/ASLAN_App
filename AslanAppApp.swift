// AslanApp/AslanAppApp.swift
import SwiftUI

@main
struct AslanAppApp: App {
    @StateObject var progressViewModel = ProgressViewModel() // Buat instance di sini

    var body: some Scene {
        WindowGroup {
            ContentView() //
                .environmentObject(progressViewModel) // Suntikkan ke environment
        }
    }
}
