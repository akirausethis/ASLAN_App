//
//  LandingPageViewModelTests.swift
//  Aslan_Testing
//
//  Created by student on 12/06/25.
//

// Aslan_Testing/LandingPageViewModelTests.swift

import XCTest
@testable import Aslan

final class LandingPageViewModelTests: XCTestCase {

    var viewModel: LandingPageViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LandingPageViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertFalse(viewModel.showForm)
    }

    func testStartLearning() {
        viewModel.startLearning()
        XCTAssertTrue(viewModel.showForm)
    }
}
