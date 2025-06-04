import FoundationAdd commentMore actions

enum FlashcardLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case expert = "Expert"

    var id: String { self.rawValue }
}

struct ChineseCourse: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
}
