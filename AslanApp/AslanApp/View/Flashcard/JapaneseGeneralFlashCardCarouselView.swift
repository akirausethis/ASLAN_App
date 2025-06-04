// AslanApp/View/Flashcard/JapaneseGeneralFlashCardCarouselView.swift
import SwiftUI

struct GeneralFlashcardCarouselView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var progressViewModel: ProgressViewModel // Akses ProgressViewModel

    // Menyimpan set flashcard awal untuk fitur "Try Again"
    private let initialFlashcards: [any JapaneseCharacterCard] //
    @State var availableFlashcards: [any JapaneseCharacterCard] //
    let title: String // Ini adalah judul kursus (misal: "Hiragana", "Kanji N5")

    @State private var currentFlashcard: (any JapaneseCharacterCard)? //
    @State private var translation: CGSize = .zero
    @State private var currentCardId: UUID?

    // State baru untuk mengontrol overlay "All Cards Seen"
    @State private var showAllCardsSeenOverlay: Bool = false

    // State untuk menyimpan courseID yang sesuai untuk progres
    @State private var courseIDForProgress: String? = nil

    // State baru untuk mengontrol visibilitas tombol Complete Course
    @State private var showCompleteCourseButton: Bool = false // TAMBAHKAN INI
    @State private var isButtonPressing: Bool = false // Untuk efek hover

    // State untuk notifikasi penyelesaian
    @State private var showingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""


    // Inisialisasi untuk menyimpan set kartu awal
    init(availableFlashcards: [any JapaneseCharacterCard], title: String) { //
        self.initialFlashcards = availableFlashcards // Simpan set awal
        // State diinisialisasi dengan data yang dioper
        _availableFlashcards = State(initialValue: availableFlashcards)
        self.title = title
    }

    var body: some View {
        GeometryReader { geometry in // Tambahkan GeometryReader
            ZStack { // ZStack untuk menempatkan overlay di atas konten utama
                VStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        Text("Flashcard")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, geometry.safeAreaInsets.top + 10) // Sesuaikan padding top
                    .padding(.bottom, 10)

                    VStack(alignment: .center) {
                        Text(title) // Judul kursus
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
                            AnyFlashcardView(flashcard: card)
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
                                .transition(.slide)
                                .id(card.id)
                        } else if !showAllCardsSeenOverlay { // Hanya tampilkan jika overlay belum aktif
                            Text(availableFlashcards.isEmpty ? "All \(title) flashcards seen!" : "Loading flashcards...") // Ubah teks sedikit
                                .font(.title2)
                                .foregroundColor(.gray)
                                .onAppear {
                                    // Jika kartu habis saat view muncul, tampilkan tombol complete
                                    if availableFlashcards.isEmpty && currentFlashcard == nil {
                                        if !initialFlashcards.isEmpty { // Pastikan ada kartu dari awal
                                            showCompleteCourseButton = true // Tampilkan tombol
                                        }
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 520) // Beri minHeight agar ZStack tidak collapse
                    
                    Spacer() // Mendorong ZStack kartu ke atas jika konten sedikit

                    // Tombol "Complete Course" - Tambahkan ini
                    if showCompleteCourseButton {
                        Button(action: {
                            markCourseAsCompleted()
                            completionNotificationMessage = "You've completed the Flashcard course!"
                            showingCompletionNotification = true
                            showAllCardsSeenOverlay = true // Tampilkan overlay setelah komplit
                        }) {
                            Text("Complete Course")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green) // Warna hijau untuk complete
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .scaleEffect(isButtonPressing ? 0.95 : 1.0) // Efek hover
                        .opacity(isButtonPressing ? 0.8 : 1.0)
                        .onLongPressGesture(minimumDuration: 0, pressing: { isPressing in
                            self.isButtonPressing = isPressing
                        }, perform: {})
                        .padding(.horizontal)
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    // Dapatkan courseID saat view muncul
                    if let appCourse = CourseDataProvider.shared.allAppCourses.first(where: { $0.title == self.title }) { //
                        self.courseIDForProgress = appCourse.id
                    } else {
                        print("Error: Tidak dapat menemukan AppCourse ID untuk Flashcard: \(self.title)")
                    }
                    loadNextFlashcard()
                }

                // Overlay View untuk "All Cards Seen"
                if showAllCardsSeenOverlay {
                    Color.black.opacity(0.4) // Latar belakang gelap transparan
                        .ignoresSafeArea()
                        .onTapGesture {
                            // Opsional: tutup overlay jika diklik di luar area tombol
                            // showAllCardsSeenOverlay = false
                        }

                    AllCardsSeenView(
                        onTryAgain: {
                            resetFlashcards()
                            showAllCardsSeenOverlay = false
                            showCompleteCourseButton = false // Sembunyikan tombol saat retry
                        },
                        onSeeOtherCourses: {
                            presentationMode.wrappedValue.dismiss() // Kembali ke layar sebelumnya
                            showAllCardsSeenOverlay = false
                            showCompleteCourseButton = false // Sembunyikan tombol saat kembali
                        }
                    )
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah overlay
                }

                // Notifikasi overlay
                if showingCompletionNotification {
                    NotificationView(message: completionNotificationMessage, isSuccess: true, isShowing: $showingCompletionNotification)
                        .padding(.top, geometry.safeAreaInsets.top) // Gunakan safeAreaInsets.top
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1) // Pastikan notifikasi di atas konten lain
                }
            }
        }
        .animation(.easeInOut, value: showAllCardsSeenOverlay) // Animasi untuk kemunculan overlay
        .animation(.easeInOut, value: showCompleteCourseButton) // Animasi untuk tombol
        .animation(.easeInOut, value: showingCompletionNotification) // Animasi untuk notifikasi
    }
    
    enum SwipeDirection { case left, right }
    
    private func handleSwipe(direction: SwipeDirection) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            translation = CGSize(width: direction == .left ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, height: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let swipedCardId = currentFlashcard?.id {
                if let index = availableFlashcards.firstIndex(where: { $0.id == swipedCardId }) {
                    availableFlashcards.remove(at: index)
                }
            }
            translation = .zero
            loadNextFlashcard()
        }
    }
    
    private func loadNextFlashcard() {
        if availableFlashcards.isEmpty {
            currentFlashcard = nil
            // Tampilkan tombol "Complete Course" setelah semua kartu habis
            if !initialFlashcards.isEmpty { // Pastikan ada kartu dari awal
                 showCompleteCourseButton = true // Tampilkan tombol
            }
        } else {
            currentFlashcard = availableFlashcards.randomElement()
            if let current = currentFlashcard {
                 currentCardId = current.id
            }
        }
    }

    // Fungsi untuk menandai kursus selesai
    private func markCourseAsCompleted() {
        if let courseID = courseIDForProgress {
            progressViewModel.userCompletedCourse(courseID: courseID, userID: "dummyUser") // Ganti "dummyUser" nanti
            print("Flashcard course '\(title)' (ID: \(courseID)) marked as completed.")
        } else {
            print("Tidak dapat menandai Flashcard course '\(title)' selesai karena ID tidak ditemukan.")
        }
    }

    // Fungsi untuk mereset flashcard
    private func resetFlashcards() {
        availableFlashcards = initialFlashcards.shuffled() // Acak kembali set awal
        loadNextFlashcard()
        showCompleteCourseButton = false // Sembunyikan tombol saat reset
    }
}

