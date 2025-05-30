import Foundation

struct KoreanQuizData {

    static let allQuizQuestions: [KoreanQuizQuestion] = {
        var questions: [KoreanQuizQuestion] = []

        // --- Pertanyaan untuk "Basic Vocabulary Quiz" ---
        let vocabOptions1 = [
            QuizOption(text: "물 (mul)"),
            QuizOption(text: "사과 (sagwa)"), // Jawaban benar
            QuizOption(text: "빵 (ppang)"),
            QuizOption(text: "집 (jip)")
        ]
        questions.append(
            KoreanQuizQuestion(
                courseTitle: "Basic Vocabulary Quiz",
                questionText: "What is 'apple' in Korean?",
                options: vocabOptions1,
                // Ambil ID dari opsi yang benar SETELAH opsi didefinisikan
                correctAnswerId: vocabOptions1.first(where: { $0.text == "사과 (sagwa)" })!.id
            )
        )

        let vocabOptions2 = [
            QuizOption(text: "학교 (hakgyo)"),
            QuizOption(text: "친구 (chingu)"),
            QuizOption(text: "물 (mul)"), // Jawaban benar
            QuizOption(text: "사랑 (sarang)")
        ]
        questions.append(
            KoreanQuizQuestion(
                courseTitle: "Basic Vocabulary Quiz",
                questionText: "Which of these means 'water'?",
                options: vocabOptions2,
                correctAnswerId: vocabOptions2.first(where: { $0.text == "물 (mul)" })!.id
            )
        )

        let vocabOptions3 = [
            QuizOption(text: "Goodbye"),
            QuizOption(text: "Thank you"),
            QuizOption(text: "Hello / Hi"), // Jawaban benar
            QuizOption(text: "Sorry")
        ]
        questions.append(
            KoreanQuizQuestion(
                courseTitle: "Basic Vocabulary Quiz",
                questionText: "Translate '안녕하세요 (annyeonghaseyo)' to English.",
                options: vocabOptions3,
                correctAnswerId: vocabOptions3.first(where: { $0.text == "Hello / Hi" })!.id
            )
        )

        // --- Pertanyaan untuk "Basic Particles Quiz" ---
        let particleOptions1 = [
            QuizOption(text: "은 (eun)"),
            QuizOption(text: "이 (i)"),
            QuizOption(text: "는 (neun)"), // Jawaban benar
            QuizOption(text: "가 (ga)")
        ]
        questions.append(
            KoreanQuizQuestion(
                courseTitle: "Basic Particles Quiz",
                questionText: "Which particle is the topic marker used after a vowel-ending noun?",
                options: particleOptions1,
                correctAnswerId: particleOptions1.first(where: { $0.text == "는 (neun)" })!.id
            )
        )

        let particleOptions2 = [
            QuizOption(text: "Subject marker"),
            QuizOption(text: "Object marker"), // Jawaban benar
            QuizOption(text: "Topic marker"),
            QuizOption(text: "Location marker")
        ]
        questions.append(
            KoreanQuizQuestion(
                courseTitle: "Basic Particles Quiz",
                questionText: "In '책을 읽어요 (chaeg-eul ilg-eoyo - I read a book)', what is the function of '을 (eul)'?",
                options: particleOptions2,
                correctAnswerId: particleOptions2.first(where: { $0.text == "Object marker" })!.id
            )
        )
        // Tambahkan lebih banyak pertanyaan kuis di sini dengan pola yang sama

        return questions
    }() // Gunakan computed property yang dieksekusi sekali

    // Helper function untuk mendapatkan pertanyaan untuk kursus kuis tertentu
    static func questions(forCourseTitle title: String) -> [KoreanQuizQuestion] {
        return allQuizQuestions.filter { $0.courseTitle == title }
    }
}
