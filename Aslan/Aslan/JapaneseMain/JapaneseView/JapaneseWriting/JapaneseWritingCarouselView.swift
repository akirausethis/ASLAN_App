// AslanApp/View/Writing/JapaneseWritingCarouselView.swift
import SwiftUI

// DEFINISI AllWritingDoneView DITARUH DI SINI (atau di file terpisah dan diimpor)
struct AllWritingDoneView: View {
    var onTryAgain: () -> Void
    var onSeeOtherCourses: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("✏️ Practice Complete! ✏️")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text("You've practiced all characters in this set.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(UIColor.label))

            Text("Would you like to practice them again?")
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel))

            VStack(spacing: 15) {
                Button(action: onTryAgain) {
                    Text("Yes, Practice Again!")
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
        .padding(30)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 40)
    }
}

// Modifier untuk konsistensi tombol navigasi (Next, Previous, Clear)
struct NavButtonModifier: ViewModifier {
    let backgroundColor: Color
    let foregroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
    }
}


struct JapaneseWritingCarouselView: View {
    @Environment(\.presentationMode) var presentationMode

    let practiceType: String // Ini adalah judul kursus
    
    @State private var initialCharactersToPractice: [any JapaneseCharacterCard] = []
    @State private var charactersToPractice: [any JapaneseCharacterCard] = []

    @State private var currentIndex: Int = 0 {
        didSet {
            if oldValue != currentIndex {
                clearDrawing()
                // isShowingNotification = false // Biarkan NotificationView menghilang sendiri
            }
        }
    }

    @State private var currentDrawing: [CGPoint] = []
    @State private var drawings: [[CGPoint]] = []

    @State private var isShowingNotification: Bool = false
    @State private var notificationMessage: String = ""
    @State private var isNotificationSuccess: Bool = false
    
    @State private var showAllWrittenOverlay: Bool = false

    private let minPointsForCompletion: Int = 30

    private var isDrawingSufficient: Bool {
        let totalPointsInDrawings = drawings.reduce(0) { $0 + $1.count }
        return totalPointsInDrawings >= minPointsForCompletion
    }

