import SwiftUI

struct KoreanGrammarListView: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: String? = nil

    // Data kursus tidak berubah
    let beginnerGrammarCourses: [KoreanCourse] = [
        KoreanCourse(id: "grammar_basic_particles_beginner", title: "Basic Particles", subtitle: "Understanding 은/는, 이/가, 을/를", iconName: "puzzlepiece.extension.fill", category: "Grammar", level: .beginner),
        KoreanCourse(id: "grammar_verb_conjugation_beginner", title: "Verb Conjugation", subtitle: "Present Tense - ㅂ니다/습니다", iconName: "function", category: "Grammar", level: .beginner),
        KoreanCourse(id: "grammar_sentence_structure_beginner", title: "Sentence Structure", subtitle: "Subject-Object-Verb", iconName: "list.bullet.indent", category: "Grammar", level: .beginner)
    ]
    let intermediateGrammarCourses: [KoreanCourse] = [
        KoreanCourse(id: "grammar_advanced_particles_intermediate", title: "Advanced Particles", subtitle: "Connecting sentences with particles", iconName: "puzzlepiece.extension", category: "Grammar", level: .intermediate),
        KoreanCourse(id: "grammar_conditional_forms_intermediate", title: "Conditional Forms", subtitle: "Expressing 'if' and 'when'", iconName: "arrow.triangle.branch", category: "Grammar", level: .intermediate),
        KoreanCourse(id: "grammar_honorifics_politeness_intermediate", title: "Honorifics & Politeness", subtitle: "Understanding speech levels", iconName: "hand.raised.fill", category: "Grammar", level: .intermediate)
    ]
    let expertGrammarCourses: [KoreanCourse] = [
        KoreanCourse(id: "grammar_complex_sentence_structures_expert", title: "Complex Sentence Structures", subtitle: "Advanced conjunctions and clauses", iconName: "text.insert", category: "Grammar", level: .expert),
        KoreanCourse(id: "grammar_passive_causative_forms_expert", title: "Passive & Causative Forms", subtitle: "Advanced verb transformations", iconName: "arrow.right.arrow.left.square.fill", category: "Grammar", level: .expert),
        KoreanCourse(id: "grammar_indirect_quotations_expert", title: "Indirect Quotations", subtitle: "Reporting speech and thoughts", iconName: "quote.bubble.fill", category: "Grammar", level: .expert)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Text("Korean Grammar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema
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
            .padding(.vertical, 10)
            .background(Color(UIColor.systemBackground))

            ScrollView {
                VStack(spacing: 15) {
                    // ... (switch case tidak berubah, karena sudah memanggil view yang akan diubah)
                    switch selectedLevel {
                    case .beginner:
                        ForEach(beginnerGrammarCourses) { course in
                            NavigationLink(destination: destinationView(for: course), tag: course.id, selection: $activeCourseId) {
                                KoreanGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    case .intermediate:
                        ForEach(intermediateGrammarCourses) { course in
                            NavigationLink(destination: destinationView(for: course), tag: course.id, selection: $activeCourseId) {
                                KoreanGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    case .expert:
                        ForEach(expertGrammarCourses) { course in
                            NavigationLink(destination: destinationView(for: course), tag: course.id, selection: $activeCourseId) {
                                KoreanGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                            }.buttonStyle(PlainButtonStyle())
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

    @ViewBuilder
    private func destinationView(for course: KoreanCourse) -> some View {
        KoreanGrammarTopicsForCourseView(course: course)
    }
}

#Preview {
    NavigationView {
        KoreanGrammarListView()
            .environmentObject(ThemeManager()) // Tambahkan untuk preview
    }
}
