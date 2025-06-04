// AslanApp/View/Quiz/QuizQuestionCarouselView.swift
import SwiftUI

// MARK: - QuizResultsView Definition
struct QuizResultsView: View {
    let score: Int
    let totalQuestions: Int
    var onTryAgain: () -> Void
    var onSeeOtherCourses: () -> Void
    var onCompleteCourse: () -> Void // TAMBAHKAN INI

    @State private var isPressingComplete: Bool = false // Untuk efek hover

    var body: some View {
        VStack(spacing: 25) {
            Text("Quiz Complete!")
                .font(.largeTitle).fontWeight(.bold).foregroundColor(.blue)
            
            Image(systemName: score >= totalQuestions / 2 ? "star.fill" : "star.slash.fill")
                .font(.system(size: 60))
                .foregroundColor(score >= totalQuestions / 2 ? .yellow : .gray)

            Text("Your Score: \(score) / \(totalQuestions)")
                .font(.title2).fontWeight(.medium)

            VStack(spacing: 15) {
                Button(action: onTryAgain) {
                    Text("Try Again").fontWeight(.semibold)
                        .frame(maxWidth: .infinity).padding().background(Color.blue)
                        .foregroundColor(.white).cornerRadius(10)
                }
                Button(action: onCompleteCourse) { // TAMBAHKAN TOMBOL INI
                    Text("Complete Course")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity).padding().background(Color.green)
                        .foregroundColor(.white).cornerRadius(10)
                }
                .scaleEffect(isPressingComplete ? 0.95 : 1.0) // Efek hover
                .opacity(isPressingComplete ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                    self.isPressingComplete = pressing
                }, perform: {})
                Button(action: onSeeOtherCourses) {
                    Text("Back to Quiz List").fontWeight(.semibold)
                        .frame(maxWidth: .infinity).padding().background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue).cornerRadius(10)
                }
            }
        }
        .padding(30).frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.4), radius: 10)
        .padding(.horizontal, 40)
        // Pastikan overlay ini memiliki padding bawah yang cukup
        // Ini adalah sub-view, jadi paddingnya harus disesuaikan jika perlu
        // Namun, karena ini overlay, biasanya akan muncul di atas navbar.
    }
}


