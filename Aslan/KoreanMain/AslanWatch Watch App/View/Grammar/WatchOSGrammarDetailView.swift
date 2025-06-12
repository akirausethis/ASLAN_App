import SwiftUI

// View untuk menampilkan detail dari satu topik grammar.
struct WatchOSGrammarDetailView: View {
    let material: GrammarMaterial // Materi grammar yang akan ditampilkan.

    var body: some View {
        ScrollView { // Gunakan ScrollView karena konten bisa panjang.
            VStack(alignment: .leading, spacing: 12) { // Spasi antar bagian.
                // Judul Topik
                Text(material.topicTitle)
                    .font(.title3) // Ukuran font judul topik.
                    .fontWeight(.bold)
                    .foregroundColor(.blue) // Warna untuk judul.
                    .padding(.bottom, 5)

                // Penjelasan (Explanation)
                Text("Penjelasan:")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(material.explanation)
                    .font(.footnote) // Font lebih kecil untuk penjelasan agar muat.
                    .lineSpacing(3) // Sedikit spasi antar baris untuk keterbacaan.
                    .fixedSize(horizontal: false, vertical: true) // Izinkan teks membungkus.

                // Contoh Kalimat (Examples)
                if !material.examples.isEmpty {
                    Text("Contoh:")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    
                    ForEach(material.examples) { example in
                        VStack(alignment: .leading, spacing: 3) {
                            Text(example.japanese) // Tampilkan kalimat Hangul.
                                .font(.system(size: 15, weight: .medium)) // Sesuaikan ukuran font.
                                .foregroundColor(.primary)
                            Text(example.romaji)   // Tampilkan romaji.
                                .font(.system(size: 13, weight: .regular, design: .monospaced))
                                .italic()
                                .foregroundColor(.gray)
                            Text(example.english)  // Tampilkan terjemahan Inggris.
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                        // Tambahkan pemisah jika ada lebih dari satu contoh.
                        if material.examples.last?.id != example.id {
                            Divider().padding(.vertical, 2)
                        }
                    }
                }

                // Tips (jika ada)
                if let tip = material.tip, !tip.isEmpty {
                    Text("💡 Tips:")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    Text(tip)
                        .font(.footnote)
                        .foregroundColor(.orange) // Warna berbeda untuk tips.
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding() // Padding keseluruhan konten dalam ScrollView.
        }
        .navigationTitle("Detail Grammar") // Judul navigasi.
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct WatchOSGrammarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Contoh data materi untuk preview.
        let sampleMaterial = KoreanGrammarContentData.allMaterials.first ??
            GrammarMaterial(
                courseTitle: "Contoh Kursus",
                topicTitle: "Contoh Topik Panjang Sekali Untuk Diuji Coba Pembungkusan Teksnya",
                explanation: "Ini adalah penjelasan yang cukup panjang untuk sebuah topik grammar di Apple Watch. Kita perlu memastikan bahwa teks ini dapat membungkus dengan baik dan tetap terbaca oleh pengguna di layar yang lebih kecil. Spasi antar baris juga penting.",
                examples: [
                    ExampleSentence(japanese: "안녕하세요, 반갑습니다.", romaji: "Annyeonghaseyo, bangapseumnida.", english: "Hello, nice to meet you."),
                    ExampleSentence(japanese: "감사합니다!", romaji: "Gamsahamnida!", english: "Thank you!")
                ],
                tip: "Ingatlah untuk selalu berlatih agar cepat menguasai materi ini. Semangat!"
            )
        
        NavigationView {
            WatchOSGrammarDetailView(material: sampleMaterial)
        }
    }
}
