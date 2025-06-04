//
//  LandingPageView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// File: LandingPageView.swift
import SwiftUI

struct LandingPageView: View {
    @StateObject private var landingViewModel = LandingPageViewModel()
    // UserViewModel akan digunakan SETELAH login terkonfirmasi atau jika user sudah login saat app dibuka
    @StateObject private var userViewModel = UserViewModel()

    var body: some View {
        ZStack {
            // 1. Selalu tampilkan UI Landing Page jika pengguna BELUM LOGIN.
            //    Atau jika SUDAH LOGIN tapi UserViewModel BELUM SELESAI menentukan view awal.
            if !landingViewModel.isUserLoggedIn || (landingViewModel.isUserLoggedIn && !userViewModel.determinedInitialView) {
                VStack { // UI Landing Page Anda
                    Spacer(minLength: 40)
                    HStack(spacing: 10) {
                        Image("icon_buku").resizable().scaledToFit().frame(width: 40, height: 40).foregroundColor(.blue)
                        Text("ASLAN").font(.title).fontWeight(.bold).foregroundColor(.black)
                    }.padding(.bottom, 5)
                    Image("orang_duduk").resizable().scaledToFit().frame(width: 350, height: 300).padding(.bottom, 5)
                    Text("Learn a language").font(.title2).fontWeight(.bold)
                    Text("in 3 minutes a day").font(.title2).fontWeight(.bold).padding(.bottom, 2)
                    Text("Let’s start your Journey!").font(.subheadline).foregroundColor(.black).padding(.bottom, 10)

                    NavigationLink(destination: RegisterPageView()) {
                        Text("Start Learning").fontWeight(.bold).foregroundColor(.white).padding()
                            .frame(maxWidth: .infinity).background(Color.blue).cornerRadius(10)
                    }
                    .padding(.horizontal, 20).padding(.bottom, 5)

                    HStack {
                        Text("Already have an Account?").font(.footnote)
                        // Ini adalah NavigationLink UI yang akan membawa ke LoginPageView
                        NavigationLink(destination: LoginPageView()) {
                            Text("Log In").font(.footnote).fontWeight(.bold).foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 5)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.edgesIgnoringSafeArea(.all)) // Pastikan background putih

                // Tampilkan ProgressView di atas UI Landing jika sedang loading profil SETELAH login
                if landingViewModel.isUserLoggedIn && userViewModel.isLoadingProfile {
                    Color.black.opacity(0.4).edgesIgnoringSafeArea(.all) // Latar belakang redup
                    ProgressView("Loading your experience...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            // 2. Jika SUDAH LOGIN dan UserViewModel SUDAH SELESAI menentukan (determinedInitialView == true)
            //    Maka biarkan ZStack ini "kosong" secara visual di sini, karena navigasi programmatic
            //    di .background akan mengambil alih.
            else if landingViewModel.isUserLoggedIn && userViewModel.determinedInitialView {
                 EmptyView()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // landingViewModel.isUserLoggedIn akan diupdate oleh listener Auth di init-nya.
            print("LandingPageView: onAppear. User logged in (from landingVM): \(landingViewModel.isUserLoggedIn)")
            if landingViewModel.isUserLoggedIn {
                if !userViewModel.determinedInitialView && !userViewModel.isLoadingProfile {
                    print("LandingPageView: Triggering fetchUserProfile.")
                    userViewModel.fetchUserProfile()
                } else if userViewModel.determinedInitialView {
                    print("LandingPageView: Profile already determined. Re-evaluating navigation.")
                    userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
                }
            } else {
                userViewModel.resetOnboardingDataForNewUser()
                // Karena tidak login, determinedInitialView bisa true karena tidak ada yang perlu di-fetch untuk user ini.
                // Ini dihandle di init UserViewModel jika currentUser nil.
                // userViewModel.determinedInitialView = true; // Pastikan ini diset jika tidak ada proses fetch
                print("LandingPageView: No user logged in. UserViewModel reset.")
            }
        }
        .onChange(of: landingViewModel.isUserLoggedIn) { isLoggedIn in
            print("LandingPageView: landingViewModel.isUserLoggedIn changed to \(isLoggedIn)")
            if isLoggedIn {
                // Jika status login berubah menjadi true (misalnya setelah listener Auth di LandingPageViewModel berjalan),
                // panggil fetchUserProfile.
                 print("LandingPageView (onChange isUserLoggedIn): User is now logged in, fetching profile.")
                 userViewModel.fetchUserProfile()
            } else {
                // Ketika user logout, reset data dan state navigasi
                userViewModel.resetOnboardingDataForNewUser()
                // navigateToMainContent = false // Jika menggunakan state lokal
                // navigateToOnboarding = false // Jika menggunakan state lokal
            }
        }
        .onChange(of: userViewModel.determinedInitialView) { isDetermined in
             if isDetermined && landingViewModel.isUserLoggedIn {
                 print("LandingPageView (onChange determinedInitialView): Profile determination complete for logged in user. Triggering navigation logic.")
                 userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
             }
        }
        // NavigationLinks Programmatic hanya relevan jika pengguna sudah login
        // dan proses penentuan view awal sudah selesai.
        .background(
            Group {
                // Hanya aktifkan NavLink programmatic ini jika pengguna sudah login
                // DAN proses penentuan view awal sudah selesai.
                if landingViewModel.isUserLoggedIn && userViewModel.determinedInitialView {
                    NavigationLink(
                        destination: JapaneseMainPageView(userViewModel: self.userViewModel)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                        isActive: $userViewModel.navigateToJapaneseMain,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: Text("Korean Main Page - Placeholder").navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        isActive: $userViewModel.navigateToKoreanMain,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: Text("Chinese Main Page - Placeholder").navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        isActive: $userViewModel.navigateToChineseMain,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: ChooseLanguagePageView() // CLPV akan buat UserViewModel baru
                            .navigationBarBackButtonHidden(true),
                        isActive: $userViewModel.needsOnboarding, // Diikat ke needsOnboarding
                        label: { EmptyView() }
                    )
                } else {
                    EmptyView() // Jika belum login atau belum determined, jangan buat NavLink ini
                }
            }
        )
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Selalu bungkus dengan NavigationView di Preview jika ada NavLink
            LandingPageView()
        }
    }
}
