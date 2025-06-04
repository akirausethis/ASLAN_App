// AslanApp/Model/FlashCards/JapaneseCharacterData.swift
import Foundation

struct JapaneseCharacterData {
    // Hiragana Characters (Pastikan ini lengkap sesuai file asli Anda)
    static let hiraganaCharacters: [HiraganaFlashcard] = [
        HiraganaFlashcard(character: "あ", romaji: "a"), HiraganaFlashcard(character: "い", romaji: "i"),
        HiraganaFlashcard(character: "う", romaji: "u"), HiraganaFlashcard(character: "え", romaji: "e"), HiraganaFlashcard(character: "お", romaji: "o"),
        HiraganaFlashcard(character: "か", romaji: "ka"), HiraganaFlashcard(character: "き", romaji: "ki"), HiraganaFlashcard(character: "く", romaji: "ku"), HiraganaFlashcard(character: "け", romaji: "ke"), HiraganaFlashcard(character: "こ", romaji: "ko"),
        HiraganaFlashcard(character: "さ", romaji: "sa"), HiraganaFlashcard(character: "し", romaji: "shi"), HiraganaFlashcard(character: "す", romaji: "su"), HiraganaFlashcard(character: "せ", romaji: "se"), HiraganaFlashcard(character: "そ", romaji: "so"),
        HiraganaFlashcard(character: "た", romaji: "ta"), HiraganaFlashcard(character: "ち", romaji: "chi"), HiraganaFlashcard(character: "つ", romaji: "tsu"), HiraganaFlashcard(character: "て", romaji: "te"), HiraganaFlashcard(character: "と", romaji: "to"),
        HiraganaFlashcard(character: "な", romaji: "na"), HiraganaFlashcard(character: "に", romaji: "ni"), HiraganaFlashcard(character: "ぬ", romaji: "nu"), HiraganaFlashcard(character: "ね", romaji: "ne"), HiraganaFlashcard(character: "の", romaji: "no"),
        HiraganaFlashcard(character: "は", romaji: "ha"), HiraganaFlashcard(character: "ひ", romaji: "hi"), HiraganaFlashcard(character: "ふ", romaji: "fu"), HiraganaFlashcard(character: "へ", romaji: "he"), HiraganaFlashcard(character: "ほ", romaji: "ho"),
        HiraganaFlashcard(character: "ま", romaji: "ma"), HiraganaFlashcard(character: "み", romaji: "mi"), HiraganaFlashcard(character: "む", romaji: "mu"), HiraganaFlashcard(character: "め", romaji: "me"), HiraganaFlashcard(character: "も", romaji: "mo"),
        HiraganaFlashcard(character: "や", romaji: "ya"), HiraganaFlashcard(character: "ゆ", romaji: "yu"), HiraganaFlashcard(character: "よ", romaji: "yo"),
        HiraganaFlashcard(character: "ら", romaji: "ra"), HiraganaFlashcard(character: "り", romaji: "ri"), HiraganaFlashcard(character: "る", romaji: "ru"), HiraganaFlashcard(character: "れ", romaji: "re"), HiraganaFlashcard(character: "ろ", romaji: "ro"),
        HiraganaFlashcard(character: "わ", romaji: "wa"), HiraganaFlashcard(character: "を", romaji: "wo"), HiraganaFlashcard(character: "ん", romaji: "n"),
        // Dakuten & Handakuten
        HiraganaFlashcard(character: "が", romaji: "ga"), HiraganaFlashcard(character: "ぎ", romaji: "gi"), HiraganaFlashcard(character: "ぐ", romaji: "gu"), HiraganaFlashcard(character: "げ", romaji: "ge"), HiraganaFlashcard(character: "ご", romaji: "go"),
        HiraganaFlashcard(character: "ざ", romaji: "za"), HiraganaFlashcard(character: "じ", romaji: "ji"), HiraganaFlashcard(character: "ず", romaji: "zu"), HiraganaFlashcard(character: "ぜ", romaji: "ze"), HiraganaFlashcard(character: "ぞ", romaji: "zo"),
        HiraganaFlashcard(character: "だ", romaji: "da"), HiraganaFlashcard(character: "ぢ", romaji: "ji (dji)"), HiraganaFlashcard(character: "づ", romaji: "zu (dzu)"), HiraganaFlashcard(character: "で", romaji: "de"), HiraganaFlashcard(character: "ど", romaji: "do"),
        HiraganaFlashcard(character: "ば", romaji: "ba"), HiraganaFlashcard(character: "び", romaji: "bi"), HiraganaFlashcard(character: "ぶ", romaji: "bu"), HiraganaFlashcard(character: "べ", romaji: "be"), HiraganaFlashcard(character: "ぼ", romaji: "bo"),
        HiraganaFlashcard(character: "ぱ", romaji: "pa"), HiraganaFlashcard(character: "ぴ", romaji: "pi"), HiraganaFlashcard(character: "ぷ", romaji: "pu"), HiraganaFlashcard(character: "ぺ", romaji: "pe"), HiraganaFlashcard(character: "ぽ", romaji: "po"),
        // Yoon
        HiraganaFlashcard(character: "きゃ", romaji: "kya"), HiraganaFlashcard(character: "きゅ", romaji: "kyu"), HiraganaFlashcard(character: "きょ", romaji: "kyo"),
        HiraganaFlashcard(character: "しゃ", romaji: "sha"), HiraganaFlashcard(character: "しゅ", romaji: "shu"), HiraganaFlashcard(character: "しょ", romaji: "sho"),
        HiraganaFlashcard(character: "ちゃ", romaji: "cha"), HiraganaFlashcard(character: "ちゅ", romaji: "chu"), HiraganaFlashcard(character: "ちょ", romaji: "cho"),
        HiraganaFlashcard(character: "にゃ", romaji: "nya"), HiraganaFlashcard(character: "にゅ", romaji: "nyu"), HiraganaFlashcard(character: "にょ", romaji: "nyo"),
        HiraganaFlashcard(character: "ひゃ", romaji: "hya"), HiraganaFlashcard(character: "ひゅ", romaji: "hyu"), HiraganaFlashcard(character: "ひょ", romaji: "hyo"),
        HiraganaFlashcard(character: "みゃ", romaji: "mya"), HiraganaFlashcard(character: "みゅ", romaji: "myu"), HiraganaFlashcard(character: "みょ", romaji: "myo"),
        HiraganaFlashcard(character: "りゃ", romaji: "rya"), HiraganaFlashcard(character: "りゅ", romaji: "ryu"), HiraganaFlashcard(character: "りょ", romaji: "ryo"),
        HiraganaFlashcard(character: "ぎゃ", romaji: "gya"), HiraganaFlashcard(character: "ぎゅ", romaji: "gyu"), HiraganaFlashcard(character: "ぎょ", romaji: "gyo"),
        HiraganaFlashcard(character: "じゃ", romaji: "ja"), HiraganaFlashcard(character: "じゅ", romaji: "ju"), HiraganaFlashcard(character: "じょ", romaji: "jo"),
        HiraganaFlashcard(character: "びゃ", romaji: "bya"), HiraganaFlashcard(character: "びゅ", romaji: "byu"), HiraganaFlashcard(character: "びょ", romaji: "byo"),
        HiraganaFlashcard(character: "ぴゃ", romaji: "pya"), HiraganaFlashcard(character: "ぴゅ", romaji: "pyu"), HiraganaFlashcard(character: "ぴょ", romaji: "pyo")

    ]

