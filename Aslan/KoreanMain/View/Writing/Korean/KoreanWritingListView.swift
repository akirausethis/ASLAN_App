import SwiftUI

struct KoreanWritingListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: String? = nil

    // Mengambil data dari sumber utama
    private let courseProvider = CourseDataProvider.shared

    // Filter data kursus Writing untuk setiap level
    private var beginnerCourses: [AppCourse] {
        courseProvider.allAppCourses.filter { $0.category == "Writing" && $0.level == .beginner }
    }
    
    private var intermediateCourses: [AppCourse] {
        courseProvider.allAppCourses.filter { $0.category == "Writing" && $0.level == .intermediate }
    }
    
    private var expertCourses: [AppCourse] {
        courseProvider.allAppCourses.filter { $0.category == "Writing" && $0.level == .expert }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // --- PERUBAHAN DI SINI: MENAMBAHKAN JUDUL BESAR ---
            HStack {
                Spacer()
                Text("Korean Writing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 15)

            // --- Tombol Level ---
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
                            .background(selectedLevel == level ? Color.blue : Color(UIColor.secondarySystemGroupedBackground))
                            .foregroundColor(selectedLevel == level ? .white : .blue)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

            // --- Daftar Kursus ---
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
            // Tombol Kembali Kustom
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            // Judul di toolbar dihapus karena sudah dipindahkan ke body
        }
    }

    // Helper view untuk menampilkan daftar kursus
    @ViewBuilder
    private func courseSection(for courses: [AppCourse]) -> some View {
        if courses.isEmpty {
            Text("No Korean writing courses available for this level yet.")
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
                    destination: KoreanWritingCarouselView(course: courseForView),
                    tag: course.id,
                    selection: $activeCourseId
                ) {
                    KoreanWritingCourseCardView(course: courseForView, isSelected: activeCourseId == course.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    NavigationView {
        KoreanWritingListView()
            .environmentObject(ProgressViewModel())
    }
}
