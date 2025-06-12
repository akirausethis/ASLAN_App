import SwiftUI

struct KoreanGrammarTopicRow: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    let materials: GrammarMaterial

    var body: some View {
        NavigationLink(destination: KoreanGrammarDetailView(materials: materials)) {
            HStack(spacing: 15) {
                Image(systemName: "text.book.closed.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(themeManager.accentColor) // 2. Gunakan warna tema
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 5) {
                    Text(materials.topicTitle)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primary)
                        .lineLimit(2)

                    Text(materials.explanation.prefix(80) + (materials.explanation.count > 80 ? "..." : ""))
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                        .lineLimit(2)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.callout)
                    .foregroundColor(.gray.opacity(0.7))
            }
            .padding(15)
            .background(Color(UIColor.systemBackground)) // Menggunakan systemBackground agar lebih adaptif
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.08), radius: 4, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
