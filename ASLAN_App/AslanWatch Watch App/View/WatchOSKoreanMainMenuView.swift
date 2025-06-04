// akirausethis/aslan_app/ASLAN_App-Korean/ASLAN_App/AslanWatch Watch App/View/WatchOSKoreanMainMenuView.swift
import SwiftUI

// View utama untuk menu aplikasi di watchOS.
// Menyediakan navigasi ke berbagai fitur pembelajaran.
struct WatchOSKoreanMainMenuView: View {
    // Definisi kategori pembelajaran. Setiap kategori memiliki nama, ikon, dan tujuan navigasi.
    // Menggunakan AnyView untuk fleksibilitas tipe tujuan navigasi.
    let categories: [(name: String, iconName: String, destination: AnyView)] = [
        ("Flashcards", "rectangle.stack.fill", AnyView(WatchOSFlashcardCategoriesView())),
        //("Quizzes", "questionmark.diamond.fill", AnyView(WatchOSQuizCategoriesView())), // Jika ada view Quiz
        ("Grammar", "book.fill", AnyView(WatchOSGrammarCategoriesView())),
        ("Writting", "pencil.and.outline", AnyView(WatchOSWritingCategoriesView())) // [DITAMBAHKAN]
    ]

    var body: some View {
        NavigationView { // Root view untuk navigasi.
            List {
                // Loop melalui setiap kategori untuk membuat baris di daftar.
                ForEach(categories, id: \.name) { category in
                    // NavigationLink untuk berpindah ke view destinasi saat baris diketuk.
                    NavigationLink(destination: category.destination) {
                        HStack(spacing: 12) { // Spasi antara ikon dan teks.
                            Image(systemName: category.iconName)
                                .font(.title3) // Sedikit disesuaikan untuk konsistensi
                                .foregroundColor(.white) // Ikon putih agar kontras dengan background biru
                                .frame(width: 40, height: 40, alignment: .center) // Ukuran frame ikon.
                                .background(Color.blue) // Background ikon solid biru
                                .clipShape(Circle()) // Bentuk ikon menjadi lingkaran.
                                
                            Text(category.name)
                                .font(.headline) // Font tebal untuk nama kategori.
                                .foregroundColor(.primary) // Warna teks utama.
                        }
                        .padding(.vertical, 10) // Sedikit mengurangi padding vertikal jika 12 terlalu banyak
                    }
                }
            }
            // Terapkan list style secara kondisional: .carousel untuk watchOS, .plain untuk lainnya.
            #if os(watchOS)
            .listStyle(.carousel) // Gaya daftar carousel khas watchOS.
            #else
            .listStyle(.plain)    // Gaya daftar standar untuk platform lain.
            #endif
            .navigationTitle("Belajar Korea") // Judul yang ditampilkan di navigation bar.
            .navigationBarTitleDisplayMode(.inline) // Tampilkan judul secara inline.
        }
    }
}

// MARK: - Preview
struct WatchOSKoreanMainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        WatchOSKoreanMainMenuView()
    }
}
