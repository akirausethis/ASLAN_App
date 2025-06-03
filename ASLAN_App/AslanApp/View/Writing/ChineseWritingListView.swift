import SwiftUI

struct ChineseWritingListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    // Ubah selectedCourseId menjadi activeCourseId untuk kontrol navigasi
    @State private var activeCourseId: UUID? = nil

    // Our sample courses for the Beginner level
    let beginnerCourses: [ChineseCourse] = [
        ChineseCourse(title: "Hanzi", subtitle: "Course Title", iconName: "text.book.closed.fill"),
        ChineseCourse(title: "Pinyin", subtitle: "Course Title", iconName: "text.book.closed.fill")
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Header: Back button and Title
                HStack {
                    Spacer()
                    Text("Writing")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // Level Selection Buttons
                HStack(spacing: 10) {
                    Spacer()
                    ForEach(FlashcardLevel.allCases) { level in
                        Button(action: {
                            selectedLevel = level
                            // Reset active course when level changes
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
                .padding(.vertical, 5)


                // Flashcard Course List (Only for Beginner for now)
                ScrollView {
                    VStack(spacing: 15) {
                        if selectedLevel == .beginner {
                            ForEach(beginnerCourses) { course in
                                // Memanggil fungsi helper untuk membuat NavigationLink
                                navigationLinkForCourse(course: course)
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

    // MARK: - Helper Function for NavigationLink Destination
    @ViewBuilder
    private func navigationLinkForCourse(course: ChineseCourse) -> some View {
        NavigationLink(
            destination: destinationView(for: course.title),
            isActive: Binding(
                get: { self.activeCourseId == course.id },
                set: { isActive in
                    if isActive {
                        self.activeCourseId = course.id
                    } else if self.activeCourseId == course.id {
                        self.activeCourseId = nil
                    }
                }
            )
        ) {
            // Label untuk NavigationLink, yaitu JapaneseFlashCardView
            ChineseFlashCardView(course: course, isSelected: activeCourseId == course.id)
        }
    }

    // MARK: - Helper Function to return the correct destination View
    @ViewBuilder
    private func destinationView(for courseTitle: String) -> some View {
        if courseTitle == "Hiragana" {
            ChineseWritingCarouselView(practiceType: "Hanzi")
        } else if courseTitle == "Katakana" {
            ChineseWritingCarouselView(practiceType: "Pinyin")
        } else {
            // Default view jika tidak ada yang cocok, atau bisa juga Text("Coming Soon")
            Text("Course details for \(courseTitle) (Coming Soon)")
        }
    }
}

#Preview {
    ChineseWritingListView()
}
