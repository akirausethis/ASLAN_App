import SwiftUI

struct KoreanFlashCardListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: UUID? = nil

    let beginnerCourses: [KoreanCourse] = [ // Menggunakan KoreanCourse
        KoreanCourse(title: "Hangul", subtitle: "Learn the Korean Alphabet", iconName: "text.book.closed.fill")
        // Tambahkan kursus lain jika ada
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Flashcard (Korea)") // Ubah judul
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                HStack(spacing: 10) { // Tombol Level
                    Spacer()
                    ForEach(FlashcardLevel.allCases) { level in
                        Button(action: { selectedLevel = level; activeCourseId = nil }) {
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
                        if selectedLevel == .beginner {
                            ForEach(beginnerCourses) { course in
                                NavigationLink(
                                    destination: destinationView(for: course),
                                    isActive: Binding(
                                        get: { self.activeCourseId == course.id },
                                        set: { isActive in
                                            self.activeCourseId = isActive ? course.id : nil
                                        }
                                    )
                                ) {
                                    KoreanFlashCardCourseCardView(course: course, isSelected: activeCourseId == course.id) // Menggunakan KoreanFlashCardCourseCardView
                                }
                            }
                        } else {
                            Text("No courses available for \(selectedLevel.rawValue) yet.")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }

    @ViewBuilder
    private func destinationView(for course: KoreanCourse) -> some View {
        if course.title == "Hangul" {
            HangulFlashcardCarouselView() // Arahkan ke Hangul Carousel
        } else {
            Text("Coming Soon")
        }
    }
}

#Preview {
    KoreanFlashCardListView()
}
