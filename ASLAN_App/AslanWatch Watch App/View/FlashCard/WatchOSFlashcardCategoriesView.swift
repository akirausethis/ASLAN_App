// akirausethis/aslan_app/ASLAN_App-Korean/ASLAN_App/AslanWatch Watch App/View/FlashCard/WatchOSFlashcardCategoriesView.swift
import SwiftUI

struct WatchOSFlashcardCategoriesView: View {
    let flashcardCourses: [KoreanCourse] = [
        KoreanCourse(title: "Konsonan Dasar", subtitle: "Pelajari ㄱ, ㄴ, ㄷ...", iconName: "textformat.abc.dottedunderline"),
        KoreanCourse(title: "Vokal Dasar", subtitle: "Pelajari ㅏ, ㅑ, ㅓ...", iconName: "textformat.size.larger"),
        KoreanCourse(title: "Konsonan Ganda", subtitle: "Pelajari ㄲ, ㄸ, ㅃ...", iconName: "textformat.alt"),
        KoreanCourse(title: "Vokal Gabungan", subtitle: "Pelajari ㅐ, ㅘ, ㅢ...", iconName: "squares.below.rectangle"),
        KoreanCourse(title: "Suku Kata Awal", subtitle: "Gabungan konsonan & vokal", iconName: "square.grid.3x1.below.line.grid.1x2"),
        KoreanCourse(title: "Semua Karakter (Acak)", subtitle: "Latihan semua Hangul", iconName: "shuffle")
    ]

    var body: some View {
        List {
            ForEach(flashcardCourses) { course in
                NavigationLink(destination: WatchOSFlashcardRunnerView(course: course)) {
                    HStack(spacing: 10) {
                        Image(systemName: course.iconName)
                            .font(.title3) // Ukuran ikon
                            .foregroundColor(.blue) // Warna ikon konsisten biru
                            .frame(width: 30, alignment: .center) // Frame untuk ikon
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(course.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(1) // Pastikan judul tidak terlalu panjang atau wrap
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
        .navigationTitle("Flashcards")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WatchOSFlashcardCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchOSFlashcardCategoriesView()
        }
    }
}
