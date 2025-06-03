// AslanApp/View/Spelling/JapaneseSpellingListView.swift
import SwiftUI

struct JapaneseSpellingListView: View {
    @State private var selectedLevel: FlashcardLevel = .beginner
    @State private var activeCourseId: UUID? = nil

    let beginnerCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Hiragana Sounds", subtitle: "Practice basic Hiragana pronunciation", iconName: "waveform.path.ecg"),
        JapaneseCourse(title: "Katakana Sounds", subtitle: "Practice basic Katakana pronunciation", iconName: "waveform.path.ecg"),
        JapaneseCourse(title: "N5 Greetings", subtitle: "Basic greetings from N5 level", iconName: "hands.sparkles.fill")
    ]

    let intermediateCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Common Phrases", subtitle: "Practice everyday phrases", iconName: "bubble.left.and.bubble.right.fill"),
        JapaneseCourse(title: "N4 Questions", subtitle: "Forming and answering N4 questions", iconName: "questionmark.bubble.fill")
    ]

    let expertCourses: [JapaneseCourse] = [
        JapaneseCourse(title: "Pitch Accent Practice", subtitle: "Focus on correct intonation", iconName: "tuningfork"),
        JapaneseCourse(title: "N3 Conversation Starters", subtitle: "Practice N3 level conversation", iconName: "figure.stand.line.dotted.figure.stand")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack { // Judul
                Spacer()
                Text("Spelling Practice")
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
            .padding(.vertical, 5)

            ScrollView {
                VStack(spacing: 15) {
                    switch selectedLevel {
                    case .beginner:
                        if beginnerCourses.isEmpty {
                            // Mengoper informasi apakah daftar kursus beginner kosong
                            EmptySpellingStateView(level: .beginner, isCourseListEmpty: true)
                        } else {
                            SpellingCourseItemsView(courses: beginnerCourses, activeCourseId: $activeCourseId)
                        }
                    case .intermediate:
                        if intermediateCourses.isEmpty {
                            EmptySpellingStateView(level: .intermediate, isCourseListEmpty: true)
                        } else {
                            SpellingCourseItemsView(courses: intermediateCourses, activeCourseId: $activeCourseId)
                        }
                    case .expert:
                        if expertCourses.isEmpty {
                            EmptySpellingStateView(level: .expert, isCourseListEmpty: true)
                        } else {
                            SpellingCourseItemsView(courses: expertCourses, activeCourseId: $activeCourseId)
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

    private struct SpellingCourseItemsView: View {
        let courses: [JapaneseCourse]
        @Binding var activeCourseId: UUID?

        var body: some View {
            ForEach(courses) { course in
                NavigationLink(
                    destination: JapaneseSpellingCarouselView(courseTitle: course.title),
                    tag: course.id,
                    selection: $activeCourseId
                ) {
                    JapaneseSpellingCourseCardView(course: course, isSelected: activeCourseId == course.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    // PERBAIKAN PADA EmptySpellingStateView
    private struct EmptySpellingStateView: View {
        let level: FlashcardLevel
        let isCourseListEmpty: Bool // Parameter baru

        // Computed property untuk menentukan pesan
        private var message: String {
            if isCourseListEmpty {
                // Jika listnya memang kosong (misalnya belum didefinisikan kursusnya)
                return "Spelling exercises for \(level.rawValue) are coming soon!"
            } else {
                // Jika list tidak kosong tapi kondisi if di parent tetap mengarah ke sini
                // (seharusnya tidak terjadi jika logika parent benar)
                return "No \(level.rawValue.lowercased()) spelling exercises currently available."
            }
        }

        var body: some View {
            Text(message) // Baris 125 (kurang lebih) sekarang hanya menampilkan Text
                .foregroundColor(.gray)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    NavigationView {
        JapaneseSpellingListView()
    }
}
