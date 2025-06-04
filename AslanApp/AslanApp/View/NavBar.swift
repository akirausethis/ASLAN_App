// Tambahkan import untuk view yang akan dinavigasikan
import SwiftUI

struct AnimatedNavbar: View {
    @Namespace var animation
    @State private var selectedTab: Tab = .home
    @State private var circlePosition: CGFloat = 0

    // Enum Tab tetap sama
    enum Tab: String, CaseIterable {
        case home = "house.fill"
        case progress = "chart.bar.fill"
        case chat = "message.fill" // Ini mungkin akan menjadi tab untuk Quiz
        case profile = "person.fill"

        // Helper untuk mendapatkan view yang sesuai
        @ViewBuilder
        func view(for tab: Tab) -> some View {
            // Mengganti NavigationView dengan NavigationStack (iOS 16+)
            // Ini akan memberikan perilaku navigasi yang lebih robust dan modern.
            // Setiap tab memiliki stack navigasinya sendiri.
            NavigationStack { //
                switch tab {
                case .home:
                    JapaneseMainPageView() // Pastikan JapaneseMainPageView bisa diakses
                case .progress:
                    ProgressPageView() // Pastikan ProgressPageView bisa diakses
                case .chat: // Anggap ini adalah tab untuk Quizzes
                    JapaneseQuizListView() // Mengarahkan tab 'Chat' ke JapaneseQuizListView
                case .profile:
                    Text("Profile View (Dummy)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.1)) // Contoh background
                        .navigationTitle("Profile") // Tambahkan judul navigasi
                }
            }
            // .navigationViewStyle(StackNavigationViewStyle()) // Tidak diperlukan lagi dengan NavigationStack
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // View konten akan ditampilkan di sini, di atas Navbar
            selectedTab.view(for: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Pastikan view mengisi ruang

            VStack { // VStack untuk Navbar
                Spacer() // Mendorong Navbar ke bawah
                ZStack {
                    NavbarBackgroundShape(circlePosition: circlePosition)
                        .fill(Color.blue) // Warna background Navbar
                        .frame(height: 80) // Tinggi Navbar
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5) // Tambahkan shadow jika diinginkan
                        .animation(.easeInOut(duration: 0.4), value: circlePosition)

                    HStack(spacing: 0) {
                        ForEach(Tab.allCases, id: \.self) { tab in
                            Spacer()
                            VStack { // VStack untuk ikon dan animasi lingkaran
                                ZStack {
                                    if selectedTab == tab {
                                        Circle()
                                            .fill(Color.white) // Warna lingkaran terpilih
                                            .matchedGeometryEffect(id: "circle", in: animation)
                                            .frame(width: 65, height: 65)
                                            .offset(y: -20) // Sesuaikan offset lingkaran
                                        Image(systemName: tab.rawValue)
                                            .font(.title2)
                                            .foregroundColor(Color.blue) // Warna ikon terpilih
                                            .offset(y: -20) // Sesuaikan offset ikon
                                            .transition(.scale(scale: 0.5, anchor: .bottom).combined(with: .opacity))
                                    } else {
                                        Image(systemName: tab.rawValue)
                                            .font(.title2)
                                            .foregroundColor(Color.white) // Warna ikon tidak terpilih
                                            .transition(.opacity)
                                    }
                                }
                            }
                            .frame(width: 70, height: 80) // Ukuran area tap per item
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    selectedTab = tab
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom) // Agar Navbar menempel di bawah, melewati safe area jika perlu
            .onAppear {
                if let initialIndex = Tab.allCases.firstIndex(of: selectedTab) {
                     circlePosition = calculateCirclePosition(for: initialIndex, in: UIScreen.main.bounds.width)
                }
            }
            .onChange(of: selectedTab) { oldTab, newTab in
                if let newIndex = Tab.allCases.firstIndex(of: newTab) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        circlePosition = calculateCirclePosition(for: newIndex, in: UIScreen.main.bounds.width)
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom) // Hindari navbar naik saat keyboard muncul
    }

    private func calculateCirclePosition(for tabIndex: Int, in totalWidth: CGFloat) -> CGFloat {
        return CGFloat(tabIndex)
    }
}

extension AnimatedNavbar.Tab {
    var index: Int {
        switch self {
        case .home: return 0
        case .progress: return 1
        case .chat: return 2 // Quiz tab index
        case .profile: return 3
        }
    }
}

struct NavbarBackgroundShape: Shape {
    var circlePosition: CGFloat
    var animatableData: CGFloat {
        get { circlePosition }
        set { circlePosition = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cutoutRadius: CGFloat = 90
        let cutoutDepth: CGFloat = -55
        let cornerRadius: CGFloat =  0

        let tabWidth = rect.width / CGFloat(AnimatedNavbar.Tab.allCases.count)
        let circleCenterX = tabWidth * circlePosition + tabWidth / 2

        let cutoutStart = circleCenterX - cutoutRadius
        let cutoutEnd = circleCenterX + cutoutRadius

        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addLine(to: CGPoint(x: cutoutStart, y: rect.minY))
        let controlPoint1 = CGPoint(x: cutoutStart + cutoutRadius * 0.4, y: rect.minY)
        let midPoint = CGPoint(x: circleCenterX, y: rect.minY - cutoutDepth)
        let controlPoint2 = CGPoint(x: circleCenterX - cutoutRadius * 0.3, y: rect.minY - cutoutDepth)
        path.addCurve(to: midPoint, control1: controlPoint1, control2: controlPoint2)
        let controlPoint3 = CGPoint(x: circleCenterX + cutoutRadius * 0.3, y: rect.minY - cutoutDepth)
        let controlPoint4 = CGPoint(x: cutoutEnd - cutoutRadius * 0.4, y: rect.minY)
        path.addCurve(to: CGPoint(x: cutoutEnd, y: rect.minY), control1: controlPoint3, control2: controlPoint4)
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        if cornerRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        }
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        if cornerRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        }
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        if cornerRadius > 0 {
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        }
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        if cornerRadius > 0 {
             path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        }
        path.closeSubpath()
        return path
    }
}


#Preview {
    AnimatedNavbar()
        .environmentObject(ProgressViewModel()) // Tambahkan ini
}