    // Katakana Characters (Pastikan ini lengkap sesuai file asli Anda)
    static let katakanaCharacters: [KatakanaFlashcard] = [
        KatakanaFlashcard(character: "ア", romaji: "a"), KatakanaFlashcard(character: "イ", romaji: "i"), KatakanaFlashcard(character: "ウ", romaji: "u"), KatakanaFlashcard(character: "エ", romaji: "e"), KatakanaFlashcard(character: "オ", romaji: "o"),
        KatakanaFlashcard(character: "カ", romaji: "ka"), KatakanaFlashcard(character: "キ", romaji: "ki"), KatakanaFlashcard(character: "ク", romaji: "ku"), KatakanaFlashcard(character: "ケ", romaji: "ke"), KatakanaFlashcard(character: "コ", romaji: "ko"),
        KatakanaFlashcard(character: "サ", romaji: "sa"), KatakanaFlashcard(character: "シ", romaji: "shi"), KatakanaFlashcard(character: "ス", romaji: "su"), KatakanaFlashcard(character: "セ", romaji: "se"), KatakanaFlashcard(character: "ソ", romaji: "so"),
        KatakanaFlashcard(character: "タ", romaji: "ta"), KatakanaFlashcard(character: "チ", romaji: "chi"), KatakanaFlashcard(character: "ツ", romaji: "tsu"), KatakanaFlashcard(character: "テ", romaji: "te"), KatakanaFlashcard(character: "ト", romaji: "to"),
        KatakanaFlashcard(character: "ナ", romaji: "na"), KatakanaFlashcard(character: "ニ", romaji: "ni"), KatakanaFlashcard(character: "ヌ", romaji: "nu"), KatakanaFlashcard(character: "ネ", romaji: "ne"), KatakanaFlashcard(character: "ノ", romaji: "no"),
        KatakanaFlashcard(character: "ハ", romaji: "ha"), KatakanaFlashcard(character: "ヒ", romaji: "hi"), KatakanaFlashcard(character: "フ", romaji: "fu"), KatakanaFlashcard(character: "ヘ", romaji: "he"), KatakanaFlashcard(character: "ホ", romaji: "ho"),
        KatakanaFlashcard(character: "マ", romaji: "ma"), KatakanaFlashcard(character: "ミ", romaji: "mi"), KatakanaFlashcard(character: "ム", romaji: "mu"), KatakanaFlashcard(character: "メ", romaji: "me"), KatakanaFlashcard(character: "モ", romaji: "mo"),
        KatakanaFlashcard(character: "ヤ", romaji: "ya"), KatakanaFlashcard(character: "ユ", romaji: "yu"), KatakanaFlashcard(character: "ヨ", romaji: "yo"),
        KatakanaFlashcard(character: "ラ", romaji: "ra"), KatakanaFlashcard(character: "リ", romaji: "ri"), KatakanaFlashcard(character: "ル", romaji: "ru"), KatakanaFlashcard(character: "レ", romaji: "re"), KatakanaFlashcard(character: "ロ", romaji: "ro"),
        KatakanaFlashcard(character: "ワ", romaji: "wa"), KatakanaFlashcard(character: "ヲ", romaji: "wo"), KatakanaFlashcard(character: "ン", romaji: "n"),
        // Dakuten & Handakuten
        KatakanaFlashcard(character: "ガ", romaji: "ga"), KatakanaFlashcard(character: "ギ", romaji: "gi"), KatakanaFlashcard(character: "グ", romaji: "gu"), KatakanaFlashcard(character: "ゲ", romaji: "ge"), KatakanaFlashcard(character: "ゴ", romaji: "go"),
        KatakanaFlashcard(character: "ザ", romaji: "za"), KatakanaFlashcard(character: "ジ", romaji: "ji"), KatakanaFlashcard(character: "ズ", romaji: "zu"), KatakanaFlashcard(character: "ゼ", romaji: "ze"), KatakanaFlashcard(character: "ゾ", romaji: "zo"),
        KatakanaFlashcard(character: "ダ", romaji: "da"), KatakanaFlashcard(character: "ヂ", romaji: "ji (dji)"), KatakanaFlashcard(character: "ヅ", romaji: "zu (dzu)"), KatakanaFlashcard(character: "デ", romaji: "de"), KatakanaFlashcard(character: "ド", romaji: "do"),
        KatakanaFlashcard(character: "バ", romaji: "ba"), KatakanaFlashcard(character: "ビ", romaji: "bi"), KatakanaFlashcard(character: "ブ", romaji: "bu"), KatakanaFlashcard(character: "ベ", romaji: "be"), KatakanaFlashcard(character: "ボ", romaji: "bo"),
        KatakanaFlashcard(character: "パ", romaji: "pa"), KatakanaFlashcard(character: "ピ", romaji: "pi"), KatakanaFlashcard(character: "プ", romaji: "pu"), KatakanaFlashcard(character: "ペ", romaji: "pe"), KatakanaFlashcard(character: "ポ", romaji: "po"),
        // Yoon
        KatakanaFlashcard(character: "キャ", romaji: "kya"), KatakanaFlashcard(character: "キュ", romaji: "kyu"), KatakanaFlashcard(character: "キョ", romaji: "kyo"),
        KatakanaFlashcard(character: "シャ", romaji: "sha"), KatakanaFlashcard(character: "シュ", romaji: "shu"), KatakanaFlashcard(character: "ショ", romaji: "sho"),
        KatakanaFlashcard(character: "チャ", romaji: "cha"), KatakanaFlashcard(character: "チュ", romaji: "chu"), KatakanaFlashcard(character: "チョ", romaji: "cho"),
        KatakanaFlashcard(character: "ニャ", romaji: "nya"), KatakanaFlashcard(character: "ニュ", romaji: "nyu"), KatakanaFlashcard(character: "ニョ", romaji: "nyo"),
        KatakanaFlashcard(character: "ヒャ", romaji: "hya"), KatakanaFlashcard(character: "ヒュ", romaji: "hyu"), KatakanaFlashcard(character: "ヒョ", romaji: "hyo"),
        KatakanaFlashcard(character: "ミャ", romaji: "mya"), KatakanaFlashcard(character: "ミュ", romaji: "myu"), KatakanaFlashcard(character: "ミョ", romaji: "myo"),
        KatakanaFlashcard(character: "リャ", romaji: "rya"), KatakanaFlashcard(character: "リュ", romaji: "ryu"), KatakanaFlashcard(character: "リョ", romaji: "ryo"),
        KatakanaFlashcard(character: "ギャ", romaji: "gya"), KatakanaFlashcard(character: "ギュ", romaji: "gyu"), KatakanaFlashcard(character: "ギョ", romaji: "gyo"),
        KatakanaFlashcard(character: "ジャ", romaji: "ja"), KatakanaFlashcard(character: "ジュ", romaji: "ju"), KatakanaFlashcard(character: "ジョ", romaji: "jo"),
        KatakanaFlashcard(character: "ビャ", romaji: "bya"), KatakanaFlashcard(character: "ビュ", romaji: "byu"), KatakanaFlashcard(character: "ビョ", romaji: "byo"),
        KatakanaFlashcard(character: "ピャ", romaji: "pya"), KatakanaFlashcard(character: "ピュ", romaji: "pyu"), KatakanaFlashcard(character: "ピョ", romaji: "pyo"),
        // Additional Katakana Combinations
        KatakanaFlashcard(character: "ファ", romaji: "fa"), KatakanaFlashcard(character: "フィ", romaji: "fi"), KatakanaFlashcard(character: "フェ", romaji: "fe"), KatakanaFlashcard(character: "フォ", romaji: "fo"),
        KatakanaFlashcard(character: "チェ", romaji: "che"), KatakanaFlashcard(character: "ジェ", romaji: "je"), KatakanaFlashcard(character: "ティ", romaji: "ti"), KatakanaFlashcard(character: "ディ", romaji: "di"),
        KatakanaFlashcard(character: "ヴァ", romaji: "va"), KatakanaFlashcard(character: "ヴィ", romaji: "vi"), KatakanaFlashcard(character: "ヴ", romaji: "vu"), KatakanaFlashcard(character: "ヴェ", romaji: "ve"), KatakanaFlashcard(character: "ヴォ", romaji: "vo"),
        KatakanaFlashcard(character: "ツァ", romaji: "tsa"), KatakanaFlashcard(character: "ツィ", romaji: "tsi"), KatakanaFlashcard(character: "ツェ", romaji: "tse"), KatakanaFlashcard(character: "ツォ", romaji: "tso"),
        KatakanaFlashcard(character: "ウィ", romaji: "wi"), KatakanaFlashcard(character: "ウェ", romaji: "we"), KatakanaFlashcard(character: "ウォ", romaji: "wo"),
        KatakanaFlashcard(character: "クァ", romaji: "kwa"), KatakanaFlashcard(character: "クィ", romaji: "kwi"), KatakanaFlashcard(character: "クェ", romaji: "kwe"), KatakanaFlashcard(character: "クォ", romaji: "kwo"),
        KatakanaFlashcard(character: "グァ", romaji: "gwa")
    ]

