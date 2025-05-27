// KatakanaFlashcardView.swift
import SwiftUI

struct KatakanaFlashcardView: View {
    let flashcard: KatakanaFlashcard // Menggunakan model KatakanaFlashcard

    var body: some View {
        VStack {
            Text(flashcard.character)
                .font(.system(size: 150, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 10)

            Text(flashcard.romaji)
                .font(.title)
                .foregroundColor(.blue)
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
    KatakanaFlashcardView(flashcard: KatakanaFlashcard(character: "カ", romaji: "ka"))
        .previewLayout(.sizeThatFits)
        .padding()
}
