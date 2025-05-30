// AslanApp/View/Grammar/JapaneseGrammarListView.swift
import SwiftUI

struct JapaneseGrammarListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: UUID? = nil

    let beginnerGrammarCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Basic Particles", subtitle: "Understanding は, が, を", iconName: "puzzlepiece.extension.fill"),
        JapaneseCourse(title: "Verb Conjugation", subtitle: "Present Tense - ます Form", iconName: "function"),
        JapaneseCourse(title: "Sentence Structure", subtitle: "Subject-Object-Verb", iconName: "list.bullet.indent")
    ]

    let intermediateGrammarCourses: [JapaneseCourse] = []
    let expertGrammarCourses: [JapaneseCourse] = []

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
            .padding(.vertical, 10)
            .background(Color(UIColor.systemBackground))

            ScrollView {
                // MENYESUAIKAN VStack INI
                VStack(spacing: 15) { // <-- SPACING DISAMAKAN MENJADI 15
                    // (Switch case untuk level tetap sama)
                    switch selectedLevel {
                    case .beginner:
                        if beginnerGrammarCourses.isEmpty {
                            Text("No beginner courses available yet.")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(beginnerGrammarCourses) { course in
                                NavigationLink(
                                    destination: destinationView(for: course),
                                    tag: course.id,
                                    selection: $activeCourseId
                                ) {
                                    // JapaneseGrammarCourseCardView sudah memiliki .padding(.horizontal) sendiri,
                                    // jadi VStack ini tidak perlu .padding(.horizontal) tambahan
                                    // kecuali jika ingin menambah Jarak ekstra lagi.
                                    JapaneseGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    case .intermediate:
                        if intermediateGrammarCourses.isEmpty {
                            Text("Courses for \(selectedLevel.rawValue) are coming soon!")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(intermediateGrammarCourses) { course in
                                NavigationLink(
                                    destination: destinationView(for: course),
                                    tag: course.id,
                                    selection: $activeCourseId
                                ) {
                                    JapaneseGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    case .expert:
                        if expertGrammarCourses.isEmpty {
                            Text("Courses for \(selectedLevel.rawValue) are coming soon!")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(expertGrammarCourses) { course in
                                NavigationLink(
                                    destination: destinationView(for: course),
                                    tag: course.id,
                                    selection: $activeCourseId
                                ) {
                                    JapaneseGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                // .padding() // Padding keseluruhan untuk VStack dalam ScrollView (jika perlu)
                // atau .padding(.vertical) atau .padding(.bottom, 20) seperti di JapaneseWritingListView
                .padding(.bottom, 20) // Menyamakan dengan JapaneseWritingListView
                // Jika JapaneseGrammarCourseCardView sudah punya .padding(.horizontal),
                // maka VStack ini tidak perlu .padding(.horizontal) lagi, atau akan jadi dobel.
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
    }

    @ViewBuilder
    private func destinationView(for course: JapaneseCourse) -> some View {
        GrammarTopicsForCourseView(course: course)
    }
}

#Preview {
    NavigationView {
        JapaneseGrammarListView()
    }
}
