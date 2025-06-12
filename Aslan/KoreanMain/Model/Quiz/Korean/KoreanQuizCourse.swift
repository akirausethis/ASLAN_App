// AslanApp/Model/Quiz/Korean/KoreanQuizCourse.swift
import Foundation

struct KoreanQuizCourse: Identifiable {
    let id = UUID() // Tetap untuk konformitas Identifiable jika diperlukan di tempat lain
    let stringID: String // ID String yang Stabil untuk pelacakan progres
    let title: String
    let subtitle: String
    let iconName: String
    // Mungkin ada properti lain seperti jumlah pertanyaan, dll.
}
