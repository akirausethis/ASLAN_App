// AslanApp/Model/GrammarMaterial.swift
import Foundation

struct GrammarMaterial: Identifiable {
    let id = UUID()
    let courseTitle: String // Judul kursus asal, misal "Basic Particles"
    let topicTitle: String // Judul spesifik topik ini, misal "Particle は (wa)"
    let explanation: String
    let examples: [ExampleSentence]
    let tip: String? // Tips tambahan, opsional
}

struct ExampleSentence: Identifiable {
    let id = UUID()
    let japanese: String
    let romaji: String
    let english: String
}
