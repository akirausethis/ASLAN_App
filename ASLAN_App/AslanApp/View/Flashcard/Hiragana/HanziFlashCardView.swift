// HiraganaFlashcardView.swiftAdd commentMore actions
import SwiftUI

struct HiraganaFlashcardView: View {
    let flashcard: HiraganaFlashcard

    var body: some View {
        VStack {
            Spacer()
            Text(flashcard.character)
                .font(.system(size: 150, weight: .bold)) // Large font for the character
                .foregroundColor(.black)
            Spacer()
            Text(flashcard.romaji)
                .font(.title)
                .foregroundColor(.blue) // Romaji text is blue
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 500) // Make card fill available vertical space
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.5), radius: 1, x: 0, y: 15)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2) // Blue outline
        )
        .padding(.horizontal)
    }
}

#Preview {
    HiraganaFlashcardView(flashcard: HiraganaFlashcard(character: "か", romaji: "ka"))
        .previewLayout(.sizeThatFits)
        .padding()Add commentMore actions
}
