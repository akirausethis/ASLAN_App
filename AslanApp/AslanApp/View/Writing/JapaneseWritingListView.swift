// AslanApp/View/Writing/JapaneseWritingListView.swift
import SwiftUI

struct JapaneseWritingListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner //
    @State private var activeCourseId: UUID? = nil

    // Pastikan nama ikon (iconName) adalah SF Symbols yang valid
    let beginnerCourses: [JapaneseCourse] = [ //
        JapaneseCourse(title: "Hiragana", subtitle: "Practice Hiragana Writing", iconName: "pencil.and.scribble"),
        JapaneseCourse(title: "Katakana", subtitle: "Practice Katakana Writing", iconName: "pencil.and.scribble"),
        JapaneseCourse(title: "Kanji N5 - Writing", subtitle: "Practice JLPT N5 Kanji", iconName: "character.ja")
    ]

    let intermediateCourses: [JapaneseCourse] = [ //
        JapaneseCourse(title: "Kanji N4 - Writing", subtitle: "Practice JLPT N4 Kanji", iconName: "character.ja"),
        JapaneseCourse(title: "Kanji N3 - Writing", subtitle: "Practice JLPT N3 Kanji", iconName: "character.ja"),
        JapaneseCourse(title: "Intermediate Vocab & Kana - Writing", subtitle: "Practice Vocab & Kana", iconName: "text.badge.plus")
    ]

    let expertCourses: [JapaneseCourse] = [ //
        JapaneseCourse(title: "Kanji N2 - Writing", subtitle: "Practice JLPT N2 Kanji", iconName: "character.ja"),
        JapaneseCourse(title: "Kanji N1 - Writing", subtitle: "Practice JLPT N1 Kanji", iconName: "character.ja"),
        JapaneseCourse(title: "Expert Vocab & Kana - Writing", subtitle: "Practice Advanced Vocab & Kana", iconName: "text.badge.star")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack { // Judul "Writing"
                Spacer()
                Text("Writing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            HStack(spacing: 10) { // Tombol Level
                Spacer()
                ForEach(FlashcardLevel.allCases) { level in //
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
                            EmptyStateWritingView(level: .beginner)
                        } else {
                            CourseItemsWritingView(courses: beginnerCourses, activeCourseId: $activeCourseId)
                        }
                    case .intermediate:
                        if intermediateCourses.isEmpty {
                            EmptyStateWritingView(level: .intermediate)
                        } else {
                            CourseItemsWritingView(courses: intermediateCourses, activeCourseId: $activeCourseId)
                        }
                    case .expert:
                        if expertCourses.isEmpty {
                            EmptyStateWritingView(level: .expert)
                        } else {
                            CourseItemsWritingView(courses: expertCourses, activeCourseId: $activeCourseId)
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

    private struct CourseItemsWritingView: View {
        let courses: [JapaneseCourse] //
        @Binding var activeCourseId: UUID?
        var body: some View {
            ForEach(courses) { course in
                NavigationLink(
                    destination: JapaneseWritingCarouselView(practiceType: course.title), //
                    tag: course.id,
                    selection: $activeCourseId
                ) {
                    JapaneseWritingView(course: course, isSelected: activeCourseId == course.id) //
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private struct EmptyStateWritingView: View {
        let level: FlashcardLevel //
        var body: some View {
            Text("Writing exercises for \(level.rawValue) are coming soon!")
                .foregroundColor(.gray)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    NavigationView {
        JapaneseWritingListView()
    }
    .environmentObject(ProgressViewModel()) //
}
