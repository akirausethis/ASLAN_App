import SwiftUI

struct CircularProgressView: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    let progress: Double
    let totalCompleted: Int
    let totalPossible: Int
    let lineWidth: CGFloat = 20.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.1)
                .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(themeManager.accentColor) // 3. Gunakan warna tema
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear(duration: 0.7), value: progress)

            VStack(spacing: 2) {
                Text(String(format: "%.0f%%", min(self.progress, 1.0) * 100.0))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(themeManager.accentColor) // 4. Gunakan warna tema
                Text("\(totalCompleted) / \(totalPossible)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                Text("Courses Completed")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    CircularProgressView(progress: 0.65, totalCompleted: 13, totalPossible: 20)
        .padding()
        .environmentObject(ThemeManager()) // Tambahkan untuk preview
}