// MARK: - QuizQuestionCarouselView Definition
struct QuizQuestionCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var progressViewModel: ProgressViewModel // 1. Akses ProgressViewModel
    let quizTitle: String // Ini adalah judul kursus dari JapaneseCourse

    @State private var questions: [QuizQuestion] = [] //
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedOptionId: UUID? = nil
    @State private var score: Int = 0
    @State private var showResultsOverlay: Bool = false
    
    @State private var showAnswerNotification: Bool = false
    @State private var answerNotificationMessage: String = ""
    @State private var isAnswerCorrectForNotification: Bool = false
    
    @State private var userAnswers: [UUID: UUID] = [:]
    private var initialQuestions: [QuizQuestion] = [] //

    // 2. State untuk menyimpan courseID yang sesuai untuk progres
    @State private var courseIDForProgress: String? = nil

    // State untuk notifikasi penyelesaian kursus
    @State private var showingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""


    init(quizTitle: String) {
        self.quizTitle = quizTitle
        let loadedQuestions = QuizData.getQuestions(forQuizTitle: quizTitle) //
        self.initialQuestions = loadedQuestions
        _questions = State(initialValue: loadedQuestions)
    }

    var currentQuestion: QuizQuestion? { //
        guard !questions.isEmpty, currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    var body: some View {
        GeometryReader { geometry in // Tambahkan GeometryReader untuk akses safe area
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Header Kustom
                    HStack {
                        Button { presentationMode.wrappedValue.dismiss() } label: {
                            Image(systemName: "chevron.left").font(.title2.weight(.semibold)).padding(12)
                        }.foregroundColor(.blue)
                        Spacer()
                        Text(quizTitle).font(.title2.weight(.bold)).foregroundColor(.blue).lineLimit(1).minimumScaleFactor(0.7)
                        Spacer()
                        Image(systemName: "chevron.left").opacity(0).padding(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, geometry.safeAreaInsets.top) // Gunakan safeAreaInsets.top
                    .padding(.bottom, 15)
                    .background(Color.white)

                    // Progres Kuis
                    HStack {
                        Text("Question \(currentQuestionIndex + 1) / \(questions.count)")
                            .font(.caption).foregroundColor(.gray)
                        Spacer()
                        Text("Score: \(score)")
                            .font(.caption).foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .background(Color.white)

                    // Konten utama (Pertanyaan dan Pilihan)
                    if let question = currentQuestion {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 25) {
                                Text(question.questionText)
                                    .font(.system(size: 22, weight: .semibold)).lineSpacing(5)
                                    .frame(minHeight: 100, alignment: .center).frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center).padding(.horizontal)

                                VStack(spacing: 15) {
                                    ForEach(question.options) { option in //
                                        Button(action: {
                                            if !showAnswerNotification {
                                                selectedOptionId = option.id
                                            }
                                        }) {
                                            HStack {
                                                Text(option.text)
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(Color.primary)
                                                Spacer()
                                                if selectedOptionId == option.id && showAnswerNotification {
                                                    Image(systemName: isAnswerCorrectForNotification ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                        .foregroundColor(isAnswerCorrectForNotification ? .green : .red)
                                                } else if selectedOptionId == option.id {
                                                     Image(systemName: "circle.fill")
                                                        .font(.caption)
                                                        .foregroundColor(.blue)
                                                } else if showAnswerNotification && option.isCorrect {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .foregroundColor(.green)
                                                }
                                            }
                                            .padding(.vertical, 15).padding(.horizontal)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.white)
                                                    .shadow(color: selectedOptionId == option.id && !showAnswerNotification ? .blue.opacity(0.3) : .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(selectedOptionId == option.id && !showAnswerNotification ? Color.blue : Color.gray.opacity(0.3), lineWidth: selectedOptionId == option.id && !showAnswerNotification ? 2 : 1)
                                                    )
                                            )
                                        }
                                        .disabled(showAnswerNotification)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.top)
                        }
                        
                    } else if !showResultsOverlay {
                        Spacer()
                        Text("Loading quiz...").font(.title).frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    } else {
                        Spacer()
                    }
                    
                    Spacer()

                    // Tombol Aksi (Submit/Next)
                    HStack {
                        Spacer()
                        if showAnswerNotification {
                            Button(action: nextQuestion) {
                                Text(currentQuestionIndex == questions.count - 1 ? "Show Results" : "Next Question") // Ubah teks tombol terakhir
                                    .fontWeight(.semibold).padding().frame(maxWidth: .infinity)
                                    .background(isAnswerCorrectForNotification ? Color.green : Color.orange)
                                    .foregroundColor(.white).cornerRadius(10)
                            }
                        } else {
                            Button(action: submitAnswer) {
                                Text("Submit Answer").fontWeight(.semibold).padding().frame(maxWidth: .infinity)
                                    .background(selectedOptionId == nil ? Color.gray.opacity(0.5) : Color.blue)
                                    .foregroundColor(.white).cornerRadius(10)
                            }
                            .disabled(selectedOptionId == nil)
                        }
                        Spacer()
                    }
                    .padding()
                    // Menambahkan padding bawah untuk memberi ruang pada Navbar
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Tambahan 10pt agar tidak terlalu mepet
                }
                .background(Color.white.ignoresSafeArea())
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    // 3. Dapatkan courseID saat view muncul
                    if let appCourse = CourseDataProvider.shared.allAppCourses.first(where: { $0.title == self.quizTitle }) { //
                        self.courseIDForProgress = appCourse.id
                    } else {
                        print("Error: Tidak dapat menemukan AppCourse ID untuk Quiz: \(self.quizTitle)")
                    }
                }

                // Notifikasi Kustom
                if showAnswerNotification {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: isAnswerCorrectForNotification ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text(answerNotificationMessage)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isAnswerCorrectForNotification ? Color.green : Color.red)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 30)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 150) // Sesuaikan padding agar tidak terpotong
                    .animation(.spring(), value: showAnswerNotification)
                }


                // Overlay Hasil Kuis
                if showResultsOverlay {
                    Color.black.opacity(0.4).ignoresSafeArea().onTapGesture {}
                    QuizResultsView(
                        score: score, totalQuestions: questions.count,
                        onTryAgain: { resetQuiz(); showResultsOverlay = false },
                        onSeeOtherCourses: { presentationMode.wrappedValue.dismiss() },
                        onCompleteCourse: { // PANGGIL markCourseAsCompleted DI SINI
                            markCourseAsCompleted()
                            completionNotificationMessage = "You've completed the Quiz course!"
                            showingCompletionNotification = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Beri waktu notif terlihat
                                presentationMode.wrappedValue.dismiss() // Kembali ke daftar kuis setelah komplit
                            }
                        }
                    )
                    .transition(.opacity.combined(with: .scale))
                    // Pastikan overlay ini juga memiliki padding bawah yang cukup jika tombol-tombolnya ada di bagian bawah
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 10)
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
        .animation(.easeInOut, value: showResultsOverlay)
        .animation(.easeInOut, value: showingCompletionNotification) // Animasi untuk notifikasi
    }

    func submitAnswer() {
        guard let question = currentQuestion, let selectedId = selectedOptionId else { return }
        if let chosenOption = question.options.first(where: { $0.id == selectedId }) {
            userAnswers[question.id] = selectedId
            if chosenOption.isCorrect {
                score += 1
                answerNotificationMessage = "Good Job! Correct."
                isAnswerCorrectForNotification = true
            } else {
                answerNotificationMessage = "Wrong answer, try again later."
                isAnswerCorrectForNotification = false
            }
            withAnimation {
                showAnswerNotification = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    showAnswerNotification = false
                }
            }
        }
    }

    func nextQuestion() {
        showAnswerNotification = false
        selectedOptionId = nil

        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            // Kuis selesai
             DispatchQueue.main.asyncAfter(deadline: .now() + (showAnswerNotification ? 0.3 : 0) ) {
                showResultsOverlay = true
            }
        }
    }

    // Fungsi untuk menandai kursus selesai
    private func markCourseAsCompleted() {
        if let courseID = courseIDForProgress {
            progressViewModel.userCompletedCourse(courseID: courseID, userID: "dummyUser") // Ganti "dummyUser" nanti
            print("Quiz course '\(quizTitle)' (ID: \(courseID)) marked as completed.")
        } else {
            print("Tidak dapat menandai Quiz course '\(quizTitle)' selesai karena ID tidak ditemukan.")
        }
    }

    func resetQuiz() {
        score = 0
        currentQuestionIndex = 0
        questions = initialQuestions.shuffled()
        selectedOptionId = nil
        showAnswerNotification = false
        userAnswers = [:]
    }
}

#Preview {
    NavigationView {
        QuizQuestionCarouselView(quizTitle: "Hiragana Basics Quiz")
    }
    .environmentObject(ProgressViewModel()) //
}
