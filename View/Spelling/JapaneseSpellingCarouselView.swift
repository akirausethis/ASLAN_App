// AslanApp/View/Spelling/JapaneseSpellingCarouselView.swift
import SwiftUI
import Speech

// MARK: - AllDoneOverlayView Definition
struct AllDoneOverlayView: View {
    let title: String
    let message: String
    var onTryAgain: () -> Void
    var onSeeOtherCourses: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title).fontWeight(.bold).foregroundColor(.blue)
            Text(message)
                .font(.headline).multilineTextAlignment(.center).foregroundColor(Color(UIColor.label))
            Text("Would you like to try again?")
                .font(.subheadline).foregroundColor(Color(UIColor.secondaryLabel))
            VStack(spacing: 15) {
                Button(action: onTryAgain) {
                    Text("Yes, Try Again!").fontWeight(.semibold).frame(maxWidth: .infinity).padding().background(Color.blue).foregroundColor(.white).cornerRadius(10)
                }
                Button(action: onSeeOtherCourses) {
                    Text("No, See Other Courses").fontWeight(.semibold).frame(maxWidth: .infinity).padding().background(Color.gray.opacity(0.2)).foregroundColor(.blue).cornerRadius(10)
                }
            }
        }
        .padding(30).frame(maxWidth: .infinity).background(Color(UIColor.systemBackground)).cornerRadius(20).shadow(radius: 10).padding(.horizontal, 40)
    }
}

