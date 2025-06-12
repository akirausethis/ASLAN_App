import SwiftUI

struct KoreanSpeakingPracticeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var progressViewModel: ProgressViewModel
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

    private var isOnLastPhrase: Bool {
        return !phrasesForCourse.isEmpty && currentPhraseIndex == phrasesForCourse.count - 1
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let phrase = currentPhraseToDisplay {
                        Text("Pronounce the Following:")
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
                            Text(phrasesForCourse.isEmpty && speechManager.errorDescription == nil ? "Loading phrases..." : "No phrases for this topic.")
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

                        if speechManager.recognizedText.isEmpty || speechManager.recognizedText == "Press the record button to start." || speechManager.recognizedText == "Listening..." {
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
                            Text("Speech Recognition and Microphone permissions are required for this feature.")
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            HStack {
                                Button("Request Permissions") { speechManager.requestPermissions() }
                                    .buttonStyle(.borderedProminent).tint(.green)
                                Button("Open Settings") {
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
                            Label(speechManager.isRecording ? "Stop Recording" : "Start Recording",
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

                        if isOnLastPhrase {
                             Button(action: {
                                markSpeakingCourseAsCompleted()
                            }) {
                                Label("Complete Course", systemImage: "checkmark.circle.fill")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(isCorrect == true ? Color.green.gradient : Color.gray.gradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .shadow(color: (isCorrect == true ? Color.green : Color.gray).opacity(0.2), radius: 4, y: 2)
                            }
                            .disabled(isCorrect != true)
                        } else if !phrasesForCourse.isEmpty {
                            HStack(spacing: 15) {
                                Button(action: goToPreviousPhrase) {
                                    Label("Previous", systemImage: "arrow.left.circle.fill")
                                        .padding(10)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                }
                                .buttonStyle(.bordered)
                                .disabled(currentPhraseIndex == 0 || speechManager.isRecording)
                                
                                Button(action: goToNextPhrase) {
                                    Label("Next", systemImage: "arrow.right.circle.fill")
                                        .padding(10)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                }
                                .buttonStyle(.bordered)
                                .disabled(currentPhraseIndex >= phrasesForCourse.count - 1 || speechManager.isRecording)
                            }
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
                if !newIsRecording && !speechManager.recognizedText.isEmpty && speechManager.recognizedText != "Press the record button to start." && speechManager.recognizedText != "Listening..." {
                    checkAnswer()
                }
            }

            if isShowingCompletionNotification {
                VStack {
                    NotificationView(message: completionNotificationMessage, isSuccess: completionNotificationIsSuccess, isShowing: $isShowingCompletionNotification)
                         .padding(.top, UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.top ?? 0)
                    Spacer()
                }.edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    func loadPhrases() {
        phrasesForCourse = KoreanSpeakingData.phrases(forCourseTitle: course.title).shuffled()
        currentPhraseIndex = 0
        resetForNewPhrase()
    }
    
    func resetForNewPhrase() {
        speechManager.recognizedText = "Press the record button to start."
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
            speechManager.recognizedText = "Listening..."
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
            feedbackMessage = "No target phrase."
            isCorrect = false
            return
        }

        if speechManager.recognizedText == "Listening..." || speechManager.recognizedText == "Press the record button to start." {
            feedbackMessage = "Please say the sentence first."
            isCorrect = false
            return
        }

        let cleanedRecognizedText = cleanString(speechManager.recognizedText)
        let cleanedTargetPhrase = cleanString(targetPhrase)

        if cleanedRecognizedText == cleanedTargetPhrase {
            isCorrect = true
            feedbackMessage = "Correct! 👍"
        } else {
            isCorrect = false
            if cleanedRecognizedText.isEmpty {
                feedbackMessage = "No sound detected. Please try again."
            } else {
                feedbackMessage = "Not quite right. Please try again."
            }
        }
    }

    private func markSpeakingCourseAsCompleted() {
        progressViewModel.userCompletedCourse(
            courseTitle: course.id,
            topicTitle: "",
            category: "Speaking"
        )

        completionNotificationMessage = "Well done! You've completed the '\(course.title)' course."
        completionNotificationIsSuccess = true
        withAnimation {
            isShowingCompletionNotification = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if presentationMode.wrappedValue.isPresented {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
