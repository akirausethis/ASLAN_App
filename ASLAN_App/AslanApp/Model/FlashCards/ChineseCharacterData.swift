import Foundation

struct ChineseCharacterData {
    // Lebih baik definisikan array hiragana dan katakana secara langsung di sini
    static let hanziCharacters: [HanziFlashcard] = [
        HanziFlashcard(character: "一", romaji: "Yī"),
        HanziFlashcard(character: "二", romaji: "Èr"),
        HanziFlashcard(character: "三", romaji: "Sān"),
        HanziFlashcard(character: "四", romaji: "Sì"),
        HanziFlashcard(character: "五", romaji: "Wǔ"),
        HanziFlashcard(character: "六", romaji: "Liù"),
        HanziFlashcard(character: "七", romaji: "Qī"),
        HanziFlashcard(character: "八", romaji: "Bā"),
        HanziFlashcard(character: "九", romaji: "Jiǔ"),
        HanziFlashcard(character: "十", romaji: "Shí"),

        HanziFlashcard(character: "か", romaji: "ka"),
        HanziFlashcard(character: "き", romaji: "ki"),
        HanziFlashcard(character: "く", romaji: "ku"),
        HanziFlashcard(character: "け", romaji: "ke"),
        HanziFlashcard(character: "こ", romaji: "ko"),

        HanziFlashcard(character: "さ", romaji: "sa"),
        HanziFlashcard(character: "し", romaji: "shi"),
        HanziFlashcard(character: "す", romaji: "su"),
        HanziFlashcard(character: "せ", romaji: "se"),
        HanziFlashcard(character: "そ", romaji: "so"),

        HanziFlashcard(character: "た", romaji: "ta"),
        HanziFlashcard(character: "ち", romaji: "chi"),
        HanziFlashcard(character: "つ", romaji: "tsu"),
        HanziFlashcard(character: "て", romaji: "te"),
        HanziFlashcard(character: "と", romaji: "to"),

        HanziFlashcard(character: "な", romaji: "na"),
        HanziFlashcard(character: "に", romaji: "ni"),
        HanziFlashcard(character: "ぬ", romaji: "nu"),
        HanziFlashcard(character: "ね", romaji: "ne"),
        HanziFlashcard(character: "の", romaji: "no"),

        HanziFlashcard(character: "は", romaji: "ha"),
        HanziFlashcard(character: "ひ", romaji: "hi"),
        HanziFlashcard(character: "ふ", romaji: "fu"),
        HanziFlashcard(character: "へ", romaji: "he"),
        HanziFlashcard(character: "ほ", romaji: "ho"),

        HanziFlashcard(character: "ま", romaji: "ma"),
        HanziFlashcard(character: "み", romaji: "mi"),
        HanziFlashcard(character: "む", romaji: "mu"),
        HanziFlashcard(character: "め", romaji: "me"),
        HanziFlashcard(character: "も", romaji: "mo"),

        HanziFlashcard(character: "や", romaji: "ya"),
        HanziFlashcard(character: "ゆ", romaji: "yu"),
        HanziFlashcard(character: "よ", romaji: "yo"),

        HanziFlashcard(character: "ら", romaji: "ra"),
        HanziFlashcard(character: "り", romaji: "ri"),
        HanziFlashcard(character: "る", romaji: "ru"),
        HanziFlashcard(character: "れ", romaji: "re"),
        HanziFlashcard(character: "ろ", romaji: "ro"),

        HanziFlashcard(character: "わ", romaji: "wa"),
        HanziFlashcard(character: "を", romaji: "wo"),
        HanziFlashcard(character: "ん", romaji: "n"),

        // Dakuten and Handakuten
        HanziFlashcard(character: "が", romaji: "ga"),
        HanziFlashcard(character: "ぎ", romaji: "gi"),
        HanziFlashcard(character: "ぐ", romaji: "gu"),
        HanziFlashcard(character: "げ", romaji: "ge"),
        HanziFlashcard(character: "ご", romaji: "go"),

        HanziFlashcard(character: "ざ", romaji: "za"),
        HanziFlashcard(character: "じ", romaji: "ji"),
        HanziFlashcard(character: "ず", romaji: "zu"),
        HanziFlashcard(character: "ぜ", romaji: "ze"),
        HanziFlashcard(character: "ぞ", romaji: "zo"),

        HanziFlashcard(character: "だ", romaji: "da"),
        HanziFlashcard(character: "ぢ", romaji: "ji"),
        HanziFlashcard(character: "づ", romaji: "zu"),
        HanziFlashcard(character: "で", romaji: "de"),
        HanziFlashcard(character: "ど", romaji: "do"),

        HanziFlashcard(character: "ば", romaji: "ba"),
        HanziFlashcard(character: "び", romaji: "bi"),
        HanziFlashcard(character: "ぶ", romaji: "bu"),
        HanziFlashcard(character: "べ", romaji: "be"),
        HanziFlashcard(character: "ぼ", romaji: "bo"),

        HanziFlashcard(character: "ぱ", romaji: "pa"),
        HanziFlashcard(character: "ぴ", romaji: "pi"),
        HanziFlashcard(character: "ぷ", romaji: "pu"),
        HanziFlashcard(character: "ぺ", romaji: "pe"),
        HanziFlashcard(character: "ぽ", romaji: "po"),

        // Combined sounds (Yōon)
        HanziFlashcard(character: "きゃ", romaji: "kya"),
        HanziFlashcard(character: "きゅ", romaji: "kyu"),
        HanziFlashcard(character: "きょ", romaji: "kyo"),
        HanziFlashcard(character: "しゃ", romaji: "sha"),
        HanziFlashcard(character: "しゅ", romaji: "shu"),
        HanziFlashcard(character: "しょ", romaji: "sho"),
        HanziFlashcard(character: "ちゃ", romaji: "cha"),
        HanziFlashcard(character: "ちゅ", romaji: "chu"),
        HanziFlashcard(character: "ちょ", romaji: "cho"),
        HanziFlashcard(character: "にゃ", romaji: "nya"),
        HanziFlashcard(character: "にゅ", romaji: "nyu"),
        HanziFlashcard(character: "にょ", romaji: "nyo"),
        HanziFlashcard(character: "ひゃ", romaji: "hya"),
        HanziFlashcard(character: "ひゅ", romaji: "hyu"),
        HanziFlashcard(character: "ひょ", romaji: "hyo"),
        HanziFlashcard(character: "みゃ", romaji: "mya"),
        HanziFlashcard(character: "みゅ", romaji: "myu"),
        HanziFlashcard(character: "みょ", romaji: "myo"),
        HanziFlashcard(character: "りゃ", romaji: "rya"),
        HanziFlashcard(character: "りゅ", romaji: "ryu"),
        HanziFlashcard(character: "りょ", romaji: "ryo"),

        HanziFlashcard(character: "ぎゃ", romaji: "gya"),
        HanziFlashcard(character: "ぎゅ", romaji: "gyu"),
        HanziFlashcard(character: "ぎょ", romaji: "gyo"),
        HanziFlashcard(character: "じゃ", romaji: "ja"),
        HanziFlashcard(character: "じゅ", romaji: "ju"),
        HanziFlashcard(character: "じょ", romaji: "jo"),
        HanziFlashcard(character: "ぢゃ", romaji: "ja"), // Rarely used
        HanziFlashcard(character: "ぢゅ", romaji: "ju"), // Rarely used
        HanziFlashcard(character: "ぢょ", romaji: "jo"), // Rarely used
        HanziFlashcard(character: "びゃ", romaji: "bya"),
        HanziFlashcard(character: "びゅ", romaji: "byu"),
        HanziFlashcard(character: "びょ", romaji: "byo"),
        HanziFlashcard(character: "ぴゃ", romaji: "pya"),
        HanziFlashcard(character: "ぴゅ", romaji: "pyu"),
        HanziFlashcard(character: "ぴょ", romaji: "pyo")
    ]

    // Ini method allCharacters() Anda yang sudah ada,
    // akan saya ubah agar mengambil dari static let di atas.
    static func allCharacters() -> [any ChineseCharacterCard] {
        return (hanziCharacters as [any ChineseCharacterCard])
    }
}