// MARK: - SpeechRecognizerManager Definition
class SpeechRecognizerManager: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isRecording: Bool = false
    @Published var errorDescription: String? = nil
    @Published var feedbackMessage: String? = nil

    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var inputNode: AVAudioInputNode?

    @Published var isSpeechAuthorized: Bool = false {
        didSet { print("SRM: isSpeechAuthorized didSet to \(isSpeechAuthorized)") }
    }
    @Published var isMicAuthorizedAndAvailable: Bool = false {
        didSet { print("SRM: isMicAuthorizedAndAvailable didSet to \(isMicAuthorizedAndAvailable)") }
    }

    init() {
        print("SRM: init")
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))
        
        guard self.speechRecognizer != nil else {
            DispatchQueue.main.async {
                self.errorDescription = "Speech recognizer for ja-JP is not available on this device."
                print("SRM: \(self.errorDescription ?? "Error init speech recognizer")")
            }
            return
        }
        requestSpeechAuthorization()
    }

    private func requestSpeechAuthorization() {
        let currentStatus = SFSpeechRecognizer.authorizationStatus()
        print("SRM: Current Speech Auth Status: \(currentStatus.rawValue)")
        switch currentStatus {
        case .authorized:
            print("SRM: Speech recognition was already authorized.")
            OperationQueue.main.addOperation { self.isSpeechAuthorized = true }
            requestMicrophonePermissionAndSetupInputNode()
        case .notDetermined:
            print("SRM: Requesting speech recognition authorization...")
            SFSpeechRecognizer.requestAuthorization { authStatus in
                OperationQueue.main.addOperation {
                    switch authStatus {
                    case .authorized:
                        print("SRM: Speech recognition newly authorized.")
                        self.isSpeechAuthorized = true
                        self.requestMicrophonePermissionAndSetupInputNode()
                    case .denied: self.errorDescription = "User denied access to speech recognition."; self.isSpeechAuthorized = false
                    case .restricted: self.errorDescription = "Speech recognition restricted on this device."; self.isSpeechAuthorized = false
                    case .notDetermined: self.errorDescription = "Speech recognition authorization still not determined."; self.isSpeechAuthorized = false
                    @unknown default: self.errorDescription = "Unknown speech authorization status."; self.isSpeechAuthorized = false
                    }
                    if !self.isSpeechAuthorized, let desc = self.errorDescription { print("SRM: \(desc)") }
                }
            }
        default:
            OperationQueue.main.addOperation {
                self.isSpeechAuthorized = false
                self.errorDescription = "Speech recognition was previously denied or is restricted."
                print("SRM: \(self.errorDescription ?? "Speech auth denied/restricted")")
            }
        }
    }

    private func requestMicrophonePermissionAndSetupInputNode() {
        print("SRM: Requesting microphone permission...")
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            OperationQueue.main.addOperation {
                if granted {
                    print("SRM: Microphone permission granted.")
                    self.inputNode = self.audioEngine.inputNode
                    if self.inputNode == nil {
                        self.errorDescription = "SRM Error: Failed to get audio input node (was nil)."
                        self.isMicAuthorizedAndAvailable = false
                    } else if self.inputNode!.inputFormat(forBus: 0).channelCount == 0 {
                        self.errorDescription = "SRM Error: Microphone found but not configured (0 channels). Try on a physical device."
                        self.isMicAuthorizedAndAvailable = false
                    } else {
                        self.isMicAuthorizedAndAvailable = true
                        if self.errorDescription?.contains("Microphone") == true || self.errorDescription?.contains("Audio input node") == true {
                            self.errorDescription = nil
                        }
                        print("SRM: Microphone available and configured.")
                    }
                } else {
                    self.errorDescription = "SRM Error: Microphone permission denied by user."
                    self.isMicAuthorizedAndAvailable = false
                }
                if !self.isMicAuthorizedAndAvailable, let desc = self.errorDescription { print("SRM: \(desc)") }
            }
        }
    }
    
    private func prepareAudioSessionAndEngine() throws {
        guard isSpeechAuthorized else {
            let err = "Speech recognition not authorized."
            print("SRM Prep Error: \(err)")
            throw NSError(domain: "SRM", code: 1001, userInfo: [NSLocalizedDescriptionKey: err])
        }
        guard let validInNode = self.inputNode else {
            let err = "Audio input node nil."
            print("SRM Prep Error: \(err)")
            if !isMicAuthorizedAndAvailable { requestMicrophonePermissionAndSetupInputNode() }
            throw NSError(domain: "SRM", code: 1003, userInfo: [NSLocalizedDescriptionKey: err])
        }
        guard isMicAuthorizedAndAvailable, validInNode.inputFormat(forBus: 0).channelCount > 0 else {
            let err = "Mic not available/configured (0 channels)."
            print("SRM Prep Error: \(err)")
            if !isMicAuthorizedAndAvailable { requestMicrophonePermissionAndSetupInputNode() }
            throw NSError(domain: "SRM", code: 1002, userInfo: [NSLocalizedDescriptionKey: err])
        }
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        print("SRM: Audio session prepared.")
    }

    func startRecording() {
        print("SRM: Attempting start. SpeechAuth: \(isSpeechAuthorized), MicAuth: \(isMicAuthorizedAndAvailable)")
        feedbackMessage = nil
        guard isSpeechAuthorized else {
            self.errorDescription = "Speech not authorized."; print("SRM: \(self.errorDescription!)")
            if SFSpeechRecognizer.authorizationStatus() == .notDetermined { requestSpeechAuthorization() }
            OperationQueue.main.addOperation { self.isRecording = false }; return
        }
        guard isMicAuthorizedAndAvailable, let node = self.inputNode, node.inputFormat(forBus: 0).channelCount > 0 else {
            self.errorDescription = "Mic not available/configured (0 channels) or denied."; print("SRM: \(self.errorDescription!)")
            if AVAudioSession.sharedInstance().recordPermission == .undetermined || !isMicAuthorizedAndAvailable { requestMicrophonePermissionAndSetupInputNode() }
            OperationQueue.main.addOperation { self.isRecording = false }; return
        }
        guard let recognizer = self.speechRecognizer, recognizer.isAvailable else {
            self.errorDescription = "Speech recognizer not available."; print("SRM: \(self.errorDescription!)")
            OperationQueue.main.addOperation { self.isRecording = false }; return
        }
        if audioEngine.isRunning {
            print("SRM: Engine running, stopping first."); stopRecordingInternal(clearTask: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { print("SRM: Attempting _startRecordingProcess after delay."); self._startRecordingProcess(recognizer: recognizer) }
            return
        }
        _startRecordingProcess(recognizer: recognizer)
    }
    
    private func _startRecordingProcess(recognizer speechRecognizerArgument: SFSpeechRecognizer) {
        print("SRM: _startRecordingProcess begin")
        OperationQueue.main.addOperation { self.recognizedText = ""; self.errorDescription = nil }
        
        recognitionTask?.cancel(); recognitionTask = nil
        inputNode?.removeTap(onBus: 0)

        do { try prepareAudioSessionAndEngine() }
        catch {
            OperationQueue.main.addOperation {
                self.errorDescription = "Audio Session prep error in _start: \(error.localizedDescription)"
                print("SRM: \(self.errorDescription!)"); self.isRecording = false
            }
            return
        }

        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let currentRecognitionRequest = self.recognitionRequest else {
            OperationQueue.main.addOperation {
                self.errorDescription = "Cannot create SFSpeechAudioBufferRecognitionRequest."
                print("SRM: \(self.errorDescription!)"); self.isRecording = false
            }
            return
        }
        currentRecognitionRequest.shouldReportPartialResults = true
        if speechRecognizerArgument.supportsOnDeviceRecognition {
            currentRecognitionRequest.requiresOnDeviceRecognition = true
        }

        guard let validNode = self.inputNode else {
             OperationQueue.main.addOperation {
                 self.errorDescription = "Input node nil before installTap."
                 print("SRM: \(self.errorDescription!)"); self.isRecording = false
             }
             return
        }
        
        let recordingFormat = validNode.outputFormat(forBus: 0)
        print("SRM: Installing tap.")
        validNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            currentRecognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            OperationQueue.main.addOperation { self.isRecording = true }
            print("SRM: Engine started.")
        } catch {
            OperationQueue.main.addOperation {
                self.errorDescription = "Engine couldn't start: \(error.localizedDescription)";
                print("SRM: \(self.errorDescription!)"); self.isRecording = false
            }
            currentRecognitionRequest.endAudio(); validNode.removeTap(onBus: 0)
            return
        }
        
        // Baris 207 (kurang lebih): Menggunakan speechRecognizerArgument
        recognitionTask = speechRecognizerArgument.recognitionTask(with: currentRecognitionRequest) { result, error in
            var isFinal = false
            if let res = result {
                OperationQueue.main.addOperation { self.recognizedText = res.bestTranscription.formattedString }
                isFinal = res.isFinal
            }

            // Baris 217, 218 (kurang lebih) - PERBAIKAN ERROR DI SINI
            if let receivedError = error { // Gunakan 'receivedError' yang baru didefinisikan
                let nsError = receivedError as NSError // Kemudian cast ke nsError di sini
                OperationQueue.main.addOperation {
                    let SFSpeechErrorCodeCancelled_rawValue = 203
                    let kAFAssistantErrorDomain_string = "kAFAssistantErrorDomain"
                    let kAFAssistantErrorCodeNoSpeech_rawValue = 1110

                    // Sekarang gunakan nsError (dengan 'o' kecil)
                    if nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorCancelled {
                        print("SRM: Recognition cancelled (URL error).")
                    } else if nsError.code == SFSpeechErrorCodeCancelled_rawValue {
                        print("SRM: Recognition explicitly cancelled (SFSpeech Error Code).")
                    } else if nsError.domain == kAFAssistantErrorDomain_string && nsError.code == kAFAssistantErrorCodeNoSpeech_rawValue {
                        print("SRM: No speech detected by recognizer.")
                    } else {
                        self.errorDescription = "Task Error (code \(nsError.code)): \(nsError.localizedDescription)" // Menggunakan nsError
                        print("SRM: \(self.errorDescription ?? "Unknown task error")")
                    }
                }
                self.stopRecordingInternal(clearTask: false)
                isFinal = true
            }

            if isFinal {
                print("SRM: Recognition task finished or errored (isFinal=true).")
                OperationQueue.main.addOperation {
                    self.recognitionRequest = nil
                }
            }
        }
    }

    private func stopRecordingInternal(clearTask: Bool) { if audioEngine.isRunning { inputNode?.removeTap(onBus: 0); audioEngine.stop(); print("SRM: Engine stopped, tap removed.") } else { print("SRM: stopRecordingInternal, engine not running.") }; recognitionRequest?.endAudio(); if clearTask { recognitionTask?.finish(); recognitionTask?.cancel(); recognitionTask = nil; print("SRM: Task cleared.") } }
    func stopRecordingAndCheck(target: String) { print("SRM: stopRecordingAndCheck."); stopRecordingInternal(clearTask: true); OperationQueue.main.addOperation { self.isRecording = false }; DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self.checkPronunciation(target: target) } }
    func checkPronunciation(target: String) { guard !target.isEmpty else { feedbackMessage = "No target text."; return }; let recognized = recognizedText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(); let targetProcessed = target.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(); if recognized == targetProcessed && !recognized.isEmpty { feedbackMessage = "Correct! 🎉" } else if !recognizedText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { feedbackMessage = "Try Again. You said: \"\(recognizedText.trimmingCharacters(in: .whitespacesAndNewlines))\"" } else { if self.errorDescription == nil { feedbackMessage = "No speech detected. Please try again." } } }
}

