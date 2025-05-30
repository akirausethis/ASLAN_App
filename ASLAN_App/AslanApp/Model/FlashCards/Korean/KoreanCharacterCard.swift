import Foundation

protocol KoreanCharacterCard: Identifiable {
    var id: UUID { get }
    var character: String { get } // Karakter Hangul (contoh: "ㄱ")
    var romaji: String { get }    // Romanisasi (contoh: "g/k")
    var name: String { get }      // Nama karakter (contoh: "Giyeok")
}
