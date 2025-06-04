// AslanApp/View/Grammar/Korean/KoreanGrammarListView.swift
import SwiftUI

struct KoreanGrammarListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: UUID? = nil

    // Judul kursus DIUBAH agar sesuai dengan KoreanGrammarContentData.swift
    let beginnerGrammarCourses: [KoreanCourse] = [
        KoreanCourse(title: "Partikel Dasar", subtitle: "Understanding 은/는, 이/가, 을/를", iconName: "puzzlepiece.extension.fill"),
        KoreanCourse(title: "Konjugasi Dasar", subtitle: "Present Tense - ㅂ니다/습니다", iconName: "function"),
        KoreanCourse(title: "Struktur Kalimat", subtitle: "Subject-Object-Verb", iconName: "list.bullet.indent")
    ]

    let intermediateGrammarCourses: [KoreanCourse] = []
    let expertGrammarCourses: [KoreanCourse] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Text("Korean Grammar")
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
                VStack(spacing: 15) {
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
                                    KoreanGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    case .intermediate:
                        Text("Intermediate Korean grammar courses are coming soon!")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                    case .expert:
                         Text("Expert Korean grammar courses are coming soon!")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
    }

    @ViewBuilder
    private func destinationView(for course: KoreanCourse) -> some View {
        KoreanGrammarTopicsForCourseView(course: course)
    }
}

#Preview {
    NavigationView {
        KoreanGrammarListView()
    }
}
