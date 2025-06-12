import Foundation

enum FlashcardLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case expert = "Expert"

    var id: String { self.rawValue }
}

struct KoreanCourse: Identifiable {
    // Ubah id menjadi String, dan kita akan menetapkannya secara manual untuk cocok dengan AppCourse.id
    let id: String
    let title: String
    let subtitle: String
    let iconName: String
    let category: String
    let level: FlashcardLevel

    // Tambahkan initializer eksplisit
    init(id: String, title: String, subtitle: String, iconName: String, category: String, level: FlashcardLevel) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.category = category
        self.level = level
    }
}
