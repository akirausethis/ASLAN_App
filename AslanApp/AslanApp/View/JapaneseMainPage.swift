import SwiftUI

struct JapaneseMainPageView: View {
    @State private var currentIndex: Int = 0

    var body: some View {
        // Penting: Hapus NavigationView dari sini.
        // NavigationView akan diatur di level AnimatedNavbar atau ContentView.
        ZStack {
            // Background biru
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

                    HStack {
                        Button("FLAG") {} // TODO: Add actual flag selection logic
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)

                        Spacer()

                        Button("Level") {} // TODO: Add actual level selection logic
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Japanese") // SEBELUMNYA "Your Language"
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

                        CarouselView(currentIndex: $currentIndex) // CarouselView dipanggil di sini

                        Spacer()
                    }
                    .padding(.top, 40)
                    // Menambahkan padding bawah untuk CarouselView
                    .padding(.bottom, 80 + 20) // Estimasi tinggi Navbar + sedikit padding ekstra
                }
            }
        }
        .navigationBarHidden(true) // Tetap sembunyikan NavigationBar di halaman utama ini
    }
}

// MARK: - Carousel View
struct CarouselView: View {
    @Binding var currentIndex: Int
    // KESALAHAN ADA DI SINI: "Spelling" belum ditambahkan ke array cards
    // Mengubah array cards: Menghapus "Quiz" karena sudah ada di Navbar
    let cards = ["Grammar", "Writing", "FlashCard", "Spelling"] //

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
                                
                                // NavigationLink sekarang akan berfungsi karena ada NavigationView di level yang lebih tinggi
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
                    .padding(.horizontal, 32)
                    .padding(.vertical, 20)
                }
            }
        }
        .frame(height: 360)
    }
    
    @ViewBuilder
    private func destinationView(for cardTitle: String) -> some View {
        switch cardTitle {
        case "Grammar":
            JapaneseGrammarListView()
        case "Writing":
            JapaneseWritingListView()
        case "FlashCard":
            JapaneseFlashCardListView()
        case "Spelling":
            JapaneseSpellingListView()
        default:
            Text("Content Not Found")
        }
    }
    
    // struct CourseCardView dipindahkan ke luar CarouselView agar bisa diakses oleh JapaneseMainPageView_Previews
}

// MARK: - Card View (DIPINDAHKAN KE LUAR CarouselView)
struct CourseCardView: View {
    let title: String
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.5), radius: 1, x: 0, y: 15)
            
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
                
                Text("Start")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.blue)
                    .cornerRadius(12)
            }
            .padding()
            .frame(width: 260, height: 340)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.blue, lineWidth: 2.5)
            )
        }
        .frame(width: 260, height: 340)
    }
        
    private func iconName(for title: String) -> String {
        switch title {
        case "Grammar":
            return "book.closed.fill"
        case "Writing":
            return "pencil.tip.crop.circle.fill"
        case "Quiz": // Ini tetap ada karena `CourseCardView` adalah komponen generik. Hanya panggilannya yang diubah.
            return "questionmark.circle.fill"
        case "FlashCard":
            return "text.book.closed.fill"
        case "Spelling":
            return "speaker.wave.2.fill"
        default:
            return "questionmark"
        }
    }
}
    
struct CoursePageView_Previews: PreviewProvider {
    static var previews: some View {
        // Bungkus dengan NavigationView agar preview NavigationLink berfungsi
        NavigationView {
            JapaneseMainPageView()
        }
        .environmentObject(ProgressViewModel()) // Tambahkan ini jika perlu di preview
    }
}
