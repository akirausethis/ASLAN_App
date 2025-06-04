import SwiftUI

struct JapaneseMainPageView: View {
    @ObservedObject var userViewModel: UserViewModel // 1. Pastikan ViewModel diterima
    @State private var currentIndex: Int = 0

    // 2. Fungsi pembantu untuk nama aset bendera
    private func flagAssetName() -> String {
        let language = userViewModel.onboardingLanguage ?? userViewModel.currentLanguagePreference //
        switch language {
        case "Japan":
            return "japan_flag" // Pastikan aset "japan_flag" ada
        case "Korea":
            return "korea_flag" // Pastikan aset "korea_flag" ada
        case "China":
            return "china_flag" // Pastikan aset "china_flag" ada
        default:
            return "globe" // Placeholder jika bahasa tidak diketahui atau aset tidak ada
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Spacer()
                            Text("Courses")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }

                        // 3. Modifikasi HStack untuk menampilkan bendera dan level
                        HStack {
                            // Tampilkan Bendera (kiri)
                            Image(flagAssetName()) // Menggunakan nama aset dari fungsi pembantu
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 28) // Sesuaikan ukuran bendera
                                .clipShape(RoundedRectangle(cornerRadius: 4)) // Sedikit lengkungan di sudut
                                .padding(6) // Sedikit padding di dalam background
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)


                            Spacer()

                            // Tampilkan Level (kanan)
                            Text(userViewModel.onboardingLevel ?? "Level") //
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 40)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Japanese")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)

                            Text("Let’s start your Journey!")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.top, 12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 60)

                    // Rounded putih
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.white)
                            .edgesIgnoringSafeArea(.bottom)

                        VStack(spacing: 2) {
                            Text("Choose your courses")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.blue)

                            Text("Make sure you study daily!")
                                .font(.subheadline)
                                .foregroundColor(.blue.opacity(0.8))

                            CarouselView(currentIndex: $currentIndex, userViewModel: userViewModel) // Teruskan userViewModel jika Carousel perlu

                            Spacer()
                        }
                        .padding(.top, 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack) // Untuk konsistensi navigasi
    }
}

// MARK: - Carousel View
// Modifikasi CarouselView untuk menerima UserViewModel jika diperlukan untuk navigasi detail
struct CarouselView: View {
    @Binding var currentIndex: Int
    @ObservedObject var userViewModel: UserViewModel // Tambahkan jika view tujuan memerlukan UserViewModel

    let cards = ["Grammar", "Writing", "Quiz", "FlashCard", "Spelling"]

    var body: some View {
        GeometryReader { outerProxy in
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(cards.indices, id: \.self) { index in
                            GeometryReader { geo in
                                let midX = geo.frame(in: .global).midX
                                let screenMidX = outerProxy.size.width / 2
                                let distance = abs(screenMidX - midX)
                                
                                let scale = max(1 - (distance / screenMidX / 3), 0.9)
                                let yOffset = distance < 30 ? -30 : 0
                                
                                // Teruskan userViewModel ke destinationView jika dibutuhkan
                                NavigationLink(destination: destinationView(for: cards[index], userViewModel: userViewModel)) {
                                    CourseCardView(title: cards[index])
                                }
                                .scaleEffect(scale)
                                .offset(y: CGFloat(yOffset))
                                .animation(.easeOut(duration: 0.3), value: yOffset)
                                .animation(.easeOut(duration: 0.3), value: scale)
                            }
                            .frame(width: 260, height: 340)
                        }
                    }
                    .padding(.horizontal, (outerProxy.size.width - 260) / 2)
                    .padding(.vertical, 40)
                }
            }
        }
        .frame(height: 380)
    }
    
    @ViewBuilder
    private func destinationView(for cardTitle: String, userViewModel: UserViewModel) -> some View {
        // Jika view tujuan memerlukan UserViewModel, teruskan seperti ini
        // Contoh: JapaneseGrammarListView(userViewModel: userViewModel)
        switch cardTitle {
        case "Grammar":
            JapaneseGrammarListView() // Ganti dengan JapaneseGrammarListView(userViewModel: userViewModel) jika perlu
        case "Writing":
            JapaneseWritingListView()
        case "Quiz":
            JapaneseQuizListView()
        case "FlashCard":
            JapaneseFlashCardListView()
        case "Spelling":
            JapaneseSpellingListView()
        default:
            Text("Content Not Found")
        }
    }
}

// MARK: - Card View (DIPINDAHKAN KE LUAR CarouselView)
struct CourseCardView: View {
    let title: String
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 5) // Penyesuaian shadow
            
            VStack(spacing: 20) {
                Image(systemName: iconName(for: title))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.blue)
                
                Text("Let’s start your Journey!")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Start")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(12)
            }
            .padding()
        }
        .frame(width: 260, height: 340)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.blue.opacity(0.5), lineWidth: 1.5) // Penyesuaian stroke
        )
    }
        
    private func iconName(for title: String) -> String {
        switch title {
        case "Grammar": return "book.closed.fill"
        case "Writing": return "pencil.tip.crop.circle.fill"
        case "Quiz": return "questionmark.circle.fill"
        case "FlashCard": return "text.book.closed.fill"
        case "Spelling": return "speaker.wave.2.fill"
        default: return "questionmark"
        }
    }
}
    
// 4. Update PreviewProvider
struct JapaneseMainPageView_Previews: PreviewProvider { // Mengganti nama dari CoursePageView_Previews
    static var previews: some View {
        let mockUserViewModel = UserViewModel()
        mockUserViewModel.onboardingLanguage = "Japan" // Data mock untuk bahasa
        mockUserViewModel.onboardingLevel = "Beginner" // Data mock untuk level
        // Anda bisa juga set currentLanguagePreference jika itu yang lebih relevan setelah login
        // mockUserViewModel.currentLanguagePreference = "Japan"

        return JapaneseMainPageView(userViewModel: mockUserViewModel)
    }
}

