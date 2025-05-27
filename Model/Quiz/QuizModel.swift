import Foundation

// Pilihan Jawaban untuk Soal Kuis
struct QuizOption: Identifiable, Hashable { // Tambahkan Hashable jika akan digunakan di ForEach tanpa id eksplisit
    let id = UUID()
    let text: String
    var isCorrect: Bool
}

// Model untuk Satu Soal Kuis
struct QuizQuestion: Identifiable {
    let id = UUID()
    let questionText: String
    let options: [QuizOption]
    let questionType: QuestionType // Misal: Pilihan Ganda, Benar/Salah, Isi Bagian Kosong
    // Mungkin ada field lain seperti 'hint', 'explanationAfterAnswer', dll.
}

enum QuestionType {
    case multipleChoice
    case trueFalse
    // Tambahkan tipe lain jika perlu
}

// Model untuk Satu Set Kuis (yang akan ditampilkan di CourseCard)
// Kita bisa menggunakan kembali struct JapaneseCourse yang sudah ada jika field-nya cukup.
// JapaneseCourse(title: "Hiragana Quiz 1", subtitle: "Test your Hiragana knowledge", iconName: "...")
// Jika butuh field spesifik untuk kuis, buat struct baru:
/*
struct QuizSet: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
    let level: FlashcardLevel //
    let questions: [QuizQuestion] // Kumpulan pertanyaan untuk set kuis ini
}
*/
// Untuk saat ini, kita akan menggunakan JapaneseCourse dan menyimpan pertanyaan secara terpisah,
// dihubungkan dengan judul kursus.
