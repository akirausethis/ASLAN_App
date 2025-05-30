import Foundation

struct JapaneseCharacterData {
    // Lebih baik definisikan array hiragana dan katakana secara langsung di sini
    static let hiraganaCharacters: [HiraganaFlashcard] = [
        HiraganaFlashcard(character: "あ", romaji: "a"),
        HiraganaFlashcard(character: "い", romaji: "i"),
        // ... semua Hiragana Anda
        HiraganaFlashcard(character: "う", romaji: "u"),
        HiraganaFlashcard(character: "え", romaji: "e"),
        HiraganaFlashcard(character: "お", romaji: "o"),

        HiraganaFlashcard(character: "か", romaji: "ka"),
        HiraganaFlashcard(character: "き", romaji: "ki"),
        HiraganaFlashcard(character: "く", romaji: "ku"),
        HiraganaFlashcard(character: "け", romaji: "ke"),
        HiraganaFlashcard(character: "こ", romaji: "ko"),

        HiraganaFlashcard(character: "さ", romaji: "sa"),
        HiraganaFlashcard(character: "し", romaji: "shi"),
        HiraganaFlashcard(character: "す", romaji: "su"),
        HiraganaFlashcard(character: "せ", romaji: "se"),
        HiraganaFlashcard(character: "そ", romaji: "so"),

        HiraganaFlashcard(character: "た", romaji: "ta"),
        HiraganaFlashcard(character: "ち", romaji: "chi"),
        HiraganaFlashcard(character: "つ", romaji: "tsu"),
        HiraganaFlashcard(character: "て", romaji: "te"),
        HiraganaFlashcard(character: "と", romaji: "to"),

        HiraganaFlashcard(character: "な", romaji: "na"),
        HiraganaFlashcard(character: "に", romaji: "ni"),
        HiraganaFlashcard(character: "ぬ", romaji: "nu"),
        HiraganaFlashcard(character: "ね", romaji: "ne"),
        HiraganaFlashcard(character: "の", romaji: "no"),

        HiraganaFlashcard(character: "は", romaji: "ha"),
        HiraganaFlashcard(character: "ひ", romaji: "hi"),
        HiraganaFlashcard(character: "ふ", romaji: "fu"),
        HiraganaFlashcard(character: "へ", romaji: "he"),
        HiraganaFlashcard(character: "ほ", romaji: "ho"),

        HiraganaFlashcard(character: "ま", romaji: "ma"),
        HiraganaFlashcard(character: "み", romaji: "mi"),
        HiraganaFlashcard(character: "む", romaji: "mu"),
        HiraganaFlashcard(character: "め", romaji: "me"),
        HiraganaFlashcard(character: "も", romaji: "mo"),

        HiraganaFlashcard(character: "や", romaji: "ya"),
        HiraganaFlashcard(character: "ゆ", romaji: "yu"),
        HiraganaFlashcard(character: "よ", romaji: "yo"),

        HiraganaFlashcard(character: "ら", romaji: "ra"),
        HiraganaFlashcard(character: "り", romaji: "ri"),
        HiraganaFlashcard(character: "る", romaji: "ru"),
        HiraganaFlashcard(character: "れ", romaji: "re"),
        HiraganaFlashcard(character: "ろ", romaji: "ro"),

        HiraganaFlashcard(character: "わ", romaji: "wa"),
        HiraganaFlashcard(character: "を", romaji: "wo"),
        HiraganaFlashcard(character: "ん", romaji: "n"),

        // Dakuten and Handakuten
        HiraganaFlashcard(character: "が", romaji: "ga"),
        HiraganaFlashcard(character: "ぎ", romaji: "gi"),
        HiraganaFlashcard(character: "ぐ", romaji: "gu"),
        HiraganaFlashcard(character: "げ", romaji: "ge"),
        HiraganaFlashcard(character: "ご", romaji: "go"),

        HiraganaFlashcard(character: "ざ", romaji: "za"),
        HiraganaFlashcard(character: "じ", romaji: "ji"),
        HiraganaFlashcard(character: "ず", romaji: "zu"),
        HiraganaFlashcard(character: "ぜ", romaji: "ze"),
        HiraganaFlashcard(character: "ぞ", romaji: "zo"),

        HiraganaFlashcard(character: "だ", romaji: "da"),
        HiraganaFlashcard(character: "ぢ", romaji: "ji"), // Often written as "ji" or "dji"
        HiraganaFlashcard(character: "づ", romaji: "zu"), // Often written as "zu" or "dzu"
        HiraganaFlashcard(character: "で", romaji: "de"),
        HiraganaFlashcard(character: "ど", romaji: "do"),

        HiraganaFlashcard(character: "ば", romaji: "ba"),
        HiraganaFlashcard(character: "び", romaji: "bi"),
        HiraganaFlashcard(character: "ぶ", romaji: "bu"),
        HiraganaFlashcard(character: "べ", romaji: "be"),
        HiraganaFlashcard(character: "ぼ", romaji: "bo"),

        HiraganaFlashcard(character: "ぱ", romaji: "pa"),
        HiraganaFlashcard(character: "ぴ", romaji: "pi"),
        HiraganaFlashcard(character: "ぷ", romaji: "pu"),
        HiraganaFlashcard(character: "ぺ", romaji: "pe"),
        HiraganaFlashcard(character: "ぽ", romaji: "po"),

        // Combined sounds (Yōon)
        HiraganaFlashcard(character: "きゃ", romaji: "kya"),
        HiraganaFlashcard(character: "きゅ", romaji: "kyu"),
        HiraganaFlashcard(character: "きょ", romaji: "kyo"),
        HiraganaFlashcard(character: "しゃ", romaji: "sha"),
        HiraganaFlashcard(character: "しゅ", romaji: "shu"),
        HiraganaFlashcard(character: "しょ", romaji: "sho"),
        HiraganaFlashcard(character: "ちゃ", romaji: "cha"),
        HiraganaFlashcard(character: "ちゅ", romaji: "chu"),
        HiraganaFlashcard(character: "ちょ", romaji: "cho"),
        HiraganaFlashcard(character: "にゃ", romaji: "nya"),
        HiraganaFlashcard(character: "にゅ", romaji: "nyu"),
        HiraganaFlashcard(character: "にょ", romaji: "nyo"),
        HiraganaFlashcard(character: "ひゃ", romaji: "hya"),
        HiraganaFlashcard(character: "ひゅ", romaji: "hyu"),
        HiraganaFlashcard(character: "ひょ", romaji: "hyo"),
        HiraganaFlashcard(character: "みゃ", romaji: "mya"),
        HiraganaFlashcard(character: "みゅ", romaji: "myu"),
        HiraganaFlashcard(character: "みょ", romaji: "myo"),
        HiraganaFlashcard(character: "りゃ", romaji: "rya"),
        HiraganaFlashcard(character: "りゅ", romaji: "ryu"),
        HiraganaFlashcard(character: "りょ", romaji: "ryo"),

        HiraganaFlashcard(character: "ぎゃ", romaji: "gya"),
        HiraganaFlashcard(character: "ぎゅ", romaji: "gyu"),
        HiraganaFlashcard(character: "ぎょ", romaji: "gyo"),
        HiraganaFlashcard(character: "じゃ", romaji: "ja"),
        HiraganaFlashcard(character: "じゅ", romaji: "ju"),
        HiraganaFlashcard(character: "じょ", romaji: "jo"),
        HiraganaFlashcard(character: "ぢゃ", romaji: "ja"), // Rarely used
        HiraganaFlashcard(character: "ぢゅ", romaji: "ju"), // Rarely used
        HiraganaFlashcard(character: "ぢょ", romaji: "jo"), // Rarely used
        HiraganaFlashcard(character: "びゃ", romaji: "bya"),
        HiraganaFlashcard(character: "びゅ", romaji: "byu"),
        HiraganaFlashcard(character: "びょ", romaji: "byo"),
        HiraganaFlashcard(character: "ぴゃ", romaji: "pya"),
        HiraganaFlashcard(character: "ぴゅ", romaji: "pyu"),
        HiraganaFlashcard(character: "ぴょ", romaji: "pyo")
    ]

