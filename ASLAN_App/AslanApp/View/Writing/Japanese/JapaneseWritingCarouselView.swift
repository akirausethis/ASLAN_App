import SwiftUI

// (Kode DrawingPad, JapaneseDrawingCanvasView, AnimatedNavbar, NavbarBackgroundShape,
// JapaneseMainPageView, CarouselView, CourseCardView, MainAppView,
// ProgressViewContent, ChatViewContent, ProfileViewContent, JapaneseCharacterData
// tetap sama.)

// MARK: - JapaneseWritingCarouselView (dengan notifikasi dari atas)
struct JapaneseWritingCarouselView: View {
    @Environment(\.presentationMode) var presentationMode

    let practiceType: String // "Hiragana" or "Katakana"

    @State private var charactersToPractice: [any JapaneseCharacterCard] = []

    @State private var currentIndex: Int = 0 {
        didSet {
            clearDrawing()
            // Reset notifikasi saat karakter berubah
            isShowingNotification = false
            notificationMessage = ""
            isNotificationSuccess = false
        }
    }

    @State private var currentDrawing: [CGPoint] = []
    @State private var drawings: [[CGPoint]] = []

    // MARK: - State untuk Notifikasi
    @State private var isShowingNotification: Bool = false
    @State private var notificationMessage: String = ""
    @State private var isNotificationSuccess: Bool = false

    // MARK: - Konstanta Ambang Batas untuk Kelengkapan Stroke
    private let minPointsForCompletion: Int = 50

    // MARK: - Computed Properties untuk validasi next
    private var isDrawingSufficient: Bool {
        let totalPointsInDrawings = drawings.reduce(0) { sum, pathPoints in
            sum + pathPoints.count
        }
        return totalPointsInDrawings >= minPointsForCompletion
    }

    var body: some View {
        ZStack { // Gunakan ZStack agar notifikasi bisa muncul di atas konten
            VStack(alignment: .leading) {
                // Header (BackButton dan Title)
                ZStack(alignment: .leading) {

                    Text(practiceType)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 10)

                // Instruction Text
                VStack(alignment: .center) {
                    Text("Please follow the stroke!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.bottom, 20)

                // Drawing Canvas
                if !charactersToPractice.isEmpty {
                    JapaneseDrawingCanvasView(
                        character: charactersToPractice[currentIndex].character,
                        romaji: charactersToPractice[currentIndex].romaji,
                        currentDrawing: $currentDrawing,
                        drawings: $drawings
                    )
                    .id(charactersToPractice[currentIndex].id)
                } else {
                    Text("No characters to practice!")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: 500)
                        .padding(.horizontal)
                }

                Spacer() // Dorong konten ke atas

                // Tombol Navigasi: Previous dan Next
                HStack {
                    Button(action: {
                        goToPreviousCharacter()
                    }) {
                        Text("Previous")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .disabled(currentIndex == 0)

                    Button(action: {
                        // Logika untuk tombol Next
                        if !isDrawingSufficient {
                            // Tampilkan notifikasi "belum selesai"
                            notificationMessage = "You haven't finished the stroke!"
                            isNotificationSuccess = false
                            isShowingNotification = true
                        } else {
                            // Lanjutkan ke karakter berikutnya jika stroke sudah cukup
                            goToNextCharacter()
                            // Tampilkan notifikasi "Good Job" sebentar
                            notificationMessage = "Good Job!"
                            isNotificationSuccess = true
                            isShowingNotification = true
                        }
                    }) {
                        Text("Next")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(currentIndex == charactersToPractice.count - 1)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)

                Button("Clear Drawing") {
                    clearDrawing()
                    isShowingNotification = false // Sembunyikan notifikasi jika clear drawing ditekan
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationBarHidden(true)
            .onAppear {
                if practiceType == "Hiragana" {
                    charactersToPractice = JapaneseCharacterData.hiraganaCharacters.shuffled()
                } else if practiceType == "Katakana" {
                    charactersToPractice = JapaneseCharacterData.katakanaCharacters.shuffled()
                }
                if !charactersToPractice.isEmpty {
                    currentIndex = 0
                }
            }

            // MARK: - Notifikasi Muncul di Sini (Di bagian atas ZStack)
            if isShowingNotification {
                VStack {
                    // Hapus Spacer() di sini karena kita ingin dia di atas
                    NotificationView(message: notificationMessage, isSuccess: isNotificationSuccess, isShowing: $isShowingNotification)
                        .padding(.top, 10) // Beri sedikit jarak dari atas layar
                    Spacer() // Dorong sisa konten ke bawah
                }
            }
        }
    }

    private func clearDrawing() {
        DispatchQueue.main.async {
            currentDrawing = []
            drawings = []
        }
    }

    private func goToNextCharacter() {
        if currentIndex < charactersToPractice.count - 1 {
            withAnimation(.easeInOut) {
                currentIndex += 1
            }
        }
    }

    private func goToPreviousCharacter() {
        if currentIndex > 0 {
            withAnimation(.easeInOut) {
                currentIndex -= 1
            }
        }
    }
}

// MARK: - Preview
struct JapaneseWritingCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        JapaneseWritingCarouselView(practiceType: "Katakana")
    }
}
