import SwiftUI

struct KoreanQuizQuestionView: View {
    let question: KoreanQuizQuestion
    @Binding var selectedOptionId: UUID?
    @State private var showFeedback: Bool = false
    @State private var isCorrect: Bool = false

    var onAnswerSubmitted: ((_ isCorrect: Bool) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // --- PERUBAHAN DI SINI ---
            Text(question.questionText)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center) // Membuat teks rata tengah
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .center) // Memastikan frame-nya juga di tengah

            // Pilihan Jawaban
            ForEach(question.options) { option in
                Button(action: {
                    if !showFeedback {
                        selectedOptionId = option.id
                        isCorrect = (option.id == question.correctAnswerId)
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
                                .font(.title2)
                        } else if showFeedback && option.id == question.correctAnswerId {
                             Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green.opacity(0.7))
                                .font(.title2)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(optionBackgroundColor(option: option))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor(option: option), lineWidth: 2)
                    )
                }
                .disabled(showFeedback)
            }
            Spacer()
        }
        .padding()
    }

    func optionBackgroundColor(option: QuizOption) -> Color {
        guard let selectedOptionId = selectedOptionId, showFeedback else { return Color(UIColor.secondarySystemGroupedBackground) }
        if selectedOptionId == option.id { return isCorrect ? .green.opacity(0.2) : .red.opacity(0.2) }
        else if option.id == question.correctAnswerId { return .green.opacity(0.1) }
        return Color(UIColor.secondarySystemGroupedBackground)
    }

    func borderColor(option: QuizOption) -> Color {
        guard let selectedOptionId = selectedOptionId, showFeedback else { return .clear }
        if selectedOptionId == option.id { return isCorrect ? .green : .red }
        else if option.id == question.correctAnswerId { return .green }
        return .clear
    }
}

// ... (Preview tidak berubah)
