// AslanApp/Model/QuizData.swift
import Foundation

struct QuizData {

    // --- BEGINNER QUIZZES ---
    static let hiraganaBasicsQuiz: [QuizQuestion] = [
        // 5 Pertanyaan Awal
        QuizQuestion(questionText: "Romaji for 'あ'?", options: [QuizOption(text: "a", isCorrect: true), QuizOption(text: "i", isCorrect: false), QuizOption(text: "u", isCorrect: false), QuizOption(text: "o", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Romaji for 'き'?", options: [QuizOption(text: "ka", isCorrect: false), QuizOption(text: "ki", isCorrect: true), QuizOption(text: "ku", isCorrect: false), QuizOption(text: "ke", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'み' is 'mi'. True or False?", options: [QuizOption(text: "True", isCorrect: true), QuizOption(text: "False", isCorrect: false)], questionType: .trueFalse),
        QuizQuestion(questionText: "Which Hiragana is 'se'?", options: [QuizOption(text: "さ", isCorrect: false), QuizOption(text: "す", isCorrect: false), QuizOption(text: "せ", isCorrect: true), QuizOption(text: "そ", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "What is the Hiragana for 'no'?", options: [QuizOption(text: "な", isCorrect: false), QuizOption(text: "に", isCorrect: false), QuizOption(text: "ぬ", isCorrect: false), QuizOption(text: "の", isCorrect: true)], questionType: .multipleChoice),
        // Tambahan
        QuizQuestion(questionText: "Romaji for 'つ'?", options: [QuizOption(text: "tsu", isCorrect: true), QuizOption(text: "chi", isCorrect: false), QuizOption(text: "ta", isCorrect: false), QuizOption(text: "te", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Which Hiragana is 'ha'?", options: [QuizOption(text: "ほ", isCorrect: false), QuizOption(text: "は", isCorrect: true), QuizOption(text: "ひ", isCorrect: false), QuizOption(text: "ふ", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'ゆ' is 'yu'. True or False?", options: [QuizOption(text: "True", isCorrect: true), QuizOption(text: "False", isCorrect: false)], questionType: .trueFalse),
        QuizQuestion(questionText: "Romaji for 'め'?", options: [QuizOption(text: "ma", isCorrect: false), QuizOption(text: "mi", isCorrect: false), QuizOption(text: "mu", isCorrect: false), QuizOption(text: "me", isCorrect: true)], questionType: .multipleChoice),
        QuizQuestion(questionText: "What is the Hiragana for 're'?", options: [QuizOption(text: "ら", isCorrect: false), QuizOption(text: "り", isCorrect: false), QuizOption(text: "る", isCorrect: false), QuizOption(text: "れ", isCorrect: true)], questionType: .multipleChoice),
        // Anda perlu menambahkan 10 pertanyaan lagi untuk mencapai 20
    ]

    static let katakanaBasicsQuiz: [QuizQuestion] = [
        // 5 Pertanyaan Awal
        QuizQuestion(questionText: "Romaji for 'ア'?", options: [QuizOption(text: "a", isCorrect: true), QuizOption(text: "e", isCorrect: false), QuizOption(text: "o", isCorrect: false), QuizOption(text: "i", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Romaji for 'シ'?", options: [QuizOption(text: "tsu", isCorrect: false), QuizOption(text: "so", isCorrect: false), QuizOption(text: "shi", isCorrect: true), QuizOption(text: "n", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'ヌ' is 'nu'. True or False?", options: [QuizOption(text: "True", isCorrect: true), QuizOption(text: "False", isCorrect: false)], questionType: .trueFalse),
        QuizQuestion(questionText: "Which Katakana is 'to'?", options: [QuizOption(text: "タ", isCorrect: false), QuizOption(text: "チ", isCorrect: false), QuizOption(text: "ツ", isCorrect: false), QuizOption(text: "ト", isCorrect: true)], questionType: .multipleChoice),
        QuizQuestion(questionText: "What is the Katakana for 'he'?", options: [QuizOption(text: "ハ", isCorrect: false), QuizOption(text: "ヒ", isCorrect: false), QuizOption(text: "フ", isCorrect: false), QuizOption(text: "ヘ", isCorrect: true)], questionType: .multipleChoice),
        // Tambahan
        QuizQuestion(questionText: "Romaji for 'マ'?", options: [QuizOption(text: "ma", isCorrect: true), QuizOption(text: "mi", isCorrect: false), QuizOption(text: "mu", isCorrect: false), QuizOption(text: "me", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Which Katakana is 'yo'?", options: [QuizOption(text: "ヤ", isCorrect: false), QuizOption(text: "ユ", isCorrect: false), QuizOption(text: "ヨ", isCorrect: true), QuizOption(text: "ラ", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'リ' is 'ri'. True or False?", options: [QuizOption(text: "True", isCorrect: true), QuizOption(text: "False", isCorrect: false)], questionType: .trueFalse),
        QuizQuestion(questionText: "Romaji for 'ワ'?", options: [QuizOption(text: "ra", isCorrect: false), QuizOption(text: "wa", isCorrect: true), QuizOption(text: "wo", isCorrect: false), QuizOption(text: "n", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "What is the Katakana for 'ke'?", options: [QuizOption(text: "カ", isCorrect: false), QuizOption(text: "キ", isCorrect: false), QuizOption(text: "ク", isCorrect: false), QuizOption(text: "ケ", isCorrect: true)], questionType: .multipleChoice),
        // Anda perlu menambahkan 10 pertanyaan lagi untuk mencapai 20
    ]

    static let kanjiN5StarterQuiz: [QuizQuestion] = [
        // 5 Pertanyaan Awal
        QuizQuestion(questionText: "Meaning of '人'?", options: [QuizOption(text: "Mountain", isCorrect: false), QuizOption(text: "Person", isCorrect: true), QuizOption(text: "Tree", isCorrect: false), QuizOption(text: "River", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Which Kanji is 'fire' (火)?", options: [QuizOption(text: "水", isCorrect: false), QuizOption(text: "木", isCorrect: false), QuizOption(text: "火", isCorrect: true), QuizOption(text: "土", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "On'yomi of '一' (one)?", options: [QuizOption(text: "ひと", isCorrect: false), QuizOption(text: "イチ / イツ", isCorrect: true), QuizOption(text: "カ / コ", isCorrect: false), QuizOption(text: "ジン / ニン", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Kun'yomi of '月' (moon/month)?", options: [QuizOption(text: "ニチ", isCorrect: false), QuizOption(text: "ゲツ / ガツ", isCorrect: false), QuizOption(text: "つき", isCorrect: true), QuizOption(text: "ひ", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'年' means 'year'. True or False?", options: [QuizOption(text: "True", isCorrect: true), QuizOption(text: "False", isCorrect: false)], questionType: .trueFalse),
        // Tambahan
        QuizQuestion(questionText: "Which Kanji means 'big' (大)?", options: [QuizOption(text: "小", isCorrect: false), QuizOption(text: "中", isCorrect: false), QuizOption(text: "大", isCorrect: true), QuizOption(text: "人", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Meaning of '本'?", options: [QuizOption(text: "Tree", isCorrect: false), QuizOption(text: "Book / Origin", isCorrect: true), QuizOption(text: "Sun", isCorrect: false), QuizOption(text: "Time", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "On'yomi of '国' (country)?", options: [QuizOption(text: "くに", isCorrect: false), QuizOption(text: "ジン", isCorrect: false), QuizOption(text: "コク", isCorrect: true), QuizOption(text: "ネン", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Kun'yomi of '見' (see)?", options: [QuizOption(text: "ケン", isCorrect: false), QuizOption(text: "み.る", isCorrect: true), QuizOption(text: "ギョウ", isCorrect: false), QuizOption(text: "シュツ", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'時' means 'time/hour'. True or False?", options: [QuizOption(text: "True", isCorrect: true), QuizOption(text: "False", isCorrect: false)], questionType: .trueFalse),
        // Anda perlu menambahkan 10 pertanyaan lagi untuk mencapai 20
    ]

    // --- INTERMEDIATE QUIZZES (Contoh Awal) ---
    static let intermediateGrammarParticlesQuiz: [QuizQuestion] = [
        QuizQuestion(questionText: "Particle for direct object?", options: [QuizOption(text: "は", isCorrect: false), QuizOption(text: "が", isCorrect: false), QuizOption(text: "を", isCorrect: true), QuizOption(text: "に", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "学校＿行きます (Gakkou _ ikimasu - Go to school). Fill blank.", options: [QuizOption(text: "へ/に", isCorrect: true), QuizOption(text: "で", isCorrect: false), QuizOption(text: "と", isCorrect: false), QuizOption(text: "も", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "図書館＿勉強します (Toshokan _ benkyou shimasu - Study AT the library). Fill blank.", options: [QuizOption(text: "に", isCorrect: false), QuizOption(text: "で", isCorrect: true), QuizOption(text: "を", isCorrect: false), QuizOption(text: "へ", isCorrect: false)], questionType: .multipleChoice),
        // ... Tambahkan 17 pertanyaan partikel lagi ...
    ]

    static let kanjiN4ChallengeQuiz: [QuizQuestion] = [
        QuizQuestion(questionText: "Meaning of '会'?", options: [QuizOption(text: "Rest", isCorrect: false), QuizOption(text: "Say", isCorrect: false), QuizOption(text: "Meet", isCorrect: true), QuizOption(text: "Eat", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Reading of '同じ' (same)?", options: [QuizOption(text: "chigau", isCorrect: false), QuizOption(text: "onaji", isCorrect: true), QuizOption(text: "sukoshi", isCorrect: false), QuizOption(text: "hayai", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Kun'yomi of '強' (strong)?", options: [QuizOption(text: "よわ.い", isCorrect: false), QuizOption(text: "つよ.い", isCorrect: true), QuizOption(text: "おも.い", isCorrect: false), QuizOption(text: "かる.い", isCorrect: false)], questionType: .multipleChoice),
        // ... Tambahkan 17 pertanyaan Kanji N4 lagi ...
    ]

    static let commonPhrasesQuiz: [QuizQuestion] = [
        QuizQuestion(questionText: "'Itadakimasu' is said...", options: [QuizOption(text: "Before eating", isCorrect: true), QuizOption(text: "After eating", isCorrect: false), QuizOption(text: "When meeting someone", isCorrect: false), QuizOption(text: "When leaving", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'Moshi moshi' is used for...", options: [QuizOption(text: "Greeting a teacher", isCorrect: false), QuizOption(text: "Answering the phone", isCorrect: true), QuizOption(text: "Saying goodbye", isCorrect: false), QuizOption(text: "Shopping", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "How to say 'You're welcome'?", options: [QuizOption(text: "ありがとう", isCorrect: false), QuizOption(text: "すみません", isCorrect: false), QuizOption(text: "どういたしまして", isCorrect: true), QuizOption(text: "おやすみ", isCorrect: false)], questionType: .multipleChoice),
        // ... Tambahkan 17 pertanyaan frasa umum lagi ...
    ]

    // --- EXPERT QUIZZES (Contoh Awal) ---
    static let kanjiN3DeepDiveQuiz: [QuizQuestion] = [
        QuizQuestion(questionText: "Meaning of '受' in 受ける?", options: [QuizOption(text: "Give", isCorrect: false), QuizOption(text: "Receive/Take (exam)", isCorrect: true), QuizOption(text: "Send", isCorrect: false), QuizOption(text: "Refuse", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "On'yomi of '進' (advance)?", options: [QuizOption(text: "シン", isCorrect: true), QuizOption(text: "セン", isCorrect: false), QuizOption(text: "シュ", isCorrect: false), QuizOption(text: "キン", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Meaning of '様' (sama)?", options: [QuizOption(text: "Like, Resembling", isCorrect: false), QuizOption(text: "Mr./Ms., Manner, Appearance", isCorrect: true), QuizOption(text: "To decide", isCorrect: false), QuizOption(text: "To fight", isCorrect: false)], questionType: .multipleChoice),
        // ... Tambahkan 17 pertanyaan Kanji N3 lagi ...
    ]

    static let advancedGrammarStructuresQuiz: [QuizQuestion] = [
        QuizQuestion(questionText: "Which expresses 'must do': ～なければならない or ～てもいい?", options: [QuizOption(text: "～なければならない", isCorrect: true), QuizOption(text: "～てもいい", isCorrect: false)], questionType: .trueFalse),
        QuizQuestion(questionText: "Passive form of 食べる (taberu)?", options: [QuizOption(text: "食べさせる", isCorrect: false), QuizOption(text: "食べられる", isCorrect: true), QuizOption(text: "食べたがる", isCorrect: false), QuizOption(text: "食べない", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Causative-passive form of 書く (kaku) 'to write' (to be made to write)?", options: [QuizOption(text: "書かれる", isCorrect: false), QuizOption(text: "書かせる", isCorrect: false), QuizOption(text: "書かせられる", isCorrect: true), QuizOption(text: "書きたくない", isCorrect: false)], questionType: .multipleChoice),
        // ... Tambahkan 17 pertanyaan struktur grammar lagi ...
    ]

    static let expertVocabularyIdiomsQuiz: [QuizQuestion] = [
        QuizQuestion(questionText: "Meaning of '一期一会' (ichigo ichie)?", options: [QuizOption(text: "Once in a lifetime encounter", isCorrect: true), QuizOption(text: "Hard work pays off", isCorrect: false), QuizOption(text: "Many people, many minds", isCorrect: false), QuizOption(text: "All is fair in love and war", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "'画竜点睛を欠く' (garyou tensei wo kaku) means something is missing the...", options: [QuizOption(text: "Starting point", isCorrect: false), QuizOption(text: "Main body", isCorrect: false), QuizOption(text: "Finishing touch", isCorrect: true), QuizOption(text: "Foundation", isCorrect: false)], questionType: .multipleChoice),
        QuizQuestion(questionText: "Meaning of '棚から牡丹餅' (tana kara botamochi)?", options: [QuizOption(text: "A difficult task", isCorrect: false), QuizOption(text: "A windfall / unexpected good fortune", isCorrect: true), QuizOption(text: "A hidden danger", isCorrect: false), QuizOption(text: "A beautiful sight", isCorrect: false)], questionType: .multipleChoice),
        // ... Tambahkan 17 pertanyaan idiom & vocab expert lagi ...
    ]


    // Update Helper untuk mendapatkan pertanyaan
    static func getQuestions(forQuizTitle title: String) -> [QuizQuestion] {
        switch title {
        // Beginner
        case "Hiragana Basics Quiz": return hiraganaBasicsQuiz.shuffled()
        case "Katakana Basics Quiz": return katakanaBasicsQuiz.shuffled()
        case "Kanji N5 Starter Quiz": return kanjiN5StarterQuiz.shuffled()
        // Intermediate
        case "Intermediate Grammar Particles": return intermediateGrammarParticlesQuiz.shuffled()
        case "Kanji N4 Challenge": return kanjiN4ChallengeQuiz.shuffled()
        case "Common Phrases Quiz": return commonPhrasesQuiz.shuffled()
        // Expert
        case "Kanji N3 Deep Dive": return kanjiN3DeepDiveQuiz.shuffled()
        case "Advanced Grammar Structures": return advancedGrammarStructuresQuiz.shuffled()
        case "Expert Vocabulary & Idioms": return expertVocabularyIdiomsQuiz.shuffled()
        default:
            print("Warning: Quiz title '\(title)' not found in QuizData. Returning empty set.")
            return []
        }
    }
}
