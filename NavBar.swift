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
        case chat = "message.fill"
        case profile = "person.fill"

        // Helper untuk mendapatkan view yang sesuai
        @ViewBuilder
        func view(for tab: Tab) -> some View {
            switch tab {
            case .home:
                JapaneseMainPageView() // Pastikan JapaneseMainPageView bisa diakses
            case .progress:
                ProgressPageView() // Pastikan ProgressPageView bisa diakses
            case .chat:
                Text("Chat View (Dummy)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.1)) // Contoh background
            case .profile:
                Text("Profile View (Dummy)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.1)) // Contoh background
            }
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // View konten akan ditampilkan di sini, di atas Navbar
            selectedTab.view(for: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Pastikan view mengisi ruang

            // Bagian bawah adalah Navbar yang sudah ada
            // Color(.systemGray6).ignoresSafeArea() // Ini mungkin tidak diperlukan lagi jika view konten punya background sendiri

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
                                    // `circlePosition` akan dihitung ulang berdasarkan index tab
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom) // Agar Navbar menempel di bawah, melewati safe area jika perlu
            .onAppear {
                // Inisialisasi posisi lingkaran saat view muncul
                // Hitung posisi berdasarkan index tab yang terpilih
                if let initialIndex = Tab.allCases.firstIndex(of: selectedTab) {
                     circlePosition = calculateCirclePosition(for: initialIndex, in: UIScreen.main.bounds.width)
                }
            }
            .onChange(of: selectedTab) { oldTab, newTab in
                 // Hitung ulang posisi lingkaran saat tab berubah
                if let newIndex = Tab.allCases.firstIndex(of: newTab) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        circlePosition = calculateCirclePosition(for: newIndex, in: UIScreen.main.bounds.width)
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom) // Hindari navbar naik saat keyboard muncul
    }

    // Fungsi helper untuk menghitung posisi X tengah untuk NavbarBackgroundShape
    // Anda mungkin perlu menyesuaikan ini jika `NavbarBackgroundShape` tidak lagi menggunakan `CGFloat(tab.index)` secara langsung
    // atau jika Anda ingin lebih presisi. Untuk sekarang, kita akan asumsikan `NavbarBackgroundShape`
    // akan diupdate untuk menerima posisi X absolut.
    // Namun, karena `NavbarBackgroundShape` menggunakan `circlePosition` sebagai index, kita bisa biarkan.
    // Kita hanya perlu memastikan `circlePosition` di-set dengan benar.
    private func calculateCirclePosition(for tabIndex: Int, in totalWidth: CGFloat) -> CGFloat {
        // Ini adalah logika yang ada di AnimatedNavbar.Tab.index
        // Sebaiknya index ini langsung dari enum Tab saja.
        return CGFloat(tabIndex)
    }
}

// Extension AnimatedNavbar.Tab.index tetap sama
extension AnimatedNavbar.Tab {
    var index: Int { // Ini digunakan oleh NavbarBackgroundShape
        switch self {
        case .home: return 0
        case .progress: return 1
        case .chat: return 2
        case .profile: return 3
        }
    }
}

// NavbarBackgroundShape tetap sama seperti yang Anda berikan
struct NavbarBackgroundShape: Shape {
    var circlePosition: CGFloat // Ini akan menjadi index tab (0, 1, 2, 3)
    var animatableData: CGFloat {
        get { circlePosition }
        set { circlePosition = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cutoutRadius: CGFloat = 90 // Radius untuk bagian setengah lingkaran di atas ikon
        let cutoutDepth: CGFloat = -55 // Seberapa dalam lengkungan itu
        let cornerRadius: CGFloat =  0 // Corner radius untuk background Navbar (jika tidak full-width)
                                       // Jika ingin rounded corner untuk keseluruhan navbar, bisa diatur di ZStack fill.

        let tabWidth = rect.width / CGFloat(AnimatedNavbar.Tab.allCases.count)
        // circleCenterX sekarang adalah posisi X tengah dari lengkungan, berdasarkan index tab
        let circleCenterX = tabWidth * circlePosition + tabWidth / 2

        let cutoutStart = circleCenterX - cutoutRadius
        let cutoutEnd = circleCenterX + cutoutRadius

        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius)) // Mulai dari kiri atas (setelah corner)

        // Garis atas ke kiri sebelum lengkungan
        path.addLine(to: CGPoint(x: cutoutStart, y: rect.minY))

        // Kurva untuk lengkungan di atas ikon
        // Control point disesuaikan agar lengkungan lebih dangkal dan lebar
        let controlPoint1 = CGPoint(x: cutoutStart + cutoutRadius * 0.4, y: rect.minY) // Control point mendekati garis atas
        let midPoint = CGPoint(x: circleCenterX, y: rect.minY - cutoutDepth) // Titik puncak lengkungan (negatif y)
        let controlPoint2 = CGPoint(x: circleCenterX - cutoutRadius * 0.3, y: rect.minY - cutoutDepth) // Control point di puncak

        path.addCurve(to: midPoint, control1: controlPoint1, control2: controlPoint2)

        let controlPoint3 = CGPoint(x: circleCenterX + cutoutRadius * 0.3, y: rect.minY - cutoutDepth) // Control point di puncak
        let controlPoint4 = CGPoint(x: cutoutEnd - cutoutRadius * 0.4, y: rect.minY) // Control point mendekati garis atas

        path.addCurve(to: CGPoint(x: cutoutEnd, y: rect.minY), control1: controlPoint3, control2: controlPoint4)

        // Garis atas ke kanan setelah lengkungan
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))

        // Corner kanan atas (jika ada)
        if cornerRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        }

        // Garis kanan ke bawah
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))

        // Corner kanan bawah (jika ada)
        if cornerRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        }
        
        // Garis bawah
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))

        // Corner kiri bawah (jika ada)
        if cornerRadius > 0 {
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        }

        // Garis kiri ke atas (menutup path)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        
        // Corner kiri atas (jika ada)
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

