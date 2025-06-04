// AslanApp/Model/Quiz/KoreanQuizCourse.swift
import Foundation

struct KoreanQuizCourse: Identifiable {
    let id = UUID()
    let title: String // Contoh: "Basic Vocabulary Quiz"
    let subtitle: String
    let iconName: String // Contoh: "questionmark.circle.fill"
    // Mungkin ada properti lain seperti jumlah pertanyaan, dll.
}
