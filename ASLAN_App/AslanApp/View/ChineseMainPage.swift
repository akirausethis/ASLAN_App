import SwiftUI

struct ChineseMainPageView: View {
    @State private var currentIndex: Int = 0

    var body: some View {
        // Penting: Bungkus seluruh View dengan NavigationView
        NavigationView {
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
                        .padding(.bottom, 40)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Chinese")
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

                            // Pass a binding to the activeCourseId if needed,
                            // or handle navigation directly in CourseCardView
                            CarouselView(currentIndex: $currentIndex) // No change here, CarouselView handles sub-navigation

                            Spacer()
                        }
                        .padding(.top, 40)
                    }
                }
            }
            // Sembunyikan navigation bar default dari NavigationView
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Carousel View
struct CarouselView: View {
    @Binding var currentIndex: Int
    let cards = ["Grammar", "Writing", "Quiz", "FlashCard"] // Sesuaikan dengan nama yang ingin Anda navigasi

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

                                let scale = max(1 - (distance / screenMidX / 3), 0.9) // Skala lebih moderat
                                let yOffset = distance < 30 ? -30 : 0

                                // Penting: Bungkus CourseCardView dengan NavigationLink
                                NavigationLink(destination: destinationView(for: cards[index])) {
                                    CourseCardView(title: cards[index])
                                }
                                .scaleEffect(scale)
                                .offset(y: CGFloat(yOffset))
                                .animation(.easeOut(duration: 0.3), value: yOffset) //
                            }
                            .frame(width: 260, height: 340) //
                        }
                    }
                    .padding(.horizontal, 32) //
                    .padding(.vertical, 40) // space agar naik nggak kepotong //
                }
            }
        }
        .frame(height: 360) //
    }

    // Fungsi helper untuk menentukan tujuan navigasi
    @ViewBuilder
    private func destinationView(for cardTitle: String) -> some View {
        switch cardTitle {
        case "Grammar":
            ChineseGrammarListView() // <<< TAMBAHKAN INI
        case "Writing":
            ChineseWritingListView() // Ini adalah View Writing yang sudah kita buat //
        case "Quiz":
            Text("Quiz Page (Coming Soon)") // Ganti dengan View Quiz Anda //
        case "FlashCard":
            ChineseFlashCardListView() // Ganti dengan View FlashCard Anda //
        default:
            Text("Content Not Found") //
        }
    }
}

// MARK: - Card View
struct CourseCardView: View {
    let title: String

    var body: some View {
        ZStack {
            // Shadow hanya untuk background
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.5), radius: 1, x: 0, y: 15)

            VStack(spacing: 20) {
                // Icon berdasarkan title
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

                // Tombol "Start" sekarang adalah bagian dari NavigationLink di CarouselView,
                // jadi tidak perlu NavigationLink lagi di sini.
                Text("Start")
                    .font(.headline) // Ubah menjadi Text agar tidak ada aksi tombol
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.blue) // Sesuaikan warna teks
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

    // Fungsi helper untuk menentukan icon
    private func iconName(for title: String) -> String {
        switch title {
        case "Grammar":
            return "book.closed.fill"
        case "Writing":
            return "pencil.tip.crop.circle.fill"
        case "Quiz":
            return "questionmark.circle.fill"
        case "FlashCard":
            return "text.book.closed.fill"
        default:
            return "questionmark"
        }
    }
}


struct CoursePageView_Previews: PreviewProvider {
    static var previews: some View {
        ChineseMainPageView()
    }
}
