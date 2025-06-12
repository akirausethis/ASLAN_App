// Aslan_Testing/SpeechRecognizerManagerTests.swift
import XCTest
@testable import Aslan
import Speech
import AVFoundation

class SpeechRecognizerManagerTests: XCTestCase {

    var speechManager: SpeechRecognizerManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        speechManager = SpeechRecognizerManager()
    }

    override func tearDownWithError() throws {
        if speechManager.isRecording {
            speechManager.stopRecording()
        }
        speechManager = nil
        try super.tearDownWithError()
    }

    // Tes 1: Verifikasi nilai awal properti.
    func testInitialValues() throws {
        XCTAssertEqual(speechManager.recognizedText, "Press the record button to start.", "recognizedText should have the correct English default value.")
        XCTAssertFalse(speechManager.isRecording, "isRecording should be false initially.")
        XCTAssertNotNil(speechManager.isSpeechRecognitionAuthorized)
        XCTAssertNotNil(speechManager.isMicrophoneAuthorized)
    }

    // Tes 2: Tes logika toggleRecording saat izin belum ada.
    func testToggleRecording_WhenPermissionsNotGranted_ShouldNotStartRecording() throws {
        // Given
        speechManager.isSpeechRecognitionAuthorized = false
        speechManager.isMicrophoneAuthorized = false
        
        // When
        speechManager.toggleRecording()
        
        // Then
        XCTAssertFalse(speechManager.isRecording, "Should not start recording if permissions are not granted.")
        XCTAssertNotNil(speechManager.errorDescription, "Error description should be set when trying to record without permissions.")
        XCTAssertTrue(speechManager.errorDescription!.contains("permission is required"), "Error message should be about permissions.")
    }

    // Tes 3: Tes logika memulai dan menghentikan rekaman.
    // --- PERBAIKAN DI SINI: Menambahkan 'throws' ke deklarasi fungsi ---
    func testToggleRecording_StartAndStop_WhenAuthorizedAndAvailable() throws {
        // Given
        speechManager.isSpeechRecognitionAuthorized = true
        speechManager.isMicrophoneAuthorized = true
        
        guard speechManager.isSpeechRecognizerAvailable else {
            // Sekarang baris ini valid karena fungsi ditandai 'throws'
            throw XCTSkip("Speech recognizer is not available on this testing environment. Skipping test.")
        }
        speechManager.isSpeechRecognizerAvailable = true

        // --- Mulai Merekam ---
        let startExpectation = XCTestExpectation(description: "Start recording and update recognizedText")
        
        speechManager.startRecording()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.speechManager.isRecording {
                XCTAssertTrue(self.speechManager.isRecording, "Manager should be in recording state.")
                XCTAssertEqual(self.speechManager.recognizedText, "Listening...", "recognizedText should update to 'Listening...'")
                print("Test success: Recording started and text is 'Listening...'.")
            } else {
                XCTFail("Failed to start recording. Error: \(self.speechManager.errorDescription ?? "Unknown reason")")
            }
            startExpectation.fulfill()
        }
        
        wait(for: [startExpectation], timeout: 2.0)

        // --- Hentikan Merekam ---
        if speechManager.isRecording {
            let stopExpectation = XCTestExpectation(description: "Stop recording")
            
            speechManager.stopRecording()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                XCTAssertFalse(self.speechManager.isRecording, "Manager should have stopped recording.")
                print("Test success: Recording stopped.")
                stopExpectation.fulfill()
            }
            wait(for: [stopExpectation], timeout: 1.0)
        }
    }
    
    // Tes 4: Memastikan pemanggilan `requestPermissions` tidak menyebabkan crash.
    func testRequestPermissionsDoesNotCrash() throws {
        let permissionExpectation = expectation(description: "requestPermissions completes without crashing")
        
        // When
        speechManager.requestPermissions()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            permissionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0)
    }
}
