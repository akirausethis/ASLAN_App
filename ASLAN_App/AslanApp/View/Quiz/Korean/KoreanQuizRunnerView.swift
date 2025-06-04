// AslanApp/View/Quiz/KoreanQuizRunnerView.swift
import SwiftUI

struct KoreanQuizRunnerView: View {
    @Environment(\.presentationMode) var presentationMode
    let course: KoreanQuizCourse // Kursus kuis yang sedang dijalankan

    @State private var questions: [KoreanQuizQuestion] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedOptionId: UUID? = nil
    @State private var score: Int = 0
    @State private var quizCompleted: Bool = false
    @State private var showFeedbackForCurrentQuestion: Bool = false

    var currentQuestion: KoreanQuizQuestion? {
        guard questions.indices.contains(currentQuestionIndex) else { return nil }
        return questions[currentQuestionIndex]
    }

    var body: some View {
        VStack {
            // Header
            ZStack(alignment: .leading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .padding(.leading)

                Text(course.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top)
            .padding(.bottom, 10)

            // Progress
            HStack {
                Text("Question: \(currentQuestionIndex + 1) / \(questions.count)")
                Spacer()
                Text("Score: \(score)")
            }
            .font(.headline)
            .padding(.horizontal)
            .padding(.bottom, 20)

            // Question View
            if let question = currentQuestion, !quizCompleted {
                KoreanQuizQuestionView(
                    question: question,
                    selectedOptionId: $selectedOptionId,
                    onAnswerSubmitted: { isCorrect in
                        if isCorrect {
                            score += 1
                        }
                        showFeedbackForCurrentQuestion = true
                    }
                )
                .id(question.id) // Untuk memastikan view di-refresh saat pertanyaan berganti
            } else if quizCompleted {
                QuizResultView(score: score, totalQuestions: questions.count, onRestart: restartQuiz, onExit: { presentationMode.wrappedValue.dismiss() })
            } else {
                Text("Loading quiz...")
                    .onAppear(perform: loadQuestions)
            }

            Spacer()

            // Next Button
            if showFeedbackForCurrentQuestion && !quizCompleted {
                Button(action: goToNextQuestion) {
                    Text(currentQuestionIndex == questions.count - 1 ? "Show Results" : "Next Question")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadQuestions)
    }

    func loadQuestions() {
        self.questions = KoreanQuizData.questions(forCourseTitle: course.title).shuffled()
        self.currentQuestionIndex = 0
        self.score = 0
        self.selectedOptionId = nil
        self.quizCompleted = false
        self.showFeedbackForCurrentQuestion = false
    }

    func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedOptionId = nil
            showFeedbackForCurrentQuestion = false
        } else {
            quizCompleted = true
            showFeedbackForCurrentQuestion = false
        }
    }

    func restartQuiz() {
        loadQuestions()
    }
}

// View untuk menampilkan hasil kuis
struct QuizResultView: View {
    let score: Int
    let totalQuestions: Int
    var onRestart: () -> Void
    var onExit: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("Quiz Completed!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Text("Your Score:")
                .font(.title2)

            Text("\(score) / \(totalQuestions)")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(score > totalQuestions / 2 ? .green : .orange)

            HStack(spacing: 20) {
                Button(action: onRestart) {
                    Label("Restart Quiz", systemImage: "arrow.clockwise")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: onExit) {
                    Label("Exit", systemImage: "xmark.circle")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}


#Preview {
    let sampleCourse = KoreanQuizCourse(title: "Basic Vocabulary Quiz", subtitle: "Test your basic Korean words", iconName: "questionmark.circle.fill")
    return KoreanQuizRunnerView(course: sampleCourse)
}
