//
//  ContinueSetUsernamePageView.swift
//  Aslan
//
//  Created by Student on 28/05/25.
//

// File: ContinueSetUsernamePageView.swift

import SwiftUI
// Tidak perlu import FirebaseAuth dan FirebaseDatabase di sini jika tidak ada interaksi Firebase langsung

struct ContinueSetUsernamePageView: View {
    @ObservedObject var userViewModel: UserViewModel // Menerima UserViewModel yang sudah ada datanya
    
    // displayName akan mengambil dari userViewModel.username yang diisi di SetUsernamePageView
    private var displayName: String {
        // Menggunakan onboardingUsername karena ini yang baru diinput
        userViewModel.onboardingUsername.isEmpty ? (userViewModel.currentUsername ?? "User") : userViewModel.onboardingUsername
    }
    
    @State private var animateCheckmark: Bool = false
    
    // State untuk memicu NavigationLink secara programmatic
    @State private var navigateToJapanese: Bool = false
    @State private var navigateToKorean: Bool = false // Untuk nanti
    @State private var navigateToChinese: Bool = false // Untuk nanti
    @State private var navigateToFallback: Bool = false // Jika bahasa tidak terdefinisi

    let peachColor = Color(red: 253/255, green: 213/255, blue: 179/255)

    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()

                Image("orang_berjabat_tangan") // PASTIKAN NAMA ASET GAMBAR INI BENAR
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)

                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(peachColor)
                    .scaleEffect(animateCheckmark ? 1.0 : 0.2)
                    .opacity(animateCheckmark ? 1.0 : 0.0)
                    .padding(.top, 10)
                    .padding(.bottom, 5)

                Text("Hello, \(displayName)!")
                    .font(.system(size: 26, weight: .bold))
                    .multilineTextAlignment(.center)

                Text("Let's start your Journey!")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 20)

                Button(action: {
                    // Tentukan navigasi berdasarkan userViewModel.onboardingLanguage
                    // atau userViewModel.currentLanguagePreference yang sudah diisi
                    // dari ChooseLanguagePageView
                    let languageToNavigate = userViewModel.onboardingLanguage ?? userViewModel.currentLanguagePreference
                    
                    print("ContinueSetUsernamePage: Button Continue, language to navigate: \(languageToNavigate ?? "None")")

                    switch languageToNavigate {
                    case "Japan":
                        self.navigateToJapanese = true
                    case "Korea":
                        self.navigateToKorean = true // Akan diimplementasikan tujuannya nanti
                    case "China":
                        self.navigateToChinese = true // Akan diimplementasikan tujuannya nanti
                    default:
                        // Jika bahasa tidak diset atau tidak dikenal, mungkin tampilkan alert
                        // atau navigasi ke halaman default/error.
                        // Untuk sekarang, kita bisa buat fallback.
                        print("Language not set or unknown for navigation from ContinueSetUsernamePage.")
                        self.navigateToFallback = true // Contoh fallback
                    }
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)

                Spacer()
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.edgesIgnoringSafeArea(.all))

            // Grup NavigationLink untuk setiap bahasa
            Group {
                NavigationLink(
                    destination: JapaneseMainPageView() // Halaman utama Jepang
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    isActive: $navigateToJapanese,
                    label: { EmptyView() }
                )
                
                NavigationLink(
                    destination: Text("Korean Main Page - Placeholder") // Ganti dengan KoreanMainPageView() nanti
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    isActive: $navigateToKorean,
                    label: { EmptyView() }
                )

                NavigationLink(
                    destination: Text("Chinese Main Page - Placeholder") // Ganti dengan ChineseMainPageView() nanti
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    isActive: $navigateToChinese,
                    label: { EmptyView() }
                )
                
                // Fallback jika bahasa tidak diketahui
                 NavigationLink(
                     destination: Text("Error: Language not properly selected.") // Halaman fallback
                         .navigationBarBackButtonHidden(true)
                         .navigationBarHidden(true),
                     isActive: $navigateToFallback,
                     label: { EmptyView() }
                 )
            }
        }
        .onAppear {
            // Animasi
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.55, blendDuration: 0.1)) {
                    self.animateCheckmark = true
                }
            }
            
            // Reset state navigasi saat view muncul agar tidak langsung navigasi jika kembali
            self.navigateToJapanese = false
            self.navigateToKorean = false
            self.navigateToChinese = false
            self.navigateToFallback = false
        }
    }
}

struct ContinueSetUsernamePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let previewVM = UserViewModel()
            previewVM.onboardingUsername = "KennethPreview" // Digunakan oleh displayName
            previewVM.onboardingLanguage = "Japan" // Contoh bahasa yang sudah dipilih di UserViewModel
            // atau previewVM.currentLanguagePreference = "Japan"
            return ContinueSetUsernamePageView(userViewModel: previewVM)
        }
    }
}
