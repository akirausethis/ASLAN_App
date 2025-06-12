import SwiftUI

struct KoreanFlashCardCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @EnvironmentObject var themeManager: ThemeManager

    let course: KoreanCourse

    @State private var initialFlashcards: [HangulFlashcard] = []
    @State private var availableFlashcards: [HangulFlashcard] = []
    @State private var currentFlashcard: HangulFlashcard?
    @State private var translation: CGSize = .zero
    @State private var currentCardId: UUID?

    @State private var isShowingCompletionScreen: Bool = false
    @State private var isShowingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""
    @State private var completionNotificationIsSuccess: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // --- KONTEN UTAMA ---
                VStack(alignment: .leading, spacing: 0) {
                    // Header Section
                    ZStack {
                        Text("Flashcard")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.accentColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, geometry.safeAreaInsets.top + 5)
                    .padding(.bottom, 5)

                    VStack(alignment: .center, spacing: 4) {
                        Text(course.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(themeManager.accentColor.opacity(0.9))
                        Text("Swipe left or right to change flashcards")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.bottom, 15)

                    // Flashcard Display Area
                    GeometryReader { cardAreaGeometry in
                        ZStack(alignment: .center) {
                            if isShowingCompletionScreen {
                                FlashcardCompletionView(
                                    courseTitle: course.title,
                                    themeColor: themeManager.accentColor,
                                    onComplete: completeCourseAction,
                                    onTryAgain: resetCourse
                                )
                                .transition(.scale.combined(with: .opacity))
                            } else if let card = currentFlashcard {
                                KoreanFlashCardView(
                                    flashcard: card,
                                    parentGeometryProxy: cardAreaGeometry,
                                    themeColor: themeManager.accentColor
                                )
                                .offset(x: translation.width, y: 0)
                                .rotationEffect(.degrees(translation.width / 10))
                                .opacity(1 - abs(translation.width) / 300.0)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in translation = value.translation }
                                        .onEnded { value in
                                            let swipeThreshold: CGFloat = 100
                                            if value.translation.width < -swipeThreshold {
                                                handleSwipe(direction: .left)
                                            } else if value.translation.width > swipeThreshold {
                                                handleSwipe(direction: .right)
                                            } else {
                                                withAnimation(.spring()) { translation = .zero }
                                            }
                                        }
                                )
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                                .id(card.id)
                            } else {
                                ProgressView() // Tampilan loading
                            }
                        }
                        .frame(width: cardAreaGeometry.size.width, height: cardAreaGeometry.size.height)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom + 20)

                // --- TOMBOL KEMBALI (BACK BUTTON) ---
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title3.weight(.heavy))
                            .foregroundColor(themeManager.accentColor)
                            .padding(10)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, geometry.safeAreaInsets.top)


                // Notification View (Overlay)
                if isShowingCompletionNotification {
                    VStack {
                        NotificationView(
                            message: completionNotificationMessage,
                            isSuccess: completionNotificationIsSuccess,
                            isShowing: $isShowingCompletionNotification
                        )
                        .padding(.top, geometry.safeAreaInsets.top > 0 ? geometry.safeAreaInsets.top : 10)
                        Spacer()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(100)
                }
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .navigationBarHidden(true) // Nav bar default tetap disembunyikan
            .onAppear {
                loadFlashcardsForCourse()
            }
            .animation(.easeInOut(duration: 0.3), value: isShowingCompletionScreen)
            .animation(.easeInOut(duration: 0.3), value: currentFlashcard?.id)
            .animation(.easeInOut, value: isShowingCompletionNotification)
        }
    }

    // ... (Semua fungsi private lainnya tetap sama)
    enum SwipeDirection { case left, right }

    private func handleSwipe(direction: SwipeDirection) {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.2)) {
            translation = CGSize(width: direction == .left ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, height: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if let swipedCardId = currentFlashcard?.id {
                availableFlashcards.removeAll { $0.id == swipedCardId }
            }
            translation = .zero
            loadNextFlashcard()
        }
    }

    private func loadFlashcardsForCourse() {
        let loadedCards = KoreanCharacterData.getFlashcardsForCourse(course.title).compactMap { $0 as? HangulFlashcard }
        self.initialFlashcards = loadedCards
        self.availableFlashcards = self.initialFlashcards.shuffled()
        if let firstCard = availableFlashcards.randomElement() {
            currentFlashcard = firstCard
            currentCardId = firstCard.id
        } else {
            currentFlashcard = nil
            if !initialFlashcards.isEmpty {
                isShowingCompletionScreen = true
            }
        }
    }

    private func loadNextFlashcard() {
        if let nextCard = availableFlashcards.randomElement() {
            currentFlashcard = nextCard
            currentCardId = nextCard.id
            isShowingCompletionScreen = false
        } else {
            currentFlashcard = nil
            if !initialFlashcards.isEmpty {
                isShowingCompletionScreen = true
            }
        }
    }

    private func completeCourseAction() {
        progressViewModel.userCompletedCourse(
            courseTitle: course.id,
            topicTitle: "",
            category: course.category
        )

        completionNotificationMessage = "You've completed the \(course.title) course!"
        completionNotificationIsSuccess = true
        withAnimation {
            isShowingCompletionNotification = true
        }
    }

    private func resetCourse() {
        availableFlashcards = initialFlashcards.shuffled()
        isShowingCompletionScreen = false
        if let firstCard = availableFlashcards.randomElement() {
             currentFlashcard = firstCard
             currentCardId = firstCard.id
        } else {
            currentFlashcard = nil
            if !initialFlashcards.isEmpty { isShowingCompletionScreen = true }
        }
    }
}

// ... (FlashcardCompletionView dan Preview tetap sama)

// Ubah FlashcardCompletionView agar menerima warna tema
struct FlashcardCompletionView: View {
    let courseTitle: String
    let themeColor: Color // <-- Terima warna tema
    let onComplete: () -> Void
    let onTryAgain: () -> Void

    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            Image(systemName: "party.popper.fill")
                .font(.system(size: 50, weight: .light))
                .foregroundColor(.orange)
            Text("Awesome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(themeColor) // <-- Gunakan warna tema
            Text("You've swiped through all flashcards in the '\(courseTitle)' set.")
                .font(.headline)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            VStack(spacing: 15) {
                Button(action: onComplete) {
                    Text("Complete Course & Mark Progress")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                Button(action: onTryAgain) {
                    Text("Review Again")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(themeColor.opacity(0.8)) // <-- Gunakan warna tema
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: themeColor.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
            }
            .padding(.top, 10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
        .background(Material.thin)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    NavigationView {
        // ... (kode preview tetap sama, pastikan ThemeManager ada)
    }
    .environmentObject(ProgressViewModel())
    .environmentObject(ThemeManager()) // <-- Jangan lupa tambahkan di preview
}
