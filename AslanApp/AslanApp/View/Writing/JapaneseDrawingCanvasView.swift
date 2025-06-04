// AslanApp/View/Writing/JapaneseDrawingCanvasView.swift
import SwiftUI

// MARK: - DrawingPad (Reusable Drawing View)
struct DrawingPad: View {
    @Binding var currentDrawing: [CGPoint]
    @Binding var drawings: [[CGPoint]]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for points in drawings {
                    path.addLines(points)
                }
                path.addLines(currentDrawing)
            }
            // UBAH LINEWIDTH DI SINI
            .stroke(Color.black, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)) // PERBESAR lineWidth, misal menjadi 8 atau 10
            .background(Color.clear) // Tetap clear agar karakter di belakang terlihat
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged { value in
                        let currentPoint = value.location
                        // Batasi agar goresan tidak keluar dari area gambar
                        if currentPoint.y >= 0 && currentPoint.y <= geometry.size.height &&
                           currentPoint.x >= 0 && currentPoint.x <= geometry.size.width {
                            currentDrawing.append(currentPoint)
                        }
                    }
                    .onEnded { _ in
                        if !currentDrawing.isEmpty {
                            drawings.append(currentDrawing)
                        }
                        currentDrawing = []
                    }
            )
        }
    }
}

// MARK: - JapaneseDrawingCanvasView (Tidak ada perubahan signifikan di sini)
struct JapaneseDrawingCanvasView: View {
    let character: String
    let romaji: String // Untuk Kanji, ini akan berisi On/Kun dari KanjiFlashcard

    @Binding var currentDrawing: [CGPoint]
    @Binding var drawings: [[CGPoint]]

    var body: some View {
        ZStack {
            // Karakter panduan di belakang
            Text(character)
                .font(.system(size: character.count > 1 ? 100 : 180, weight: .bold)) // Ukuran font adaptif untuk kata/kanji
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(Color.gray.opacity(0.25)) // Lebih terlihat sedikit
                .padding(.bottom, character.count > 1 ? 0 : 10) // Sesuaikan padding jika kata
                .zIndex(0)

            // DrawingPad di atas karakter panduan
            DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1)

            // Romaji/info di bagian bawah (opsional untuk UI yang lebih bersih saat menggambar)
            VStack {
                Spacer() // Dorong ke bawah
                Text(romaji) // Tampilkan bacaan atau arti singkat
                    .font(.title2)
                    .foregroundColor(.blue)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 20) // Padding bawah untuk romaji
            .padding(.horizontal) // Padding horizontal agar tidak mepet
            .zIndex(2) // Pastikan romaji di atas DrawingPad jika ada tumpang tindih
        }
        .frame(maxWidth: .infinity, maxHeight: 500) // Sesuaikan tinggi canvas
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
        )
        .padding(.horizontal) // Padding luar untuk seluruh canvas card
    }
}

#Preview {
    // Contoh Kanji untuk Preview
    let sampleKanji = JapaneseCharacterData.kanjiN5.first ?? KanjiFlashcard(character: "字", meaning: "Character", onyomi: ["ジ"], kunyomi: ["あざな"], jlptLevel: 5) //
    
    return JapaneseDrawingCanvasView(
        character: sampleKanji.character,
        romaji: sampleKanji.romaji, // Ini akan menampilkan On/Kun dari KanjiFlashcard
        currentDrawing: .constant([]),
        drawings: .constant([])
    )
}
