// AslanApp/View/Quiz/QuizQuestionCarouselView.swift
import SwiftUI

// MARK: - QuizResultsView Definition (Sama seperti sebelumnya)
struct QuizResultsView: View {
    let score: Int
    let totalQuestions: Int
    var onTryAgain: () -> Void
    var onSeeOtherCourses: () -> Void

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
                Button(action: onSeeOtherCourses) {
                    Text("Back to Quiz List").fontWeight(.semibold)
                        .frame(maxWidth: .infinity).padding().background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue).cornerRadius(10)
                }
            }
        }
        .padding(30).frame(maxWidth: .infinity)
        .background(Color.white) // Latar belakang putih
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.4), radius: 10) // Shadow sedikit lebih gelap
        .padding(.horizontal, 40)
    }
}


// MARK: - QuizQuestionCarouselView Definition
struct QuizQuestionCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    let quizTitle: String

    @State private var questions: [QuizQuestion] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedOptionId: UUID? = nil
    @State private var score: Int = 0
    @State private var showResultsOverlay: Bool = false
    
    // State untuk notifikasi custom
    @State private var showAnswerNotification: Bool = false
    @State private var answerNotificationMessage: String = ""
    @State private var isAnswerCorrectForNotification: Bool = false
    
    @State private var userAnswers: [UUID: UUID] = [:]
    private var initialQuestions: [QuizQuestion] = []

    init(quizTitle: String) {
        self.quizTitle = quizTitle
        let loadedQuestions = QuizData.getQuestions(forQuizTitle: quizTitle)
        self.initialQuestions = loadedQuestions
        _questions = State(initialValue: loadedQuestions)
    }

    var currentQuestion: QuizQuestion? {
        guard !questions.isEmpty, currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    var body: some View {
        ZStack { // ZStack utama untuk overlay hasil dan notifikasi
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
                .padding(.top, (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 0 + 5)
                .padding(.bottom, 15)
                .background(Color.white) // Latar belakang putih

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
                .background(Color.white) // Latar belakang putih

                // Konten utama (Pertanyaan dan Pilihan)
                if let question = currentQuestion {
                    ScrollView { // Tambahkan ScrollView di sini jika konten bisa panjang
                        VStack(alignment: .leading, spacing: 25) {
                            Text(question.questionText)
                                .font(.system(size: 22, weight: .semibold)).lineSpacing(5)
                                .frame(minHeight: 100, alignment: .center).frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center).padding(.horizontal)

                            VStack(spacing: 15) {
                                ForEach(question.options) { option in
                                    Button(action: {
                                        if !showAnswerNotification { // Hanya bisa memilih jika notifikasi tidak aktif
                                            selectedOptionId = option.id
                                        }
                                    }) {
                                        HStack {
                                            Text(option.text)
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color.primary) // Warna teks pilihan
                                            Spacer()
                                            // Tampilan checkmark setelah jawaban disubmit dan notifikasi hilang
                                            if selectedOptionId == option.id && showAnswerNotification { // Saat notifikasi aktif
                                                Image(systemName: isAnswerCorrectForNotification ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                    .foregroundColor(isAnswerCorrectForNotification ? .green : .red)
                                            } else if selectedOptionId == option.id { // Saat dipilih, sebelum submit
                                                 Image(systemName: "circle.fill") // Indikator terpilih
                                                    .font(.caption) // Lebih kecil
                                                    .foregroundColor(.blue)
                                            } else if showAnswerNotification && option.isCorrect { // Tampilkan jawaban benar setelah submit
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.green)
                                            }
                                        }
                                        .padding(.vertical, 15).padding(.horizontal)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white) // Pilihan jawaban selalu putih
                                                .shadow(color: selectedOptionId == option.id && !showAnswerNotification ? .blue.opacity(0.3) : .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                                                .overlay( // Border saat dipilih
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(selectedOptionId == option.id && !showAnswerNotification ? Color.blue : Color.gray.opacity(0.3), lineWidth: selectedOptionId == option.id && !showAnswerNotification ? 2 : 1)
                                                )
                                        )
                                    }
                                    .disabled(showAnswerNotification) // Nonaktifkan tombol saat notifikasi/feedback muncul
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                    } // Akhir ScrollView
                    
                } else if !showResultsOverlay {
                    Spacer()
                    Text("Loading quiz...").font(.title).frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                } else {
                    Spacer()
                }
                
                Spacer() // Mendorong tombol ke bawah

                // Tombol Aksi (Submit/Next)
                HStack {
                    Spacer()
                    // Tombol berubah fungsi tergantung apakah jawaban sudah disubmit (dan notifikasi muncul)
                    if showAnswerNotification {
                        Button(action: nextQuestion) {
                            Text(currentQuestionIndex == questions.count - 1 ? "Finish Quiz" : "Next Question")
                                .fontWeight(.semibold).padding().frame(maxWidth: .infinity)
                                .background(isAnswerCorrectForNotification ? Color.green : Color.orange) // Warna beda jika salah
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
                .padding(.bottom, 20)
            }
            .background(Color.white.ignoresSafeArea()) // Latar belakang utama putih
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

            // Notifikasi Kustom (Mirip NotificationView.swift)
            if showAnswerNotification {
                VStack { // VStack untuk menempatkan notifikasi di atas
                    Spacer() // Mendorong notifikasi ke tengah jika diinginkan, atau atur padding
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
                    // Spacer() // Uncomment jika ingin notifikasi benar-benar di tengah layar
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.3) // Posisi notifikasi agak ke bawah
                .animation(.spring(), value: showAnswerNotification)
            }


            // Overlay Hasil Kuis
            if showResultsOverlay {
                Color.black.opacity(0.4).ignoresSafeArea().onTapGesture {}
                QuizResultsView(
                    score: score, totalQuestions: questions.count,
                    onTryAgain: { resetQuiz(); showResultsOverlay = false },
                    onSeeOtherCourses: { presentationMode.wrappedValue.dismiss() }
                )
                .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.easeInOut, value: showResultsOverlay) // Animasi untuk ZStack utama
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
                answerNotificationMessage = "Wrong answer, try again later." // Atau "Wrong. The correct answer was..."
                isAnswerCorrectForNotification = false
            }
            withAnimation {
                showAnswerNotification = true
            }
            // Sembunyikan notifikasi setelah beberapa detik
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    showAnswerNotification = false
                }
            }
        }
    }

    func nextQuestion() {
        // Sembunyikan notifikasi jawaban sebelum pindah
        showAnswerNotification = false
        selectedOptionId = nil // Reset pilihan untuk pertanyaan berikutnya
        // answerFeedback sudah tidak digunakan, diganti notifikasi kustom

        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            // Coba load jawaban user sebelumnya jika ada (opsional)
            // selectedOptionId = userAnswers[questions[currentQuestionIndex].id]
        } else {
            // Kuis selesai, tampilkan hasil setelah notifikasi terakhir (jika ada) hilang
             DispatchQueue.main.asyncAfter(deadline: .now() + (showAnswerNotification ? 0.3 : 0) ) { // Beri sedikit jeda jika notif masih ada
                showResultsOverlay = true
            }
        }
    }

    func resetQuiz() {
        score = 0
        currentQuestionIndex = 0
        questions = initialQuestions.shuffled()
        selectedOptionId = nil
        showAnswerNotification = false // Pastikan notifikasi disembunyikan
        userAnswers = [:]
    }
}

#Preview {
    NavigationView {
        QuizQuestionCarouselView(quizTitle: "Hiragana Basics Quiz")
    }
}
