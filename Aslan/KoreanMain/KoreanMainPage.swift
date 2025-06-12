import SwiftUI

struct KoreanMainPageView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var userViewModel: UserViewModel
    @State private var currentIndex: Int = 0
    
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
        ZStack {
            themeManager.accentColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header (Tidak ada perubahan)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Spacer()
                        Text("Courses")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }

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
                    .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Korean")
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
                .padding(.bottom, 40)

                // --- AREA KONTEN PUTIH YANG DIPERBAIKI ---
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color(UIColor.systemGroupedBackground)) // Warna lebih adaptif
                        .edgesIgnoringSafeArea(.bottom)

                    // 1. Jadikan seluruh area ini sebagai ScrollView
                    ScrollView {
                        VStack(spacing: 2) {
                            Text("Choose your courses")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(themeManager.accentColor)
                                .padding(.top, 40)

                            Text("Make sure you study daily!")
                                .font(.subheadline)
                                .foregroundColor(themeManager.accentColor.opacity(0.8))
                                .padding(.bottom, 20) // Beri jarak sebelum konten utama

                            // Tampilan adaptif tetap di sini
                            if horizontalSizeClass == .regular {
                                iPadCourseGridView()
                            } else {
                                CarouselView(currentIndex: $currentIndex)
                            }
                        }
                        // Beri padding di bawah untuk ruang navbar
                        .padding(.bottom, 120)
                    }
                    // Clip ScrollView agar sesuai dengan bentuk RoundedRectangle
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                }
            }
        }
        .navigationBarHidden(true)
    }
}


// --- VIEW GRID UNTUK IPAD YANG DIPERBAIKI ---
struct iPadCourseGridView: View {
    let cards = ["Grammar", "Writing", "FlashCard", "Speaking"]
    
    // Gunakan .adaptive agar kolom bisa menyesuaikan dengan orientasi layar
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 260), spacing: 25)
    ]

    var body: some View {
        // 2. Hapus ScrollView dari sini karena sudah ada di parent view
        LazyVGrid(columns: columns, spacing: 25) {
            ForEach(cards, id: \.self) { cardTitle in
                NavigationLink(destination: destinationView(for: cardTitle)) {
                    CourseCardView(title: cardTitle)
                }
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical)
    }
    
    @ViewBuilder
    private func destinationView(for cardTitle: String) -> some View {
        switch cardTitle {
        case "Grammar": KoreanGrammarListView()
        case "Writing": KoreanWritingListView()
        case "FlashCard": KoreanFlashCardListView()
        case "Speaking": KoreanSpeakingCategoriesView()
        default: Text("Content Not Found")
        }
    }
}


// Sisa kode di file ini (CarouselView, CourseCardView, Preview) tidak perlu diubah.
// ...
struct CarouselView: View {
    @Binding var currentIndex: Int
    let cards = ["Grammar", "Writing", "FlashCard", "Speaking"]

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
                                
                                NavigationLink(destination: destinationView(for: cards[index])) {
                                    CourseCardView(title: cards[index])
                                }
                                .scaleEffect(scale)
                                .offset(y: CGFloat(yOffset))
                                .animation(.easeOut(duration: 0.3), value: yOffset)
                            }
                            .frame(width: 260, height: 340)
                        }
                    }
                    .padding(.horizontal, (outerProxy.size.width - 260) / 2)
                    .padding(.vertical, 35)
                }
            }
        }
        .frame(height: 380)
    }
    
    @ViewBuilder
    private func destinationView(for cardTitle: String) -> some View {
        switch cardTitle {
        case "Grammar": KoreanGrammarListView()
        case "Writing": KoreanWritingListView()
        case "FlashCard": KoreanFlashCardListView()
        case "Speaking": KoreanSpeakingCategoriesView()
        default: Text("Content Not Found")
        }
    }
}

struct CourseCardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let title: String
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 4, y: 4)
            
            VStack(spacing: 20) {
                Image(systemName: iconName(for: title))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .foregroundColor(themeManager.accentColor)
                
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(themeManager.accentColor)
                
                Text("Let’s start your Journey!")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("Start")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(themeManager.accentColor.opacity(0.1))
                    .foregroundColor(themeManager.accentColor)
                    .cornerRadius(12)
            }
            .padding()
        }
        .frame(width: 260, height: 340)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(themeManager.accentColor, lineWidth: 2)
        )
    }
    
    private func iconName(for title: String) -> String {
        switch title {
        case "Grammar": return "book.closed.fill"
        case "Writing": return "pencil.tip.crop.circle.fill"
        case "Quiz": return "questionmark.circle.fill"
        case "FlashCard": return "rectangle.stack.fill"
        case "Speaking": return "speaker.wave.2.fill"
        default: return "questionmark"
        }
    }
}
    
struct KoreanMainPageView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUserViewModel = UserViewModel()
        let mockProgressViewModel = ProgressViewModel()

        mockUserViewModel.currentLanguagePreference = "Korea"
        mockUserViewModel.currentUsername = "Preview User"
        mockUserViewModel.onboardingLevel = "Beginner"

        return NavigationView {
            KoreanMainPageView(userViewModel: mockUserViewModel)
        }
        .environmentObject(mockUserViewModel)
        .environmentObject(mockProgressViewModel)
    }
}
