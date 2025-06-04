import FoundationAdd commentMore actions

protocol ChineseCharacterCard: Identifiable {
    var id: UUID { get }
    var character: String { get }
    var pinyin: String { get }
}
