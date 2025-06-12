import SwiftUI

struct KoreanQuizListView: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeQuizCourseId: UUID? = nil

    // Data kursus tidak berubah
    let beginnerQuizCourses: [KoreanQuizCourse] = [
        KoreanQuizCourse(stringID: "quiz_korean_basic_vocab_beginner", title: "Basic Vocabulary Quiz", subtitle: "Test your basic Korean words", iconName: "text.book.closed.fill"),
        KoreanQuizCourse(stringID: "quiz_korean_basic_particles_beginner", title: "Basic Particles Quiz", subtitle: "Test your understanding of 은/는, 이/가, etc.", iconName: "puzzlepiece.extension.fill")
    ]
    let intermediateQuizCourses: [KoreanQuizCourse] = []
    let expertQuizCourses: [KoreanQuizCourse] = []

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("Korean Quizzes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, geometry.safeAreaInsets.top > 0 ? geometry.safeAreaInsets.top : 15)
                .padding(.bottom, 10)

                HStack(spacing: 10) {
                    Spacer()
                    ForEach(FlashcardLevel.allCases) { level in
                        Button(action: { selectedLevel = level; activeQuizCourseId = nil }) {
                            Text(level.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background(selectedLevel == level ? themeManager.accentColor : Color(UIColor.secondarySystemGroupedBackground)) // 3. Gunakan warna tema
                                .foregroundColor(selectedLevel == level ? .white : themeManager.accentColor) // 4. Gunakan warna tema
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(themeManager.accentColor, lineWidth: 1) // 5. Gunakan warna tema
                                )
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .padding(.bottom, 15)

                ScrollView {
                    // ... (VStack & switch tidak berubah)
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
                                        destination: KoreanQuizRunnerView(course: course),
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
                        case .expert:
                             Text("Expert Korean quizzes are coming soon!")
                                 .foregroundColor(.gray).padding()
                                 .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 95)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    KoreanQuizListView()
        .environmentObject(ProgressViewModel())
        .environmentObject(ThemeManager()) // Tambahkan untuk preview
}
