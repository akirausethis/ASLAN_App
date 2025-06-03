// AslanApp/Model/JapaneseCharacterData.swift
import Foundation

struct JapaneseCharacterData {
    // Hiragana Characters (Pastikan ini lengkap sesuai file asli Anda)
    static let hiraganaCharacters: [HiraganaFlashcard] = [
        HiraganaFlashcard(character: "あ", romaji: "a"), HiraganaFlashcard(character: "い", romaji: "i"), /* ... sisa hiragana ... */ HiraganaFlashcard(character: "ん", romaji: "n"),
        HiraganaFlashcard(character: "が", romaji: "ga"), /* ... sisa hiragana dakuten/handakuten & yoon ... */
        HiraganaFlashcard(character: "ぽ", romaji: "po"),
        HiraganaFlashcard(character: "きゃ", romaji: "kya"), HiraganaFlashcard(character: "きゅ", romaji: "kyu"), HiraganaFlashcard(character: "きょ", romaji: "kyo"),
        HiraganaFlashcard(character: "ぴゃ", romaji: "pya"), HiraganaFlashcard(character: "ぴゅ", romaji: "pyu"), HiraganaFlashcard(character: "ぴょ", romaji: "pyo")

    ]

    // Katakana Characters (Pastikan ini lengkap sesuai file asli Anda)
    static let katakanaCharacters: [KatakanaFlashcard] = [
        KatakanaFlashcard(character: "ア", romaji: "a"), KatakanaFlashcard(character: "イ", romaji: "i"), /* ... sisa katakana ... */ KatakanaFlashcard(character: "ン", romaji: "n"),
        KatakanaFlashcard(character: "ガ", romaji: "ga"), /* ... sisa katakana dakuten/handakuten & yoon ... */
        KatakanaFlashcard(character: "ポ", romaji: "po"),
        KatakanaFlashcard(character: "キャ", romaji: "kya"), KatakanaFlashcard(character: "キュ", romaji: "kyu"), KatakanaFlashcard(character: "キョ", romaji: "kyo"),
        KatakanaFlashcard(character: "ピャ", romaji: "pya"), KatakanaFlashcard(character: "ピュ", romaji: "pyu"), KatakanaFlashcard(character: "ピョ", romaji: "pyo"),
        KatakanaFlashcard(character: "ファ", romaji: "fa"), KatakanaFlashcard(character: "フィ", romaji: "fi"), KatakanaFlashcard(character: "フェ", romaji: "fe"), KatakanaFlashcard(character: "フォ", romaji: "fo"),
        KatakanaFlashcard(character: "ヴァ", romaji: "va"), KatakanaFlashcard(character: "ヴィ", romaji: "vi"), KatakanaFlashcard(character: "ヴ", romaji: "vu"), KatakanaFlashcard(character: "ヴェ", romaji: "ve"), KatakanaFlashcard(character: "ヴォ", romaji: "vo")
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
    // (Pastikan Anda MENGISI ini dengan definisi dari respons saya sebelumnya yang sesuai)
    static let intermediateVocabAndKana: [any JapaneseCharacterCard] = [
        HiraganaFlashcard(character: "ぢゃ", romaji: "ja (rare)"), HiraganaFlashcard(character: "ぢゅ", romaji: "ju (rare)"), HiraganaFlashcard(character: "ぢょ", romaji: "jo (rare)"),
        KatakanaFlashcard(character: "ヂャ", romaji: "ja (rare)"), KatakanaFlashcard(character: "ヂュ", romaji: "ju (rare)"), KatakanaFlashcard(character: "ヂョ", romaji: "jo (rare)"),
        HiraganaFlashcard(character: "おはよう", romaji: "ohayou (good morning)"),
        HiraganaFlashcard(character: "こんにちは", romaji: "konnichiwa (hello)"),
        HiraganaFlashcard(character: "ありがとう", romaji: "arigatou (thank you)"),
        KatakanaFlashcard(character: "コーヒー", romaji: "koohii (coffee)"),
        KatakanaFlashcard(character: "テレビ", romaji: "terebi (television)"),
        // ... (TAMBAHKAN sisa definisi dari intermediateFlashcards yang sebelumnya)
    ]

    static let expertVocabAndKana: [any JapaneseCharacterCard] = [
        KatakanaFlashcard(character: "ツァ", romaji: "tsa"), KatakanaFlashcard(character: "ツィ", romaji: "tsi"), KatakanaFlashcard(character: "ツェ", romaji: "tse"), KatakanaFlashcard(character: "ツォ", romaji: "tso"),
        KatakanaFlashcard(character: "シェ", romaji: "she"), KatakanaFlashcard(character: "チェ", romaji: "che"), KatakanaFlashcard(character: "ジェ", romaji: "je"),
        HiraganaFlashcard(character: "いただきます", romaji: "itadakimasu (expression before meal)"),
        HiraganaFlashcard(character: "ごちそうさま", romaji: "gochisousama (expression after meal)"),
        KatakanaFlashcard(character: "レストラン", romaji: "resutoran (restaurant)"),
        KatakanaFlashcard(character: "コンピュータ", romaji: "konpyuuta (computer)"),
        // ... (TAMBAHKAN sisa definisi dari expertFlashcards yang sebelumnya)
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
