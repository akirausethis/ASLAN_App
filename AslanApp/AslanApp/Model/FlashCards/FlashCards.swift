// AslanApp/Model/FlashCards.swift
import Foundation

// MARK: - Hiragana Flashcard Model
struct HiraganaFlashcard: Identifiable, JapaneseCharacterCard {
    let id = UUID()
    let character: String
    let romaji: String
}

// MARK: - Katakana Flashcard Model
struct KatakanaFlashcard: Identifiable, JapaneseCharacterCard {
    let id = UUID()
    let character: String
    let romaji: String
}

// MARK: - Kanji Flashcard Model
struct KanjiFlashcard: Identifiable, JapaneseCharacterCard {
    let id = UUID()
    let character: String
    let meaning: String
    let onyomi: [String]?
    let kunyomi: [String]?
    let jlptLevel: Int

    var romaji: String {
        var readings = ""
        if let onyomi = onyomi, !onyomi.isEmpty {
            readings += "On: \(onyomi.joined(separator: ", "))"
        }
        if let kunyomi = kunyomi, !kunyomi.isEmpty {
            if !readings.isEmpty { readings += "\n" }
            readings += "Kun: \(kunyomi.joined(separator: ", "))"
        }
        return readings.isEmpty ? meaning : readings
    }
}

// Extension untuk HiraganaFlashcard
extension HiraganaFlashcard {
    static var allHiragana: [HiraganaFlashcard] {
        return JapaneseCharacterData.hiraganaCharacters // Mengambil langsung dari sumber data
    }
}

// Extension untuk KatakanaFlashcard
extension KatakanaFlashcard {
    static var allKatakana: [KatakanaFlashcard] {
        return JapaneseCharacterData.katakanaCharacters // Mengambil langsung dari sumber data
    }
}