    // KANJI BARU BERDASARKAN LEVEL JLPT
    static let kanjiN5: [KanjiFlashcard] = [
        KanjiFlashcard(character: "日", meaning: "Day, Sun", onyomi: ["ニチ", "ジツ"], kunyomi: ["ひ", "-び", "-か"], jlptLevel: 5),
        KanjiFlashcard(character: "一", meaning: "One", onyomi: ["イチ", "イツ"], kunyomi: ["ひと-", "ひと.つ"], jlptLevel: 5),
        KanjiFlashcard(character: "国", meaning: "Country", onyomi: ["コク"], kunyomi: ["くに"], jlptLevel: 5),
        KanjiFlashcard(character: "人", meaning: "Person", onyomi: ["ジン", "ニン"], kunyomi: ["ひと", "-り", "-と"], jlptLevel: 5),
        KanjiFlashcard(character: "年", meaning: "Year", onyomi: ["ネン"], kunyomi: ["とし"], jlptLevel: 5),
        KanjiFlashcard(character: "大", meaning: "Big", onyomi: ["ダイ", "タイ"], kunyomi: ["おお-", "おお.きい"], jlptLevel: 5),
        KanjiFlashcard(character: "十", meaning: "Ten", onyomi: ["ジュウ"], kunyomi: ["とお", "と"], jlptLevel: 5),
        KanjiFlashcard(character: "二", meaning: "Two", onyomi: ["ニ"], kunyomi: ["ふた", "ふた.つ"], jlptLevel: 5),
        KanjiFlashcard(character: "本", meaning: "Book, Origin", onyomi: ["ホン"], kunyomi: ["もと"], jlptLevel: 5),
        KanjiFlashcard(character: "中", meaning: "Middle, Inside", onyomi: ["チュウ"], kunyomi: ["なか", "うち"], jlptLevel: 5),
        KanjiFlashcard(character: "長", meaning: "Long, Leader", onyomi: ["チョウ"], kunyomi: ["なが.い", "おさ"], jlptLevel: 5),
        KanjiFlashcard(character: "出", meaning: "Exit, Put out", onyomi: ["シュツ", "スイ"], kunyomi: ["で.る", "だ.す"], jlptLevel: 5),
        KanjiFlashcard(character: "三", meaning: "Three", onyomi: ["サン"], kunyomi: ["み", "み.つ", "みっ.つ"], jlptLevel: 5),
        KanjiFlashcard(character: "時", meaning: "Time, Hour", onyomi: ["ジ"], kunyomi: ["とき"], jlptLevel: 5),
        KanjiFlashcard(character: "行", meaning: "Go, Conduct", onyomi: ["コウ", "ギョウ"], kunyomi: ["い.く", "ゆ.く", "おこな.う"], jlptLevel: 5),
        KanjiFlashcard(character: "見", meaning: "See, Look", onyomi: ["ケン"], kunyomi: ["み.る", "み.える", "み.せる"], jlptLevel: 5),
        KanjiFlashcard(character: "月", meaning: "Month, Moon", onyomi: ["ゲツ", "ガツ"], kunyomi: ["つき"], jlptLevel: 5),
        KanjiFlashcard(character: "分", meaning: "Minute, Part, Understand", onyomi: ["ブン", "フン", "ブ"], kunyomi: ["わ.ける", "わ.かる"], jlptLevel: 5),
        KanjiFlashcard(character: "後", meaning: "After, Behind", onyomi: ["ゴ", "コウ"], kunyomi: ["のち", "うし.ろ", "あと"], jlptLevel: 5),
        KanjiFlashcard(character: "前", meaning: "Before, Front", onyomi: ["ゼン"], kunyomi: ["まえ"], jlptLevel: 5),
        KanjiFlashcard(character: "生", meaning: "Birth, Life, Raw", onyomi: ["セイ", "ショウ"], kunyomi: ["い.きる", "う.まれる", "なま"], jlptLevel: 5)
    ]

