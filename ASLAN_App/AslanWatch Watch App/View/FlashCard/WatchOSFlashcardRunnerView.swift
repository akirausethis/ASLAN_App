// akirausethis/aslan_app/ASLAN_App-Korean/ASLAN_App/AslanWatch Watch App/View/FlashCard/WatchOSFlashcardRunnerView.swift
import SwiftUI

struct WatchOSFlashcardRunnerView: View {
    let course: KoreanCourse
    @State private var flashcards: [any KoreanCharacterCard] = []
    @State private var currentIndex: Int = 0
    @State private var crownValue: Double = 0.0

    var body: some View {
        VStack(spacing: 8) { // Spacing disesuaikan
            if flashcards.isEmpty {
                Text("Memuat Kartu...")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .onAppear(perform: loadFlashcards)
            } else {
                Text("\(currentIndex + 1) / \(flashcards.count)")
                    .font(.caption) // Font lebih kecil untuk progress
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4) // Padding bawah

                TabView(selection: $currentIndex) {
                    ForEach(flashcards.indices, id: \.self) { index in
                        WatchOSSingleFlashcardView(card: flashcards[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .focusable(true)
                #if os(watchOS)
                .digitalCrownRotation(
                    $crownValue,
                    from: 0,
                    through: Double(flashcards.count > 0 ? flashcards.count - 1 : 0),
                    by: 1,
                    sensitivity: .medium,
                    isContinuous: false,
                    isHapticFeedbackEnabled: true
                )
                .onChange(of: crownValue) { newValue in
                    let newIndex = Int(newValue.rounded())
                    if newIndex >= 0 && newIndex < flashcards.count {
                        currentIndex = newIndex
                    }
                }
                #endif
            }
        }
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if flashcards.isEmpty {
                loadFlashcards()
            }
            crownValue = Double(currentIndex)
        }
    }

    func loadFlashcards() {
        self.flashcards = KoreanCharacterData.getFlashcardsForCourse(course.title)
        if !self.flashcards.isEmpty {
            self.currentIndex = 0
            self.crownValue = 0
        } else {
            self.currentIndex = 0
            self.crownValue = 0
            print("Peringatan: Tidak ada flashcard yang dimuat untuk kursus '\(course.title)'. Periksa logika di KoreanCharacterData.getFlashcardsForCourse.")
        }
    }
}

struct WatchOSFlashcardRunnerView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCourse = KoreanCourse(title: "Konsonan Dasar", subtitle: "Pelajari ㄱ, ㄴ, ㄷ...", iconName: "textformat.abc.dottedunderline")
        NavigationView {
            WatchOSFlashcardRunnerView(course: sampleCourse)
        }
    }
}
