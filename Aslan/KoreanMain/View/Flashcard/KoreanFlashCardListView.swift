import SwiftUI

struct KoreanFlashCardListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: String? = nil
    
    private let courseProvider = CourseDataProvider.shared

    // Filter untuk memastikan hanya kursus flashcard Bahasa Korea yang muncul
    private var beginnerCourses: [AppCourse] {
        courseProvider.allAppCourses.filter {
            $0.category == "Flashcard" && $0.level == .beginner &&
            !$0.title.lowercased().contains("hiragana") &&
            !$0.title.lowercased().contains("katakana") &&
            !$0.title.lowercased().contains("kanji")
        }
    }
    
    private var intermediateCourses: [AppCourse] {
        courseProvider.allAppCourses.filter {
            $0.category == "Flashcard" && $0.level == .intermediate &&
            !$0.title.lowercased().contains("kanji") &&
            !$0.title.lowercased().contains("kana")
        }
    }
    
    private var expertCourses: [AppCourse] {
        courseProvider.allAppCourses.filter {
            $0.category == "Flashcard" && $0.level == .expert &&
            !$0.title.lowercased().contains("kanji") &&
            !$0.title.lowercased().contains("kana")
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // --- BAGIAN JUDUL ---
            HStack {
                Spacer()
                Text("Korean Flashcard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 15)

            // --- BAGIAN TOMBOL LEVEL ---
            HStack(spacing: 10) {
                Spacer()
                ForEach(FlashcardLevel.allCases) { level in
                    Button(action: {
                        selectedLevel = level
                        activeCourseId = nil
                    }) {
                        Text(level.rawValue)
                            .font(.subheadline).fontWeight(.medium)
                            .padding(.vertical, 8).padding(.horizontal, 15)
                            .background(selectedLevel == level ? themeManager.accentColor : Color(UIColor.secondarySystemGroupedBackground)) // 3. Gunakan warna tema
                            .foregroundColor(selectedLevel == level ? .white : themeManager.accentColor) // 4. Gunakan warna tema
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(themeManager.accentColor, lineWidth: 1)) // 5. Gunakan warna tema
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

            // --- BAGIAN DAFTAR KURSUS ---
            ScrollView {
                VStack(spacing: 15) {
                    switch selectedLevel {
                    case .beginner:
                        courseSection(for: beginnerCourses)
                    case .intermediate:
                        courseSection(for: intermediateCourses)
                    case .expert:
                        courseSection(for: expertCourses)
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
    }

    @ViewBuilder
    private func courseSection(for courses: [AppCourse]) -> some View {
        if courses.isEmpty {
            Text("No Korean flashcard courses available for this level yet.")
                .foregroundColor(.gray)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        } else {
            ForEach(courses) { course in
                let courseForView = KoreanCourse(
                    id: course.id,
                    title: course.title,
                    subtitle: course.subtitle,
                    iconName: course.iconName,
                    category: course.category,
                    level: course.level
                )
                NavigationLink(
                    destination: KoreanFlashCardCarouselView(course: courseForView),
                    tag: course.id,
                    selection: $activeCourseId
                ) {
                    KoreanFlashCardCourseCardView(course: courseForView, isSelected: activeCourseId == course.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    NavigationView {
        KoreanFlashCardListView()
            .environmentObject(ProgressViewModel())
            .environmentObject(ThemeManager()) // Jangan lupa tambahkan di preview
    }
}