    static let kanjiN4: [KanjiFlashcard] = [
        KanjiFlashcard(character: "会", meaning: "Meet, Society", onyomi: ["カイ", "エ"], kunyomi: ["あ.う"], jlptLevel: 4),
        KanjiFlashcard(character: "同", meaning: "Same", onyomi: ["ドウ"], kunyomi: ["おな.じ"], jlptLevel: 4),
        KanjiFlashcard(character: "事", meaning: "Thing, Matter", onyomi: ["ジ", "ズ"], kunyomi: ["こと"], jlptLevel: 4),
        KanjiFlashcard(character: "自", meaning: "Oneself", onyomi: ["ジ", "シ"], kunyomi: ["みずか.ら"], jlptLevel: 4),
        KanjiFlashcard(character: "社", meaning: "Company, Shrine", onyomi: ["シャ"], kunyomi: ["やしろ"], jlptLevel: 4),
        KanjiFlashcard(character: "作", meaning: "Make", onyomi: ["サク", "サ"], kunyomi: ["つく.る"], jlptLevel: 4),
        KanjiFlashcard(character: "度", meaning: "Degree, Time", onyomi: ["ド", "ト"], kunyomi: ["たび"], jlptLevel: 4),
        KanjiFlashcard(character: "強", meaning: "Strong", onyomi: ["キョウ", "ゴウ"], kunyomi: ["つよ.い"], jlptLevel: 4),
        KanjiFlashcard(character: "公", meaning: "Public", onyomi: ["コウ", "ク"], kunyomi: ["おおやけ"], jlptLevel: 4),
        KanjiFlashcard(character: "持", meaning: "Hold", onyomi: ["ジ"], kunyomi: ["も.つ"], jlptLevel: 4),
        KanjiFlashcard(character: "野", meaning: "Field", onyomi: ["ヤ", "ショ"], kunyomi: ["の"], jlptLevel: 4),
        KanjiFlashcard(character: "思", meaning: "Think", onyomi: ["シ"], kunyomi: ["おも.う"], jlptLevel: 4),
        KanjiFlashcard(character: "家", meaning: "House, Family", onyomi: ["カ", "ケ"], kunyomi: ["いえ", "うち"], jlptLevel: 4),
        KanjiFlashcard(character: "世", meaning: "World, Generation", onyomi: ["セイ", "セ"], kunyomi: ["よ"], jlptLevel: 4),
        KanjiFlashcard(character: "多", meaning: "Many, Much", onyomi: ["タ"], kunyomi: ["おお.い"], jlptLevel: 4),
        KanjiFlashcard(character: "正", meaning: "Correct, Right", onyomi: ["セイ", "ショウ"], kunyomi: ["ただ.しい", "まさ"], jlptLevel: 4),
        KanjiFlashcard(character: "安", meaning: "Cheap, Safe, Peaceful", onyomi: ["アン"], kunyomi: ["やす.い"], jlptLevel: 4),
        KanjiFlashcard(character: "院", meaning: "Institution, Hospital", onyomi: ["イン"], kunyomi: [], jlptLevel: 4),
        KanjiFlashcard(character: "心", meaning: "Heart, Mind", onyomi: ["シン"], kunyomi: ["こころ"], jlptLevel: 4),
        KanjiFlashcard(character: "界", meaning: "World, Boundary", onyomi: ["カイ"], kunyomi: [], jlptLevel: 4),
        KanjiFlashcard(character: "教", meaning: "Teach, Religion", onyomi: ["キョウ"], kunyomi: ["おし.える", "おそ.わる"], jlptLevel: 4)
    ]

