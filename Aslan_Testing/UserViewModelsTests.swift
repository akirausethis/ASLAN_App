// Aslan_Testing/UserViewModelsTests.swift

import XCTest
@testable import Aslan

final class UserViewModelTests: XCTestCase {

    var viewModel: UserViewModel!

    // Ditambahkan: Panggil FirebaseTestHelper.configure() sebelum semua tes di kelas ini berjalan
    override class func setUp() {
        super.setUp()
        FirebaseTestHelper.configure()
    }

    override func setUp() {
        super.setUp()
        viewModel = UserViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialStateIsLoggedOut() {
        XCTAssertFalse(viewModel.isUserLoggedIn, "UserViewModel should initialize as logged out.")
        XCTAssertTrue(viewModel.needsOnboarding, "A new UserViewModel should require onboarding.")
        XCTAssertTrue(viewModel.determinedInitialView, "Initial view determination should be true at start.")
    }
    
    func testDetermineNavigationBasedOnLanguage() {
        // Given: A user who has completed onboarding and chosen Korean
        viewModel.needsOnboarding = false
        viewModel.currentLanguagePreference = "Korea"
        
        // When: Determining the main page
        viewModel.determineMainPageNavigationBasedOnStoredLanguage()
        
        // Then: The flag for the Korean main page should be true
        XCTAssertTrue(viewModel.navigateToKoreanMain, "Should navigate to Korean main page.")
        XCTAssertFalse(viewModel.navigateToJapaneseMain, "Should not navigate to Japanese page.")
        XCTAssertFalse(viewModel.navigateToChineseMain, "Should not navigate to Chinese page.")
    }
    
    func testDetermineNavigationForUnknownLanguage() {
        // Given: A user with an unknown language preference
        viewModel.needsOnboarding = false
        viewModel.currentLanguagePreference = "Klingon"
        
        // When: Determining the main page
        viewModel.determineMainPageNavigationBasedOnStoredLanguage()
        
        // Then: The user should be sent back to onboarding
        XCTAssertTrue(viewModel.needsOnboarding, "Should force onboarding for unknown language.")
        XCTAssertFalse(viewModel.isUserLoggedIn, "User should be considered logged out if language is invalid.")
    }
}
