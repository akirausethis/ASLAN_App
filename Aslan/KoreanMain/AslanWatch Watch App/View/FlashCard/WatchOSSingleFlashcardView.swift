import SwiftUI

// View untuk menampilkan satu kartu flashcard Hangul.
struct WatchOSSingleFlashcardView: View {
    // Menerima objek apa pun yang mengadopsi protokol KoreanCharacterCard.
    // Ini memungkinkan fleksibilitas jika Anda memiliki tipe kartu lain di masa depan.
    let card: any KoreanCharacterCard

    // State untuk mengontrol apakah detail (romaji, nama) ditampilkan.
    @State private var showDetails: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            Spacer(minLength: 0) // Mendorong konten ke tengah secara vertikal.

            // Menampilkan karakter Hangul utama.
            Text(card.character)
                .font(.system(size: 75, weight: .bold, design: .rounded)) // Ukuran font besar, tebal, dengan desain rounded.
                .minimumScaleFactor(0.5) // Izinkan teks mengecil jika tidak muat.
                .lineLimit(1)            // Batasi hanya satu baris.
                .foregroundColor(.primary) // Gunakan warna teks utama sistem.

            // Tampilkan detail jika showDetails adalah true.
            if showDetails {
                VStack(spacing: 2) { // Spasi kecil antar detail.
                    Text(card.romaji)
                        .font(.title3)         // Ukuran font sedang untuk romaji.
                        .fontWeight(.medium)
                        .foregroundColor(.blue) // Warna berbeda untuk menyorot romaji.
                        .lineLimit(1)

                    Text(card.name)
                        .font(.caption)        // Ukuran font kecil untuk nama/deskripsi.
                        .fontWeight(.light)
                        .foregroundColor(.gray)  // Warna lebih lembut.
                        .lineLimit(1)
                }
                .transition(.opacity.combined(with: .scale(scale: 0.85))) // Animasi halus saat muncul/hilang.
            }
            
            Spacer(minLength: 0) // Mendorong konten ke tengah.
        }
        .padding(10) // Padding di sekitar konten kartu.
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Buat kartu mengisi ruang yang tersedia.
        .background(
            RoundedRectangle(cornerRadius: 16) // Sudut kartu yang lebih bulat.
                .fill(Color.gray.opacity(0.18)) // Latar belakang kartu yang sedikit transparan.
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.35), lineWidth: 1.5) // Border yang sedikit lebih tebal.
        )
        .onTapGesture {
            // Toggle tampilan detail dengan animasi spring saat kartu diketuk.
            withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                showDetails.toggle()
            }
        }
    }
}

// MARK: - Preview
struct WatchOSSingleFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        // Contoh data untuk preview.
        // Menggunakan HangulFlashcard karena itu adalah implementasi konkret dari KoreanCharacterCard.
        // Pastikan struct HangulFlashcard dan protokol KoreanCharacterCard sudah didefinisikan dan
        // di-share ke target watchOS Anda.
        let sampleCard1 = HangulFlashcard(character: "한", romaji: "han", name: "Hangeul Syllable")
        let sampleCard2 = HangulFlashcard(character: "글", romaji: "geul", name: "Geul Syllable")

        Group {
            WatchOSSingleFlashcardView(card: sampleCard1) // showDetails akan false secara default
                .previewDevice("Apple Watch Series 7 - 45mm") // Target preview device.
                .previewDisplayName("45mm - Tap to Show Details")

            WatchOSSingleFlashcardView(card: sampleCard2) // showDetails akan false secara default
                .previewDevice("Apple Watch Series 6 - 40mm")
                .previewDisplayName("40mm - Tap to Show Details")
        }
    }
}
