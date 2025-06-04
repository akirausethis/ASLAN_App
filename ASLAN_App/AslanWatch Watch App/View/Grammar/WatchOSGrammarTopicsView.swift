import SwiftUI

// View untuk menampilkan daftar topik grammar dalam satu kursus tertentu.
struct WatchOSGrammarTopicsView: View {
    let course: KoreanCourse // Kursus yang dipilih.
    @State private var topics: [KoreanGrammarMaterial] = [] // Topik grammar untuk kursus ini.

    var body: some View {
        List {
            // Loop melalui setiap topik grammar.
            ForEach(topics) { topic in
                // Setiap baris adalah NavigationLink yang mengarah ke WatchOSGrammarDetailView.
                // Pastikan WatchOSGrammarDetailView sudah didefinisikan dan menerima 'material: GrammarMaterial'.
                NavigationLink(destination: WatchOSGrammarDetailView(material: topic)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(topic.topicTitle)
                            .font(.subheadline) // Font lebih kecil untuk judul topik di daftar.
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(2) // Izinkan dua baris jika judul panjang.
                        
                        // Anda bisa menambahkan preview singkat penjelasan jika muat dan diinginkan.
                        // Text(topic.explanation.prefix(40) + (topic.explanation.count > 40 ? "..." : ""))
                        //     .font(.caption2)
                        //     .foregroundColor(.gray)
                        //     .lineLimit(1)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle(course.title) // Judul halaman adalah nama kursus.
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Muat topik grammar saat view muncul.
            // MEMPERBAIKI PEMANGGILAN FUNGSI DI SINI:
            // Menggunakan nama fungsi yang benar: 'materials(forCourseTitle:)'
            self.topics = KoreanGrammarContentData.materials(forCourseTitle: course.title)

            if self.topics.isEmpty {
                print("Peringatan di WatchOSGrammarTopicsView: Tidak ada topik grammar yang dimuat untuk kursus '\(course.title)'. Pastikan 'courseTitle' di KoreanGrammarContentData.swift cocok dengan judul kursus ini, dan file model sudah di-share ke target watchOS.")
            }
        }
    }
}

// MARK: - Preview
struct WatchOSGrammarTopicsView_Previews: PreviewProvider {
    static var previews: some View {
        // Contoh data kursus untuk preview.
        // Pastikan KoreanCourse dan GrammarMaterial sudah didefinisikan dan dapat diakses.
        let sampleCourse = KoreanCourse(title: "Partikel Dasar", subtitle: "Pelajari 은/는, 이/가, dll.", iconName: "puzzlepiece.extension.fill")
        
        NavigationView {
            WatchOSGrammarTopicsView(course: sampleCourse)
        }
    }
}
