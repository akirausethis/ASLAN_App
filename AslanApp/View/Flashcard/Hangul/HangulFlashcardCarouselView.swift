import SwiftUI

struct HangulFlashcardCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var availableFlashcards: [HangulFlashcard] = HangulFlashcard.allHangul.shuffled()
    @State private var currentFlashcard: HangulFlashcard?
    @State private var translation: CGSize = .zero
    @State private var currentCardId: UUID?

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text("Flashcard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 10)

            VStack(alignment: .center) {
                Text("Hangul") // Judul diubah
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text("Swipe left or right to change flashcards")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 20)

            ZStack {
                if let card = currentFlashcard {
                    HangulFlashcardView(flashcard: card) // Menggunakan HangulFlashcardView
                        .offset(x: translation.width, y: 0)
                        .rotationEffect(.degrees(translation.width / 10))
                        .opacity(1 - abs(translation.width) / 300.0)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    translation = value.translation
                                }
                                .onEnded { value in
                                    let swipeThreshold: CGFloat = 100
                                    if value.translation.width < -swipeThreshold {
                                        handleSwipe(direction: .left)
                                    } else if value.translation.width > swipeThreshold {
                                        handleSwipe(direction: .right)
                                    } else {
                                        withAnimation(.spring()) {
                                            translation = .zero
                                        }
                                    }
                                }
                        )
                        .transition(.slide)
                        .id(card.id)
                } else {
                    Text("No more flashcards!")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()

        }
        .navigationBarHidden(true)
        .onAppear {
            loadNextFlashcard()
        }
    }
    
    enum SwipeDirection { case left, right }
    
    private func handleSwipe(direction: SwipeDirection) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            translation = CGSize(width: direction == .left ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, height: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let swipedCardId = currentFlashcard?.id {
                availableFlashcards.removeAll { $0.id == swipedCardId }
            }
            translation = .zero
            loadNextFlashcard()
        }
    }
    
    private func loadNextFlashcard() {
        if let nextCard = availableFlashcards.randomElement() {
            currentFlashcard = nextCard
            currentCardId = nextCard.id
        } else {
            currentFlashcard = nil
        }
    }
}

#Preview {
    HangulFlashcardCarouselView()
}
