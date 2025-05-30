import Foundation

enum FlashcardLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case expert = "Expert"

    var id: String { self.rawValue }
}

struct JapaneseCourse: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
}
