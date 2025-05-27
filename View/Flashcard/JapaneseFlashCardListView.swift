// AslanApp/View/Flashcard/JapaneseFlashCardListView.swift
import SwiftUI

struct JapaneseFlashCardListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: UUID? = nil

    // Mendefinisikan kursus untuk setiap level secara terpisah
    let beginnerCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Hiragana", subtitle: "All Hiragana Characters", iconName: "text.book.closed.fill"),
        JapaneseCourse(title: "Katakana", subtitle: "All Katakana Characters", iconName: "text.book.closed.fill"),
        JapaneseCourse(title: "Kanji N5", subtitle: "JLPT N5 Kanji", iconName: "character.book.closed.fill.ja")
    ]

    let intermediateCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Kanji N4", subtitle: "JLPT N4 Kanji", iconName: "character.book.closed.fill.ja"),
        JapaneseCourse(title: "Kanji N3", subtitle: "JLPT N3 Kanji", iconName: "character.book.closed.fill.ja"),
        JapaneseCourse(title: "Intermediate Vocab & Kana", subtitle: "Yōon, Complex Kana, Vocab", iconName: "square.stack.3d.up.fill")
    ]

    let expertCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Kanji N2", subtitle: "JLPT N2 Kanji", iconName: "character.book.closed.fill.ja"),
        JapaneseCourse(title: "Kanji N1", subtitle: "JLPT N1 Kanji", iconName: "character.book.closed.fill.ja"),
        JapaneseCourse(title: "Expert Vocab & Kana", subtitle: "Advanced Katakana & Vocab", iconName: "crown.fill")
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // ... (Header dan Tombol Level tetap sama) ...
                HStack {
                    Spacer()
                    Text("Flashcard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                HStack(spacing: 10) {
                    Spacer()
                    ForEach(FlashcardLevel.allCases) { level in
                        Button(action: {
                            selectedLevel = level
                            activeCourseId = nil
                        }) {
                            Text(level.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background(selectedLevel == level ? Color.blue : Color.white)
                                .foregroundColor(selectedLevel == level ? .white : .blue)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 5)


                ScrollView {
                    VStack(spacing: 15) {
                        switch selectedLevel {
                        case .beginner:
                            if beginnerCourses.isEmpty {
                                EmptyFlashcardStateView(level: .beginner, courseCount: beginnerCourses.count)
                            } else {
                                ForEach(beginnerCourses) { course in
                                    NavigationLink(
                                        destination: destinationViewForFlashcard(course: course),
                                        tag: course.id,
                                        selection: $activeCourseId
                                    ) {
                                        JapaneseFlashCardView(course: course, isSelected: activeCourseId == course.id)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        case .intermediate:
                            if intermediateCourses.isEmpty {
                                EmptyFlashcardStateView(level: .intermediate, courseCount: intermediateCourses.count)
                            } else {
                                ForEach(intermediateCourses) { course in
                                    NavigationLink(
                                        destination: destinationViewForFlashcard(course: course),
                                        tag: course.id,
                                        selection: $activeCourseId
                                    ) {
                                        JapaneseFlashCardView(course: course, isSelected: activeCourseId == course.id)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        case .expert:
                            if expertCourses.isEmpty {
                                EmptyFlashcardStateView(level: .expert, courseCount: expertCourses.count)
                            } else {
                                ForEach(expertCourses) { course in
                                    NavigationLink(
                                        destination: destinationViewForFlashcard(course: course),
                                        tag: course.id,
                                        selection: $activeCourseId
                                    ) {
                                        JapaneseFlashCardView(course: course, isSelected: activeCourseId == course.id)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemBackground))
            }
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    private struct EmptyFlashcardStateView: View {
        let level: FlashcardLevel
        let courseCount: Int
        var body: some View {
            let message = courseCount == 0 ? "Flashcards for \(level.rawValue) are coming soon!" : "No \(level.rawValue.lowercased()) flashcards available."
            Text(message)
                .foregroundColor(.gray)
                .padding()
        }
    }
    
    @ViewBuilder
    private func destinationViewForFlashcard(course: JapaneseCourse) -> some View {
        let title = course.title
        
        switch title {
        case "Hiragana":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.hiraganaCharacters.shuffled(), title: title)
        case "Katakana":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.katakanaCharacters.shuffled(), title: title)
        case "Kanji N5":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.kanjiN5.shuffled(), title: title)
        case "Kanji N4":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.kanjiN4.shuffled(), title: title)
        case "Kanji N3":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.kanjiN3.shuffled(), title: title)
        case "Kanji N2":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.kanjiN2.shuffled(), title: title)
        case "Kanji N1":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.kanjiN1.shuffled(), title: title)
        case "Intermediate Vocab & Kana":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.intermediateVocabAndKana.shuffled(), title: title)
        case "Expert Vocab & Kana":
            GeneralFlashcardCarouselView(availableFlashcards: JapaneseCharacterData.expertVocabAndKana.shuffled(), title: title)
        default:
            Text("Flashcard set for '\(title)' not found.")
        }
    }
}

#Preview {
    JapaneseFlashCardListView()
}
