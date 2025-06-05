// AslanApp/Model/Quiz/KoreanQuizQuestion.swift
import Foundation

struct KoreanQuizQuestion: Identifiable {
    let id = UUID()
    let courseTitle: String // Judul kursus kuis asal, misal "Basic Vocabulary Quiz"
    let questionText: String // Teks pertanyaan, misal "What is 'apple' in Korean?"
    let options: [QuizOption] // Pilihan jawaban
    let correctAnswerId: UUID // ID dari QuizOption yang benar

    // Properti tambahan jika diperlukan, misal:
    // let explanation: String? // Penjelasan untuk jawaban yang benar (opsional)
    // let difficulty: QuizDifficulty // Enum untuk tingkat kesulitan (opsional)
}

struct QuizOption: Identifiable {
    let id = UUID()
    let text: String // Teks pilihan jawaban, misal "사과"
}

// enum QuizDifficulty: String, CaseIterable {
//     case easy, medium, hard
// }
