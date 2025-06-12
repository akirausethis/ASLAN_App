import SwiftUI

struct KoreanFlashCardView: View {
    let flashcard: HangulFlashcard
    var parentGeometryProxy: GeometryProxy?
    var themeColor: Color // <-- TAMBAHKAN INI

    private var cardWidthMultiplier: CGFloat = 0.85
    private var cardHeightMultiplier: CGFloat = 0.55
    private var defaultCardWidth: CGFloat = 300
    private var defaultCardHeight: CGFloat = 420

    // Modifikasi initializer untuk menerima themeColor
    init(flashcard: HangulFlashcard, parentGeometryProxy: GeometryProxy? = nil, themeColor: Color) {
        self.flashcard = flashcard
        self.parentGeometryProxy = parentGeometryProxy
        self.themeColor = themeColor
    }

    var body: some View {
        let cardWidth = parentGeometryProxy != nil ? parentGeometryProxy!.size.width * cardWidthMultiplier : defaultCardWidth
        let cardHeight = parentGeometryProxy != nil ? parentGeometryProxy!.size.height * cardHeightMultiplier : defaultCardHeight

        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 6, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(themeColor.opacity(0.8), lineWidth: 2.5) // <-- GUNAKAN WARNA TEMA DI SINI
                )

            VStack(alignment: .center, spacing: 15) {
                Spacer()

                Text(flashcard.character)
                    .font(.system(size: cardHeight * 0.3, weight: .bold))
                    .foregroundColor(themeColor) // <-- GUNAKAN WARNA TEMA DI SINI
                    .minimumScaleFactor(0.4)
                    .lineLimit(1)
                    .padding(.horizontal, 10)

                VStack(spacing: 5) {
                    if !flashcard.romaji.isEmpty {
                        Text(flashcard.romaji)
                            .font(.system(size: cardHeight * 0.07, weight: .medium))
                            .foregroundColor(Color.black.opacity(0.85))
                    }
                    if !flashcard.name.isEmpty {
                        Text(flashcard.name)
                            .font(.system(size: cardHeight * 0.055, weight: .regular))
                            .foregroundColor(.gray.opacity(0.9))
                    }
                }
                .padding(.bottom, cardHeight * 0.05)
                Spacer()
            }
            .padding(20)
        }
        .frame(width: cardWidth, height: cardHeight)
    }
}
