// AslanApp/View/Writing/JapaneseWritingCarouselView.swift
import SwiftUI

// DEFINISI AllWritingDoneView
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
    @EnvironmentObject var progressViewModel: ProgressViewModel // 1. Akses ProgressViewModel

    let practiceType: String // Ini adalah judul kursus (misal: "Hiragana", "Kanji N5 - Writing")
    
    @State private var initialCharactersToPractice: [any JapaneseCharacterCard] = [] //
    @State private var charactersToPractice: [any JapaneseCharacterCard] = [] //

    @State private var currentIndex: Int = 0 {
        didSet {
            if oldValue != currentIndex {
                clearDrawing()
            }
        }
    }

    @State private var currentDrawing: [CGPoint] = []
    @State private var drawings: [[CGPoint]] = []

    @State private var isShowingNotification: Bool = false
    @State private var notificationMessage: String = ""
    @State private var isNotificationSuccess: Bool = false
    
    @State private var showAllWrittenOverlay: Bool = false

    // State baru untuk mengontrol visibilitas tombol Complete Course
    @State private var showCompleteCourseButton: Bool = false // TAMBAHKAN INI
    @State private var isButtonPressing: Bool = false // Untuk efek hover pada tombol Complete Course

    // 2. State untuk menyimpan courseID yang sesuai untuk progres
    @State private var courseIDForProgress: String? = nil

    // State untuk notifikasi penyelesaian kursus
    @State private var showingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""


    private let minPointsForCompletion: Int = 30 // Minimal titik agar dianggap sudah menulis

    private var isDrawingSufficient: Bool {
        let totalPointsInDrawings = drawings.reduce(0) { $0 + $1.count }
        return totalPointsInDrawings >= minPointsForCompletion
    }

    var body: some View {
        GeometryReader { geometry in // Tambahkan GeometryReader
            ZStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .center) {
                        Text("Please follow the stroke!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.top, geometry.safeAreaInsets.top + 15) // Sesuaikan padding top
                    .padding(.bottom, 15)

                    if !charactersToPractice.isEmpty && currentIndex < charactersToPractice.count {
                        JapaneseDrawingCanvasView( //
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal)
                    } else if !showAllWrittenOverlay && charactersToPractice.isEmpty && !initialCharactersToPractice.isEmpty {
                         Text("Preparing to show completion...")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal)
                    } else {
                        Spacer()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Spacer(minLength: 20)

                    HStack {
                        Button(action: goToPreviousCharacter) {
                            Text("Previous").modifier(NavButtonModifier(backgroundColor: Color.gray.opacity(0.3), foregroundColor: .black))
                        }
                        .disabled(currentIndex == 0 || charactersToPractice.isEmpty)

                        Button(action: handleNextButton) {
                            Text(currentIndex == charactersToPractice.count - 1 && !charactersToPractice.isEmpty ? "Review" : "Next") // Ubah teks tombol terakhir
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

                    // Tombol "Complete Course" - Tambahkan ini
                    if showCompleteCourseButton {
                        Button(action: {
                            markCourseAsCompleted()
                            completionNotificationMessage = "You've completed the Writing course!"
                            showingCompletionNotification = true
                            showAllWrittenOverlay = true // Tampilkan overlay setelah komplit
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
                .padding(.top) // Ini padding untuk VStack, bukan padding keseluruhan
                .padding(.bottom, showCompleteCourseButton ? 0 : geometry.safeAreaInsets.bottom + 10) // Jika tombol complete muncul, padding sudah di tombol
                                                                                                    // Jika tidak, tambahkan padding untuk tombol di bawahnya.


                if isShowingNotification {
                    VStack {
                        NotificationView(message: notificationMessage, isSuccess: isNotificationSuccess, isShowing: $isShowingNotification) //
                            .padding(.top, geometry.safeAreaInsets.top) // Gunakan safeAreaInsets.top
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.top)
                }
                
                if showAllWrittenOverlay {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {}

                    AllWritingDoneView(
                        onTryAgain: {
                            resetWritingPractice()
                            showAllWrittenOverlay = false
                            showCompleteCourseButton = false // Sembunyikan tombol saat retry
                        },
                        onSeeOtherCourses: {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.8)))
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah overlay
                }

                // Notifikasi penyelesaian kursus
                if showingCompletionNotification {
                    NotificationView(message: completionNotificationMessage, isSuccess: true, isShowing: $showingCompletionNotification)
                        .padding(.top, geometry.safeAreaInsets.top) // Gunakan safeAreaInsets.top
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1) // Pastikan notifikasi di atas konten lain
                }
            }
        }
        .animation(.easeInOut, value: showAllWrittenOverlay)
        .animation(.easeInOut, value: showCompleteCourseButton) // Animasi untuk tombol
        .animation(.easeInOut, value: showingCompletionNotification) // Animasi untuk notifikasi
        .onAppear {
            // 3. Dapatkan courseID saat view muncul
            if let appCourse = CourseDataProvider.shared.allAppCourses.first(where: { $0.title == self.practiceType }) { //
                self.courseIDForProgress = appCourse.id
            } else {
                print("Error: Tidak dapat menemukan AppCourse ID untuk Writing practice: \(self.practiceType)")
            }
            setupInitialCharactersAndPracticeSet()
        }
        .animation(.default, value: currentIndex)
        .navigationTitle(practiceType)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func setupInitialCharactersAndPracticeSet() {
        let loadedChars = loadCharacters(for: practiceType)
        self.initialCharactersToPractice = loadedChars
        self.charactersToPractice = loadedChars.shuffled()
        self.currentIndex = 0
        clearDrawing()
        self.showAllWrittenOverlay = false
        self.showCompleteCourseButton = false // Pastikan tersembunyi saat setup
    }

    private func loadCharacters(for type: String) -> [any JapaneseCharacterCard] { //
        // Menggunakan JapaneseCharacterData untuk mengambil data karakter
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
            isShowingNotification = true
        } else {
            isNotificationSuccess = true
            
            if currentIndex == charactersToPractice.count - 1 {
                // Notifikasi Good Job untuk karakter terakhir (opsional, bisa dihilangkan jika ingin notif Complete Course saja)
                notificationMessage = "Good Job! Set Complete!"
                isShowingNotification = true
                showCompleteCourseButton = true // Tampilkan tombol Complete Course
            } else {
                notificationMessage = "Good Job!"
                isShowingNotification = true
                goToNextCharacter()
            }
        }
    }

    // Fungsi untuk menandai kursus selesai
    private func markCourseAsCompleted() {
        if let courseID = courseIDForProgress {
            progressViewModel.userCompletedCourse(courseID: courseID, userID: "dummyUser") // Ganti "dummyUser" nanti
            print("Writing course '\(practiceType)' (ID: \(courseID)) marked as completed.")
        } else {
            print("Tidak dapat menandai Writing course '\(practiceType)' selesai karena ID tidak ditemukan.")
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
        showCompleteCourseButton = false // Sembunyikan tombol saat reset
    }
}


#Preview {
    NavigationView {
        JapaneseWritingCarouselView(practiceType: "Hiragana")
    }
    .environmentObject(ProgressViewModel()) //
}