    static let kanjiN3: [KanjiFlashcard] = [
        KanjiFlashcard(character: "受", meaning: "Receive, Accept", onyomi: ["ジュ"], kunyomi: ["う.ける"], jlptLevel: 3),
        KanjiFlashcard(character: "様", meaning: "Manner, Mr./Ms.", onyomi: ["ヨウ"], kunyomi: ["さま"], jlptLevel: 3),
        KanjiFlashcard(character: "進", meaning: "Advance, Proceed", onyomi: ["シン"], kunyomi: ["すす.む", "すす.める"], jlptLevel: 3),
        KanjiFlashcard(character: "部", meaning: "Department, Part", onyomi: ["ブ"], kunyomi: ["-べ"], jlptLevel: 3),
        KanjiFlashcard(character: "係", meaning: "Connection, In charge", onyomi: ["ケイ"], kunyomi: ["かか.る", "かかり"], jlptLevel: 3),
        KanjiFlashcard(character: "化", meaning: "Change, Transform", onyomi: ["カ", "ケ"], kunyomi: ["ば.ける", "ば.かす"], jlptLevel: 3),
        KanjiFlashcard(character: "区", meaning: "District, Ward", onyomi: ["ク"], kunyomi: [], jlptLevel: 3),
        KanjiFlashcard(character: "相", meaning: "Mutual, Phase", onyomi: ["ソウ", "ショウ"], kunyomi: ["あい-"], jlptLevel: 3),
        KanjiFlashcard(character: "定", meaning: "Decide, Fix", onyomi: ["テイ", "ジョウ"], kunyomi: ["さだ.める", "さだ.まる"], jlptLevel: 3),
        KanjiFlashcard(character: "実", meaning: "Truth, Fruit, Reality", onyomi: ["ジツ", "シツ"], kunyomi: ["み", "みの.る"], jlptLevel: 3),
        KanjiFlashcard(character: "決", meaning: "Decide", onyomi: ["ケツ"], kunyomi: ["き.める", "き.まる"], jlptLevel: 3),
        KanjiFlashcard(character: "全", meaning: "All, Entire", onyomi: ["ゼン"], kunyomi: ["まった.く", "すべ.て"], jlptLevel: 3),
        KanjiFlashcard(character: "表", meaning: "Surface, Express", onyomi: ["ヒョウ"], kunyomi: ["おもて", "あらわ.す"], jlptLevel: 3),
        KanjiFlashcard(character: "戦", meaning: "War, Battle", onyomi: ["セン"], kunyomi: ["たたか.う", "いくさ"], jlptLevel: 3),
        KanjiFlashcard(character: "経", meaning: "Pass through,経perience", onyomi: ["ケイ", "キョウ"], kunyomi: ["へ.る", "た.つ"], jlptLevel: 3),
        KanjiFlashcard(character: "最", meaning: "Most, Extreme", onyomi: ["サイ"], kunyomi: ["もっと.も"], jlptLevel: 3),
        KanjiFlashcard(character: "現", meaning: "Appear, Present", onyomi: ["ゲン"], kunyomi: ["あらわ.れる", "あらわ.す"], jlptLevel: 3),
        KanjiFlashcard(character: "調", meaning: "Investigate, Tone", onyomi: ["チョウ"], kunyomi: ["しら.べる", "ととの.う"], jlptLevel: 3),
        KanjiFlashcard(character: "議", meaning: "Discuss, Deliberate", onyomi: ["ギ"], kunyomi: [], jlptLevel: 3),
        KanjiFlashcard(character: "民", meaning: "People, Nation", onyomi: ["ミン"], kunyomi: ["たみ"], jlptLevel: 3),
        KanjiFlashcard(character: "連", meaning: "Connect, Take along", onyomi: ["レン"], kunyomi: ["つら.なる", "つ.れる"], jlptLevel: 3)
    ]