// MARK: - JapaneseSpellingCarouselView
struct JapaneseSpellingCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    let courseTitle: String

    @State private var spellingItems: [any JapaneseCharacterCard] = []
    @State private var currentItemIndex: Int = 0
    
    @StateObject private var speechManager = SpeechRecognizerManager()
    @State private var showAllDoneOverlay = false
    @State private var initialSpellingItems: [any JapaneseCharacterCard] = []

    var currentTargetText: String { guard !spellingItems.isEmpty, currentItemIndex < spellingItems.count else { return "" }; if let kanjiCard = spellingItems[currentItemIndex] as? KanjiFlashcard { return kanjiCard.kunyomi?.first ?? kanjiCard.onyomi?.first ?? kanjiCard.character }; return spellingItems[currentItemIndex].character }
    var currentDisplayCharacter: String { guard !spellingItems.isEmpty, currentItemIndex < spellingItems.count else { return "" }; return spellingItems[currentItemIndex].character }
    var currentDisplayInfo: String { guard !spellingItems.isEmpty, currentItemIndex < spellingItems.count else { return "" }; if let kanjiCard = spellingItems[currentItemIndex] as? KanjiFlashcard { return kanjiCard.meaning }; return spellingItems[currentItemIndex].romaji }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack { /* ... Header kustom dengan tombol back dan judul ... */
                    Button { presentationMode.wrappedValue.dismiss() } label: { Image(systemName: "chevron.left").font(.title2.weight(.semibold)).padding(12).contentShape(Rectangle()) }.foregroundColor(.blue)
                    Spacer()
                    Text(courseTitle).font(.system(size: 24, weight: .bold)).foregroundColor(.blue).lineLimit(1).minimumScaleFactor(0.7)
                    Spacer()
                    Image(systemName: "chevron.left").opacity(0).padding(12)
                }
                .padding(.horizontal).padding(.top, (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 0 + 5).padding(.bottom, 15).background(Color(UIColor.systemBackground))

                Text("Tap the mic and say: \(currentTargetText.isEmpty ? "the item" : "\"\(currentTargetText)\"")")
                    .font(.headline).foregroundColor(.gray).multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center).padding(.horizontal).padding(.bottom, 25)
                
                Spacer()

                if !spellingItems.isEmpty && currentItemIndex < spellingItems.count {
                    VStack(spacing: 5) {
                        Text(currentDisplayCharacter).font(.system(size: tentukanUkuranFont(untuk: currentDisplayCharacter), weight: .bold)).minimumScaleFactor(0.3).lineLimit(1)
                        Text(currentDisplayInfo).font(.title2) // Ini adalah penggunaan .title2 yang benar
                            .foregroundColor(.gray).lineLimit(2).multilineTextAlignment(.center).padding(.horizontal)
                    }.frame(maxWidth: .infinity)
                } else if !showAllDoneOverlay { /* ... Pesan Loading/Complete ... */ Text(initialSpellingItems.isEmpty && speechManager.errorDescription == nil ? "Loading items..." : (initialSpellingItems.isEmpty && speechManager.errorDescription != nil ? "" : "Course Complete!")).font(.title).foregroundColor(.gray).frame(maxWidth: .infinity, maxHeight: .infinity).onAppear{ if spellingItems.isEmpty && !initialSpellingItems.isEmpty && currentItemIndex >= initialSpellingItems.count { if currentItemIndex >= initialSpellingItems.count { showAllDoneOverlay = true } } } }
                else { Spacer().frame(maxWidth: .infinity, maxHeight: .infinity) }

                Spacer()

                VStack { /* ... Feedback Area ... */
                    if speechManager.isRecording { Text("Listening...").font(.title3).foregroundColor(.orange) }
                    else if let feedback = speechManager.feedbackMessage { Text(feedback).font(.headline).foregroundColor(feedback.contains("Correct") ? .green : .red).multilineTextAlignment(.center) }
                    else if !speechManager.recognizedText.isEmpty { Text("You said: \"\(speechManager.recognizedText)\"").multilineTextAlignment(.center).font(.body) }
                    
                    // Baris 292 (kurang lebih) - Pastikan padding di sini menggunakan sintaks yang benar
                    if let errorDesc = speechManager.errorDescription {
                        Text("Error: \(errorDesc)")
                            .font(.caption).foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5) // SINTAKS INI SUDAH BENAR, tidak ada CGFloat.top
                    }
                }.padding().frame(minHeight: 80, maxHeight: 120)

                HStack(spacing: 50) { /* ... Tombol Kontrol Mic & Next ... */
                    Button(action: {
                        if speechManager.isRecording { speechManager.stopRecordingAndCheck(target: currentTargetText) }
                        else { speechManager.startRecording() }
                    }) { Image(systemName: speechManager.isRecording ? "stop.circle.fill" : "mic.fill").resizable().scaledToFit().frame(width: 65, height: 65).padding(18).background(Color.blue).foregroundColor(.white).clipShape(Circle()).shadow(radius: 5) }
                    .disabled(!speechManager.isSpeechAuthorized || !speechManager.isMicAuthorizedAndAvailable)

                    Button(action: {
                        if canProceedToNext() { goToNextItem(); speechManager.recognizedText = ""; speechManager.feedbackMessage = nil; speechManager.errorDescription = nil }
                    }) { Image(systemName: "arrow.right").resizable().scaledToFit().frame(width: 35, height: 35).padding(28).background(Color(UIColor.systemGray5)).foregroundColor(canProceedToNext() ? Color.blue : Color.gray.opacity(0.7)).clipShape(Circle()).shadow(radius: 3) }
                    .disabled(!canProceedToNext())
                }.padding(.bottom, 50).frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .onAppear(perform: loadSpellingItems)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            if showAllDoneOverlay { /* ... Overlay Selesai ... */
                Color.black.opacity(0.4).ignoresSafeArea().onTapGesture {}
                AllDoneOverlayView(title: "Practice Complete!", message: "You've practiced all items in this set.", onTryAgain: { resetPractice(); showAllDoneOverlay = false }, onSeeOtherCourses: { presentationMode.wrappedValue.dismiss() })
                    .transition(.opacity.combined(with: .scale(scale: 0.8)))
            }
        }
        .animation(.easeInOut, value: showAllDoneOverlay)
        .animation(.default, value: currentItemIndex)
    }
    
    private func tentukanUkuranFont(untuk karakter: String) -> CGFloat { let length = karakter.count; if length == 1 { return 150 }; if length == 2 { return 130 }; if length == 3 { return 110 }; if length <= 5 { return 90 }; return 70 }
    func canProceedToNext() -> Bool { guard !spellingItems.isEmpty else { return false }; if currentItemIndex == spellingItems.count - 1 { return speechManager.feedbackMessage?.contains("Correct") == true }; return speechManager.feedbackMessage?.contains("Correct") == true || !speechManager.isRecording }
    func loadSpellingItems() { var items: [any JapaneseCharacterCard] = []; switch courseTitle { case "Hiragana Sounds": items = JapaneseCharacterData.hiraganaCharacters; case "Katakana Sounds": items = JapaneseCharacterData.katakanaCharacters; case "N5 Greetings": items = [ HiraganaFlashcard(character: "おはよう", romaji: "ohayou / good morning"), HiraganaFlashcard(character: "こんにちは", romaji: "konnichiwa / hello"), HiraganaFlashcard(character: "ありがとう", romaji: "arigatou / thank you"), HiraganaFlashcard(character: "さようなら", romaji: "sayounara / goodbye"), HiraganaFlashcard(character: "すみません", romaji: "sumimasen / excuse me, sorry") ]; default: items = [HiraganaFlashcard(character: "あ", romaji: "a")] }; self.initialSpellingItems = items; self.spellingItems = items.shuffled(); self.currentItemIndex = 0; self.showAllDoneOverlay = false; speechManager.recognizedText = ""; speechManager.feedbackMessage = nil; speechManager.errorDescription = nil }
    func goToNextItem() { if currentItemIndex < spellingItems.count - 1 { currentItemIndex += 1 } else { if !initialSpellingItems.isEmpty && (speechManager.feedbackMessage?.contains("Correct") == true || !speechManager.isRecording) { showAllDoneOverlay = true } } }
    func resetPractice() { guard !initialSpellingItems.isEmpty else { presentationMode.wrappedValue.dismiss(); return }; spellingItems = initialSpellingItems.shuffled(); currentItemIndex = 0; showAllDoneOverlay = false; speechManager.recognizedText = ""; speechManager.feedbackMessage = nil; speechManager.errorDescription = nil }
}

#Preview {
    NavigationView {
        JapaneseSpellingCarouselView(courseTitle: "N5 Greetings")
    }
}
