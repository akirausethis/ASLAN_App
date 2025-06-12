import SwiftUI

struct KoreanGrammarTopicsForCourseView: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    let course: KoreanCourse

    private var materialsForCourse: [GrammarMaterial] {
        KoreanGrammarContentData.materials(forCourseTitle: course.title)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                
                // ... (sisa kode tidak berubah)
                if materialsForCourse.isEmpty {
                    // ...
                } else {
                    VStack(spacing: 15) {
                        ForEach(materialsForCourse) { material_topic in
                            KoreanGrammarTopicRow(materials: material_topic)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
