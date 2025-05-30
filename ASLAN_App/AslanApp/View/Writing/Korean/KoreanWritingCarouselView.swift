import SwiftUI

struct KoreanWritingCarouselView: View {
    @Environment(\.presentationMode) var presentationMode

    let practiceType: String // "Hangul Basic" atau "Hangul Syllable"

    @State private var charactersToPractice: [any KoreanCharacterCard] = [] // Gunakan KoreanCharacterCard

    @State private var currentIndex: Int = 0 {
        didSet {
            clearDrawing()
            isShowingNotification = false
            notificationMessage = ""
            isNotificationSuccess = false
        }
    }

    @State private var currentDrawing: [CGPoint] = []
    @State private var drawings: [[CGPoint]] = []

    @State private var isShowingNotification: Bool = false
    @State private var notificationMessage: String = ""
    @State private var isNotificationSuccess: Bool = false

    private let minPointsForCompletion: Int = 50

    private var isDrawingSufficient: Bool {
        let totalPointsInDrawings = drawings.reduce(0) { $0 + $1.count }
        return totalPointsInDrawings >= minPointsForCompletion
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    Text(practiceType) // Judul "Hangul"
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 10)

                VStack(alignment: .center) {
                    Text("Please follow the stroke!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.bottom, 20)

                if !charactersToPractice.isEmpty {
                    KoreanDrawingCanvasView( // Gunakan KoreanDrawingCanvasView
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

                Spacer()

                HStack { // Tombol Navigasi
                    Button("Previous") { goToPreviousCharacter() }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .disabled(currentIndex == 0)

                    Button("Next") { handleNextButton() }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(currentIndex == charactersToPractice.count - 1)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)

                Button("Clear Drawing") { clearDrawing(); isShowingNotification = false }
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
                // Sesuaikan data berdasarkan practiceType jika perlu
                charactersToPractice = KoreanCharacterData.hangulCharacters.shuffled()
                if !charactersToPractice.isEmpty {
                    currentIndex = 0
                }
            }

            if isShowingNotification { // Notifikasi
                VStack {
                    NotificationView(message: notificationMessage, isSuccess: isNotificationSuccess, isShowing: $isShowingNotification)
                        .padding(.top, 10)
                    Spacer()
                }
            }
        }
    }

    private func handleNextButton() {
        if !isDrawingSufficient {
            notificationMessage = "You haven't finished the stroke!"
            isNotificationSuccess = false
            isShowingNotification = true
        } else {
            goToNextCharacter()
            notificationMessage = "Good Job!"
            isNotificationSuccess = true
            isShowingNotification = true
        }
    }
    
    private func clearDrawing() { DispatchQueue.main.async { currentDrawing = []; drawings = [] } }
    private func goToNextCharacter() { if currentIndex < charactersToPractice.count - 1 { withAnimation(.easeInOut) { currentIndex += 1 } } }
    private func goToPreviousCharacter() { if currentIndex > 0 { withAnimation(.easeInOut) { currentIndex -= 1 } } }
}

#Preview {
    KoreanWritingCarouselView(practiceType: "Hangul")
}
