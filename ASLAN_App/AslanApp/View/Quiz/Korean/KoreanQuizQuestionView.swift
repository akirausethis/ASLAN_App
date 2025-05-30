// AslanApp/View/Quiz/KoreanQuizQuestionView.swift
import SwiftUI

struct KoreanQuizQuestionView: View {
    let question: KoreanQuizQuestion
    @Binding var selectedOptionId: UUID?
    @State private var showFeedback: Bool = false
    @State private var isCorrect: Bool = false

    var onAnswerSubmitted: ((_ isCorrect: Bool) -> Void)? // Callback saat jawaban dipilih

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.questionText)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)

            ForEach(question.options) { option in
                Button(action: {
                    if !showFeedback {
                        selectedOptionId = option.id
                        isCorrect = (option.id == question.correctAnswerId) // Perbandingan ini sekarang seharusnya berfungsi
                        showFeedback = true
                        onAnswerSubmitted?(isCorrect)
                    }
                }) {
                    HStack {
                        Text(option.text)
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                        if showFeedback && selectedOptionId == option.id {
                            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(isCorrect ? .green : .red)
                        } else if showFeedback && option.id == question.correctAnswerId {
                            // Menandai jawaban yang benar jika pengguna salah memilih
                             Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green.opacity(0.7))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(optionBackgroundColor(option: option))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor(option: option), lineWidth: 2)
                    )
                }
                .disabled(showFeedback) // Nonaktifkan tombol setelah jawaban dipilih
            }
            Spacer()
        }
        .padding()
    }

    func optionBackgroundColor(option: QuizOption) -> Color {
        guard let selectedOptionId = selectedOptionId, showFeedback else {
            return Color(UIColor.secondarySystemGroupedBackground) // Warna default
        }

        if selectedOptionId == option.id { // Opsi yang dipilih pengguna
            return isCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
        } else if option.id == question.correctAnswerId { // Jawaban yang benar (jika pengguna salah)
            return Color.green.opacity(0.1)
        }
        return Color(UIColor.secondarySystemGroupedBackground)
    }

    func borderColor(option: QuizOption) -> Color {
         guard let selectedOptionId = selectedOptionId, showFeedback else {
            return Color.gray.opacity(0.3) // Warna default
        }

        if selectedOptionId == option.id {
            return isCorrect ? Color.green : Color.red
        } else if option.id == question.correctAnswerId {
            return Color.green
        }
        return Color.gray.opacity(0.3)
    }
}

#Preview {
    // Contoh data untuk preview
    let sampleQuestion = KoreanQuizData.allQuizQuestions.first ?? KoreanQuizQuestion(
        courseTitle: "Sample",
        questionText: "Sample Question: What is 1+1?",
        options: [QuizOption(text: "1"), QuizOption(text: "2"), QuizOption(text: "3")],
        correctAnswerId: KoreanQuizData.allQuizQuestions.first?.options[1].id ?? UUID()
    )
    @State var selectedId: UUID? = nil
    return KoreanQuizQuestionView(question: sampleQuestion, selectedOptionId: $selectedId, onAnswerSubmitted: { correct in print("Answer correct: \(correct)") })
}