    static let katakanaCharacters: [KatakanaFlashcard] = [
        // Basic Katakana
        KatakanaFlashcard(character: "ア", romaji: "a"),
        KatakanaFlashcard(character: "イ", romaji: "i"),
        // ... semua Katakana Anda
        KatakanaFlashcard(character: "ウ", romaji: "u"),
        KatakanaFlashcard(character: "エ", romaji: "e"),
        KatakanaFlashcard(character: "オ", romaji: "o"),

        KatakanaFlashcard(character: "カ", romaji: "ka"),
        KatakanaFlashcard(character: "キ", romaji: "ki"),
        KatakanaFlashcard(character: "ク", romaji: "ku"),
        KatakanaFlashcard(character: "ケ", romaji: "ke"),
        KatakanaFlashcard(character: "コ", romaji: "ko"),

        KatakanaFlashcard(character: "サ", romaji: "sa"),
        KatakanaFlashcard(character: "シ", romaji: "shi"),
        KatakanaFlashcard(character: "ス", romaji: "su"),
        KatakanaFlashcard(character: "セ", romaji: "se"),
        KatakanaFlashcard(character: "ソ", romaji: "so"),

        KatakanaFlashcard(character: "タ", romaji: "ta"),
        KatakanaFlashcard(character: "チ", romaji: "chi"),
        KatakanaFlashcard(character: "ツ", romaji: "tsu"),
        KatakanaFlashcard(character: "テ", romaji: "te"),
        KatakanaFlashcard(character: "ト", romaji: "to"),

        KatakanaFlashcard(character: "ナ", romaji: "na"),
        KatakanaFlashcard(character: "ニ", romaji: "ni"),
        KatakanaFlashcard(character: "ヌ", romaji: "nu"),
        KatakanaFlashcard(character: "ネ", romaji: "ne"),
        KatakanaFlashcard(character: "ノ", romaji: "no"),

        KatakanaFlashcard(character: "ハ", romaji: "ha"),
        KatakanaFlashcard(character: "ヒ", romaji: "hi"),
        KatakanaFlashcard(character: "フ", romaji: "fu"),
        KatakanaFlashcard(character: "ヘ", romaji: "he"),
        KatakanaFlashcard(character: "ホ", romaji: "ho"),

        KatakanaFlashcard(character: "マ", romaji: "ma"),
        KatakanaFlashcard(character: "ミ", romaji: "mi"),
        KatakanaFlashcard(character: "ム", romaji: "mu"),
        KatakanaFlashcard(character: "メ", romaji: "me"),
        KatakanaFlashcard(character: "モ", romaji: "mo"),

        KatakanaFlashcard(character: "ヤ", romaji: "ya"),
        KatakanaFlashcard(character: "ユ", romaji: "yu"),
        KatakanaFlashcard(character: "ヨ", romaji: "yo"),

        KatakanaFlashcard(character: "ラ", romaji: "ra"),
        KatakanaFlashcard(character: "リ", romaji: "ri"),
        KatakanaFlashcard(character: "ル", romaji: "ru"),
        KatakanaFlashcard(character: "レ", romaji: "re"),
        KatakanaFlashcard(character: "ロ", romaji: "ro"),

        KatakanaFlashcard(character: "ワ", romaji: "wa"),
        KatakanaFlashcard(character: "ヲ", romaji: "wo"),
        KatakanaFlashcard(character: "ン", romaji: "n"),

        // Dakuten and Handakuten
        KatakanaFlashcard(character: "ガ", romaji: "ga"),
        KatakanaFlashcard(character: "ギ", romaji: "gi"),
        KatakanaFlashcard(character: "グ", romaji: "gu"),
        KatakanaFlashcard(character: "ゲ", romaji: "ge"),
        KatakanaFlashcard(character: "ゴ", romaji: "go"),

        KatakanaFlashcard(character: "ザ", romaji: "za"),
        KatakanaFlashcard(character: "ジ", romaji: "ji"),
        KatakanaFlashcard(character: "ズ", romaji: "zu"),
        KatakanaFlashcard(character: "ゼ", romaji: "ze"),
        KatakanaFlashcard(character: "ゾ", romaji: "zo"),

        KatakanaFlashcard(character: "ダ", romaji: "da"),
        KatakanaFlashcard(character: "ヂ", romaji: "ji"), // Often written as "ji" or "dji"
        KatakanaFlashcard(character: "ヅ", romaji: "zu"), // Often written as "zu" or "dzu"
        KatakanaFlashcard(character: "デ", romaji: "de"),
        KatakanaFlashcard(character: "ド", romaji: "do"),

        KatakanaFlashcard(character: "バ", romaji: "ba"),
        KatakanaFlashcard(character: "ビ", romaji: "bi"),
        KatakanaFlashcard(character: "ブ", romaji: "bu"),
        KatakanaFlashcard(character: "ベ", romaji: "be"),
        KatakanaFlashcard(character: "ボ", romaji: "bo"),

        KatakanaFlashcard(character: "パ", romaji: "pa"),
        KatakanaFlashcard(character: "ピ", romaji: "pi"),
        KatakanaFlashcard(character: "プ", romaji: "pu"),
        KatakanaFlashcard(character: "ペ", romaji: "pe"),
        KatakanaFlashcard(character: "ポ", romaji: "po"),

        // Combined sounds (Yōon)
        KatakanaFlashcard(character: "キャ", romaji: "kya"),
        KatakanaFlashcard(character: "キュ", romaji: "kyu"),
        KatakanaFlashcard(character: "キョ", romaji: "kyo"),
        KatakanaFlashcard(character: "シャ", romaji: "sha"),
        KatakanaFlashcard(character: "シュ", romaji: "shu"),
        KatakanaFlashcard(character: "ショ", romaji: "sho"),
        KatakanaFlashcard(character: "チャ", romaji: "cha"),
        KatakanaFlashcard(character: "チュ", romaji: "chu"),
        KatakanaFlashcard(character: "チョ", romaji: "cho"),
        KatakanaFlashcard(character: "ニャ", romaji: "nya"),
        KatakanaFlashcard(character: "ニュ", romaji: "nyu"),
        KatakanaFlashcard(character: "ニョ", romaji: "nyo"),
        KatakanaFlashcard(character: "ヒャ", romaji: "hya"),
        KatakanaFlashcard(character: "ヒュ", romaji: "hyu"),
        KatakanaFlashcard(character: "ヒョ", romaji: "hyo"),
        KatakanaFlashcard(character: "ミャ", romaji: "mya"),
        KatakanaFlashcard(character: "ミュ", romaji: "myu"),
        KatakanaFlashcard(character: "ミョ", romaji: "myo"),
        KatakanaFlashcard(character: "リャ", romaji: "rya"),
        KatakanaFlashcard(character: "リュ", romaji: "ryu"),
        KatakanaFlashcard(character: "リョ", romaji: "ryo"),

        KatakanaFlashcard(character: "ギャ", romaji: "gya"),
        KatakanaFlashcard(character: "ギュ", romaji: "gyu"),
        KatakanaFlashcard(character: "ギョ", romaji: "gyo"),
        KatakanaFlashcard(character: "ジャ", romaji: "ja"),
        KatakanaFlashcard(character: "ジュ", romaji: "ju"),
        KatakanaFlashcard(character: "ジョ", romaji: "jo"),
        KatakanaFlashcard(character: "ヂャ", romaji: "ja"), // Rarely used
        KatakanaFlashcard(character: "ヂュ", romaji: "ju"), // Rarely used
        KatakanaFlashcard(character: "ヂョ", romaji: "jo"), // Rarely used
        KatakanaFlashcard(character: "ビャ", romaji: "bya"),
        KatakanaFlashcard(character: "ビュ", romaji: "byu"),
        KatakanaFlashcard(character: "ビョ", romaji: "byo"),
        KatakanaFlashcard(character: "ピャ", romaji: "pya"),
        KatakanaFlashcard(character: "ピュ", romaji: "pyu"),
        KatakanaFlashcard(character: "ピョ", romaji: "pyo"),

        // Additional combinations (often for foreign words)
        KatakanaFlashcard(character: "ファ", romaji: "fa"),
        KatakanaFlashcard(character: "フィ", romaji: "fi"),
        KatakanaFlashcard(character: "フェ", romaji: "fe"),
        KatakanaFlashcard(character: "フォ", romaji: "fo"),
        KatakanaFlashcard(character: "ティ", romaji: "ti"), // For "ti" sound in foreign words
        KatakanaFlashcard(character: "チェ", romaji: "che"),
        KatakanaFlashcard(character: "ツァ", romaji: "tsa"),
        KatakanaFlashcard(character: "ツィ", romaji: "tsi"),
        KatakanaFlashcard(character: "ツェ", romaji: "tse"),
        KatakanaFlashcard(character: "ツォ", romaji: "tso"),
        KatakanaFlashcard(character: "ヴァ", romaji: "va"),
        KatakanaFlashcard(character: "ヴィ", romaji: "vi"),
        KatakanaFlashcard(character: "ヴ", romaji: "vu"), // The "v" sound itself
        KatakanaFlashcard(character: "ヴェ", romaji: "ve"),
        KatakanaFlashcard(character: "ヴォ", romaji: "vo"),
        KatakanaFlashcard(character: "ウィ", romaji: "wi"),
        KatakanaFlashcard(character: "ウェ", romaji: "we"),
        KatakanaFlashcard(character: "ウォ", romaji: "wo"), // For "wo" sound in foreign words
        KatakanaFlashcard(character: "シェ", romaji: "she"),
        KatakanaFlashcard(character: "ジェ", romaji: "je"),
        KatakanaFlashcard(character: "ディ", romaji: "di"), // For "di" sound in foreign words
        KatakanaFlashcard(character: "デュ", romaji: "du"), // For "du" sound in foreign words
        KatakanaFlashcard(character: "クァ", romaji: "kwa"),
        KatakanaFlashcard(character: "グァ", romaji: "gwa")
    ]

    // Ini method allCharacters() Anda yang sudah ada,
    // akan saya ubah agar mengambil dari static let di atas.
    static func allCharacters() -> [any JapaneseCharacterCard] {
        return (hiraganaCharacters as [any JapaneseCharacterCard]) + (katakanaCharacters as [any JapaneseCharacterCard])
    }
}
