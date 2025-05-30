// AslanApp/View/Quiz/KoreanQuizListView.swift
import SwiftUI

struct KoreanQuizListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner // Dapat menggunakan enum yang sama
    @State private var activeQuizCourseId: UUID? = nil // Untuk navigasi

    // Contoh daftar kursus kuis
    let beginnerQuizCourses: [KoreanQuizCourse] = [
        KoreanQuizCourse(title: "Basic Vocabulary Quiz", subtitle: "Test your basic Korean words", iconName: "text.book.closed.fill"),
        KoreanQuizCourse(title: "Basic Particles Quiz", subtitle: "Test your understanding of 은/는, 이/가, etc.", iconName: "puzzlepiece.extension.fill")
    ]

    let intermediateQuizCourses: [KoreanQuizCourse] = [] // Isi nanti

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("Korean Quizzes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 5)

                HStack(spacing: 10) { // Tombol Level
                    Spacer()
                    ForEach(FlashcardLevel.allCases) { level in
                        Button(action: { selectedLevel = level; activeQuizCourseId = nil }) {
                            Text(level.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background(selectedLevel == level ? Color.blue : Color(UIColor.systemGroupedBackground))
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

                ScrollView {
                    VStack(spacing: 15) {
                        switch selectedLevel {
                        case .beginner:
                            if beginnerQuizCourses.isEmpty {
                                Text("No beginner quizzes available yet.")
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                ForEach(beginnerQuizCourses) { course in
                                    NavigationLink(
                                        destination: KoreanQuizRunnerView(course: course), // Arahkan ke runner kuis
                                        tag: course.id,
                                        selection: $activeQuizCourseId
                                    ) {
                                        KoreanQuizCourseCardView(course: course, isSelected: activeQuizCourseId == course.id)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        case .intermediate:
                            Text("Intermediate Korean quizzes are coming soon!")
                                .foregroundColor(.gray).padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                            // Implementasi untuk intermediate
                        case .expert:
                            Text("Expert Korean quizzes are coming soon!")
                                .foregroundColor(.gray).padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                            // Implementasi untuk expert
                        }
                    }
                    .padding(.vertical, 10) // Beri sedikit padding vertikal untuk daftar
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .navigationBarHidden(true) // Atau sesuaikan dengan alur navigasi Anda
        }
    }
}

#Preview {
    KoreanQuizListView()
}
