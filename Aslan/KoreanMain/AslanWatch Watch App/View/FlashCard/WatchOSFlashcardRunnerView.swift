import SwiftUI

// View yang mengelola dan menampilkan sesi flashcard.
// Pengguna dapat menggeser atau menggunakan Digital Crown untuk bernavigasi antar kartu.
struct WatchOSFlashcardRunnerView: View {
    // Kursus yang dipilih pengguna, berisi info seperti judul.
    let course: KoreanCourse
    
    // State untuk menyimpan daftar kartu flashcard yang akan ditampilkan.
    // Menggunakan `any CharacterCard` untuk fleksibilitas tipe kartu.
    @State private var flashcards: [any KoreanCharacterCard] = []
    // State untuk melacak indeks kartu yang sedang ditampilkan.
    @State private var currentIndex: Int = 0

    // State untuk interaksi dengan Digital Crown.
    @State private var crownValue: Double = 0.0

    var body: some View {
        VStack(spacing: 5) { // Mengurangi spasi antar elemen utama.
            if flashcards.isEmpty {
                // Tampilkan pesan ini jika kartu belum dimuat.
                Text("Memuat Kartu...")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .onAppear(perform: loadFlashcards) // Panggil loadFlashcards saat teks ini muncul.
            } else {
                // Informasi progres: nomor kartu saat ini / total kartu.
                Text("\(currentIndex + 1) dari \(flashcards.count)")
                    .font(.system(size: 12, weight: .medium)) // Font lebih kecil dan medium weight.
                    .foregroundColor(.secondary) // Warna sekunder agar tidak terlalu menonjol.
                    .padding(.bottom, 3)

                // TabView digunakan untuk membuat efek geser halaman (swipe).
                TabView(selection: $currentIndex) {
                    // Loop melalui semua kartu yang telah dimuat.
                    ForEach(flashcards.indices, id: \.self) { index in
                        // Tampilkan setiap kartu menggunakan WatchOSSingleFlashcardView.
                        WatchOSSingleFlashcardView(card: flashcards[index])
                            .tag(index) // Tag penting agar TabView dapat mengelola seleksi.
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // Sembunyikan indikator halaman default TabView.
                .focusable(true) // Memungkinkan view menerima fokus untuk input (misalnya, Digital Crown).
                
                // Terapkan interaksi Digital Crown hanya jika dikompilasi untuk watchOS.
                #if os(watchOS)
                .digitalCrownRotation(
                    $crownValue, // Binding ke nilai rotasi crown.
                    from: 0,      // Nilai minimum rotasi.
                    through: Double(flashcards.count > 0 ? flashcards.count - 1 : 0), // Nilai maksimum, berdasarkan jumlah kartu.
                    by: 1,        // Setiap langkah rotasi mengubah nilai sebesar 1.
                    sensitivity: .medium, // Sensitivitas rotasi.
                    isContinuous: false,  // Rotasi tidak berlanjut setelah mencapai batas.
                    isHapticFeedbackEnabled: true // Aktifkan feedback haptic.
                )
                .onChange(of: crownValue) { newValue in
                    // Ketika nilai crown berubah, update currentIndex.
                    let newIndex = Int(newValue.rounded()) // Bulatkan nilai crown ke integer terdekat.
                    // Pastikan newIndex valid sebelum mengupdate currentIndex.
                    if newIndex >= 0 && newIndex < flashcards.count {
                        currentIndex = newIndex
                    }
                }
                #endif
            }
        }
        .navigationTitle(course.title) // Atur judul navigasi bar dari judul kursus.
        .navigationBarTitleDisplayMode(.inline) // Tampilkan judul secara inline.
        .onAppear {
            // Muat flashcards saat view pertama kali muncul jika belum ada.
            if flashcards.isEmpty {
                loadFlashcards()
            }
            // Sinkronkan nilai crownValue dengan currentIndex saat view muncul.
            // Ini penting jika pengguna kembali ke view ini.
            crownValue = Double(currentIndex)
        }
    }

    // Fungsi untuk memuat flashcard berdasarkan kursus yang dipilih.
    func loadFlashcards() {
        // Panggil fungsi dari KoreanCharacterData untuk mendapatkan kartu yang relevan.
        // Ini menggunakan model data yang di-share dari iOS.
        self.flashcards = KoreanCharacterData.getFlashcardsForCourse(course.title)
        
        // Reset currentIndex dan crownValue ke awal.
        if !self.flashcards.isEmpty {
            self.currentIndex = 0
            self.crownValue = 0
        } else {
            // Jika tidak ada kartu yang dimuat, pastikan state tetap konsisten.
            self.currentIndex = 0
            self.crownValue = 0
            print("Peringatan: Tidak ada flashcard yang dimuat untuk kursus '\(course.title)'. Periksa logika di KoreanCharacterData.getFlashcardsForCourse.")
        }
    }
}
