// AslanApp/Model/Progress/CourseDataProvider.swift
import Foundation

// Definisikan struct untuk merepresentasikan detail kursus yang ada di aplikasi
// Kita akan menggunakan ini sebagai sumber utama, bukan mengambil dari instance ListView.
struct AppCourse: Identifiable {
    let id: String // ID Unik, contoh: "writing_hiragana" atau "Basic Particles_Particles 은/는 (eun/neun) - Topic Marker"
    let title: String // Judul utama kursus (misal: "Hiragana" atau "Basic Particles")
    let subtitle: String // Subtitle atau deskripsi
    let iconName: String
    let category: String // "Writing", "Flashcard", "Spelling", "Grammar", "Quiz"
    let level: FlashcardLevel
}

class CourseDataProvider {
    static let shared = CourseDataProvider()

    let allAppCourses: [AppCourse] // Ini akan berisi semua kursus dan *topik* yang dapat diselesaikan

    private init() {
        var courses: [AppCourse] = []

        // MARK: - Writing Courses
        courses.append(contentsOf: [
            AppCourse(id: "writing_basic_consonants_beginner", title: "Basic Consonants", subtitle: "Practice writing basic Korean consonants", iconName: "pencil.line", category: "Writing", level: .beginner),
            AppCourse(id: "writing_basic_vowels_beginner", title: "Basic Vowels", subtitle: "Practice writing basic Korean vowels", iconName: "pencil.line", category: "Writing", level: .beginner),
            AppCourse(id: "writing_combined_vowels_beginner", title: "Combined Vowels", subtitle: "Practice writing combined Korean vowels", iconName: "pencil.line", category: "Writing", level: .beginner),
            AppCourse(id: "writing_double_consonants_beginner", title: "Double Consonants", subtitle: "Practice writing double Korean consonants", iconName: "pencil.line", category: "Writing", level: .beginner),
            // Materi Intermediate Writing
            AppCourse(id: "writing_intermediate_syllables_intermediate", title: "Intermediate Syllables", subtitle: "Practice writing common syllables with batchim", iconName: "text.alignleft", category: "Writing", level: .intermediate),
            AppCourse(id: "writing_intermediate_words_intermediate", title: "Intermediate Words", subtitle: "Practice writing intermediate vocabulary", iconName: "character.book.closed", category: "Writing", level: .intermediate),
            AppCourse(id: "writing_basic_sentence_writing_intermediate", title: "Basic Sentence Writing", subtitle: "Practice writing simple Korean sentences", iconName: "text.insert", category: "Writing", level: .intermediate),
            // Materi Expert Writing
            AppCourse(id: "writing_advanced_words_phrases_expert", title: "Advanced Words & Phrases", subtitle: "Practice writing complex words and phrases", iconName: "text.badge.star", category: "Writing", level: .expert),
            AppCourse(id: "writing_short_paragraph_writing_expert", title: "Short Paragraph Writing", subtitle: "Practice writing short paragraphs in Korean", iconName: "doc.text.fill", category: "Writing", level: .expert),
            AppCourse(id: "writing_formal_informal_writing_expert", title: "Formal & Informal Writing", subtitle: "Understand and practice different writing styles", iconName: "person.2.fill", category: "Writing", level: .expert)
        ])

        // MARK: - Flashcard Courses (as is)
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
        
        // MARK: - Spelling Courses (as is)
        courses.append(contentsOf: [
            AppCourse(id: "spelling_hiragana_sounds_beginner", title: "Hiragana Sounds", subtitle: "Practice basic Hiragana pronunciation", iconName: "waveform.path.ecg", category: "Spelling", level: .beginner),
            AppCourse(id: "spelling_katakana_sounds_beginner", title: "Katakana Sounds", subtitle: "Practice basic Katakana pronunciation", iconName: "waveform.path.ecg", category: "Spelling", level: .beginner),
            AppCourse(id: "spelling_n5_greetings_beginner", title: "N5 Greetings", subtitle: "Basic greetings from N5 level", iconName: "hands.sparkles.fill", category: "Spelling", level: .beginner),
            AppCourse(id: "spelling_common_phrases_intermediate", title: "Common Phrases", subtitle: "Practice everyday phrases", iconName: "bubble.left.and.bubble.right.fill", category: "Spelling", level: .intermediate),
            AppCourse(id: "spelling_n4_questions_intermediate", title: "N4 Questions", subtitle: "Forming and answering N4 questions", iconName: "questionmark.bubble.fill", category: "Spelling", level: .intermediate),
            AppCourse(id: "spelling_pitch_accent_expert", title: "Pitch Accent Practice", subtitle: "Focus on correct intonation", iconName: "tuningfork", category: "Spelling", level: .expert),
            AppCourse(id: "spelling_n3_conversation_expert", title: "N3 Conversation Starters", subtitle: "Practice N3 level conversation", iconName: "figure.stand.line.dotted.figure.stand", category: "Spelling", level: .expert)
        ])
        
        // MARK: - Quiz Courses (as is)
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

        // MARK: - Grammar Topics (each topic is now a completable unit)
        for material in KoreanGrammarContentData.allMaterials {
            let topicId = "\(material.courseTitle)__\(material.topicTitle)" // Buat ID unik untuk topik
            courses.append(
                AppCourse(
                    id: topicId, // Menggunakan ID unik topik
                    title: material.courseTitle, // Judul kursus
                    subtitle: material.topicTitle, // Judul topik sebagai subtitle
                    iconName: "text.book.closed.fill", // Atau ikon spesifik jika ada
                    category: "Grammar",
                    level: .beginner // Level perlu disesuaikan berdasarkan logic di KoreanGrammarListView
                                    // Untuk sementara, kita bisa biarkan .beginner atau menyesuaikannya
                                    // Berdasarkan courseTitle yang sudah dikategorikan
                )
            )
        }
        

        // MARK: - Korean Flashcard Courses (TAMBAHKAN INI ATAU GABUNG DENGAN YANG ADA)
        courses.append(contentsOf: [
            // Beginner Korean Flashcards
            AppCourse(id: "flashcard_hangul_consonants_beginner", title: "Hangul Consonants", subtitle: "Practice basic Hangul consonants", iconName: "text.book.closed.fill", category: "Flashcard", level: .beginner),
            AppCourse(id: "flashcard_hangul_vowels_beginner", title: "Hangul Vowels", subtitle: "Practice basic Hangul vowels", iconName: "text.book.closed.fill", category: "Flashcard", level: .beginner),
            AppCourse(id: "flashcard_hangul_syllables_beginner", title: "Hangul Syllables", subtitle: "Practice common Hangul syllables", iconName: "text.book.closed.fill", category: "Flashcard", level: .beginner),
            
            // Intermediate Korean Flashcards
            AppCourse(id: "flashcard_double_consonants_intermediate", title: "Double Consonants", subtitle: "Practice double Hangul consonants", iconName: "square.stack.3d.up.fill", category: "Flashcard", level: .intermediate),
            AppCourse(id: "flashcard_combined_vowels_intermediate", title: "Combined Vowels", subtitle: "Practice combined Hangul vowels", iconName: "square.stack.3d.up.fill", category: "Flashcard", level: .intermediate),
            AppCourse(id: "flashcard_basic_words_intermediate", title: "Basic Words", subtitle: "Practice common Korean words", iconName: "square.stack.3d.up.fill", category: "Flashcard", level: .intermediate),
            
            // Expert Korean Flashcards
            AppCourse(id: "flashcard_complex_syllables_expert", title: "Complex Syllables", subtitle: "Practice complex Hangul syllables", iconName: "crown.fill", category: "Flashcard", level: .expert),
            AppCourse(id: "flashcard_advanced_words_expert", title: "Advanced Words", subtitle: "Practice advanced Korean vocabulary", iconName: "crown.fill", category: "Flashcard", level: .expert),
            AppCourse(id: "flashcard_korean_phrases_expert", title: "Korean Phrases", subtitle: "Practice common Korean phrases", iconName: "crown.fill", category: "Flashcard", level: .expert)
        ])
        
        // MARK: - Speaking Courses
                courses.append(contentsOf: [
                    AppCourse(id: "speaking_basic_conversation_beginner", title: "Basic Conversation", subtitle: "Common everyday phrases", iconName: "message.fill", category: "Speaking", level: .beginner),
                    AppCourse(id: "speaking_self_introduction_beginner", title: "Self Introduction", subtitle: "How to introduce yourself", iconName: "person.wave.2.fill", category: "Speaking", level: .beginner),
                    AppCourse(id: "speaking_at_the_restaurant_intermediate", title: "At the Restaurant", subtitle: "Ordering food and drinks", iconName: "fork.knife", category: "Speaking", level: .intermediate)
                ])
        
        // MARK: - Quiz Courses
        courses.append(contentsOf: [
            AppCourse(id: "quiz_korean_basic_vocab_beginner", title: "Basic Vocabulary Quiz", subtitle: "Test your basic Korean words", iconName: "text.book.closed.fill", category: "Quiz", level: .beginner),
            AppCourse(id: "quiz_korean_basic_particles_beginner", title: "Basic Particles Quiz", subtitle: "Test your understanding of 은/는, 이/가, etc.", iconName: "puzzlepiece.extension.fill", category: "Quiz", level: .beginner),
            // AppCourse(id: "quiz_korean_intermediate_grammar_intermediate", title: "Intermediate Grammar Quiz", subtitle: "Test intermediate grammar concepts", iconName: "list.star", category: "Quiz", level: .intermediate)
            // Tambahkan AppCourse lain untuk kuis Korea di sini jika ada
        ])
        
        // MARK: - Speaking Courses (each phrase topic is a completable unit)
        // Kita perlu menambahkan AppCourse untuk setiap topik Speaking agar terhitung dalam totalPossibleCourses
        for phraseTopic in KoreanSpeakingData.allPhrases.map({ $0.courseTitle }).removingDuplicates() {
            // Asumsi setiap courseTitle dari SpeakingPhrase unik dan merepresentasikan satu kursus/topik
            // Anda bisa menyesuaikan ID dan subtitle jika diperlukan
            let speakingCourseId = "speaking_\(phraseTopic.lowercased().replacingOccurrences(of: " ", with: "_"))"
            courses.append(
                AppCourse(
                    id: speakingCourseId,
                    title: phraseTopic,
                    subtitle: "Practice speaking phrases", // Subtitle umum
                    iconName: "speaker.wave.2.fill",
                    category: "Speaking",
                    level: .beginner // Anda perlu menentukan level untuk setiap topik Speaking
                )
            )
        }


        self.allAppCourses = courses
        print("CourseDataProvider initialized with \(self.allAppCourses.count) total app courses and topics.")
    }

    func getCourseDetail(forId id: String) -> AppCourse? {
        return allAppCourses.first { $0.id == id }
    }

    var totalPossibleCourses: Int {
        return allAppCourses.count
    }
}

// Helper untuk menghilangkan duplikat (jika Anda memiliki array string yang perlu unik)
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}
