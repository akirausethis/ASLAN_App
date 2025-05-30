// AslanApp/View/Grammar/KoreanGrammarListView.swift
import SwiftUI

struct KoreanGrammarListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner // FlashcardLevel bisa dipakai ulang
    @State private var activeCourseId: UUID? = nil

    // Contoh kursus grammar untuk Bahasa Korea
    let beginnerGrammarCourses: [KoreanCourse] = [
        KoreanCourse(title: "Basic Particles", subtitle: "Understanding 은/는, 이/가, 을/를", iconName: "puzzlepiece.extension.fill"),
        KoreanCourse(title: "Verb Conjugation", subtitle: "Present Tense - ㅂ니다/습니다", iconName: "function"),
        KoreanCourse(title: "Sentence Structure", subtitle: "Subject-Object-Verb", iconName: "list.bullet.indent")
    ]

    let intermediateGrammarCourses: [KoreanCourse] = [] // Isi nanti
    let expertGrammarCourses: [KoreanCourse] = []     // Isi nanti

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Text("Korean Grammar") // Judul diubah
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 5)
            .background(Color(UIColor.systemBackground))

            HStack(spacing: 10) { // Tombol Level
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
                                    destination: destinationView(for: course), // Arahkan ke KoreanGrammarTopicsForCourseView
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
                        // Implementasi untuk intermediate
                    case .expert:
                         Text("Expert Korean grammar courses are coming soon!")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        // Implementasi untuk expert
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
        // .navigationBarHidden(true) // Tergantung bagaimana Anda mengintegrasikannya
    }

    @ViewBuilder
    private func destinationView(for course: KoreanCourse) -> some View {
        KoreanGrammarTopicsForCourseView(course: course) // Menggunakan KoreanGrammarTopicsForCourseView
    }
}

#Preview {
    NavigationView { // Bungkus dengan NavigationView untuk preview
        KoreanGrammarListView()
    }
}
