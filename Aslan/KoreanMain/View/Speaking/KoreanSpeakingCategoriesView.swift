import SwiftUI

struct KoreanSpeakingCategoriesView: View {
    // --- PERUBAHAN 1: Ganti semua teks ke Bahasa Inggris ---
    let speakingTopics: [KoreanCourse] = [
        KoreanCourse(id: "speaking_basic_conversation_beginner", title: "Basic Conversation", subtitle: "Common everyday phrases", iconName: "message.fill", category: "Speaking", level: .beginner),
        KoreanCourse(id: "speaking_self_introduction_beginner", title: "Self Introduction", subtitle: "How to introduce yourself", iconName: "person.wave.2.fill", category: "Speaking", level: .beginner),
        KoreanCourse(id: "speaking_at_the_restaurant_beginner", title: "At the Restaurant", subtitle: "Ordering food and drinks", iconName: "fork.knife", category: "Speaking", level: .intermediate)
    ]
    
    @State private var activeCourseId: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                // --- PERUBAHAN 2: Ganti judul utama ---
                Text("Speaking Practice")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 20)

            ScrollView {
                VStack(spacing: 15) {
                    if speakingTopics.isEmpty {
                        // --- PERUBAHAN 3: Ganti teks saat kosong ---
                        Text("No speaking topics available yet.")
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(speakingTopics) { course in
                            NavigationLink(
                                destination: KoreanSpeakingPracticeView(course: course),
                                tag: course.id,
                                selection: $activeCourseId
                            ) {
                                KoreanGrammarCourseCardView(course: course, isSelected: activeCourseId == course.id)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        // --- PERUBAHAN 4: Ganti judul navigasi ---
        .navigationTitle("Select a Topic")
        .navigationBarTitleDisplayMode(.inline)
    }
}
