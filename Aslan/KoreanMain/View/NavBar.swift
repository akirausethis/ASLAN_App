// Aslan/KoreanMain/View/NavBar.swift
import SwiftUI

struct AnimatedNavbar: View {
    @Namespace var animation
    @State private var selectedTab: Tab = .home
    @State private var circlePosition: CGFloat = 0

    @ObservedObject var userViewModel: UserViewModel
    @EnvironmentObject var themeManager: ThemeManager

    @State private var homeNavigationPath: NavigationPath = NavigationPath()
    @State private var progressNavigationPath: NavigationPath = NavigationPath()
    @State private var quizNavigationPath: NavigationPath = NavigationPath()
    @State private var profileNavigationPath: NavigationPath = NavigationPath()

    enum Tab: String, CaseIterable {
        case home = "house.fill"
        case progress = "chart.bar.fill"
        case quiz = "message.fill"
        case profile = "person.fill"
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            view(for: selectedTab,
                 homePath: $homeNavigationPath,
                 progressPath: $progressNavigationPath,
                 quizPath: $quizNavigationPath,
                 profilePath: $profileNavigationPath)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Spacer()
                ZStack {
                    NavbarBackgroundShape(circlePosition: circlePosition)
                        .fill(themeManager.accentColor)
                        .frame(height: 80)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                        .animation(.easeInOut(duration: 0.4), value: circlePosition)

                    HStack(spacing: 0) {
                        ForEach(Tab.allCases, id: \.self) { tab in
                            Spacer()
                            VStack {
                                ZStack {
                                    if selectedTab == tab {
                                        Circle()
                                            .fill(Color.white)
                                            .matchedGeometryEffect(id: "circle", in: animation)
                                            .frame(width: 65, height: 65)
                                            .offset(y: -20)
                                        Image(systemName: tab.rawValue)
                                            .font(.title2)
                                            .foregroundColor(themeManager.accentColor)
                                            .offset(y: -20)
                                            .transition(.scale(scale: 0.5, anchor: .bottom).combined(with: .opacity))
                                    } else {
                                        Image(systemName: tab.rawValue)
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                                            .transition(.opacity)
                                    }
                                }
                            }
                            .frame(width: 70, height: 80)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    if selectedTab == tab {
                                        popToRoot(for: tab)
                                    } else {
                                        selectedTab = tab
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onChange(of: selectedTab) { oldTab, newTab in
                if let newIndex = Tab.allCases.firstIndex(of: newTab) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        circlePosition = calculateCirclePosition(for: newIndex, in: UIScreen.main.bounds.width)
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        // --- PERBAIKAN: TAMBAHKAN MODIFIER .onAppear DI SINI ---
        .onAppear {
            if let initialIndex = Tab.allCases.firstIndex(of: selectedTab) {
                circlePosition = calculateCirclePosition(for: initialIndex, in: UIScreen.main.bounds.width)
            }
            
            // Setelah berhasil navigasi ke halaman ini, kunci status login menjadi true.
            if !userViewModel.isUserLoggedIn {
                userViewModel.isUserLoggedIn = true
                print("AnimatedNavbar appeared, setting isUserLoggedIn to true.")
            }
        }
    }

    @ViewBuilder
    func view(for tab: Tab, homePath: Binding<NavigationPath>, progressPath: Binding<NavigationPath>, quizPath: Binding<NavigationPath>, profilePath: Binding<NavigationPath>) -> some View {
        switch tab {
        case .home:
            NavigationStack(path: homePath) {
                KoreanMainPageView(userViewModel: self.userViewModel)
            }
        case .progress:
            NavigationStack(path: progressPath) {
                ProgressPageView()
            }
        case .quiz:
            NavigationStack(path: quizPath) {
                KoreanQuizListView()
            }
        case .profile:
            NavigationStack(path: profilePath) {
                ProfileView()
            }
        }
    }

    private func calculateCirclePosition(for tabIndex: Int, in totalWidth: CGFloat) -> CGFloat {
        return CGFloat(tabIndex)
    }
    
    private func popToRoot(for tab: Tab) {
        switch tab {
        case .home: homeNavigationPath = NavigationPath()
        case .progress: progressNavigationPath = NavigationPath()
        case .quiz: quizNavigationPath = NavigationPath()
        case .profile: profileNavigationPath = NavigationPath()
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
        let cornerRadius: CGFloat = 0

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
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
