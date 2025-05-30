import Foundation

// MARK: - Hangul Flashcard Model
struct HangulFlashcard: Identifiable, KoreanCharacterCard {
    let id = UUID()
    let character: String // Contoh: "가"
    let romaji: String    // Contoh: "ga"
    let name: String      // Bisa nama Jamo penyusunnya atau kosong

    // Properti tambahan jika diperlukan (misal: tipe vokal/konsonan)
}

// MARK: - Ekstensi untuk menyediakan semua karakter
extension HangulFlashcard {
    static var allHangul: [HangulFlashcard] {
        return KoreanCharacterData.allCharacters().compactMap { $0 as? HangulFlashcard }
    }
}
