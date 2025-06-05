// AslanApp/View/Grammar/Korean/KoreanGrammarTopicsForCourseView.swift
import SwiftUI

struct KoreanGrammarTopicsForCourseView: View {
    let course: KoreanCourse // Menggunakan KoreanCourse
    
    private var materialsForCourse: [KoreanGrammarMaterial] {
         print("KoreanGrammarTopicsForCourseView - Mencari materi untuk kursus: \(course.title)")
         let filtered = KoreanGrammarContentData.materials(forCourseTitle: course.title)
         print("KoreanGrammarTopicsForCourseView - Jumlah materi ditemukan: \(filtered.count)")
         return filtered
        KoreanGrammarContentData.materials(forCourseTitle: course.title)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 5)

                if materialsForCourse.isEmpty {
                    VStack {
                        Spacer(minLength: 50)
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                        Text("No specific topics found for \"\(course.title)\" yet.")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Text("Please ensure the course title in the data file matches exactly or check back later.")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 300)
                } else {
                    List {
                        ForEach(materialsForCourse) { material_topic in
                            KoreanGrammarTopicRow(materials: material_topic)
                                .listRowInsets(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                                .listRowSeparator(.visible, edges: .bottom)
                        }
                    }
                    .listStyle(.plain)
                    .frame(minHeight: CGFloat(materialsForCourse.count) * 70) // Perkiraan tinggi minimum
                    .shrinkOrScroll()
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
        // .onAppear { // Aktifkan untuk debugging
        //     print("KoreanGrammarTopicsForCourseView: Muncul untuk kursus '\(course.title)'")
        //     print("KoreanGrammarTopicsForCourseView: Jumlah materi ditemukan: \(materialsForCourse.count)")
        //     if materialsForCourse.isEmpty {
        //         let allTitlesInData = Set(KoreanGrammarContentData.allMaterials.map { $0.courseTitle })
        //         print("KoreanGrammarTopicsForCourseView: Judul kursus yang ada di data: \(allTitlesInData)")
        //         print("KoreanGrammarTopicsForCourseView: Judul kursus yang dicari: '\(course.title)'")
        //     }
        // }
    }
}

// Custom ViewModifier (jika Anda masih menggunakannya)
struct ShrinkOrScroll: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

extension View {
    func shrinkOrScroll() -> some View {
        modifier(ShrinkOrScroll())
    }
}


// MARK: - Preview
struct KoreanGrammarTopicsForCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // Pastikan KoreanCourse dan GrammarMaterial sudah didefinisikan
            // Ganti "Verb Conjugation" dengan judul yang ADA di KoreanGrammarContentData Anda
            // untuk preview yang benar dan menampilkan data.
            let sampleCourse = KoreanCourse(title: "Verb Conjugation", subtitle: "Belajar konjugasi", iconName: "function")
            
            KoreanGrammarTopicsForCourseView(course: sampleCourse)
        }
    }
}

// Pastikan KoreanGrammarDetailView juga ada dan di-share ke target iOS
// Contoh sederhana:
/*
struct KoreanGrammarDetailView: View {
    let material: GrammarMaterial // Nama parameter diubah menjadi 'material'
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text(material.topicTitle).font(.title).padding()
                Text(material.explanation).padding()
                // Tambahkan tampilan untuk examples dan tip jika perlu
            }
        }
        .navigationTitle(material.topicTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
*/
