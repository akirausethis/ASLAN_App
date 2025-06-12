// AslanApp/Model/FlashCards/Korean/KoreanCharacterData.swift
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

        // --- Contoh Suku Kata (untuk Basic Syllables, dll.) ---
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

        // --- Tambahan untuk Intermediate Syllables/Words (Contoh) ---
        HangulFlashcard(character: "책", romaji: "chaek", name: "book"),
        HangulFlashcard(character: "학교", romaji: "hakgyo", name: "school"),
        HangulFlashcard(character: "친구", romaji: "chingu", name: "friend"),
        HangulFlashcard(character: "사랑", romaji: "sarang", name: "love"),
        HangulFlashcard(character: "커피", romaji: "keopi", name: "coffee"),
        HangulFlashcard(character: "도서관", romaji: "doseogwan", name: "library"),
        HangulFlashcard(character: "안녕하세요", romaji: "annyeonghaseyo", name: "hello"),
        HangulFlashcard(character: "감사합니다", romaji: "gamsahamnida", name: "thank you"),

        // --- Tambahan untuk Expert Syllables/Words/Phrases (Contoh) ---
        HangulFlashcard(character: "괜찮아요", romaji: "gwaenchanayo", name: "it's okay"),
        HangulFlashcard(character: "미안합니다", romaji: "mianhamnida", name: "I'm sorry"),
        HangulFlashcard(character: "어떻게", romaji: "eotteoke", name: "how"),
        HangulFlashcard(character: "왜냐하면", romaji: "waenyahamyeon", name: "because"),
        HangulFlashcard(character: "그렇지만", romaji: "geureochiman", name: "however"),
        HangulFlashcard(character: "비행기", romaji: "bihaenggi", name: "airplane"),
        HangulFlashcard(character: "복잡하다", romaji: "bokjapada", name: "to be complicated"),
        HangulFlashcard(character: "개인적인", romaji: "gaeinjeogin", name: "personal")
    ]

    static func allCharacters() -> [any KoreanCharacterCard] {
        return hangulCharacters
    }
    
    static func getFlashcardsForCourse(_ courseTitle: String) -> [any KoreanCharacterCard] {
           // Logika pemfilteran yang lebih baik berdasarkan judul kursus.
           // Anda perlu menyesuaikan string "contains" agar cocok dengan judul kursus Anda.
           switch courseTitle {
           case let title where title.contains("Basic Consonants"): // Perbarui ini
               return hangulCharacters.filter {
                   ["ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard } // Pastikan konversi ke tipe protokol
           case let title where title.contains("Basic Vowels"): // Perbarui ini
               return hangulCharacters.filter {
                   ["ㅏ","ㅑ","ㅓ","ㅕ","ㅗ","ㅛ","ㅜ","ㅠ","ㅡ","ㅣ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Double Consonants"): // Perbarui ini
               return hangulCharacters.filter {
                   ["ㄲ","ㄸ","ㅃ","ㅆ","ㅉ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Combined Vowels"): // Perbarui ini
               return hangulCharacters.filter {
                   ["ㅐ","ㅒ","ㅔ","ㅖ","ㅘ","ㅙ","ㅚ","ㅝ","ㅞ","ㅟ","ㅢ"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Intermediate Syllables"): // Kategori baru
               return hangulCharacters.filter {
                   // Contoh: filter suku kata dengan batchim atau kata pendek
                   ["책","학교","친구","사랑","커피","도서관"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Intermediate Words"): // Kategori baru
                return hangulCharacters.filter {
                    // Contoh: filter kata-kata intermediate
                    ["안녕하세요","감사합니다"].contains($0.character)
                }.shuffled().map { $0 as any KoreanCharacterCard }
           case let title where title.contains("Advanced Words & Phrases"): // Kategori baru
               return hangulCharacters.filter {
                   // Contoh: filter kata-kata atau frasa yang lebih kompleks
                   ["괜찮아요","미안합니다","어떻게","왜냐하면","그렇지만","비행기","복잡하다","개인적인"].contains($0.character)
               }.shuffled().map { $0 as any KoreanCharacterCard }
           default:
               // Jika tidak ada filter khusus, kembalikan sejumlah kartu acak.
               // Pastikan untuk mengkonversi ke [any KoreanCharacterCard]
               return Array(hangulCharacters.shuffled().prefix(15)).map { $0 as any KoreanCharacterCard }
           }
       }
   }
