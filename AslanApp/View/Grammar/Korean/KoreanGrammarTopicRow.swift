import SwiftUI

// Subview untuk menampilkan satu baris topik grammar.
struct KoreanGrammarTopicRow: View {
    let materials: KoreanGrammarMaterial // Menerima satu objek GrammarMaterial

    var body: some View {
        // Pastikan KoreanGrammarDetailView sudah didefinisikan dan menerima 'material: GrammarMaterial'
        NavigationLink(destination: KoreanGrammarDetailView(materials: materials)) { // DIPERBAIKI: materials -> material
            HStack(spacing: 15) {
                Image(systemName: "text.book.closed.fill") // Ikon untuk topik
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())

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
            // Padding dan styling lainnya sebaiknya diatur oleh List atau di sini jika tidak menggunakan List
        }
    }
}
