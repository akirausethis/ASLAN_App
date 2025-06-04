import SwiftUI

// View untuk menampilkan daftar kategori atau kursus grammar.
struct WatchOSGrammarCategoriesView: View {
    // Daftar kursus grammar. Anda bisa memuat ini dari sumber data lain jika perlu.
    let grammarCourses: [KoreanCourse] = [
        KoreanCourse(title: "Partikel Dasar", subtitle: "Pelajari 은/는, 이/가, dll.", iconName: "puzzlepiece.extension.fill"),
        KoreanCourse(title: "Konjugasi Dasar", subtitle: "Bentuk -(스)ㅂ니다, -아/어요", iconName: "function"),
        KoreanCourse(title: "Struktur Kalimat", subtitle: "Pola kalimat dasar", iconName: "list.bullet.indent")
        // Tambahkan kursus grammar lainnya di sini
    ]

    var body: some View {
        List {
            // Loop melalui setiap kursus grammar.
            ForEach(grammarCourses) { course in
                // Setiap baris adalah NavigationLink yang mengarah ke WatchOSGrammarTopicsView.
                NavigationLink(destination: WatchOSGrammarTopicsView(course: course)) {
                    // Tampilan untuk setiap baris kursus.
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 8) {
                            Image(systemName: course.iconName)
                                .foregroundColor(.green) // Warna ikon bisa disesuaikan
                                .font(.headline)
                                .frame(width: 25, alignment: .center)
                            Text(course.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        Text(course.subtitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Grammar Korea") // Judul halaman.
        .navigationBarTitleDisplayMode(.inline) // Tampilkan judul secara inline.
    }
}

// MARK: - Preview
struct WatchOSGrammarCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        // Bungkus dengan NavigationView agar judul dan navigasi berfungsi di preview.
        NavigationView {
            WatchOSGrammarCategoriesView()
        }
    }
}
