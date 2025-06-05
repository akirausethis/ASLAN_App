import SwiftUI

struct KoreanDrawingCanvasView: View {
    let character: String // Hangul
    let romaji: String    // Romaji

    @Binding var currentDrawing: [CGPoint]
    @Binding var drawings: [[CGPoint]]

    var body: some View {
        ZStack {
            Text(character)
                .font(.system(size: 150, weight: .bold))
                .foregroundColor(.black.opacity(0.15))
                .padding(.bottom, 10)
                .zIndex(0)

            DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings) // Menggunakan DrawingPad yang ada
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1)

            VStack {
                Spacer()
                Text(romaji)
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding(.bottom)
            .zIndex(2)
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}
