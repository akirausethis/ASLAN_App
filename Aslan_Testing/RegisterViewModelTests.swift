//
//  RegisterViewModelTests.swift
//  Aslan_Testing
//
//  Created by student on 12/06/25.
//

// Aslan_Testing/RegisterViewModelTests.swift

import XCTest
@testable import Aslan

final class RegisterViewModelTests: XCTestCase {

    var viewModel: RegisterPageViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RegisterPageViewModel()
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
        XCTAssertFalse(viewModel.didRegisterSuccessfully)
    }

    func testValidation_EmptyFields() {
        viewModel.validateAndRegister()
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Email and Password are required!")
        XCTAssertFalse(viewModel.didRegisterSuccessfully)
    }

    func testValidation_InvalidEmail() {
        viewModel.email = "invalid-email"
        viewModel.password = "password123"
        viewModel.validateAndRegister()
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Invalid email format.")
        XCTAssertFalse(viewModel.didRegisterSuccessfully)
    }

    func testValidation_PasswordTooShort() {
        viewModel.email = "test@example.com"
        viewModel.password = "12345"
        viewModel.validateAndRegister()
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Password must be at least 6 characters long.")
        XCTAssertFalse(viewModel.didRegisterSuccessfully)
    }
}
