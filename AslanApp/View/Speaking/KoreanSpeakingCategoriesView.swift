import SwiftUI

struct KoreanSpeakingCategoriesView: View {
    let speakingTopics: [KoreanCourse] = [
        KoreanCourse(title: "Percakapan Dasar", subtitle: "Frasa umum sehari-hari", iconName: "message.fill"),
        KoreanCourse(title: "Perkenalan Diri", subtitle: "Cara memperkenalkan diri", iconName: "person.wave.2.fill"),
        KoreanCourse(title: "Di Restoran", subtitle: "Memesan makanan dan minuman", iconName: "fork.knife")
    ]
    
    @State private var activeCourseId: UUID? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Text("Latihan Berbicara")
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
                        Text("Belum ada topik latihan berbicara.")
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
        .navigationTitle("Pilih Topik")
        .navigationBarTitleDisplayMode(.inline)
    }
}




