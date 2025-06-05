import SwiftUI

struct KoreanMainPageView: View { // Diubah dari JapaneseMainPageView
    @State private var currentIndex: Int = 0

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

                        HStack {
                            // TODO: Implement flag selection logic if needed for Korean
                            Button(action: {
                                // Placeholder for Korean flag or language selection
                                print("Korean Flag/Language selected")
                            }) {
                                // You can use an SF Symbol or a custom image for the Korean flag
                                Image(systemName: "flag.fill") // Placeholder icon
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            .padding(.horizontal, 16)


                            Spacer()

                            // TODO: Implement level selection logic if needed
                            Button("Level") {
                                print("Level button tapped")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        }
                        .padding(.bottom, 40)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Korean") // Diubah dari Japanese
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
                    .padding(.top, 20) // Adjusted for status bar
                    .padding(.bottom, 60)

                    // Rounded white background for courses
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.white)
                            .edgesIgnoringSafeArea(.bottom)

                        VStack(spacing: 2) {
                            Text("Choose your courses")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(.top, 30) // Give some space from the top edge

                            Text("Make sure you study daily!")
                                .font(.subheadline)
                                .foregroundColor(.blue.opacity(0.8))
                                .padding(.bottom, 10) // Add some space before carousel

                            // CarouselView for Korean courses
                            KoreanCourseCarouselView(currentIndex: $currentIndex) // Menggunakan KoreanCourseCarouselView

                            Spacer()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Carousel View for Korean Courses
struct KoreanCourseCarouselView: View { // Diubah nama struct dan tujuan navigasi
    @Binding var currentIndex: Int
    // Daftar kategori kursus tetap sama, namun tujuannya akan berbeda
    let courseCategories = ["Grammar", "Writing", "Quiz", "FlashCard", "Speaking","profile"]

    var body: some View {
        GeometryReader { outerProxy in
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(courseCategories.indices, id: \.self) { index in
                            GeometryReader { geo in
                                let midX = geo.frame(in: .global).midX
                                let screenMidX = outerProxy.size.width / 2
                                let distance = abs(screenMidX - midX)
                                let scale = max(1 - (distance / screenMidX / 3), 0.9)
                                let yOffset = distance < 30 ? -30 : 0

                                NavigationLink(destination: destinationView(for: courseCategories[index])) {
                                    // Menggunakan LanguageCourseCardView yang lebih generik
                                    LanguageCourseCardView(title: courseCategories[index])
                                }
                                .scaleEffect(scale)
                                .offset(y: CGFloat(yOffset))
                                .animation(.easeOut(duration: 0.3), value: yOffset)
                            }
                            .frame(width: 260, height: 340)
                        }
                    }
                    .padding(.horizontal, (outerProxy.size.width - 260) / 2) // Center the first and last card
                    .padding(.vertical, 40)
                }
            }
        }
        .frame(height: 380) // Adjusted height to better fit content
    }

    // Fungsi helper untuk menentukan tujuan navigasi untuk Bahasa Korea
    @ViewBuilder
    private func destinationView(for cardTitle: String) -> some View {
        switch cardTitle {
        case "Grammar":
            KoreanGrammarListView() // Arahkan ke list view Grammar Korea
        case "Writing":
            KoreanWritingListView() // Arahkan ke list view Writing Korea
        case "Quiz":
            KoreanQuizListView()    // Arahkan ke list view Quiz Korea
        case "FlashCard":
            KoreanFlashCardListView()// Arahkan ke list view FlashCard Korea
        case "Speaking":
            KoreanSpeakingCategoriesView()
        case "profile":
            ProfileView()
        default:
            Text("Content Not Found for \(cardTitle)")
        }
    }
}

// MARK: - Generic Card View (bisa dinamai LanguageCourseCardView)
// Ini adalah CourseCardView dari kode Anda, saya hanya mengganti namanya agar lebih generik
// Jika Anda sudah memiliki CourseCardView yang identik, Anda tidak perlu mendefinisikannya lagi.
struct LanguageCourseCardView: View {
    let title: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 10) // Adjusted shadow

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
                    .padding(.horizontal, 5)


                Text("Start")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.1)) // Softer background
                    .foregroundColor(.blue)
                    .cornerRadius(12)
            }
            .padding()
        }
        .frame(width: 260, height: 340)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.blue.opacity(0.7), lineWidth: 2) // Softer stroke
        )
    }

    private func iconName(for title: String) -> String {
        switch title {
        case "Grammar":
            return "book.closed.fill"
        case "Writing":
            return "pencil.and.ruler.fill" // Changed icon
        case "Quiz":
            return "questionmark.diamond.fill" // Changed icon
        case "FlashCard":
            return "rectangle.stack.fill" // Changed icon
        default:
            return "microphone.fill" // Default icon
        }
    }
}


struct KoreanMainPageView_Previews: PreviewProvider { 
    static var previews: some View {
        KoreanMainPageView()
    }
}