    var body: some View {
        // TIDAK ADA NavigationView di sini
        ZStack {
            VStack(alignment: .leading) {
                // Header tidak lagi menggunakan ZStack dengan tombol back manual,
                // karena kita akan mengandalkan Navigation Bar dari parent.
                // Judul akan diatur oleh .navigationTitle()

                VStack(alignment: .center) { // Kontainer untuk instruksi
                    Text("Please follow the stroke!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 15) // Padding atas untuk instruksi
                .padding(.bottom, 15) // Padding bawah untuk instruksi


                // Drawing Canvas Area - Pastikan if-else if-else memiliki kurung kurawal yang benar
                // Baris 103 yang error kemungkinan ada di sekitar sini
                if !charactersToPractice.isEmpty && currentIndex < charactersToPractice.count {
                    JapaneseDrawingCanvasView(
                        character: charactersToPractice[currentIndex].character,
                        romaji: charactersToPractice[currentIndex].romaji,
                        currentDrawing: $currentDrawing,
                        drawings: $drawings
                    )
                    .id(charactersToPractice[currentIndex].id)
                } else if !showAllWrittenOverlay && initialCharactersToPractice.isEmpty && charactersToPractice.isEmpty {
                    Text("Loading characters or no characters available for \(practiceType)...")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Agar mengisi ruang
                        .padding(.horizontal)
                } else if !showAllWrittenOverlay && charactersToPractice.isEmpty && !initialCharactersToPractice.isEmpty {
                     Text("Preparing to show completion...")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Agar mengisi ruang
                        .padding(.horizontal)
                } else {
                    // Fallback jika kondisi di atas tidak terpenuhi tetapi harus ada view
                    Spacer() // Atau view placeholder lain
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Spacer(minLength: 20) // Beri jarak sebelum tombol

                // Tombol Navigasi
                HStack {
                    Button(action: goToPreviousCharacter) {
                        Text("Previous").modifier(NavButtonModifier(backgroundColor: Color.gray.opacity(0.3), foregroundColor: .black))
                    }
                    .disabled(currentIndex == 0 || charactersToPractice.isEmpty)

                    Button(action: handleNextButton) {
                        Text(currentIndex == charactersToPractice.count - 1 && !charactersToPractice.isEmpty ? "Finish" : "Next")
                            .modifier(NavButtonModifier(backgroundColor: .blue, foregroundColor: .white))
                    }
                    .disabled(charactersToPractice.isEmpty)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)

                Button("Clear Drawing") {
                    clearDrawing()
                    isShowingNotification = false
                }
                .modifier(NavButtonModifier(backgroundColor: Color.red.opacity(0.8), foregroundColor: .white))
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top) // Padding atas untuk keseluruhan VStack

            // Notifikasi Sukses/Gagal Goresan
            if isShowingNotification {
                VStack {
                    NotificationView(message: notificationMessage, isSuccess: isNotificationSuccess, isShowing: $isShowingNotification)
                        .padding(.top, (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 0)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
            }
            
            // Overlay "Selesai"
            if showAllWrittenOverlay {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {}

                AllWritingDoneView( // Pastikan struct ini sudah didefinisikan
                    onTryAgain: {
                        resetWritingPractice()
                        showAllWrittenOverlay = false
                    },
                    onSeeOtherCourses: {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
                .transition(.opacity.combined(with: .scale(scale: 0.8)))
            }
        }
        .animation(.easeInOut, value: showAllWrittenOverlay)
        .onAppear(perform: setupInitialCharactersAndPracticeSet)
        .animation(.default, value: currentIndex)
        // Mengatur judul di Navigation Bar, lebih kecil, dan rata tengah (efek dari .inline)
        .navigationTitle(practiceType) // Judul kursus
        .navigationBarTitleDisplayMode(.inline) // Membuat judul lebih kecil dan di tengah (bersama tombol back)
        // Pastikan TIDAK ADA .navigationBarHidden(true) di sini agar Nav Bar dari parent terlihat
    }

    private func setupInitialCharactersAndPracticeSet() {
        let loadedChars = loadCharacters(for: practiceType)
        self.initialCharactersToPractice = loadedChars
        self.charactersToPractice = loadedChars.shuffled()
        self.currentIndex = 0
        clearDrawing()
        self.showAllWrittenOverlay = false
    }

    private func loadCharacters(for type: String) -> [any JapaneseCharacterCard] {
        switch type {
        case "Hiragana": return JapaneseCharacterData.hiraganaCharacters
        case "Katakana": return JapaneseCharacterData.katakanaCharacters
        case "Kanji N5 - Writing": return JapaneseCharacterData.kanjiN5
        case "Kanji N4 - Writing": return JapaneseCharacterData.kanjiN4
        case "Kanji N3 - Writing": return JapaneseCharacterData.kanjiN3
        case "Kanji N2 - Writing": return JapaneseCharacterData.kanjiN2
        case "Kanji N1 - Writing": return JapaneseCharacterData.kanjiN1
        case "Intermediate Vocab & Kana - Writing": return JapaneseCharacterData.intermediateVocabAndKana
        case "Expert Vocab & Kana - Writing": return JapaneseCharacterData.expertVocabAndKana
        default:
            print("Warning: Unknown practice type for writing: '\(type)'. Returning empty set.")
            return []
        }
    }
    
    private func handleNextButton() {
        guard !charactersToPractice.isEmpty else { return }

        if !isDrawingSufficient {
            notificationMessage = "You haven't finished the stroke!"
            isNotificationSuccess = false
            isShowingNotification = true // Tampilkan notifikasi error
        } else {
            isNotificationSuccess = true // Set sukses
            
            if currentIndex == charactersToPractice.count - 1 {
                notificationMessage = "Good Job! Set Complete!"
                isShowingNotification = true // Tampilkan notifikasi "Set Complete"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    // self.isShowingNotification = false // Biarkan NotificationView hilang sendiri
                    self.showAllWrittenOverlay = true
                }
            } else {
                notificationMessage = "Good Job!"
                isShowingNotification = true // Tampilkan notifikasi "Good Job"
                goToNextCharacter()
            }
        }
    }

    private func clearDrawing() {
        currentDrawing = []
        drawings = []
    }

    private func goToNextCharacter() {
        if currentIndex < charactersToPractice.count - 1 {
            currentIndex += 1
        }
    }

    private func goToPreviousCharacter() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }

    private func resetWritingPractice() {
        guard !initialCharactersToPractice.isEmpty else {
            presentationMode.wrappedValue.dismiss()
            return
        }
        charactersToPractice = initialCharactersToPractice.shuffled()
        currentIndex = 0
        showAllWrittenOverlay = false
    }
}


#Preview {
    // Untuk Preview, selalu bungkus dengan NavigationView
    NavigationView {
        JapaneseWritingCarouselView(practiceType: "Hiragana")
    }
}
