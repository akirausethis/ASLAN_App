// AslanApp/Model/ProgressModels.swift
import Foundation

struct CompletedCourseDisplayItem: Identifiable, Hashable { // Tambahkan Hashable
    let id: String // ID unik kursus (misal: "writing_hiragana")
    let title: String
    let category: String // Misal: "Writing", "Flashcard", "Quiz", "Spelling", "Grammar"
    let iconName: String
    let completionDate: Date? // Opsional, bisa ditambahkan nanti jika ingin melacak tanggal
}
