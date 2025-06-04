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
    @EnvironmentObject var progressViewModel: ProgressViewModel // Akses ProgressViewModel
    let courseTitle: String

    @State private var spellingItems: [any JapaneseCharacterCard] = []
    @State private var currentItemIndex: Int = 0
    
    @StateObject private var speechManager = SpeechRecognizerManager()
    @State private var showAllDoneOverlay = false
    @State private var initialSpellingItems: [any JapaneseCharacterCard] = []

    @State private var courseIDForProgress: String? = nil // State untuk menyimpan courseID
    @State private var showCompleteCourseButton: Bool = false // State untuk mengontrol visibilitas tombol Complete Course
    @State private var isButtonPressing: Bool = false // Untuk efek hover pada tombol Complete Course

    // State untuk notifikasi penyelesaian kursus
    @State private var showingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""


    var currentTargetText: String { guard !spellingItems.isEmpty, currentItemIndex < spellingItems.count else { return "" }; if let kanjiCard = spellingItems[currentItemIndex] as? KanjiFlashcard { return kanjiCard.kunyomi?.first ?? kanjiCard.onyomi?.first ?? kanjiCard.character }; return spellingItems[currentItemIndex].character }
    var currentDisplayCharacter: String { guard !spellingItems.isEmpty, currentItemIndex < spellingItems.count else { return "" }; return spellingItems[currentItemIndex].character }
    var currentDisplayInfo: String { guard !spellingItems.isEmpty, currentItemIndex < spellingItems.count else { return "" }; if let kanjiCard = spellingItems[currentItemIndex] as? KanjiFlashcard { return kanjiCard.meaning }; return spellingItems[currentItemIndex].romaji }

    var body: some View {
        GeometryReader { geometry in // Tambahkan GeometryReader
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack { /* ... Header kustom dengan tombol back dan judul ... */
                        Button { presentationMode.wrappedValue.dismiss() } label: { Image(systemName: "chevron.left").font(.title2.weight(.semibold)).padding(12).contentShape(Rectangle()) }.foregroundColor(.blue)
                        Spacer()
                        Text(courseTitle).font(.system(size: 24, weight: .bold)).foregroundColor(.blue).lineLimit(1).minimumScaleFactor(0.7)
                        Spacer()
                        Image(systemName: "chevron.left").opacity(0).padding(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, geometry.safeAreaInsets.top + 5) // Sesuaikan padding top
                    .padding(.bottom, 15)
                    .background(Color(UIColor.systemBackground))

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

                    // Tombol "Complete Course" - Ditambahkan
                    if showCompleteCourseButton {
                        Button(action: {
                            markCourseAsCompleted()
                            completionNotificationMessage = "You've completed the Spelling course!"
                            showingCompletionNotification = true
                            // Tidak langsung dismiss di sini, biarkan overlay "All Done" muncul
                            // setelah notifikasi hilang, atau bisa langsung dismiss jika itu yang diinginkan
                        }) {
                            Text("Complete Course")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green) // Warna hijau untuk complete
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .scaleEffect(isButtonPressing ? 0.95 : 1.0) // Efek hover
                        .opacity(isButtonPressing ? 0.8 : 1.0)
                        .onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
                            self.isButtonPressing = isPressing
                        }, perform: {})
                        .padding(.horizontal)
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah
                    }

                }
                .padding(.horizontal)
                .onAppear {
                    // Dapatkan courseID saat view muncul
                    if let appCourse = CourseDataProvider.shared.allAppCourses.first(where: { $0.title == self.courseTitle }) {
                        self.courseIDForProgress = appCourse.id
                    } else {
                        print("Error: Tidak dapat menemukan AppCourse ID untuk Spelling practice: \(self.courseTitle)")
                    }
                    loadSpellingItems()
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                
                if showAllDoneOverlay { /* ... Overlay Selesai ... */
                    Color.black.opacity(0.4).ignoresSafeArea().onTapGesture {}
                    AllDoneOverlayView(title: "Practice Complete!", message: "You've practiced all items in this set.", onTryAgain: { resetPractice(); showAllDoneOverlay = false }, onSeeOtherCourses: { presentationMode.wrappedValue.dismiss() })
                        .transition(.opacity.combined(with: .scale(scale: 0.8)))
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah overlay
                }

                // Notifikasi penyelesaian kursus
                if showingCompletionNotification {
                    NotificationView(message: completionNotificationMessage, isSuccess: true, isShowing: $showingCompletionNotification)
                        .padding(.top, geometry.safeAreaInsets.top) // Gunakan safeAreaInsets.top
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1) // Pastikan notifikasi di atas konten lain
                }
            }
        }
        .animation(.easeInOut, value: showAllDoneOverlay)
        .animation(.easeInOut, value: showCompleteCourseButton) // Animasi untuk tombol
        .animation(.easeInOut, value: showingCompletionNotification) // Animasi untuk notifikasi
        .animation(.default, value: currentItemIndex)
    }
    
    private func tentukanUkuranFont(untuk karakter: String) -> CGFloat { let length = karakter.count; if length == 1 { return 150 }; if length == 2 { return 130 }; if length == 3 { return 110 }; if length <= 5 { return 90 }; return 70 }
    
    func canProceedToNext() -> Bool {
        guard !spellingItems.isEmpty else { return false }
        return speechManager.feedbackMessage?.contains("Correct") == true || !speechManager.isRecording // Bisa lanjut jika sudah benar atau tidak sedang merekam
    }
    
    func loadSpellingItems() {
        var items: [any JapaneseCharacterCard] = []
        switch courseTitle {
        case "Hiragana Sounds": items = JapaneseCharacterData.hiraganaCharacters
        case "Katakana Sounds": items = JapaneseCharacterData.katakanaCharacters
        case "N5 Greetings": items = [
            HiraganaFlashcard(character: "おはよう", romaji: "ohayou / good morning"),
            HiraganaFlashcard(character: "こんにちは", romaji: "konnichiwa / hello"),
            HiraganaFlashcard(character: "ありがとう", romaji: "arigatou / thank you"),
            HiraganaFlashcard(character: "さようなら", romaji: "sayounara / goodbye"),
            HiraganaFlashcard(character: "すみません", romaji: "sumimasen / excuse me, sorry"),
            HiraganaFlashcard(character: "おやすみ", romaji: "oyasumi / good night"),
            HiraganaFlashcard(character: "ごめんなさい", romaji: "gomennasai / I'm sorry"),
            HiraganaFlashcard(character: "はい", romaji: "hai / yes"),
            HiraganaFlashcard(character: "いいえ", romaji: "iie / no"),
            HiraganaFlashcard(character: "いただきます", romaji: "itadakimasu / expression before meal"),
            HiraganaFlashcard(character: "ごちそうさま", romaji: "gochisousama / expression after meal"),
            HiraganaFlashcard(character: "おつかれさま", romaji: "otsukaresama / good work, thanks for your effort"),
            HiraganaFlashcard(character: "ただいま", romaji: "tadaima / I'm home"),
            HiraganaFlashcard(character: "おかえりなさい", romaji: "okaerinasai / welcome home"),
            HiraganaFlashcard(character: "いってきます", romaji: "ittekimasu / I'm going (and coming back)"),
            HiraganaFlashcard(character: "いってらっしゃい", romaji: "itterasshai / please go (and come back)"),
            HiraganaFlashcard(character: "おめでとう", romaji: "omedetou / congratulations"),
            HiraganaFlashcard(character: "がんばって", romaji: "ganbatte / do your best"),
            HiraganaFlashcard(character: "もしもし", romaji: "moshi moshi / hello (on phone)"),
            HiraganaFlashcard(character: "おねがいします", romaji: "onegaishimasu / please (request)")
        ]
        case "Common Phrases": items = [
            HiraganaFlashcard(character: "げんきですか", romaji: "genki desu ka / How are you?"),
            HiraganaFlashcard(character: "おひさしぶり", romaji: "ohisashiburi / Long time no see"),
            HiraganaFlashcard(character: "おげんきで", romaji: "ogenkide / Take care"),
            HiraganaFlashcard(character: "またね", romaji: "matane / See you"),
            HiraganaFlashcard(character: "おたんじょうびおめでとう", romaji: "otanjoubi omedetou / Happy Birthday"),
            HiraganaFlashcard(character: "しつれいします", romaji: "shitsureishimasu / Excuse me (entering/leaving)"),
            HiraganaFlashcard(character: "おきのどくに", romaji: "okinodokuni / I'm sorry to hear that"),
            HiraganaFlashcard(character: "どうぞ", romaji: "douzo / Please (offer)"),
            HiraganaFlashcard(character: "ゆっくりどうぞ", romaji: "yukkuri douzo / Take your time"),
            HiraganaFlashcard(character: "おだいじに", romaji: "odaijini / Get well soon"),
            HiraganaFlashcard(character: "ごちゅういください", romaji: "gochuui kudasai / Please be careful"),
            HiraganaFlashcard(character: "おまかせください", romaji: "omakase kudasai / Leave it to me"),
            HiraganaFlashcard(character: "おつかれさまです", romaji: "otsukaresama desu / Good work (polite)"),
            HiraganaFlashcard(character: "よろしくおねがいします", romaji: "yoroshiku onegaishimasu / Nice to meet you / Please take care of me"),
            HiraganaFlashcard(character: "がんばりましょう", romaji: "ganbarimashou / Let's do our best"),
            HiraganaFlashcard(character: "おあいにくさま", romaji: "oainikusama / Too bad (for you)"),
            HiraganaFlashcard(character: "ごゆっくり", romaji: "goyukkuri / Take your time (relax)"),
            HiraganaFlashcard(character: "おじゃまします", romaji: "ojamashimasu / Excuse me for intruding"),
            HiraganaFlashcard(character: "おそれいります", romaji: "osoreirimasu / Thank you / Excuse me (polite)"),
            HiraganaFlashcard(character: "ごめいわくをおかけしました", romaji: "gomeiwaku o okakeshita / Sorry for the trouble")
        ]
        case "N4 Questions": items = [
            HiraganaFlashcard(character: "これはなんですか", romaji: "kore wa nan desu ka / What is this?"),
            HiraganaFlashcard(character: "どこですか", romaji: "doko desu ka / Where is it?"),
            HiraganaFlashcard(character: "だれですか", romaji: "dare desu ka / Who is it?"),
            HiraganaFlashcard(character: "いつですか", romaji: "itsu desu ka / When is it?"),
            HiraganaFlashcard(character: "いくらですか", romaji: "ikura desu ka / How much is it?"),
            HiraganaFlashcard(character: "なぜですか", romaji: "naze desu ka / Why?"),
            HiraganaFlashcard(character: "どうしましたか", romaji: "dou shimashita ka / What happened?"),
            HiraganaFlashcard(character: "どうやっていきますか", romaji: "dou yatte ikimasu ka / How do I get there?"),
            HiraganaFlashcard(character: "できますか", romaji: "dekimasu ka / Can you do it?"),
            HiraganaFlashcard(character: "わかりますか", romaji: "wakarimasu ka / Do you understand?"),
            HiraganaFlashcard(character: "しっていますか", romaji: "shitteimasu ka / Do you know?"),
            HiraganaFlashcard(character: "もちろんです", romaji: "mochiron desu / Of course"),
            HiraganaFlashcard(character: "だいじょうぶです", romaji: "daijoubu desu / It's alright"),
            HiraganaFlashcard(character: "わかりました", romaji: "wakarimashita / I understood"),
            HiraganaFlashcard(character: "すみません、もういちど", romaji: "sumimasen, mou ichido / Excuse me, one more time"),
            HiraganaFlashcard(character: "もうすこしゆっくりおねがいします", romaji: "mou sukoshi yukkuri onegaishimasu / A little slower please"),
            HiraganaFlashcard(character: "どういうことですか", romaji: "dou iu koto desu ka / What do you mean?"),
            HiraganaFlashcard(character: "どうすればいいですか", romaji: "dou sureba ii desu ka / What should I do?"),
            HiraganaFlashcard(character: "おてつだいしましょうか", romaji: "otetsudai shimashou ka / May I help you?"),
            HiraganaFlashcard(character: "なにかたべましたか", romaji: "nanika tabemashita ka / Did you eat something?")
        ]
        case "Pitch Accent Practice": items = [
            HiraganaFlashcard(character: "はし (橋)", romaji: "háshi (bridge)"), HiraganaFlashcard(character: "はし (箸)", romaji: "hashí (chopsticks)"),
            HiraganaFlashcard(character: "あめ (飴)", romaji: "amé (candy)"), HiraganaFlashcard(character: "あめ (雨)", romaji: "áme (rain)"),
            HiraganaFlashcard(character: "かみ (紙)", romaji: "kamí (paper)"), HiraganaFlashcard(character: "かみ (髪)", romaji: "kámi (hair)"),
            HiraganaFlashcard(character: "さけ (酒)", romaji: "saké (sake)"), HiraganaFlashcard(character: "さけ (鮭)", romaji: "sáke (salmon)"),
            HiraganaFlashcard(character: "にわ (庭)", romaji: "niwá (garden)"), HiraganaFlashcard(character: "にわ (二羽)", romaji: "níwa (two birds)"),
            HiraganaFlashcard(character: "はな (花)", romaji: "haná (flower)"), HiraganaFlashcard(character: "はな (鼻)", romaji: "hána (nose)"),
            HiraganaFlashcard(character: "いし (石)", romaji: "ishí (stone)"), HiraganaFlashcard(character: "いし (意志)", romaji: "íshi (will, intention)"),
            HiraganaFlashcard(character: "くも (雲)", romaji: "kumó (cloud)"), HiraganaFlashcard(character: "くも (蜘蛛)", romaji: "kúmo (spider)"),
            HiraganaFlashcard(character: "ふく (吹く)", romaji: "fúku (to blow)"), HiraganaFlashcard(character: "ふく (服)", romaji: "fukú (clothes)"),
            HiraganaFlashcard(character: "おもい (重い)", romaji: "omói (heavy)"), HiraganaFlashcard(character: "おもい (思い)", romaji: "omoi (thought)")
        ]
        case "N3 Conversation Starters": items = [
            HiraganaFlashcard(character: "おつかれさまでした", romaji: "otsukaresamadeshita / Thank you for your hard work (past)"),
            HiraganaFlashcard(character: "おさきにどうぞ", romaji: "osaki ni douzo / Please go ahead"),
            HiraganaFlashcard(character: "すみません、ちょっと", romaji: "sumimasen, chotto / Excuse me, but... (hesitation)"),
            HiraganaFlashcard(character: "しょうがない", romaji: "shou ga nai / It can't be helped"),
            HiraganaFlashcard(character: "なるほど", romaji: "naruhodo / I see, indeed"),
            HiraganaFlashcard(character: "もちろん", romaji: "mochiron / Of course"),
            HiraganaFlashcard(character: "たぶん", romaji: "tabun / Probably"),
            HiraganaFlashcard(character: "きっと", romaji: "kitto / Surely, without fail"),
            HiraganaFlashcard(character: "べつに", romaji: "betsu ni / Not particularly"),
            HiraganaFlashcard(character: "まさか", romaji: "masaka / No way! Impossible!"),
            HiraganaFlashcard(character: "さすが", romaji: "sasuga / As expected!"),
            HiraganaFlashcard(character: "やっぱり", romaji: "yappari / As expected, after all"),
            HiraganaFlashcard(character: "そろそろ", romaji: "sorosoro / It's about time to..."),
            HiraganaFlashcard(character: "だいたい", romaji: "daitai / Roughly, mostly"),
            HiraganaFlashcard(character: "とんでもない", romaji: "tondemonai / No way, not at all (refuting praise)"),
            HiraganaFlashcard(character: "まいった", romaji: "maitta / I give up, I'm beaten"),
            HiraganaFlashcard(character: "お気の毒に", romaji: "o kinodoku ni / I'm sorry to hear that"),
            HiraganaFlashcard(character: "お手柔らかに", romaji: "ote yawaraka ni / Please be gentle (go easy on me)"),
            HiraganaFlashcard(character: "申し訳ございません", romaji: "moushiwake gozaimasen / I am truly sorry (formal)"),
            HiraganaFlashcard(character: "ご無沙汰しております", romaji: "gobusata shite orimasu / I haven't contacted you for a long time (formal)")
        ]
        default: items = [HiraganaFlashcard(character: "あ", romaji: "a")]
        }
        self.initialSpellingItems = items
        self.spellingItems = items.shuffled()
        self.currentItemIndex = 0
        self.showAllDoneOverlay = false
        self.showCompleteCourseButton = false // Sembunyikan tombol saat load items
        speechManager.recognizedText = ""
        speechManager.feedbackMessage = nil
        speechManager.errorDescription = nil
    }
    
    func goToNextItem() {
        if currentItemIndex < spellingItems.count - 1 {
            currentItemIndex += 1
        } else {
            // Semua item sudah selesai
            if !initialSpellingItems.isEmpty {
                // Tampilkan tombol complete course jika ada item yang di-load
                showCompleteCourseButton = true
            } else {
                // Jika tidak ada item awal, langsung tampilkan overlay "All Done"
                showAllDoneOverlay = true
            }
        }
    }
    
    func resetPractice() {
        guard !initialSpellingItems.isEmpty else {
            presentationMode.wrappedValue.dismiss()
            return
        }
        spellingItems = initialSpellingItems.shuffled()
        currentItemIndex = 0
        showAllDoneOverlay = false
        showCompleteCourseButton = false // Sembunyikan tombol saat reset
        speechManager.recognizedText = ""
        speechManager.feedbackMessage = nil
        speechManager.errorDescription = nil
    }

    private func markCourseAsCompleted() {
        if let courseID = courseIDForProgress {
            progressViewModel.userCompletedCourse(courseID: courseID, userID: "dummyUser")
            print("Spelling course '\(courseTitle)' (ID: \(courseID)) marked as completed.")
        } else {
            print("Tidak dapat menandai Spelling course '\(courseTitle)' selesai karena ID tidak ditemukan.")
        }
    }
}

#Preview {
    NavigationView {
        JapaneseSpellingCarouselView(courseTitle: "N5 Greetings")
    }
}
