//
//  AslanAppApp.swift
//  AslanApp
//
//  Created by student on 22/05/25.
//

import SwiftUI

// Ini adalah entry point HANYA untuk aplikasi iOS Anda.
// Pastikan file ini HANYA menjadi bagian dari target iOS App.
@main
struct AslanAppApp: App {
    var body: some Scene {
        WindowGroup {
            // View awal untuk aplikasi iOS Anda
            KoreanMainPageView() // Atau ContentView(), atau view utama iOS Anda
        }
    }
}
