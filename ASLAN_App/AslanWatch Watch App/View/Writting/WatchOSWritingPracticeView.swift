// akirausethis/aslan_app/ASLAN_App-Korean/ASLAN_App/AslanWatch Watch App/View/Writing/WatchOSWritingPracticeView.swift
import SwiftUI

struct WatchOSWritingPracticeView: View {
    let course: KoreanCourse
    
    @State private var charactersToPractice: [any KoreanCharacterCard] = []
    @State private var currentIndex: Int = 0
    
    // Drawing states
    @State private var currentDrawing: [CGPoint] = []
    @State private var completedDrawings: [[CGPoint]] = []

    // Digital Crown
    @State private var crownValue: Double = 0.0

    var currentCharacter: (any KoreanCharacterCard)? {
        guard !charactersToPractice.isEmpty, charactersToPractice.indices.contains(currentIndex) else {
            return nil
        }
        return charactersToPractice[currentIndex]
    }

    var body: some View {
        VStack(spacing: 5) {
            if charactersToPractice.isEmpty {
                Text("Memuat karakter...")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .onAppear(perform: loadCharacters)
            } else if let characterInfo = currentCharacter {
                // Progress
                Text("\(currentIndex + 1) / \(charactersToPractice.count)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 2)

                // Drawing Canvas Area
                ZStack {
                    Text(characterInfo.character)
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(Color.gray.opacity(0.25))

                    DrawingCanvas(currentLine: $currentDrawing, completedLines: $completedDrawings)
                        .border(Color.gray.opacity(0.5), width: 1)
                }
                .frame(minHeight: 100, maxHeight: .infinity)
                .padding(.horizontal, 5)

                Text(characterInfo.romaji)
                    .font(.callout)
                    .foregroundColor(.blue)
                    .padding(.top, 2)
                
                // Tombol Aksi
                HStack {
                    Button(action: clearDrawing) {
                        Image(systemName: "trash")
                            .font(.title3)
                    }
                    // [MODIFIED] Conditional Button Style
                    #if os(watchOS)
                    .buttonStyle(BorderedButtonStyle(tint: .red.opacity(0.8)))
                    #else
                    .buttonStyle(.borderedProminent) // Fallback style untuk non-watchOS (preview)
                    .tint(.red.opacity(0.8))
                    #endif
                    
                    Spacer()

                    Button(action: goToNextCharacter) {
                        Image(systemName: "chevron.right.circle.fill")
                             .font(.title2)
                    }
                    // [MODIFIED] Conditional Button Style
                    #if os(watchOS)
                    .buttonStyle(BorderedButtonStyle(tint: .blue))
                    #else
                    .buttonStyle(.borderedProminent) // Fallback style
                    .tint(.blue)
                    #endif
                    .disabled(currentIndex >= charactersToPractice.count - 1 && charactersToPractice.count > 0)
                }
                .padding(.top, 5)
                .padding(.horizontal)

            } else {
                Text("Tidak ada karakter untuk dilatih.")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if charactersToPractice.isEmpty {
                loadCharacters()
            }
            crownValue = Double(currentIndex)
        }
        #if os(watchOS)
        .digitalCrownRotation(
            $crownValue,
            from: 0,
            through: Double(charactersToPractice.count > 0 ? charactersToPractice.count - 1 : 0),
            by: 1,
            sensitivity: .medium,
            isContinuous: false,
            isHapticFeedbackEnabled: true
        )
        .onChange(of: crownValue) { newValue in
            let newIndex = Int(newValue.rounded())
            if newIndex >= 0 && newIndex < charactersToPractice.count && newIndex != currentIndex {
                currentIndex = newIndex
                clearDrawing()
            }
        }
        #endif
    }

    func loadCharacters() {
        self.charactersToPractice = KoreanCharacterData.getFlashcardsForCourse(course.title)
        if !self.charactersToPractice.isEmpty {
            self.currentIndex = 0
            self.crownValue = 0
            clearDrawing()
        } else {
            self.currentIndex = 0 // Pastikan reset walaupun kosong
            self.crownValue = 0
            print("Peringatan: Tidak ada karakter yang dimuat untuk kursus '\(course.title)' di latihan menulis.")
        }
    }

    func clearDrawing() {
        currentDrawing = []
        completedDrawings = []
    }

    func goToNextCharacter() {
        if currentIndex < charactersToPractice.count - 1 {
            currentIndex += 1
            clearDrawing()
        }
    }
}

struct DrawingCanvas: View { // Definisi DrawingCanvas tetap sama
    @Binding var currentLine: [CGPoint]
    @Binding var completedLines: [[CGPoint]]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for line in completedLines {
                    path.addLines(line)
                }
                path.addLines(currentLine)
            }
            .stroke(Color.primary, lineWidth: 3)
            .background(Color.clear)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0.1, coordinateSpace: .local)
                    .onChanged { value in
                        let point = value.location
                        if geometry.frame(in: .local).contains(point) {
                            currentLine.append(point)
                        }
                    }
                    .onEnded { value in
                        if !currentLine.isEmpty {
                            completedLines.append(currentLine)
                        }
                        currentLine = []
                    }
            )
        }
    }
}


