import SwiftUI

struct KoreanSpeakingPracticeView: View {
    @Environment(\.presentationMode) var presentationMode

    
    let course: KoreanCourse
    @StateObject private var speechManager = SpeechRecognizerManager()
    
    @State private var phrasesForCourse: [SpeakingPhrase] = []
    @State private var currentPhraseIndex: Int = 0
    
    @State private var feedbackMessage: String? = nil
    @State private var isCorrect: Bool? = nil

    @State private var isShowingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""
    @State private var completionNotificationIsSuccess: Bool = true


    private var currentPhraseToDisplay: SpeakingPhrase? {
        guard !phrasesForCourse.isEmpty, phrasesForCourse.indices.contains(currentPhraseIndex) else {
            return nil
        }
        return phrasesForCourse[currentPhraseIndex]
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let phrase = currentPhraseToDisplay {
                        Text("Ucapkan Kalimat Berikut:")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .padding(.top)

                        VStack(alignment: .center, spacing: 8) {
                            Text(phrase.korean)
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.blue)
                            Text(phrase.romaji)
                                .font(.title3)
                                .italic()
                                .foregroundColor(.gray)
                            Text("(\(phrase.english))")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Material.thin)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)
                    } else {
                        VStack {
                            Spacer(minLength: 50)
                            Text(phrasesForCourse.isEmpty && speechManager.errorDescription == nil ? "Memuat frasa..." : "Tidak ada frasa untuk topik ini.")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer(minLength: 50)
                        }
                        .frame(maxWidth: .infinity, minHeight: 150)
                    }
                        
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: .constant(speechManager.recognizedText))
                            .font(.body)
                            .frame(minHeight: 80, maxHeight: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .disabled(true)
                            .padding(.horizontal)

                        if speechManager.recognizedText.isEmpty || speechManager.recognizedText == "Tekan tombol rekam untuk mulai." || speechManager.recognizedText == "Mendengarkan..." {
                            Text(speechManager.recognizedText)
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding(.leading, 22)
                                .padding(.top, 8)
                                .allowsHitTesting(false)
                        }
                    }

                    if let message = feedbackMessage, let correctStatus = isCorrect {
                        HStack {
                            Image(systemName: correctStatus ? "checkmark.circle.fill" : "xmark.circle.fill")
                            Text(message)
                        }
                        .font(.headline)
                        .foregroundColor(correctStatus ? .green : .red)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background((correctStatus ? Color.green : Color.red).opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }

                    if let errorMsg = speechManager.errorDescription, feedbackMessage == nil {
                        Text("Info: \(errorMsg)")
                            .foregroundColor(errorMsg.lowercased().contains("error") ? .red : .orange)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 5)
                    }
                    
                    if !speechManager.isSpeechRecognitionAuthorized || !speechManager.isMicrophoneAuthorized {
                        VStack(spacing: 10) {
                            Text("Izin Pengenalan Ucapan dan Mikrofon diperlukan untuk fitur ini.")
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            HStack {
                                Button("Minta Izin") { speechManager.requestPermissions() }
                                    .buttonStyle(.borderedProminent).tint(.green)
                                Button("Buka Pengaturan") {
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding(.vertical, 10)
                    }

                    VStack(spacing: 15) {
                        Button(action: {
                            toggleSpeechRecording()
                        }) {
                            Label(speechManager.isRecording ? "Stop Rekaman" : "Mulai Rekam",
                                  systemImage: speechManager.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(speechManager.isRecording ? Color.red.gradient : (speechManager.isSpeechRecognizerAvailable ? Color.green.gradient : Color.gray.gradient))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.1), radius: 3, y: 2)
                        }
                        .disabled((!speechManager.isSpeechRecognitionAuthorized || !speechManager.isMicrophoneAuthorized || !speechManager.isSpeechRecognizerAvailable) && !speechManager.isRecording)

                        HStack(spacing: 15) {
                            Button(action: goToPreviousPhrase) {
                                Label("Sebelumnya", systemImage: "arrow.left.circle.fill")
                                    .padding(10)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(currentPhraseIndex == 0 || phrasesForCourse.isEmpty || speechManager.isRecording)
                            
                            Button(action: goToNextPhrase) {
                                Label("Berikutnya", systemImage: "arrow.right.circle.fill")
                                    .padding(10)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(currentPhraseIndex >= phrasesForCourse.count - 1 || phrasesForCourse.isEmpty || speechManager.isRecording)
                        }

                 
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle(course.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
            .onAppear {
                speechManager.checkPermissionsAndSetup()
                loadPhrases()
            }
            .onChange(of: speechManager.isRecording) { oldIsRecording, newIsRecording in
                if !newIsRecording && !speechManager.recognizedText.isEmpty && speechManager.recognizedText != "Tekan tombol rekam untuk mulai." && speechManager.recognizedText != "Mendengarkan..." {
                    checkAnswer()
                }
            }

            if isShowingCompletionNotification {
                VStack {
                    NotificationView(message: completionNotificationMessage, isSuccess: completionNotificationIsSuccess, isShowing: $isShowingCompletionNotification)
                         .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                    Spacer()
                }.edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    func loadPhrases() {
        phrasesForCourse = KoreanSpeakingData.phrases(forCourseTitle: course.title)
        currentPhraseIndex = 0
        resetForNewPhrase()
    }
    
    func resetForNewPhrase() {
        speechManager.recognizedText = "Tekan tombol rekam untuk mulai."
        feedbackMessage = nil
        isCorrect = nil
    }
    
    func goToNextPhrase() {
        if currentPhraseIndex < phrasesForCourse.count - 1 {
            currentPhraseIndex += 1
            resetForNewPhrase()
        }
    }
    
    func goToPreviousPhrase() {
        if currentPhraseIndex > 0 {
            currentPhraseIndex -= 1
            resetForNewPhrase()
        }
    }
    
    func toggleSpeechRecording() {
        if !speechManager.isRecording {
            speechManager.recognizedText = "Mendengarkan..."
            feedbackMessage = nil
            isCorrect = nil
        }
        speechManager.toggleRecording()
    }

    func cleanString(_ text: String) -> String {
        return text.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .punctuationCharacters).joined()
            .components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.joined(separator: " ")
    }

    func checkAnswer() {
        guard let targetPhrase = currentPhraseToDisplay?.korean else {
            feedbackMessage = "Tidak ada frasa target."
            isCorrect = false
            return
        }

        if speechManager.recognizedText == "Mendengarkan..." || speechManager.recognizedText == "Tekan tombol rekam untuk mulai." {
            feedbackMessage = "Ucapkan kalimatnya terlebih dahulu."
            isCorrect = false
            return
        }

        let cleanedRecognizedText = cleanString(speechManager.recognizedText)
        let cleanedTargetPhrase = cleanString(targetPhrase)

        if cleanedRecognizedText == cleanedTargetPhrase {
            isCorrect = true
            feedbackMessage = "Benar! 👍"
        } else {
            isCorrect = false
            if cleanedRecognizedText.isEmpty {
                feedbackMessage = "Tidak ada suara terdeteksi. Coba lagi."
            } else {
                feedbackMessage = "Kurang tepat. Coba lagi."
            }
        }
    }
}


