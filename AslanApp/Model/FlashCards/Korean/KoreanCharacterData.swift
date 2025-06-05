import Foundation

struct KoreanCharacterData {

    static let hangulCharacters: [HangulFlashcard] = [
        // --- Konsonan Dasar ---
        HangulFlashcard(character: "ㄱ", romaji: "g/k", name: "Giyeok"),
        HangulFlashcard(character: "ㄴ", romaji: "n", name: "Nieun"),
        HangulFlashcard(character: "ㄷ", romaji: "d/t", name: "Digeut"),
        HangulFlashcard(character: "ㄹ", romaji: "r/l", name: "Rieul"),
        HangulFlashcard(character: "ㅁ", romaji: "m", name: "Mieum"),
        HangulFlashcard(character: "ㅂ", romaji: "b/p", name: "Bieup"),
        HangulFlashcard(character: "ㅅ", romaji: "s/t", name: "Shiot"),
        HangulFlashcard(character: "ㅇ", romaji: "ng/-", name: "Ieung"),
        HangulFlashcard(character: "ㅈ", romaji: "j/t", name: "Jieut"),
        HangulFlashcard(character: "ㅊ", romaji: "ch/t", name: "Chieut"),
        HangulFlashcard(character: "ㅋ", romaji: "k", name: "Kieuk"),
        HangulFlashcard(character: "ㅌ", romaji: "t", name: "Tieut"),
        HangulFlashcard(character: "ㅍ", romaji: "p", name: "Pieup"),
        HangulFlashcard(character: "ㅎ", romaji: "h/t", name: "Hieut"),

        // --- Konsonan Ganda ---
        HangulFlashcard(character: "ㄲ", romaji: "kk", name: "Ssang Giyeok"),
        HangulFlashcard(character: "ㄸ", romaji: "tt", name: "Ssang Digeut"),
        HangulFlashcard(character: "ㅃ", romaji: "pp", name: "Ssang Bieup"),
        HangulFlashcard(character: "ㅆ", romaji: "ss", name: "Ssang Shiot"),
        HangulFlashcard(character: "ㅉ", romaji: "jj", name: "Ssang Jieut"),

        // --- Vokal Dasar ---
        HangulFlashcard(character: "ㅏ", romaji: "a", name: "A"),
        HangulFlashcard(character: "ㅑ", romaji: "ya", name: "Ya"),
        HangulFlashcard(character: "ㅓ", romaji: "eo", name: "Eo"),
        HangulFlashcard(character: "ㅕ", romaji: "yeo", name: "Yeo"),
        HangulFlashcard(character: "ㅗ", romaji: "o", name: "O"),
        HangulFlashcard(character: "ㅛ", romaji: "yo", name: "Yo"),
        HangulFlashcard(character: "ㅜ", romaji: "u", name: "U"),
        HangulFlashcard(character: "ㅠ", romaji: "yu", name: "Yu"),
        HangulFlashcard(character: "ㅡ", romaji: "eu", name: "Eu"),
        HangulFlashcard(character: "ㅣ", romaji: "i", name: "I"),

        // --- Vokal Gabungan ---
        HangulFlashcard(character: "ㅐ", romaji: "ae", name: "Ae"),
        HangulFlashcard(character: "ㅒ", romaji: "yae", name: "Yae"),
        HangulFlashcard(character: "ㅔ", romaji: "e", name: "E"),
        HangulFlashcard(character: "ㅖ", romaji: "ye", name: "Ye"),
        HangulFlashcard(character: "ㅘ", romaji: "wa", name: "Wa"),
        HangulFlashcard(character: "ㅙ", romaji: "wae", name: "Wae"),
        HangulFlashcard(character: "ㅚ", romaji: "oe", name: "Oe"),
        HangulFlashcard(character: "ㅝ", romaji: "wo", name: "Wo"),
        HangulFlashcard(character: "ㅞ", romaji: "we", name: "We"),
        HangulFlashcard(character: "ㅟ", romaji: "wi", name: "Wi"),
        HangulFlashcard(character: "ㅢ", romaji: "ui", name: "Ui"),

        // --- Contoh Suku Kata ---
        HangulFlashcard(character: "가", romaji: "ga", name: ""),
        HangulFlashcard(character: "나", romaji: "na", name: ""),
        HangulFlashcard(character: "다", romaji: "da", name: ""),
        HangulFlashcard(character: "마", romaji: "ma", name: ""),
        HangulFlashcard(character: "바", romaji: "ba", name: ""),
        HangulFlashcard(character: "사", romaji: "sa", name: ""),
        HangulFlashcard(character: "아", romaji: "a", name: ""),
        HangulFlashcard(character: "자", romaji: "ja", name: ""),
        HangulFlashcard(character: "카", romaji: "ka", name: ""),
        HangulFlashcard(character: "타", romaji: "ta", name: ""),
        HangulFlashcard(character: "파", romaji: "pa", name: ""),
        HangulFlashcard(character: "하", romaji: "ha", name: ""),
        HangulFlashcard(character: "안", romaji: "an", name: ""), // dengan batchim
        HangulFlashcard(character: "녕", romaji: "nyeong", name: ""),// dengan batchim
        HangulFlashcard(character: "하", romaji: "ha", name: ""),
        HangulFlashcard(character: "세", romaji: "se", name: ""),
        HangulFlashcard(character: "요", romaji: "yo", name: ""),
        HangulFlashcard(character: "김", romaji: "gim", name: ""),
        HangulFlashcard(character: "치", romaji: "chi", name: ""),
        HangulFlashcard(character: "밥", romaji: "bap", name: ""),
        HangulFlashcard(character: "물", romaji: "mul", name: ""),
        HangulFlashcard(character: "빵", romaji: "ppang", name: ""),

    ]

    static func allCharacters() -> [any KoreanCharacterCard] {
        return hangulCharacters
    }
    
    static func getFlashcardsForCourse(_ courseTitle: String) -> [any KoreanCharacterCard] {
           // Logika pemfilteran yang lebih baik berdasarkan judul kursus.
           // Anda perlu menyesuaikan string "contains" agar cocok dengan judul kursus Anda.
           switch courseTitle {
           case let title where title.contains("Konsonan Dasar"):
               return hangulCharacters.filter {
                   ["ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard } // Pastikan konversi ke tipe protokol
           case let title where title.contains("Vokal Dasar"):
               return hangulCharacters.filter {
                   ["ㅏ","ㅑ","ㅓ","ㅕ","ㅗ","ㅛ","ㅜ","ㅠ","ㅡ","ㅣ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Konsonan Ganda"):
               return hangulCharacters.filter {
                   ["ㄲ","ㄸ","ㅃ","ㅆ","ㅉ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Vokal Gabungan"):
               return hangulCharacters.filter {
                   ["ㅐ","ㅒ","ㅔ","ㅖ","ㅘ","ㅙ","ㅚ","ㅝ","ㅞ","ㅟ","ㅢ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Suku Kata Awal"):
               return hangulCharacters.filter {
                   ["가","나","다","마","바","사","아","자","카","타","파","하"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           default:
               // Jika tidak ada filter khusus, kembalikan sejumlah kartu acak.
               // Pastikan untuk mengkonversi ke [any KoreanCharacterCard]
               return Array(hangulCharacters.shuffled().prefix(15)).map { $0 as any KoreanCharacterCard }
           }
       }
   }


