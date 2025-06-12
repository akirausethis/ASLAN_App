//
//  ChatbotViewModelTests.swift
//  Aslan_Testing
//
//  Created by student on 12/06/25.
//

// Aslan_Testing/ChatbotViewModelTests.swift

import XCTest
@testable import Aslan

final class ChatbotViewModelTests: XCTestCase {

    var viewModel: ChatbotViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ChatbotViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialMessage() {
        XCTAssertEqual(viewModel.messages.count, 1)
        XCTAssertEqual(viewModel.messages.first?.sender, .bot)
        XCTAssertTrue(viewModel.messages.first?.text.contains("Hello! I'm AslanBot") ?? false)
    }

    func testSendMessage_AddsUserMessage() {
        let initialCount = viewModel.messages.count
        let testMessage = "Hello Bot"
        
        viewModel.sendMessage(testMessage)
        
        XCTAssertEqual(viewModel.messages.count, initialCount + 1)
        XCTAssertEqual(viewModel.messages.last?.text, testMessage)
        XCTAssertEqual(viewModel.messages.last?.sender, .user)
    }

    func testCustomerServiceResponse() {
        let expectation = XCTestExpectation(description: "Wait for bot response")
        
        viewModel.sendMessage("What is progress?")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertEqual(self.viewModel.messages.count, 3)
            XCTAssertEqual(self.viewModel.messages.last?.sender, .bot)
            XCTAssertTrue(self.viewModel.messages.last?.text.contains("Progress") ?? false)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testTranslationCommand_InvalidFormat() {
        let initialCount = viewModel.messages.count
        viewModel.sendMessage("translate hello") // Invalid format
        
        XCTAssertEqual(viewModel.messages.count, initialCount + 2)
        XCTAssertEqual(viewModel.messages.last?.sender, .bot)
        XCTAssertTrue(viewModel.messages.last?.text.contains("didn't understand") ?? false)
    }
}
