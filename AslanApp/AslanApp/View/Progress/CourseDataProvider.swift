// AslanApp/Model/Progress/CourseDataProvider.swift
import Foundation

// Definisikan struct untuk merepresentasikan detail kursus yang ada di aplikasi
// Kita akan menggunakan ini sebagai sumber utama, bukan mengambil dari instance ListView.
struct AppCourse: Identifiable {
    let id: String // ID Unik, contoh: "writing_hiragana_beginner"
    let title: String
    let subtitle: String
    let iconName: String
    let category: String // "Writing", "Flashcard", "Spelling", "Grammar", "Quiz"
    let level: FlashcardLevel
}

class CourseDataProvider {
    static let shared = CourseDataProvider()

    let allAppCourses: [AppCourse]

    private init() {
        var courses: [AppCourse] = []

        // MARK: - Writing Courses
        courses.append(contentsOf: [
            AppCourse(id: "writing_hiragana_beginner", title: "Hiragana", subtitle: "Practice Hiragana Writing", iconName: "pencil.and.scribble", category: "Writing", level: .beginner),
            AppCourse(id: "writing_katakana_beginner", title: "Katakana", subtitle: "Practice Katakana Writing", iconName: "pencil.and.scribble", category: "Writing", level: .beginner),
            AppCourse(id: "writing_kanji_n5_beginner", title: "Kanji N5 - Writing", subtitle: "Practice JLPT N5 Kanji", iconName: "character.ja", category: "Writing", level: .beginner),
            AppCourse(id: "writing_kanji_n4_intermediate", title: "Kanji N4 - Writing", subtitle: "Practice JLPT N4 Kanji", iconName: "character.ja", category: "Writing", level: .intermediate),
            AppCourse(id: "writing_kanji_n3_intermediate", title: "Kanji N3 - Writing", subtitle: "Practice JLPT N3 Kanji", iconName: "character.ja", category: "Writing", level: .intermediate),
            AppCourse(id: "writing_intermediate_vocab_kana_intermediate", title: "Intermediate Vocab & Kana - Writing", subtitle: "Practice Vocab & Kana", iconName: "text.badge.plus", category: "Writing", level: .intermediate),
            AppCourse(id: "writing_kanji_n2_expert", title: "Kanji N2 - Writing", subtitle: "Practice JLPT N2 Kanji", iconName: "character.ja", category: "Writing", level: .expert),
            AppCourse(id: "writing_kanji_n1_expert", title: "Kanji N1 - Writing", subtitle: "Practice JLPT N1 Kanji", iconName: "character.ja", category: "Writing", level: .expert),
            AppCourse(id: "writing_expert_vocab_kana_expert", title: "Expert Vocab & Kana - Writing", subtitle: "Practice Advanced Vocab & Kana", iconName: "text.badge.star", category: "Writing", level: .expert)
        ])

        // MARK: - Flashcard Courses
        courses.append(contentsOf: [
            AppCourse(id: "flashcard_hiragana_beginner", title: "Hiragana", subtitle: "All Hiragana Characters", iconName: "text.book.closed.fill", category: "Flashcard", level: .beginner),
            AppCourse(id: "flashcard_katakana_beginner", title: "Katakana", subtitle: "All Katakana Characters", iconName: "text.book.closed.fill", category: "Flashcard", level: .beginner),
            AppCourse(id: "flashcard_kanji_n5_beginner", title: "Kanji N5", subtitle: "JLPT N5 Kanji", iconName: "character.book.closed.fill.ja", category: "Flashcard", level: .beginner),
            AppCourse(id: "flashcard_kanji_n4_intermediate", title: "Kanji N4", subtitle: "JLPT N4 Kanji", iconName: "character.book.closed.fill.ja", category: "Flashcard", level: .intermediate),
            AppCourse(id: "flashcard_kanji_n3_intermediate", title: "Kanji N3", subtitle: "JLPT N3 Kanji", iconName: "character.book.closed.fill.ja", category: "Flashcard", level: .intermediate),
            AppCourse(id: "flashcard_intermediate_vocab_kana_intermediate", title: "Intermediate Vocab & Kana", subtitle: "Yōon, Complex Kana, Vocab", iconName: "square.stack.3d.up.fill", category: "Flashcard", level: .intermediate),
            AppCourse(id: "flashcard_kanji_n2_expert", title: "Kanji N2", subtitle: "JLPT N2 Kanji", iconName: "character.book.closed.fill.ja", category: "Flashcard", level: .expert),
            AppCourse(id: "flashcard_kanji_n1_expert", title: "Kanji N1", subtitle: "JLPT N1 Kanji", iconName: "character.book.closed.fill.ja", category: "Flashcard", level: .expert),
            AppCourse(id: "flashcard_expert_vocab_kana_expert", title: "Expert Vocab & Kana", subtitle: "Advanced Katakana & Vocab", iconName: "crown.fill", category: "Flashcard", level: .expert)
        ])
        
        // MARK: - Spelling Courses
        courses.append(contentsOf: [
            AppCourse(id: "spelling_hiragana_sounds_beginner", title: "Hiragana Sounds", subtitle: "Practice basic Hiragana pronunciation", iconName: "waveform.path.ecg", category: "Spelling", level: .beginner),
            AppCourse(id: "spelling_katakana_sounds_beginner", title: "Katakana Sounds", subtitle: "Practice basic Katakana pronunciation", iconName: "waveform.path.ecg", category: "Spelling", level: .beginner),
            AppCourse(id: "spelling_n5_greetings_beginner", title: "N5 Greetings", subtitle: "Basic greetings from N5 level", iconName: "hands.sparkles.fill", category: "Spelling", level: .beginner),
            AppCourse(id: "spelling_common_phrases_intermediate", title: "Common Phrases", subtitle: "Practice everyday phrases", iconName: "bubble.left.and.bubble.right.fill", category: "Spelling", level: .intermediate),
            AppCourse(id: "spelling_n4_questions_intermediate", title: "N4 Questions", subtitle: "Forming and answering N4 questions", iconName: "questionmark.bubble.fill", category: "Spelling", level: .intermediate),
            AppCourse(id: "spelling_pitch_accent_expert", title: "Pitch Accent Practice", subtitle: "Focus on correct intonation", iconName: "tuningfork", category: "Spelling", level: .expert),
            AppCourse(id: "spelling_n3_conversation_expert", title: "N3 Conversation Starters", subtitle: "Practice N3 level conversation", iconName: "figure.stand.line.dotted.figure.stand", category: "Spelling", level: .expert)
        ])
        
        // MARK: - Grammar Courses
        courses.append(contentsOf: [
            AppCourse(id: "grammar_basic_particles_beginner", title: "Basic Particles", subtitle: "Understanding は, が, を", iconName: "puzzlepiece.extension.fill", category: "Grammar", level: .beginner),
            AppCourse(id: "grammar_verb_conjugation_beginner", title: "Verb Conjugation", subtitle: "Present Tense - ます Form", iconName: "function", category: "Grammar", level: .beginner),
            AppCourse(id: "grammar_sentence_structure_beginner", title: "Sentence Structure", subtitle: "Subject-Object-Verb", iconName: "list.bullet.indent", category: "Grammar", level: .beginner),
            AppCourse(id: "grammar_te_form_intermediate", title: "Te-Form", subtitle: "Joining clauses, requests", iconName: "link.circle.fill", category: "Grammar", level: .intermediate),
            AppCourse(id: "grammar_potential_form_intermediate", title: "Potential Form", subtitle: "Expressing ability (can do)", iconName: "figure.walk.motion", category: "Grammar", level: .intermediate),
            AppCourse(id: "grammar_giving_receiving_intermediate", title: "Giving & Receiving", subtitle: "Verbs like あげる, くれる, もらう", iconName: "gift.fill", category: "Grammar", level: .intermediate),
            AppCourse(id: "grammar_passive_voice_expert", title: "Passive Voice", subtitle: "Expressingられる, される", iconName: "person.badge.shield.checkmark.fill", category: "Grammar", level: .expert),
            AppCourse(id: "grammar_causative_form_expert", title: "Causative Form", subtitle: "Making someone do (させる)", iconName: "figure.stand.line.dotted.figure.stand", category: "Grammar", level: .expert),
            AppCourse(id: "grammar_conditional_forms_expert", title: "Conditional Forms", subtitle: "たら, ば, と, なら", iconName: "arrow.triangle.branch", category: "Grammar", level: .expert)
        ])
        
        // MARK: - Quiz Courses
        courses.append(contentsOf: [
            AppCourse(id: "quiz_hiragana_basics_quiz_beginner", title: "Hiragana Basics Quiz", subtitle: "Test your Hiragana A-N", iconName: "textformat.abc", category: "Quiz", level: .beginner),
            AppCourse(id: "quiz_katakana_basics_quiz_beginner", title: "Katakana Basics Quiz", subtitle: "Test your Katakana A-N", iconName: "textformat.abc.dottedunderline", category: "Quiz", level: .beginner),
            AppCourse(id: "quiz_kanji_n5_starter_quiz_beginner", title: "Kanji N5 Starter Quiz", subtitle: "Common N5 Kanji recognition", iconName: "character.book.closed.fill.ja", category: "Quiz", level: .beginner),
            AppCourse(id: "quiz_intermediate_grammar_particles_intermediate", title: "Intermediate Grammar Particles", subtitle: "Particles like に, で, へ, と", iconName: "list.star", category: "Quiz", level: .intermediate),
            AppCourse(id: "quiz_kanji_n4_challenge_intermediate", title: "Kanji N4 Challenge", subtitle: "Test your N4 Kanji knowledge", iconName: "character.book.closed.fill.ja", category: "Quiz", level: .intermediate),
            AppCourse(id: "quiz_common_phrases_quiz_intermediate", title: "Common Phrases Quiz", subtitle: "Daily Japanese expressions", iconName: "bubble.left.and.bubble.right.fill", category: "Quiz", level: .intermediate),
            AppCourse(id: "quiz_kanji_n3_deep_dive_expert", title: "Kanji N3 Deep Dive", subtitle: "In-depth N3 Kanji", iconName: "character.book.closed.fill.ja", category: "Quiz", level: .expert),
            AppCourse(id: "quiz_advanced_grammar_structures_expert", title: "Advanced Grammar Structures", subtitle: "Complex sentence patterns", iconName: "puzzlepiece.extension.fill", category: "Quiz", level: .expert),
            AppCourse(id: "quiz_expert_vocabulary_idioms_expert", title: "Expert Vocabulary & Idioms", subtitle: "Nuanced words and phrases", iconName: "sum", category: "Quiz", level: .expert)
        ])

        self.allAppCourses = courses
        print("CourseDataProvider initialized with \(self.allAppCourses.count) total app courses.")
    }

    func getCourseDetail(forId id: String) -> AppCourse? {
        return allAppCourses.first { $0.id == id }
    }

    var totalPossibleCourses: Int {
        return allAppCourses.count
    }
}