    static let kanjiN2: [KanjiFlashcard] = [
        KanjiFlashcard(character: "率", meaning: "Ratio, Rate, Lead", onyomi: ["ソツ", "リツ"], kunyomi: ["ひき.いる"], jlptLevel: 2),
        KanjiFlashcard(character: "製", meaning: "Manufacture, Made in", onyomi: ["セイ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "義", meaning: "Righteousness, Justice, Meaning", onyomi: ["ギ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "際", meaning: "Occasion, Edge, When", onyomi: ["サイ"], kunyomi: ["きわ", "-ぎわ"], jlptLevel: 2),
        KanjiFlashcard(character: "識", meaning: "Discern, Know, Write", onyomi: ["シキ"], kunyomi: ["し.る", "しる.す"], jlptLevel: 2),
        KanjiFlashcard(character: "劇", meaning: "Drama, Play, Severe", onyomi: ["ゲキ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "派", meaning: "Faction, Group, Dispatch", onyomi: ["ハ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "批", meaning: "Criticism, Strike", onyomi: ["ヒ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "技", meaning: "Skill, Art, Craft", onyomi: ["ギ"], kunyomi: ["わざ"], jlptLevel: 2),
        KanjiFlashcard(character: "格", meaning: "Status, Rank, Capacity", onyomi: ["カク", "コウ", "キャク", "ゴウ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "複", meaning: "Duplicate, Double, Compound", onyomi: ["フク"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "覧", meaning: "Look at, See, View", onyomi: ["ラン"], kunyomi: ["み.る"], jlptLevel: 2),
        KanjiFlashcard(character: "賀", meaning: "Congratulations, Joy", onyomi: ["ガ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "寄", meaning: "Draw near, Send, Collect", onyomi: ["キ"], kunyomi: ["よ.る", "-よ.り", "よ.せる"], jlptLevel: 2),
        KanjiFlashcard(character: "規", meaning: "Standard, Measure, Rule", onyomi: ["キ"], kunyomi: [], jlptLevel: 2),
        KanjiFlashcard(character: "喜", meaning: "Rejoice, Be glad", onyomi: ["キ"], kunyomi: ["よろこ.ぶ", "よろこ.ばす"], jlptLevel: 2),
        KanjiFlashcard(character: "幹", meaning: "Tree trunk, Main part, Manage", onyomi: ["カン"], kunyomi: ["みき"], jlptLevel: 2),
        KanjiFlashcard(character: "態", meaning: "Attitude, Condition, Figure", onyomi: ["タイ"], kunyomi: ["わざと"], jlptLevel: 2),
        KanjiFlashcard(character: "検", meaning: "Examine, Investigate", onyomi: ["ケン"], kunyomi: ["しら.べる"], jlptLevel: 2),
        KanjiFlashcard(character: "権", meaning: "Right, Power, Authority", onyomi: ["ケン", "ゴン"], kunyomi: ["おもり", "かり", "はか.る"], jlptLevel: 2),
        KanjiFlashcard(character: "句", meaning: "Phrase, Sentence, Clause", onyomi: ["ク"], kunyomi: [], jlptLevel: 2)
    ]
    
    static let kanjiN1: [KanjiFlashcard] = [
        KanjiFlashcard(character: "劾", meaning: "Impeach, Censure", onyomi: ["ガイ"], kunyomi: [], jlptLevel: 1),
        KanjiFlashcard(character: "朕", meaning: "Royal 'we', Imperial 'I'", onyomi: ["チン"], kunyomi: [], jlptLevel: 1),
        KanjiFlashcard(character: "詔", meaning: "Imperial edict", onyomi: ["ショウ"], kunyomi: ["みことのり"], jlptLevel: 1),
        KanjiFlashcard(character: "侍", meaning: "Samurai, Attend", onyomi: ["ジ", "シ"], kunyomi: ["さむらい", "はべ.る"], jlptLevel: 1),
        KanjiFlashcard(character: "罷", meaning: "Dismiss, Cease, Resign", onyomi: ["ヒ"], kunyomi: ["まか.る", "や.める"], jlptLevel: 1),
        KanjiFlashcard(character: "伐", meaning: "Fell (trees), Attack", onyomi: ["バツ", "カ"], kunyomi: ["き.る", "う.つ"], jlptLevel: 1),
        KanjiFlashcard(character: "唇", meaning: "Lips", onyomi: ["シン"], kunyomi: ["くちびる"], jlptLevel: 1),
        KanjiFlashcard(character: "巾", meaning: "Cloth, Towel, Width", onyomi: ["キン"], kunyomi: ["きれ"], jlptLevel: 1),
        KanjiFlashcard(character: "凹", meaning: "Concave, Dent", onyomi: ["オウ"], kunyomi: ["くぼ.む", "へこ.む"], jlptLevel: 1),
        KanjiFlashcard(character: "凸", meaning: "Convex, Protrusion", onyomi: ["トツ"], kunyomi: ["でこ"], jlptLevel: 1),
        KanjiFlashcard(character: "瓦", meaning: "Roof tile, Gram", onyomi: ["ガ"], kunyomi: ["かわら"], jlptLevel: 1),
        KanjiFlashcard(character: "臼", meaning: "Mortar", onyomi: ["キュウ"], kunyomi: ["うす"], jlptLevel: 1),
        KanjiFlashcard(character: "銑", meaning: "Pig iron", onyomi: ["セン"], kunyomi: [], jlptLevel: 1),
        KanjiFlashcard(character: "錘", meaning: "Spindle, Weight", onyomi: ["スイ"], kunyomi: ["つむ", "おもり"], jlptLevel: 1),
        KanjiFlashcard(character: "綬", meaning: "Sash, Ribbon cord", onyomi: ["ジュ"], kunyomi: ["おび"], jlptLevel: 1),
        KanjiFlashcard(character: "錨", meaning: "Anchor", onyomi: ["ビョウ"], kunyomi: ["いかり"], jlptLevel: 1),
        KanjiFlashcard(character: "舷", meaning: "Gunwale, Ship's side", onyomi: ["ゲン"], kunyomi: ["ふなばた"], jlptLevel: 1),
        KanjiFlashcard(character: "亀", meaning: "Turtle, Tortoise", onyomi: ["キ", "キン"], kunyomi: ["かめ"], jlptLevel: 1),
        KanjiFlashcard(character: "匣", meaning: "Small box, Casket", onyomi: ["コウ"], kunyomi: ["くしげ"], jlptLevel: 1),
        KanjiFlashcard(character: "枷", meaning: "Shackles, Fetters, Yoke", onyomi: ["カ"], kunyomi: ["かせ"], jlptLevel: 1),
        KanjiFlashcard(character: "檐", meaning: "Eaves", onyomi: ["エン"], kunyomi: ["ひさし", "のき"], jlptLevel: 1)
    ]

    // Definisi flashcard untuk intermediate dan expert (kosakata & kana kompleks)
    static let intermediateVocabAndKana: [any JapaneseCharacterCard] = [
        // Complex Kana (Yoon, dll.)
        HiraganaFlashcard(character: "てぃ", romaji: "ti"), HiraganaFlashcard(character: "でぃ", romaji: "di"),
        HiraganaFlashcard(character: "ふぁ", romaji: "fa"), HiraganaFlashcard(character: "ふぃ", romaji: "fi"), HiraganaFlashcard(character: "ふぇ", romaji: "fe"), HiraganaFlashcard(character: "ふぉ", romaji: "fo"),
        KatakanaFlashcard(character: "ティ", romaji: "ti"), KatakanaFlashcard(character: "ディ", romaji: "di"),
        KatakanaFlashcard(character: "ファ", romaji: "fa"), KatakanaFlashcard(character: "フィ", romaji: "fi"), KatakanaFlashcard(character: "フェ", romaji: "fe"), KatakanaFlashcard(character: "フォ", romaji: "fo"),
        KatakanaFlashcard(character: "シェ", romaji: "she"), KatakanaFlashcard(character: "チェ", romaji: "che"), KatakanaFlashcard(character: "ジェ", romaji: "je"),

        // Vocab (Intermediate Level)
        HiraganaFlashcard(character: "おはようございます", romaji: "ohayou gozaimasu (good morning - formal)"),
        HiraganaFlashcard(character: "おやすみなさい", romaji: "oyasuminasai (good night - formal)"),
        HiraganaFlashcard(character: "ありがとうございます", romaji: "arigatou gozaimasu (thank you - formal)"),
        HiraganaFlashcard(character: "どういたしまして", romaji: "dou itashimashite (you're welcome)"),
        HiraganaFlashcard(character: "ごめんなさい", romaji: "gomennasai (I'm sorry)"),
        KatakanaFlashcard(character: "レストラン", romaji: "resutoran (restaurant)"),
        KatakanaFlashcard(character: "ホテル", romaji: "hoteru (hotel)"),
        KatakanaFlashcard(character: "タクシー", romaji: "takushii (taxi)"),
        KatakanaFlashcard(character: "コンピュータ", romaji: "konpyuuta (computer)"),
        KatakanaFlashcard(character: "シャツ", romaji: "shatsu (shirt)"),
        KatakanaFlashcard(character: "プレゼント", romaji: "purezento (present)"),
        KatakanaFlashcard(character: "メニュー", romaji: "menyuu (menu)"),
        KatakanaFlashcard(character: "チョコレート", romaji: "chokoreeto (chocolate)"),
        KatakanaFlashcard(character: "デパート", romaji: "depaato (department store)"),
        KatakanaFlashcard(character: "アパート", romaji: "apaato (apartment)"),
        KatakanaFlashcard(character: "カメラ", romaji: "kamera (camera)"),
        KatakanaFlashcard(character: "ビール", romaji: "biiru (beer)"),
        KatakanaFlashcard(character: "アイスクリーム", romaji: "aisukuriimu (ice cream)"),
        KatakanaFlashcard(character: "サンドイッチ", romaji: "sandoicchi (sandwich)"),
        KatakanaFlashcard(character: "カーテン", romaji: "kaaten (curtain)")
    ]

    static let expertVocabAndKana: [any JapaneseCharacterCard] = [
        // More Complex Kana & Sounds for Foreign Words
        KatakanaFlashcard(character: "ヴォ", romaji: "vo"), KatakanaFlashcard(character: "ヴィ", romaji: "vi"),
        KatakanaFlashcard(character: "ツァ", romaji: "tsa"), KatakanaFlashcard(character: "ツィ", romaji: "tsi"), KatakanaFlashcard(character: "ツェ", romaji: "tse"), KatakanaFlashcard(character: "ツォ", romaji: "tso"),
        KatakanaFlashcard(character: "ヂャ", romaji: "ja (rare)"), KatakanaFlashcard(character: "ヂュ", romaji: "ju (rare)"), KatakanaFlashcard(character: "ヂョ", romaji: "jo (rare)"),

        // Vocab (Expert Level, more nuanced/complex words)
        HiraganaFlashcard(character: "いただきます", romaji: "itadakimasu (expression before meal)"),
        HiraganaFlashcard(character: "ごちそうさま", romaji: "gochisousama (expression after meal)"),
        HiraganaFlashcard(character: "おつかれさまでした", romaji: "otsukaresamadeshita (thank you for your hard work)"),
        HiraganaFlashcard(character: "かしこまりました", romaji: "kashikomarimashita (certainly, understood - humble)"),
        HiraganaFlashcard(character: "恐れ入ります", romaji: "osoreirimasu (I'm sorry/thank you - formal)"),
        KatakanaFlashcard(character: "コミュニケーション", romaji: "komyunikeeshon (communication)"),
        KatakanaFlashcard(character: "テクノロジー", romaji: "tekunorojii (technology)"),
        KatakanaFlashcard(character: "グローバル", romaji: "guroobaru (global)"),
        KatakanaFlashcard(character: "イノベーション", romaji: "inobeeshon (innovation)"),
        KatakanaFlashcard(character: "プライバシー", romaji: "puraibashii (privacy)"),
        KatakanaFlashcard(character: "カスタマーサービス", romaji: "kasutamaa saabisu (customer service)"),
        KatakanaFlashcard(character: "エンターテイメント", romaji: "entaateimento (entertainment)"),
        KatakanaFlashcard(character: "マーケティング", romaji: "maaketingu (marketing)"),
        KatakanaFlashcard(character: "クリエイティブ", romaji: "kurieitibu (creative)"),
        KatakanaFlashcard(character: "エコノミー", romaji: "ekonomii (economy)"),
        KatakanaFlashcard(character: "リスク", romaji: "risuku (risk)"),
        KatakanaFlashcard(character: "ソリューション", romaji: "soryuushon (solution)"),
        KatakanaFlashcard(character: "プロジェクト", romaji: "purojekuto (project)"),
        KatakanaFlashcard(character: "マネージメント", romaji: "maneegimento (management)"),
        KatakanaFlashcard(character: "パフォーマンス", romaji: "pafoomansu (performance)")
    ]

    // Set Flashcard Gabungan per Level
    static let beginnerFlashcards: [any JapaneseCharacterCard] =
        (hiraganaCharacters as [any JapaneseCharacterCard]) + // Semua Hiragana
        (katakanaCharacters as [any JapaneseCharacterCard]) + // Semua Katakana
        (kanjiN5 as [any JapaneseCharacterCard])

    static let intermediateFlashcardsWithKanji: [any JapaneseCharacterCard] =
        intermediateVocabAndKana +
        (kanjiN4 as [any JapaneseCharacterCard]) +
        (kanjiN3 as [any JapaneseCharacterCard])

    static let expertFlashcardsWithKanji: [any JapaneseCharacterCard] =
        expertVocabAndKana +
        (kanjiN2 as [any JapaneseCharacterCard]) +
        (kanjiN1 as [any JapaneseCharacterCard])

    // Metode allCharacters() tidak secara langsung digunakan oleh flashcard per level lagi.
    static func allCharacters() -> [any JapaneseCharacterCard] {
        return (hiraganaCharacters as [any JapaneseCharacterCard]) + (katakanaCharacters as [any JapaneseCharacterCard])
    }
}
