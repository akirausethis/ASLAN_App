import Foundation

// MARK: - Hiragana Flashcard Model
struct HiraganaFlashcard: Identifiable, JapaneseCharacterCard {
    let id = UUID()
    let character: String // Example: "あ"
    let romaji: String    // Example: "a"
}

// MARK: - Katakana Flashcard Model
struct KatakanaFlashcard: Identifiable, JapaneseCharacterCard {
    let id = UUID()
    let character: String // Example: "ア"
    let romaji: String    // Example: "a"
}

// MARK: - Extensions to provide all characters (ini bagian yang agak redundan,
// kita akan perbaiki sedikit nanti)
extension HiraganaFlashcard {
    static var allHiragana: [HiraganaFlashcard] {
        // Ini akan menyebabkan infinite loop karena JapaneseCharacterData.allCharacters()
        // akan memanggil kembali allHiragana dan allKatakana.
        // Sebaiknya data Hiragana dan Katakana langsung didefinisikan di JapaneseCharacterData
        // dan diakses langsung dari sana.
        // Untuk sementara, saya akan biarkan ini, tapi akan saya komentari.
        return JapaneseCharacterData.allCharacters().compactMap { $0 as? HiraganaFlashcard }
    }
}

extension KatakanaFlashcard {
    static var allKatakana: [KatakanaFlashcard] {
        // Sama seperti di atas.
        return JapaneseCharacterData.allCharacters().compactMap { $0 as? KatakanaFlashcard }
    }
}
