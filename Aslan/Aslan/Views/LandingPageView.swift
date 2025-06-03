//
//  LandingPageView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

import SwiftUI

struct LandingPageView: View {
    @StateObject private var landingViewModel = LandingPageViewModel()
    @StateObject private var userViewModel = UserViewModel()

    // State lokal untuk mengelola navigasi programmatic
    @State private var navigateToMainContent: Bool = false
    @State private var navigateToOnboarding: Bool = false

    var body: some View {
        ZStack {
            // Selalu tampilkan UI Landing Page standar Anda
            VStack {
                Spacer(minLength: 40)
                HStack(spacing: 10) {
                    Image("icon_buku").resizable().scaledToFit().frame(width: 40, height: 40).foregroundColor(.blue)
                    Text("ASLAN").font(.title).fontWeight(.bold).foregroundColor(.black)
                }.padding(.bottom, 5)
                Image("orang_duduk").resizable().scaledToFit().frame(width: 350, height: 300).padding(.bottom, 5)
                Text("Learn a language").font(.title2).fontWeight(.bold)
                Text("in 3 minutes a day").font(.title2).fontWeight(.bold).padding(.bottom, 2)
                Text("Let’s start your Journey!").font(.subheadline).foregroundColor(.black).padding(.bottom, 10)

                // Tombol "Start Learning" ke RegisterPageView
                NavigationLink(destination: RegisterPageView()) {
                    Text("Start Learning").fontWeight(.bold).foregroundColor(.white).padding()
                        .frame(maxWidth: .infinity).background(Color.blue).cornerRadius(10)
                }.padding(.horizontal, 20).padding(.bottom, 5)

                // Link "Log In" ke LoginPageView
                HStack {
                    Text("Already have an Account?").font(.footnote)
                    NavigationLink(destination: LoginPageView()) { // Pastikan ini menunjuk ke LoginPageView
                        Text("Log In").font(.footnote).fontWeight(.bold).foregroundColor(.blue)
                    }
                }.padding(.top, 5)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.edgesIgnoringSafeArea(.all))

            // Tampilkan ProgressView HANYA JIKA userViewModel sedang loading dan user sudah login
            if landingViewModel.isUserLoggedIn && userViewModel.isLoadingProfile {
                ProgressView("Loading your experience...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    .transition(.opacity) // Tambahkan transisi agar lebih halus
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Selalu reset status navigasi setiap kali LandingPageView muncul
            navigateToMainContent = false
            navigateToOnboarding = false

            print("LandingPageView: onAppear. User logged in: \(landingViewModel.isUserLoggedIn)")
            if landingViewModel.isUserLoggedIn {
                // Jika user login, panggil fetchUserProfile untuk menentukan tujuan
                // Hanya fetch jika belum ditentukan atau sedang tidak loading
                if !userViewModel.determinedInitialView && !userViewModel.isLoadingProfile {
                    print("LandingPageView: Triggering fetchUserProfile for logged-in user.")
                    userViewModel.fetchUserProfile()
                } else if userViewModel.determinedInitialView {
                    // Jika sudah ditentukan sebelumnya, evaluasi ulang navigasi
                    print("LandingPageView: Profile already determined. Re-evaluating navigation.")
                    userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
                }
            } else {
                // Jika tidak ada user yang login (berdasarkan listener Auth),
                // pastikan UserViewModel direset untuk alur user baru.
                userViewModel.resetOnboardingDataForNewUser()
                // Untuk user baru, kita asumsikan determinedInitialView = true
                // karena tidak ada yang perlu di-fetch, dan mereka akan menggunakan Register/Login.
                userViewModel.determinedInitialView = true
                print("LandingPageView: No user logged in. UserViewModel reset. Determined initial view.")
            }
        }
        .onChange(of: landingViewModel.isUserLoggedIn) { isLoggedIn in
            print("LandingPageView: isUserLoggedIn changed to \(isLoggedIn)")
            if isLoggedIn {
                // Ketika user baru saja login (misalnya dari LoginPage), segera fetch profilnya
                print("LandingPageView: User is now logged in (onChange), fetching profile.")
                userViewModel.fetchUserProfile()
            } else {
                // Ketika user logout, reset data dan state navigasi, dan kembali ke Landing Page UI
                userViewModel.resetOnboardingDataForNewUser()
                userViewModel.determinedInitialView = true // Siap menampilkan UI landing
                // Pastikan state navigasi lokal juga direset
                navigateToMainContent = false
                navigateToOnboarding = false
            }
        }
        .onChange(of: userViewModel.determinedInitialView) { isDetermined in
            if isDetermined && landingViewModel.isUserLoggedIn {
                print("LandingPageView: determinedInitialView is now \(isDetermined) and user is logged in.")
                // Setelah profil ditentukan, baru putuskan ke mana navigasi
                userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
                // Kemudian, set state navigasi lokal berdasarkan ViewModel
                if userViewModel.needsOnboarding {
                    navigateToOnboarding = true
                } else {
                    navigateToMainContent = true
                }
            }
        }
        .background(
            Group {
                // Navigasi ke halaman utama jika sudah login dan onboarding complete
                NavigationLink(
                    destination: {
                        if userViewModel.navigateToJapaneseMain {
                            return AnyView(JapaneseMainPageView().navigationBarBackButtonHidden(true).navigationBarHidden(true))
                        } else if userViewModel.navigateToKoreanMain {
                            return AnyView(Text("Korean Main Page - Placeholder").navigationBarBackButtonHidden(true).navigationBarHidden(true))
                        } else if userViewModel.navigateToChineseMain {
                            return AnyView(Text("Chinese Main Page - Placeholder").navigationBarBackButtonHidden(true).navigationBarHidden(true))
                        }
                        return AnyView(EmptyView()) // Fallback
                    }(),
                    isActive: $navigateToMainContent, // Gunakan state lokal
                    label: { EmptyView() }
                )

                // Navigasi ke ChooseLanguagePageView jika needsOnboarding true
                NavigationLink(
                    destination: ChooseLanguagePageView().navigationBarBackButtonHidden(true),
                    isActive: $navigateToOnboarding, // Gunakan state lokal
                    label: { EmptyView() }
                )
            }
        )
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LandingPageView()
        }
    }
}
