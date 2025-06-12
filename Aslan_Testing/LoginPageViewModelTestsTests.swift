//
//  LoginPageViewModelTestsTests.swift
//  Aslan_Testing
//
//  Created by student on 12/06/25.
//

// Aslan_Testing/LoginPageViewModelTests.swift

import XCTest
@testable import Aslan

// Nama kelas diganti agar tidak bentrok dengan file lain
final class LoginPageViewModelTests: XCTestCase {

    var viewModel: LoginPageViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginPageViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "")
        XCTAssertFalse(viewModel.didLoginSuccessfully)
    }

    func testValidation_EmptyFields() {
        viewModel.validateAndLogin()
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Email and Password are required!")
        XCTAssertFalse(viewModel.didLoginSuccessfully)
    }
    
    func testValidation_EmptyPassword() {
        viewModel.email = "test@example.com"
        viewModel.validateAndLogin()
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Email and Password are required!")
        XCTAssertFalse(viewModel.didLoginSuccessfully)
    }
}
