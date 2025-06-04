// akirausethis/aslan_app/ASLAN_App-Korean/ASLAN_App/AslanWatch Watch App/View/Writing/WatchOSWritingCategoriesView.swift
import SwiftUI

struct WatchOSWritingCategoriesView: View {
    // Menggunakan KoreanCourse yang sama dengan Flashcard untuk kategori
    let writingCourses: [KoreanCourse] = [
        KoreanCourse(title: "Konsonan Dasar", subtitle: "Latihan menulis ㄱ, ㄴ, ㄷ...", iconName: "textformat.abc.dottedunderline"),
        KoreanCourse(title: "Vokal Dasar", subtitle: "Latihan menulis ㅏ, ㅑ, ㅓ...", iconName: "textformat.size.larger"),
        KoreanCourse(title: "Konsonan Ganda", subtitle: "Latihan menulis ㄲ, ㄸ, ㅃ...", iconName: "textformat.alt"),
        KoreanCourse(title: "Vokal Gabungan", subtitle: "Latihan menulis ㅐ, ㅘ, ㅢ...", iconName: "squares.below.rectangle")
        // Tambahkan kategori lain jika perlu
    ]

    var body: some View {
        List {
            ForEach(writingCourses) { course in
                NavigationLink(destination: WatchOSWritingPracticeView(course: course)) {
                    HStack(spacing: 10) {
                        Image(systemName: course.iconName)
                            .font(.title3)
                            .foregroundColor(.blue)
                            .frame(width: 30, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(course.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            Text(course.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Latihan Menulis")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WatchOSWritingCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchOSWritingCategoriesView()
        }
    }
}
