import SwiftUI

// View untuk menampilkan daftar kategori atau kursus flashcard.
struct WatchOSFlashcardCategoriesView: View {
    // Daftar kursus flashcard. Sebaiknya ini diambil dari sumber data yang lebih dinamis
    // atau di-pass sebagai parameter jika perlu. Untuk contoh ini, kita hardcode.
    let flashcardCourses: [KoreanCourse] = [ // Menggunakan KoreanCourse
        // PERBAIKAN: Tambahkan `id`, `category`, dan `level`
        KoreanCourse(id: "flashcard_hangul_beginner", title: "Hangul", subtitle: "Learn the Korean Alphabet", iconName: "text.book.closed.fill", category: "Flashcard", level: .beginner)
        // Tambahkan kursus lain jika ada, dengan id, category, dan level yang sesuai
    ]

    var body: some View {
        List {
            // Loop melalui setiap kursus flashcard.
            ForEach(flashcardCourses) { course in
                // Setiap baris adalah NavigationLink yang mengarah ke WatchOSFlashcardRunnerView.
                NavigationLink(destination: WatchOSFlashcardRunnerView(course: course)) {
                    // Tampilan untuk setiap baris kursus.
                    VStack(alignment: .leading, spacing: 5) { // Menambah spasi antar elemen.
                        HStack(spacing: 8) { // Spasi antara ikon dan judul.
                            Image(systemName: course.iconName)
                                .foregroundColor(.blue) // Warna ikon.
                                .font(.headline)       // Ukuran ikon sedikit lebih besar.
                                .frame(width: 25, alignment: .center) // Frame untuk ikon.
                            Text(course.title)
                                .font(.headline)    // Font tebal untuk judul.
                                .foregroundColor(.primary)
                        }
                        Text(course.subtitle)
                            .font(.caption)         // Font kecil untuk subjudul.
                            .foregroundColor(.gray)   // Warna abu-abu untuk subjudul.
                            .lineLimit(2)           // Batasi subjudul hingga 2 baris.
                    }
                    .padding(.vertical, 8) // Padding vertikal untuk setiap baris.
                }
            }
        }
        .navigationTitle("Flashcards") // Judul halaman.
        .navigationBarTitleDisplayMode(.inline) // Tampilkan judul secara inline.
    }
}

// MARK: - Preview
struct WatchOSFlashcardCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        // Bungkus dengan NavigationView agar judul dan navigasi berfungsi di preview.
        NavigationView {
            WatchOSFlashcardCategoriesView()
        }
    }
}
