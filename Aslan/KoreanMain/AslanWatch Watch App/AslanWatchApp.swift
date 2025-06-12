//
//  AslanWatchApp.swift
//  AslanWatch Watch App
//
//  Created by student on 03/06/25.
//

import SwiftUI

// Ini adalah entry point HANYA untuk aplikasi watchOS Anda.
// Pastikan file ini HANYA menjadi bagian dari target watchOS App.
struct AslanWatch_Watch_AppApp: App { // Nama struct bisa disesuaikan
    var body: some Scene {
        WindowGroup {
            // View awal untuk aplikasi watchOS Anda
            WatchOSKoreanMainMenuView()
        }
    }
}
