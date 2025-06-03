// AslanApp/View/Grammar/GrammarTopicsForCourseView.swift
import SwiftUI

struct GrammarTopicsForCourseView: View {
    let course: JapaneseCourse
    private var materialsForCourse: [GrammarMaterial] {
        GrammarContentData.materials(forCourseTitle: course.title)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) { // Alignment .center untuk judul kursus
                // Judul Kursus (seperti "Basic Particles")
                Text(course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center) // Pastikan multiline juga center
                    .padding(.horizontal, 20) // Padding horizontal untuk judul
                    .padding(.top, 20) // Tambah padding atas
                    .padding(.bottom, 10) // Padding bawah sebelum daftar

                if materialsForCourse.isEmpty {
                    Text("No specific topics found for \(course.title) yet.")
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    VStack(spacing: 18) { // Spasi antar kartu topik
                        ForEach(materialsForCourse) { material_topic in
                            NavigationLink(destination: JapaneseGrammarDetailView(material: material_topic)) {
                                HStack(spacing: 15) {
                                    Image(systemName: "text.book.closed.fill")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                        .frame(width: 40, alignment: .center)

                                    VStack(alignment: .leading, spacing: 4) { // Sedikit spacing untuk subjudul
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
                                // Padding internal kartu disesuaikan (misal: atas/bawah 15, samping 20)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 20)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20) // Padding horizontal untuk seluruh daftar topik
                }
            }
            .padding(.bottom, 20) // Padding bawah untuk ScrollView
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        let sampleCourse = JapaneseGrammarListView().beginnerGrammarCourses.first ?? JapaneseCourse(title: "Sample Particles Long Title Example", subtitle: "Learn basic particles", iconName: "puzzlepiece.extension.fill")
        GrammarTopicsForCourseView(course: sampleCourse)
    }
}
