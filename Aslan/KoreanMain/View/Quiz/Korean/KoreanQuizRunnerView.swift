import SwiftUI

// --- UI Helper: QuizProgressBar (Tidak ada perubahan) ---
struct QuizProgressBar: View {
    @EnvironmentObject var themeManager: ThemeManager
    var progress: CGFloat
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().fill(Color.gray.opacity(0.2)).frame(height: 12)
            Capsule().fill(themeManager.accentColor.gradient)
                .frame(width: max(0, progress * (UIScreen.main.bounds.width - 40)), height: 12)
                .animation(.spring(response: 0.5, dampingFraction: 0.8), value: progress)
        }.clipShape(Capsule())
    }
}


// --- Tampilan Utama Kuis ---
struct KoreanQuizRunnerView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @EnvironmentObject var themeManager: ThemeManager
    let course: KoreanQuizCourse

    @State private var questions: [KoreanQuizQuestion] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedOptionId: UUID? = nil
    @State private var score: Int = 0
    @State private var quizCompleted: Bool = false
    @State private var showFeedbackForCurrentQuestion: Bool = false
    @State private var progressAlreadyMarkedForThisSession: Bool = false
    @State private var questionTransitionId = UUID()
    
    var currentQuestion: KoreanQuizQuestion? {
        guard questions.indices.contains(currentQuestionIndex) else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var progress: CGFloat {
        questions.isEmpty ? 0 : CGFloat(currentQuestionIndex + 1) / CGFloat(questions.count)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack(alignment: .center) {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark").font(.title3.weight(.semibold))
                    }
                    Spacer()
                    Text("Score: \(score)").font(.headline).fontWeight(.semibold)
                }
                Text(course.title).font(.headline).fontWeight(.bold)
            }
            .foregroundColor(themeManager.accentColor)
            .padding(.horizontal).padding(.vertical, 10)
            
            // Progress Bar Animasi
            QuizProgressBar(progress: progress).padding(.horizontal).padding(.bottom, 15)
            
            // --- PERUBAHAN UTAMA PADA LAYOUT ---
            // Area Konten Utama
            if let question = currentQuestion, !quizCompleted {
                // Dibuat di dalam ScrollView agar konten panjang bisa di-scroll
                ScrollView {
                    KoreanQuizQuestionView(question: question, selectedOptionId: $selectedOptionId, onAnswerSubmitted: { isCorrect in
                        if isCorrect { score += 1 }
                        withAnimation { showFeedbackForCurrentQuestion = true }
                    })
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)).combined(with: .opacity))
                .id(questionTransitionId)
                
            } else if quizCompleted {
                // Tampilan hasil kuis akan memakan seluruh ruang yang tersedia
                QuizResultView(score: score, totalQuestions: questions.count, themeColor: themeManager.accentColor, onRestart: restartQuiz, onExit: { presentationMode.wrappedValue.dismiss() })
                .onAppear(perform: markCourseAsCompletedOnQuizEnd)
                
            } else {
                // Tampilan loading
                Spacer()
                ProgressView("Loading quiz...")
                Spacer()
            }
            
            // Spacer ini akan mendorong tombol ke bawah jika konten pertanyaan pendek
            if !showFeedbackForCurrentQuestion {
                 Spacer()
            }

            // Tombol "Next"
            if showFeedbackForCurrentQuestion && !quizCompleted {
                // Spacer ini memastikan tombol tidak menempel pada konten di atasnya
                Spacer(minLength: 15)
                
                Button(action: goToNextQuestion) {
                    Label(currentQuestionIndex == questions.count - 1 ? "Show Results" : "Next Question", systemImage: "arrow.right")
                        .font(.headline).fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(themeManager.accentColor.gradient)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: themeManager.accentColor.opacity(0.4), radius: 8, y: 4)
                }
                .padding(.horizontal)
                .padding(.bottom, 40) // Jarak aman dari tepi bawah
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear {
            if questions.isEmpty { loadQuestions() }
            if !quizCompleted { progressAlreadyMarkedForThisSession = false }
        }
    }
    
    // ... (Fungsi-fungsi tidak berubah)
    func loadQuestions() {
        self.questions = KoreanQuizData.questions(forCourseTitle: course.title).shuffled()
        restartQuiz()
    }
    func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            withAnimation {
                currentQuestionIndex += 1
                selectedOptionId = nil
                showFeedbackForCurrentQuestion = false
                questionTransitionId = UUID()
            }
        } else {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                quizCompleted = true
            }
        }
    }
    func restartQuiz() {
        withAnimation {
            score = 0
            currentQuestionIndex = 0
            selectedOptionId = nil
            showFeedbackForCurrentQuestion = false
            quizCompleted = false
            progressAlreadyMarkedForThisSession = false
            questionTransitionId = UUID()
        }
    }
    private func markCourseAsCompletedOnQuizEnd() {
        guard !progressAlreadyMarkedForThisSession else { return }
        progressViewModel.userCompletedCourse(courseTitle: course.stringID, topicTitle: "", category: "Quiz")
        progressAlreadyMarkedForThisSession = true
    }
}


// --- Tampilan Hasil Kuis (Tidak berubah) ---
struct QuizResultView: View {
    let score: Int
    let totalQuestions: Int
    let themeColor: Color
    var onRestart: () -> Void
    var onExit: () -> Void

    @State private var animate = false
    @State private var confettiCounter: Int = 0
    
    private var percentage: Double {
        totalQuestions == 0 ? 0 : Double(score) / Double(totalQuestions)
    }
    
    private var resultMessage: (title: String, subtitle: String) {
        switch percentage {
        case 0.9...: return ("Awesome!", "You're a true master!")
        case 0.7...: return ("Great Job!", "You've got a solid knowledge.")
        case 0.4...: return ("Good Effort!", "Keep practicing to improve.")
        default: return ("Keep Going!", "Practice makes perfect.")
        }
    }

    var body: some View {
        ZStack {
            ConfettiCannonView(counter: $confettiCounter)
            
            ScrollView {
                VStack(spacing: 25) {
                    VStack {
                        Text(resultMessage.title)
                            .font(.system(size: 45, weight: .bold, design: .rounded))
                            .foregroundColor(themeColor)
                        
                        Text(resultMessage.subtitle)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .scaleEffect(animate ? 1 : 0.8)
                    .opacity(animate ? 1 : 0)

                    VStack(spacing: 10) {
                        Text("YOUR SCORE")
                            .font(.subheadline).fontWeight(.bold).foregroundColor(.secondary)
                        Text("\(score) / \(totalQuestions)")
                            .font(.system(size: 70, weight: .bold, design: .rounded)).foregroundColor(.primary)
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scaleEffect(animate ? 1 : 0.8)
                    .opacity(animate ? 1 : 0)
                    .animation(.spring().delay(0.2), value: animate)

                    VStack(spacing: 15) {
                        Button(action: onRestart) {
                            Label("Restart Quiz", systemImage: "arrow.clockwise")
                                .font(.headline).fontWeight(.bold)
                                .padding().frame(maxWidth: .infinity)
                                .background(themeColor.gradient)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(color: themeColor.opacity(0.4), radius: 8, y: 4)
                        }
                        Button(action: onExit) {
                            Text("Back to Course List")
                                .font(.headline).fontWeight(.bold)
                                .padding().frame(maxWidth: .infinity)
                        }
                    }
                    .scaleEffect(animate ? 1 : 0.8)
                    .opacity(animate ? 1 : 0)
                    .animation(.spring().delay(0.4), value: animate)
                }
                .padding()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                animate = true
            }
            if percentage >= 0.7 {
                confettiCounter += 1
            }
        }
    }
}
