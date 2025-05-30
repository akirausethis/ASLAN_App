// AslanApp/View/Writing/KoreanWritingListView.swift
import SwiftUI

struct KoreanWritingListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner // Anda bisa menggunakan level yang sama
    @State private var activeCourseId: UUID? = nil

    let beginnerWritingCourses: [KoreanCourse] = [
        KoreanCourse(title: "Basic Consonants", subtitle: "Practice writing basic Korean consonants", iconName: "pencil.line"),
        KoreanCourse(title: "Basic Vowels", subtitle: "Practice writing basic Korean vowels", iconName: "pencil.line"),
        KoreanCourse(title: "Combined Vowels", subtitle: "Practice writing combined Korean vowels", iconName: "pencil.line"),
        KoreanCourse(title: "Double Consonants", subtitle: "Practice writing double Korean consonants", iconName: "pencil.line")
        // Tambahkan kursus menulis lainnya di sini
    ]

    let intermediateWritingCourses: [KoreanCourse] = []
    let expertWritingCourses: [KoreanCourse] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("Korean Writing")
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
                            ForEach(beginnerWritingCourses) { course in
                                NavigationLink(
                                    destination: KoreanWritingCarouselView(practiceType: course.title),
                                    tag: course.id,
                                    selection: $activeCourseId
                                ) {
                                    KoreanWritingCourseCardView(course: course, isSelected: activeCourseId == course.id)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        case .intermediate:
                            Text("Intermediate Korean writing courses are coming soon!")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .expert:
                            Text("Expert Korean writing courses are coming soon!")
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
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    KoreanWritingListView()
}
