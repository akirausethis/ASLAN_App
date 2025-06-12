//
//  ThemeManagerTests.swift
//  Aslan_Testing
//
//  Created by student on 12/06/25.
//

// Aslan_Testing/ThemeManagerTests.swift

import XCTest
import SwiftUI
@testable import Aslan

final class ThemeManagerTests: XCTestCase {

    var themeManager: ThemeManager!
    let userDefaultsKey = "app_accent_color_name"

    override func setUp() {
        super.setUp()
        // Hapus semua user defaults sebelum setiap tes untuk memastikan lingkungan yang bersih
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        themeManager = ThemeManager()
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        themeManager = nil
        super.tearDown()
    }

    func testInitialColorIsDefaultBlue() {
        // Ketika tidak ada yang disimpan di UserDefaults, warna harus default biru.
        XCTAssertEqual(themeManager.accentColor, .blue, "Initial accent color should be Color.blue")
    }

    func testSetAccentColor_ChangesPublishedColor() {
        // Given
        guard let greenTheme = themeManager.themes.first(where: { $0.name == "Vibrant Green" }) else {
            XCTFail("Green theme not found")
            return
        }
        
        // When
        themeManager.setAccentColor(to: greenTheme)
        
        // Then
        XCTAssertEqual(themeManager.accentColor, greenTheme.color, "Accent color should be updated to green.")
    }

    func testSetAccentColor_SavesToUserDefaults() {
        // Given
        guard let purpleTheme = themeManager.themes.first(where: { $0.name == "Royal Purple" }) else {
            XCTFail("Purple theme not found")
            return
        }
        
        // When
        themeManager.setAccentColor(to: purpleTheme)
        
        // Then
        let savedName = UserDefaults.standard.string(forKey: userDefaultsKey)
        XCTAssertEqual(savedName, "Royal Purple", "The name of the new theme should be saved to UserDefaults.")
    }

    func testLoadAccentColor_LoadsSavedColorOnNextInit() {
        // Given: Simpan tema oranye
        let orangeTheme = themeManager.themes.first { $0.name == "Sunny Orange" }!
        themeManager.setAccentColor(to: orangeTheme)
        
        // When: Buat instance ThemeManager baru
        let newThemeManager = ThemeManager()
        
        // Then: Instance baru harus memuat warna oranye
        XCTAssertEqual(newThemeManager.accentColor, orangeTheme.color, "New instance should load the saved orange color from UserDefaults.")
    }
}
