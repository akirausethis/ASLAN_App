// AslanApp/View/Progress/CircularProgressView.swift
import SwiftUI

struct CircularProgressView: View {
    let progress: Double // Nilai antara 0.0 dan 1.0
    let totalCompleted: Int
    let totalPossible: Int
    let lineWidth: CGFloat = 20.0 // Ketebalan garis progress

    var body: some View {
        ZStack {
            Circle() // Latar belakang lingkaran progress
                .stroke(lineWidth: lineWidth)
                .opacity(0.1)
                .foregroundColor(Color.blue)

            Circle() // Lingkaran progress yang terisi
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0)) // Mulai dari atas
                .animation(.linear(duration: 0.7), value: progress) // Animasi saat progress berubah

            VStack(spacing: 2) { // Teks di tengah lingkaran
                Text(String(format: "%.0f%%", min(self.progress, 1.0) * 100.0))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)
                Text("\(totalCompleted) / \(totalPossible)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                Text("Courses Completed")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 200, height: 200) // Ukuran lingkaran progress
    }
}

#Preview {
    CircularProgressView(progress: 0.65, totalCompleted: 13, totalPossible: 20)
        .padding()
}
