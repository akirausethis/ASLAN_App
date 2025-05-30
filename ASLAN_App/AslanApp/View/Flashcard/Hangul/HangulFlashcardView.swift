import SwiftUI

struct HangulFlashcardView: View {
    let flashcard: HangulFlashcard // Menggunakan model HangulFlashcard

    var body: some View {
        VStack {
            Spacer()
            Text(flashcard.character)
                .font(.system(size: 150, weight: .bold))
                .foregroundColor(.black)
            Spacer()
            Text(flashcard.romaji)
                .font(.title)
                .foregroundColor(.blue)
            Text(flashcard.name)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.5), radius: 1, x: 0, y: 15)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}

#Preview {
    HangulFlashcardView(flashcard: HangulFlashcard(character: "한", romaji: "han", name: ""))
        .previewLayout(.sizeThatFits)
        .padding()
}
