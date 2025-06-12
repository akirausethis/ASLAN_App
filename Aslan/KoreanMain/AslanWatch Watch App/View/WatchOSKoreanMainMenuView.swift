import SwiftUI

// Tampilan menu utama untuk watchOS dengan UI yang diperbarui
struct WatchOSKoreanMainMenuView: View {
    
    let categories: [(name: String, iconName: String, color: Color, destination: AnyView)] = [
        ("Flashcards", "rectangle.stack.fill", .blue, AnyView(WatchOSFlashcardCategoriesView())),
        ("Grammar", "book.fill", .green, AnyView(WatchOSGrammarCategoriesView())),
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.name) { category in
                    NavigationLink(destination: category.destination) {
                        // --- PERUBAHAN UTAMA LAYOUT DI SINI ---
                        VStack(spacing: 8) {
                            Spacer()
                            // 1. Ikon dibuat lebih besar dan berwarna
                            Image(systemName: category.iconName)
                                .font(.system(size: 40, weight: .light))
                                .foregroundColor(category.color)
                                .shadow(color: .black.opacity(0.3), radius: 3, y: 2) // Tambah shadow lembut

                            // 2. Teks di bawah ikon
                            Text(category.name)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .frame(height: 125) // Memberi tinggi yang konsisten untuk setiap item
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            // Menggunakan .carousel untuk efek geser yang modern di watchOS
            #if os(watchOS)
            .listStyle(.carousel)
            #else
            .listStyle(.plain)
            #endif
            .navigationTitle("Belajar Jepang")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
