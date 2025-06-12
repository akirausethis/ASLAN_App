import SwiftUI

// View untuk menampilkan daftar kategori atau kursus grammar.
struct WatchOSGrammarCategoriesView: View {
    // Daftar kursus grammar. Anda bisa memuat ini dari sumber data lain jika perlu.
    let grammarCourses: [KoreanCourse] = [ // Menggunakan KoreanCourse
        // PERBAIKAN: Tambahkan `id`, `category`, dan `level`
        KoreanCourse(id: "grammar_basic_particles_beginner", title: "Basic Particles", subtitle: "Understanding 은/는, 이/가, 을/를", iconName: "puzzlepiece.extension.fill", category: "Grammar", level: .beginner),
        KoreanCourse(id: "grammar_verb_conjugation_beginner", title: "Verb Conjugation", subtitle: "Present Tense - ㅂ니다/습니다", iconName: "function", category: "Grammar", level: .beginner)
        // Tambahkan kursus lain jika ada, dengan id, category, dan level yang sesuai
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
