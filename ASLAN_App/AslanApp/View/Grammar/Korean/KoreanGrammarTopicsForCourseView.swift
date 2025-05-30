// AslanApp/View/Grammar/KoreanGrammarTopicsForCourseView.swift
import SwiftUI

struct KoreanGrammarTopicsForCourseView: View {
    let course: KoreanCourse // Menggunakan KoreanCourse
    private var materialsForCourse: [GrammarMaterial] {
        // Mengambil data dari KoreanGrammarContentData
        KoreanGrammarContentData.materials(forCourseTitle: course.title)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text(course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                if materialsForCourse.isEmpty {
                    Text("No specific topics found for \(course.title) yet.")
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    VStack(spacing: 18) {
                        ForEach(materialsForCourse) { material_topic in
                            // Navigasi ke KoreanGrammarDetailView
                            NavigationLink(destination: KoreanGrammarDetailView(material: material_topic)) {
                                HStack(spacing: 15) {
                                    Image(systemName: "text.book.closed.fill") // Icon bisa disesuaikan
                                        .font(.title)
                                        .foregroundColor(.blue)
                                        .frame(width: 40, alignment: .center)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(material_topic.topicTitle)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.primary)
                                        Text(material_topic.explanation.prefix(80) + (material_topic.explanation.count > 80 ? "..." : ""))
                                            .font(.subheadline)
                                            .foregroundColor(Color.secondary)
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray.opacity(0.7))
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 20)
                                .background(Color(UIColor.systemBackground)) // Warna background kartu topik
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("") // Judul navigasi bisa dikosongkan jika sudah ada di atas
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        // Pastikan ada data kursus dan materi untuk preview
        let sampleCourse = KoreanGrammarListView().beginnerGrammarCourses.first ?? KoreanCourse(title: "Sample Korean Particles", subtitle: "Learn basic particles", iconName: "puzzlepiece.extension.fill")
        KoreanGrammarTopicsForCourseView(course: sampleCourse)
    }
}
