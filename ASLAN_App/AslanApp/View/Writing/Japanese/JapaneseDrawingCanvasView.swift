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
            .stroke(Color.black, lineWidth: 5) // <-- DI SINI, UBAH KETEBALAN GARIS
            .background(Color.clear)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged { value in
                        let currentPoint = value.location
                        if currentPoint.x >= 0 && currentPoint.x <= geometry.size.width &&
                           currentPoint.y >= 0 && currentPoint.y <= geometry.size.height {
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

// MARK: - JapaneseDrawingCanvasView (Tidak ada perubahan di sini)
struct JapaneseDrawingCanvasView: View {
    let character: String
    let romaji: String

    @Binding var currentDrawing: [CGPoint]
    @Binding var drawings: [[CGPoint]]

    var body: some View {
        ZStack {
            Text(character)
                .font(.system(size: 150, weight: .bold))
                .foregroundColor(.black.opacity(0.15))
                .padding(.bottom, 10)
                .zIndex(0)

            DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings)
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

