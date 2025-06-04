import SwiftUI

// MARK: - KatakanaFlashcardCarouselView
struct KatakanaFlashcardCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var availableFlashcards: [KatakanaFlashcard] = KatakanaFlashcard.allKatakana.shuffled()
    
    @State private var currentFlashcard: KatakanaFlashcard?
    @State private var translation: CGSize = .zero
    @State private var currentCardId: UUID? // Masih berguna untuk .id() modifier

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
                Text("Katakana")
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
                    KatakanaFlashcardView(flashcard: card)
                        .offset(x: translation.width, y: 0)
                        .rotationEffect(.degrees(translation.width / 10))
                        // Tambahkan modifier opacity ini
                        .opacity(1 - abs(translation.width) / 300.0) // <-- INI MODIFIKASI UTAMA
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    translation = value.translation
                                }
                                .onEnded { value in
                                    let swipeThreshold: CGFloat = 100
                                    if value.translation.width < -swipeThreshold {
                                        print("Swiped left: \(card.character)")
                                        handleSwipe(direction: .left)
                                    } else if value.translation.width > swipeThreshold {
                                        print("Swiped right: \(card.character)")
                                        handleSwipe(direction: .right)
                                    } else {
                                        withAnimation(.spring()) {
                                            translation = .zero
                                        }
                                    }
                                }
                        )
                        .transition(.slide) // Tetap pertahankan transisi slide untuk masuk/keluar
                        .id(card.id) // Penting untuk animasi transisi
                } else {
                    Text("No more flashcards!")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity) // Pastikan ZStack mengambil lebar penuh
            
            Spacer() // Dorong konten ke atas
        }
        .navigationBarHidden(true)
        .onAppear {
            loadNextFlashcard()
        }
    }
    
    enum SwipeDirection {
        case left, right
    }
    
    private func handleSwipe(direction: SwipeDirection) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            translation = CGSize(width: direction == .left ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, height: 0)
            // Tidak perlu mengatur opacity di sini karena sudah diikat ke translation.width
        }
        
        // Delay sebentar sebelum memuat kartu berikutnya agar animasi selesai
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let swipedCardId = currentFlashcard?.id {
                availableFlashcards.removeAll { $0.id == swipedCardId }
            }
            translation = .zero // Reset translation untuk kartu baru
            loadNextFlashcard()
        }
    }
    
    private func loadNextFlashcard() {
        if let nextCard = availableFlashcards.randomElement() {
            currentFlashcard = nextCard
            currentCardId = nextCard.id // Perbarui ID untuk .id() modifier
        } else {
            currentFlashcard = nil
            print("All Katakana flashcards completed!")
        }
    }
}

#Preview {
    KatakanaFlashcardCarouselView()
}
