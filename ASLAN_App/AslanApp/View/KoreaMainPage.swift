import SwiftUI

struct KoreanMainPageView: View {
    @State private var currentIndex: Int = 0
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // Detect size class

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
                                .font(horizontalSizeClass == .regular ? .title2 : .headline) // Larger on iPad
                                .foregroundColor(.white)
                            Spacer()
                        }

                        HStack {
                            Button(action: {
                                print("Korean Flag/Language selected")
                            }) {
                                Image(systemName: "flag.fill")
                                    .font(horizontalSizeClass == .regular ? .title3 : .body) // Larger icon content
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(
                                        top: horizontalSizeClass == .regular ? 10 : 6,
                                        leading: horizontalSizeClass == .regular ? 14 : 10,
                                        bottom: horizontalSizeClass == .regular ? 10 : 6,
                                        trailing: horizontalSizeClass == .regular ? 14 : 10
                                    ))
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            .padding(.horizontal, horizontalSizeClass == .regular ? 30 : 16) // More padding on iPad

                            Spacer()

                            Button("Level") { // Consider making this a Menu for iPad
                                print("Level button tapped")
                            }
                            .font(horizontalSizeClass == .regular ? .title3 : .body)
                            .padding(.horizontal, horizontalSizeClass == .regular ? 30 : 16)
                            .padding(.vertical, horizontalSizeClass == .regular ? 12 : 8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(horizontalSizeClass == .regular ? 15 : 10)
                            .foregroundColor(.white)
                        }
                        .padding(.bottom, horizontalSizeClass == .regular ? 60 : 40) // More bottom padding

                        VStack(alignment: .leading, spacing: horizontalSizeClass == .regular ? 8 : 2) {
                            Text("Korean")
                                .font(horizontalSizeClass == .regular ? .system(size: 60, weight: .bold) : .title) // Significantly larger on iPad
                                .bold()
                                .foregroundColor(.white)

                            Text("Let’s start your Journey!")
                                .font(horizontalSizeClass == .regular ? .title3 : .system(size: 14))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.top, horizontalSizeClass == .regular ? 20 : 12)
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 24)
                    .padding(.top, horizontalSizeClass == .regular ? 40 : 20) // More top padding
                    .padding(.bottom, horizontalSizeClass == .regular ? 80 : 60) // More bottom padding for header

                    // Rounded white background for courses
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 50 : 40) // Larger corner radius
                            .fill(Color.white)
                            .edgesIgnoringSafeArea(.bottom)

                        VStack(spacing: horizontalSizeClass == .regular ? 10 : 2) {
                            Text("Choose your courses")
                                .font(.system(size: horizontalSizeClass == .regular ? 34 : 26, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(.top, horizontalSizeClass == .regular ? 50 : 30)

                            Text("Make sure you study daily!")
                                .font(horizontalSizeClass == .regular ? .title3 : .subheadline)
                                .foregroundColor(.blue.opacity(0.8))
                                .padding(.bottom, horizontalSizeClass == .regular ? 30 : 10)

                            // CarouselView or GridView for Korean courses
                            KoreanCourseDisplayView(currentIndex: $currentIndex) // Changed name for clarity

                            Spacer()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            // For iPad, consider using NavigationSplitView at a higher level if this is a main navigation hub
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use Stack style to avoid sidebar on iPad by default here, unless desired
    }
}

// MARK: - Course Display View (Carousel for iPhone, Grid for iPad)
struct KoreanCourseDisplayView: View {
    @Binding var currentIndex: Int
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let courseCategories = ["Grammar", "Writing", "Quiz", "FlashCard"]
    // Define adaptive columns for iPad grid
    private var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 260, maximum: 320), spacing: 20)] // Cards will be 260-320 wide
    }

    var body: some View {
        if horizontalSizeClass == .regular { // iPad: Use a Grid
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 30) { // Increased spacing for iPad grid
                    ForEach(courseCategories.indices, id: \.self) { index in
                        NavigationLink(destination: destinationView(for: courseCategories[index])) {
                            LanguageCourseCardView(title: courseCategories[index])
                                .frame(height: 360) // Give cards a consistent height in the grid
                        }
                    }
                }
                .padding(.horizontal, 30) // Horizontal padding for the grid
                .padding(.vertical, 20)
            }
        } else { // iPhone: Use the Carousel
            GeometryReader { outerProxy in
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(courseCategories.indices, id: \.self) { index in
                                GeometryReader { geo in
                                    let midX = geo.frame(in: .global).midX
                                    let screenMidX = outerProxy.size.width / 2
                                    let distance = abs(screenMidX - midX)
                                    // Make scaling less aggressive, more items visible
                                    let scale = max(1 - (distance / screenMidX / 4), 0.85)
                                    let yOffset = distance < outerProxy.size.width / 4 ? -20 : 0 // Adjust active region for yOffset

                                    NavigationLink(destination: destinationView(for: courseCategories[index])) {
                                        LanguageCourseCardView(title: courseCategories[index])
                                    }
                                    .scaleEffect(scale)
                                    .offset(y: CGFloat(yOffset))
                                    .animation(.easeOut(duration: 0.3), value: yOffset)
                                    .animation(.easeOut(duration: 0.3), value: scale) // Animate scale too
                                }
                                .frame(width: 260, height: 340) // Original card size for carousel
                            }
                        }
                        .padding(.horizontal, (outerProxy.size.width - 260) / 2)
                        .padding(.vertical, 40)
                    }
                }
            }
            .frame(height: 380) // Original carousel height
        }
    }

    @ViewBuilder
    private func destinationView(for cardTitle: String) -> some View {
        switch cardTitle {
        case "Grammar": KoreanGrammarListView()
        case "Writing": KoreanWritingListView()
        case "Quiz": KoreanQuizListView()
        case "FlashCard": KoreanFlashCardListView()
        default: Text("Content Not Found for \(cardTitle)")
        }
    }
}

