// AslanApp/View/Speaking/SpeechRecognizerManager.swift
import SwiftUI
import Speech
import AVFoundation

class SpeechRecognizerManager: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    // PERUBAHAN: String default diubah ke Bahasa Inggris
    @Published var recognizedText: String = "Press the record button to start."
    @Published var isRecording: Bool = false
    @Published var errorDescription: String? = nil
    @Published var isSpeechRecognitionAuthorized: Bool = SFSpeechRecognizer.authorizationStatus() == .authorized
    @Published var isMicrophoneAuthorized: Bool = AVAudioSession.sharedInstance().recordPermission == .granted
    @Published var isSpeechRecognizerAvailable: Bool = false

    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override init() {
        super.init()
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR")) // Tetap Korea untuk pengenalan
        self.speechRecognizer?.delegate = self

        if let recognizer = self.speechRecognizer {
            self.isSpeechRecognizerAvailable = recognizer.isAvailable
            if !recognizer.isAvailable {
                 self.errorDescription = "Speech recognition is not available at this moment." // Bahasa Inggris
            }
        } else {
            self.errorDescription = "Speech recognition is not supported on this device or locale." // Bahasa Inggris
            self.isSpeechRecognizerAvailable = false
        }
    }

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        DispatchQueue.main.async {
            self.isSpeechRecognizerAvailable = available
            if available {
                self.errorDescription = nil
                print("Speech recognizer is now available.")
            } else {
                self.errorDescription = "Speech recognition is not available at this moment." // Bahasa Inggris
                if self.isRecording {
                    self.stopRecording()
                }
                print("Speech recognizer is now UNAVAILABLE.")
            }
        }
    }
    
    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                self.isSpeechRecognitionAuthorized = (authStatus == .authorized)
                if !self.isSpeechRecognitionAuthorized {
                    self.errorDescription = "Speech recognition permission was denied by the user." // Bahasa Inggris
                    print("Speech recognition permission status: \(authStatus.rawValue)")
                }
            }
        }

        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                self.isMicrophoneAuthorized = granted
                if !granted {
                    self.errorDescription = "Microphone access was denied by the user." // Bahasa Inggris
                }
            }
        }
    }
    
    func checkPermissionsAndSetup() {
        DispatchQueue.main.async {
            self.isSpeechRecognitionAuthorized = (SFSpeechRecognizer.authorizationStatus() == .authorized)
            self.isMicrophoneAuthorized = (AVAudioSession.sharedInstance().recordPermission == .granted)
            
            if let recognizer = self.speechRecognizer {
                self.isSpeechRecognizerAvailable = recognizer.isAvailable
                if !recognizer.isAvailable {
                     self.errorDescription = "Speech recognition is not available. Please try again later." // Bahasa Inggris
                }
            } else {
                self.errorDescription = "SFSpeechRecognizer failed to initialize." // Bahasa Inggris
                self.isSpeechRecognizerAvailable = false
            }
        }
    }

    func startRecording() {
        guard isSpeechRecognitionAuthorized else {
            errorDescription = "Speech recognition permission is required." // Bahasa Inggris
            requestPermissions()
            return
        }
        guard isMicrophoneAuthorized else {
            errorDescription = "Microphone permission is required." // Bahasa Inggris
            requestPermissions()
            return
        }
        
        guard let currentRecognizer = self.speechRecognizer, currentRecognizer.isAvailable else {
            errorDescription = "Speech recognition is not available at this moment. Please try again later." // Bahasa Inggris
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isSpeechRecognizerAvailable = self.speechRecognizer?.isAvailable ?? false
                if !(self.speechRecognizer?.isAvailable ?? false) {
                     self.errorDescription = "Speech recognition is still unavailable." // Bahasa Inggris
                }
            }
            return
        }
        
        guard !audioEngine.isRunning else {
            print("Audio engine is already running.")
            return
        }

        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            self.errorDescription = "Failed to set up audio session: \(error.localizedDescription)" // Bahasa Inggris
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let recognitionRequest = recognitionRequest else {
            self.errorDescription = "Unable to create SFSpeechAudioBufferRecognitionRequest." // Bahasa Inggris
            return
        }

        recognitionRequest.shouldReportPartialResults = true
        let inputNode = audioEngine.inputNode
        
        recognitionTask = currentRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false

            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
                isFinal = result.isFinal
                if error == nil { // Clear previous error if recognition is successful
                    self.errorDescription = nil
                }
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                DispatchQueue.main.async {
                    self.isRecording = false
                }

                if let error = error {
                    // Error SFSpeechRecognizer. berbahasa Inggris secara default
                    self.errorDescription = "Recognition Error: \(error.localizedDescription)"
                    print("Recognition Error: \(error)")
                }
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
         guard recordingFormat.sampleRate > 0 else {
            self.errorDescription = "Invalid recording format (sample rate is 0)." // Bahasa Inggris
            DispatchQueue.main.async {
                self.isRecording = false
            }
            do {
                try audioSession.setActive(false)
            } catch {
                print("Failed to deactivate audio session: \(error)")
            }
            return
        }

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
            DispatchQueue.main.async {
                // PERUBAHAN: String diubah ke Bahasa Inggris
                self.recognizedText = "Listening..."
                self.isRecording = true
                self.errorDescription = nil // Clear previous errors on start
            }
        } catch {
            self.errorDescription = "Failed to start audio engine: \(error.localizedDescription)" // Bahasa Inggris
            DispatchQueue.main.async {
                self.isRecording = false
            }
        }
    }

    func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio() // Ensures the recognition task knows audio has ended
        }
        // No need to check recognitionTask != nil before calling finish(), endAudio() handles it.
        // recognitionTask?.finish() // This might be called too early or cause issues if called directly.
                                  // The task should finish itself when endAudio() is processed and isFinal is true.
        DispatchQueue.main.async {
             self.isRecording = false
             // Optional: if you want to reset text after stopping if nothing was recognized.
             // if self.recognizedText == "Listening..." {
             // self.recognizedText = "Press the record button to start."
             // }
        }
    }
    
    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
}