// ... (AnyFlashcardView dan AllCardsSeenView tidak berubah) ...
// Saya tidak akan menyertakan kode AnyFlashcardView dan AllCardsSeenView lagi untuk menghemat ruang,
// Anda bisa pastikan kode tersebut tetap seperti sebelumnya.

struct AnyFlashcardView: View {
    let flashcard: any JapaneseCharacterCard //

    var body: some View {
        VStack(spacing: 8) {
            Text(flashcard.character)
                .font(.system(size: tentukanUkuranFont(untuk: flashcard.character), weight: .bold))
                .minimumScaleFactor(0.3)
                .lineLimit(flashcard.character.count > 3 ? 3 : 2)
                .padding(.horizontal, 5)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(minHeight: 100)

            if let kanjiCard = flashcard as? KanjiFlashcard { //
                Text(kanjiCard.meaning)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .padding(.top, 2)
                    .multilineTextAlignment(.center)

                VStack(spacing: 1) {
                    if let onyomi = kanjiCard.onyomi, !onyomi.isEmpty {
                        Text("On: \(onyomi.joined(separator: ", "))")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                    if let kunyomi = kanjiCard.kunyomi, !kunyomi.isEmpty {
                        Text("Kun: \(kunyomi.joined(separator: ", "))")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                }
                .padding(.top, 2)

            } else {
                Text(flashcard.romaji)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 5)
            }
        }
        .padding()
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

    private func tentukanUkuranFont(untuk karakter: String) -> CGFloat {
        let length = karakter.count
        if length == 1 { return 120 }
        if length == 2 { return 100 }
        if length == 3 { return 80 }
        if length <= 5 { return 70 }
        return 55
    }
}

// View baru untuk overlay "All Cards Seen" (BAGIAN INI DARI FILE YANG SAMA)
struct AllCardsSeenView: View {
    var onTryAgain: () -> Void
    var onSeeOtherCourses: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Well Done!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text("You've seen all of the flashcards in this course.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(UIColor.label)) // Adaptif terhadap dark/light mode

            Text("Would you like to try again?")
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel))

            VStack(spacing: 15) {
                Button(action: onTryAgain) {
                    Text("Yes, Try Again!")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: onSeeOtherCourses) {
                    Text("No, See Other Courses")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
            }
        }
        .padding(30) // Padding untuk konten di dalam kotak overlay
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground)) // Latar belakang kotak overlay
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 40) // Jarak kotak overlay dari tepi layar
    }
}


#Preview {
    // Untuk Preview, kita bisa simulasikan data kosong atau data sedikit
    GeneralFlashcardCarouselView(
        // availableFlashcards: [], // Coba dengan data kosong untuk melihat overlay
        availableFlashcards: [
            HiraganaFlashcard(character: "あ", romaji: "a"), //
            KatakanaFlashcard(character: "ア", romaji: "a") //
        ].shuffled(),
        title: "Preview All Seen"
    )
    .environmentObject(ProgressViewModel()) //
}
