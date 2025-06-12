// Aslan_Testing/ProgressViewModelTests.swift

import XCTest
@testable import Aslan

final class ProgressViewModelTests: XCTestCase {

    var viewModel: ProgressViewModel!

    // Ditambahkan: Panggil FirebaseTestHelper.configure() sebelum semua tes di kelas ini berjalan
    override class func setUp() {
        super.setUp()
        FirebaseTestHelper.configure()
    }

    override func setUp() {
        super.setUp()
        viewModel = ProgressViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testProcessEmptyIdentifiers() {
        viewModel.processCompletedIdentifiers([])
        XCTAssertEqual(viewModel.totalCompletedCount, 0)
        XCTAssertTrue(viewModel.completedCourseItems.isEmpty)
        XCTAssertEqual(viewModel.progressPercentage, 0.0)
        XCTAssertEqual(viewModel.lastCourseName, "Start a course!")
    }
}
