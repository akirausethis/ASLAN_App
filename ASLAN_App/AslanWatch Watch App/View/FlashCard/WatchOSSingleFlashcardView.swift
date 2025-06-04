// akirausethis/aslan_app/ASLAN_App-Korean/ASLAN_App/AslanWatch Watch App/View/FlashCard/WatchOSSingleFlashcardView.swift
import SwiftUI

struct WatchOSSingleFlashcardView: View {
    let card: any KoreanCharacterCard
    @State private var showDetails: Bool = false

    var body: some View {
        VStack(spacing: 6) { // Mengurangi spasi utama sedikit
            Spacer(minLength: 0)

            Text(card.character)
                .font(.system(size: 80, weight: .bold, design: .rounded)) // Ukuran font sedikit lebih besar jika muat
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)
                .padding(.bottom, showDetails ? 4 : 0) // Tambah padding bawah jika detail muncul

            if showDetails {
                VStack(spacing: 2) {
                    Text(card.romaji)
                        .font(.title3)
                        .fontWeight(.semibold) // Lebih tebal untuk romaji
                        .foregroundColor(.blue)
                        .lineLimit(1)

                    if !card.name.isEmpty { // Hanya tampilkan jika ada nama
                        Text(card.name)
                            .font(.caption)
                            .fontWeight(.regular) // Regular weight untuk nama
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: .top))) // Animasi dari atas
            }
            
            Spacer(minLength: 0)
        }
        .padding(12) // Padding internal
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Material.thin) // Menggunakan material background
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Corner radius lebih besar
        // .overlay( // Overlay bisa dihilangkan jika material sudah cukup
        //     RoundedRectangle(cornerRadius: 20)
        //         .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        // )
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                showDetails.toggle()
            }
        }
    }
}

struct WatchOSSingleFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCard1 = HangulFlashcard(character: "한", romaji: "han", name: "Hangeul Syllable")
        let sampleCard2 = HangulFlashcard(character: "글", romaji: "geul", name: "") // Contoh tanpa nama

        Group {
            WatchOSSingleFlashcardView(card: sampleCard1)
                .previewDevice("Apple Watch Series 7 - 45mm")
                .previewDisplayName("45mm - With Name")

            WatchOSSingleFlashcardView(card: sampleCard2)
                .previewDevice("Apple Watch Series 6 - 40mm")
                .previewDisplayName("40mm - No Name")
        }
    }
}
