// AslanApp/View/Quiz/JapaneseQuizListView.swift
import SwiftUI

struct JapaneseQuizListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: UUID? = nil

    // BEGINNER QUIZZES (3 sets)
    let beginnerCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Hiragana Basics Quiz", subtitle: "Test your Hiragana A-N", iconName: "textformat.abc"),
        JapaneseCourse(title: "Katakana Basics Quiz", subtitle: "Test your Katakana A-N", iconName: "textformat.abc.dottedunderline"),
        JapaneseCourse(title: "Kanji N5 Starter Quiz", subtitle: "Common N5 Kanji recognition", iconName: "character.book.closed.fill.ja")
    ]

    // INTERMEDIATE QUIZZES (3 sets)
    let intermediateCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Intermediate Grammar Particles", subtitle: "Particles like に, で, へ, と", iconName: "list.star"),
        JapaneseCourse(title: "Kanji N4 Challenge", subtitle: "Test your N4 Kanji knowledge", iconName: "character.book.closed.fill.ja"),
        JapaneseCourse(title: "Common Phrases Quiz", subtitle: "Daily Japanese expressions", iconName: "bubble.left.and.bubble.right.fill")
    ]

    // EXPERT QUIZZES (3 sets)
    let expertCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Kanji N3 Deep Dive", subtitle: "In-depth N3 Kanji", iconName: "character.book.closed.fill.ja"),
        JapaneseCourse(title: "Advanced Grammar Structures", subtitle: "Complex sentence patterns", iconName: "puzzlepiece.extension.fill"),
        JapaneseCourse(title: "Expert Vocabulary & Idioms", subtitle: "Nuanced words and phrases", iconName: "sum")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack { // Judul
                Spacer()
                Text("Quizzes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            HStack(spacing: 10) { // Tombol Level
                Spacer()
                ForEach(FlashcardLevel.allCases) { level in
                    Button(action: {
                        selectedLevel = level
                        activeCourseId = nil
                    }) {
                        Text(level.rawValue)
                            .font(.subheadline).fontWeight(.medium)
                            .padding(.vertical, 8).padding(.horizontal, 15)
                            .background(selectedLevel == level ? Color.blue : Color.white)
                            .foregroundColor(selectedLevel == level ? .white : .blue)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    }
                }
                Spacer()
            }
            .padding(.horizontal).padding(.vertical, 5)

            ScrollView {
                VStack(spacing: 15) {
                    switch selectedLevel {
                    case .beginner:
                        if beginnerCourses.isEmpty {
                            EmptyQuizStateView(level: .beginner)
                        } else {
                            QuizCourseItemsView(courses: beginnerCourses, activeCourseId: $activeCourseId)
                        }
                    case .intermediate:
                        if intermediateCourses.isEmpty {
                            EmptyQuizStateView(level: .intermediate)
                        } else {
                            QuizCourseItemsView(courses: intermediateCourses, activeCourseId: $activeCourseId)
                        }
                    case .expert:
                        if expertCourses.isEmpty {
                            EmptyQuizStateView(level: .expert)
                        } else {
                            QuizCourseItemsView(courses: expertCourses, activeCourseId: $activeCourseId)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
    }

    private struct QuizCourseItemsView: View {
        let courses: [JapaneseCourse]
        @Binding var activeCourseId: UUID?
        var body: some View {
            ForEach(courses) { course in
                NavigationLink(
                    destination: QuizQuestionCarouselView(quizTitle: course.title),
                    tag: course.id,
                    selection: $activeCourseId
                ) {
                    JapaneseQuizCourseCardView(course: course, isSelected: activeCourseId == course.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    private struct EmptyQuizStateView: View {
        let level: FlashcardLevel
        var body: some View {
            Text("Quizzes for \(level.rawValue) are coming soon!")
                .foregroundColor(.gray).padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    NavigationView {
        JapaneseQuizListView()
    }
}
