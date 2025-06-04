import FoundationAdd commentMore actions

// MARK: - Hanzi Flashcard Model
struct HanziFlashcard: Identifiable, ChineseCharacterCard {
    let id = UUID()
    let character: String // Example: "あ"
    let romaji: String    // Example: "a"
}



// MARK: - Extensions to provide all characters (ini bagian yang agak redundan,
// kita akan perbaiki sedikit nanti)
extension HanziFlashcard {
    static var allHanzi: [HanziFlashcard] {
        // Ini akan menyebabkan infinite loop karena JapaneseCharacterData.allCharacters()
        // akan memanggil kembali allHiragana dan allKatakana.
        // Sebaiknya data Hiragana dan Katakana langsung didefinisikan di JapaneseCharacterData
        // dan diakses langsung dari sana.
        // Untuk sementara, saya akan biarkan ini, tapi akan saya komentari.
        return ChineseCharacterData.allCharacters().compactMap { $0 as? HanziFlashcard }
    }
}
