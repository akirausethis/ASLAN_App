// AslanApp/View/Grammar/JapaneseGrammarListView.swift
import SwiftUI

struct JapaneseGrammarListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner //
    @State private var activeCourseId: UUID? = nil

    let beginnerGrammarCourses: [JapaneseCourse] = [ //
        JapaneseCourse(title: "Basic Particles", subtitle: "Understanding は, が, を", iconName: "puzzlepiece.extension.fill"),
        JapaneseCourse(title: "Verb Conjugation", subtitle: "Present Tense - ます Form", iconName: "function"),
        JapaneseCourse(title: "Sentence Structure", subtitle: "Subject-Object-Verb", iconName: "list.bullet.indent")
    ]

    let intermediateGrammarCourses: [JapaneseCourse] = [ //
        JapaneseCourse(title: "Te-Form", subtitle: "Joining clauses, requests", iconName: "link.circle.fill"),
        JapaneseCourse(title: "Potential Form", subtitle: "Expressing ability (can do)", iconName: "figure.walk.motion"),
        JapaneseCourse(title: "Giving & Receiving", subtitle: "Verbs like あげる, くれる, もらう", iconName: "gift.fill")
    ]

    let expertGrammarCourses: [JapaneseCourse] = [ //
        JapaneseCourse(title: "Passive Voice", subtitle: "Expressingられる, される", iconName: "person.badge.shield.checkmark.fill"),
        JapaneseCourse(title: "Causative Form", subtitle: "Making someone do (させる)", iconName: "figure.stand.line.dotted.figure.stand"),
        JapaneseCourse(title: "Conditional Forms", subtitle: "たら, ば, と, なら", iconName: "arrow.triangle.branch")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Text("Grammar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 5)
            .background(Color(UIColor.systemBackground))

            HStack(spacing: 10) {
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
            .padding(.vertical, 10)
            .background(Color(UIColor.systemBackground))

            ScrollView {
                VStack(spacing: 15) { // Spacing antar kartu kursus
                    
                    // PERBAIKAN BAGIAN INI:
                    // Switch statement sekarang langsung menghasilkan View
                    switch selectedLevel {
                    case .beginner:
                        if beginnerGrammarCourses.isEmpty {
                            EmptyStateView(level: .beginner)
                        } else {
                            CourseListView(courses: beginnerGrammarCourses, activeCourseId: $activeCourseId)
                        }
                    case .intermediate:
                        if intermediateGrammarCourses.isEmpty {
                            EmptyStateView(level: .intermediate)
                        } else {
                            CourseListView(courses: intermediateGrammarCourses, activeCourseId: $activeCourseId)
                        }
                    case .expert:
                        if expertGrammarCourses.isEmpty {
                            EmptyStateView(level: .expert)
                        } else {
                            CourseListView(courses: expertGrammarCourses, activeCourseId: $activeCourseId)
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

    // Helper view untuk menampilkan daftar kursus
    // Ini membantu menjaga `body` tetap bersih
    private struct CourseListView: View {
        let courses: [JapaneseCourse] //
        @Binding var activeCourseId: UUID?

        var body: some View {
            ForEach(courses) { course in
                NavigationLink(
                    destination: GrammarTopicsForCourseView(course: course),
                    tag: course.id,
                    selection: $activeCourseId
                ) {
                    JapaneseGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    // Helper view untuk pesan "coming soon"
    private struct EmptyStateView: View {
        let level: FlashcardLevel //

        var body: some View {
            Text(level == .beginner && JapaneseGrammarListView().beginnerGrammarCourses.isEmpty ? "No beginner courses available yet." : "Courses for \(level.rawValue) are coming soon!")
                .foregroundColor(.gray)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    NavigationView {
        JapaneseGrammarListView()
    }
}
