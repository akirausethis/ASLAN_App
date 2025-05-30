import Foundation

protocol JapaneseCharacterCard: Identifiable {
    var id: UUID { get }
    var character: String { get }
    var romaji: String { get }
}