// MARK: - Generic Language Course Card View
struct LanguageCourseCardView: View {
    let title: String
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 35 : 30)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 8) // Slightly adjusted shadow

            VStack(spacing: horizontalSizeClass == .regular ? 25 : 20) { // More spacing on iPad
                Image(systemName: iconName(for: title))
                    .resizable()
                    .scaledToFit()
                    .frame(width: horizontalSizeClass == .regular ? 90 : 72, height: horizontalSizeClass == .regular ? 90 : 72) // Larger icon
                    .foregroundColor(.blue)

                Text(title)
                    .font(horizontalSizeClass == .regular ? .title : .title2) // Larger title
                    .bold()
                    .foregroundColor(.blue)

                Text("Let’s start your Journey!")
                    .font(horizontalSizeClass == .regular ? .body : .footnote) // Larger subtitle
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)

                Text("Start")
                    .font(horizontalSizeClass == .regular ? .title3 : .headline) // Larger button text
                    .padding(.horizontal, horizontalSizeClass == .regular ? 30 : 24)
                    .padding(.vertical, horizontalSizeClass == .regular ? 14 : 10)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(horizontalSizeClass == .regular ? 16 : 12)
            }
            .padding(horizontalSizeClass == .regular ? 25 : 20) // More padding inside card
        }
        // The frame is now applied by the container (GridItem or Carousel's .frame modifier)
        // Remove fixed frame from here to allow flexibility
        .overlay(
            RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 35 : 30)
                .stroke(Color.blue.opacity(horizontalSizeClass == .regular ? 0.6 : 0.7), lineWidth: horizontalSizeClass == .regular ? 3 : 2)
        )
    }

    private func iconName(for title: String) -> String {
        switch title {
        case "Grammar": return "book.closed.fill"
        case "Writing": return "pencil.and.ruler.fill"
        case "Quiz": return "questionmark.diamond.fill"
        case "FlashCard": return "rectangle.stack.fill"
        default: return "graduationcap.fill"
        }
    }
}

// Dummy Destination Views for Compilation
//struct KoreanGrammarListView: View { var body: some View { Text("Korean Grammar List") .font(.largeTitle) } }
//struct KoreanWritingListView: View { var body: some View { Text("Korean Writing List") .font(.largeTitle) } }
//struct KoreanQuizListView: View { var body: some View { Text("Korean Quiz List") .font(.largeTitle) } }
//struct KoreanFlashCardListView: View { var body: some View { Text("Korean FlashCard List") .font(.largeTitle) } }


struct KoreanMainPageView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview for iPhone
        KoreanMainPageView()
            .previewDevice("iPhone 14 Pro")
            .previewDisplayName("iPhone")

        // Preview for iPad
        KoreanMainPageView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewDisplayName("iPad Pro 12.9")
            .navigationViewStyle(StackNavigationViewStyle()) // Ensure preview uses stack style if you set it

        KoreanMainPageView()
            .previewDevice("iPad mini (6th generation)")
            .previewDisplayName("iPad mini")
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
