//
//  LandingPageView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// File: Views/LandingPageView.swift
import SwiftUI

struct LandingPageView: View {
    // landingViewModel mungkin tidak lagi memerlukan @StateObject jika hanya untuk aksi sederhana
    // atau jika tidak ada state yang perlu diobservasi untuk mengubah tampilan LandingPageView itu sendiri.
    // Untuk saat ini, kita biarkan karena Anda mungkin memiliki logika UI lain di sana.
    @StateObject private var landingViewModel = LandingPageViewModel()
    // UserViewModel tidak lagi diinisialisasi atau digunakan di sini untuk navigasi otomatis.

    var body: some View {
        // ZStack tidak lagi diperlukan jika tidak ada NavLink programmatic atau ProgressView kondisional
        VStack { // UI Landing Page standar Anda
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
            }
            .padding(.horizontal, 20).padding(.bottom, 5)

            // Link "Log In" ke LoginPageView
            HStack {
                Text("Already have an Account?").font(.footnote)
                NavigationLink(destination: LoginPageView()) { // Langsung ke LoginPageView
                    Text("Log In").font(.footnote).fontWeight(.bold).foregroundColor(.blue)
                }
            }
            .padding(.top, 5)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Pastikan VStack mengisi layar
        .background(Color.white.edgesIgnoringSafeArea(.all)) // Background putih
        .navigationBarHidden(true) // Tetap sembunyikan navigation bar di sini
        .onAppear {
            // landingViewModel.checkUserLoginStatus() // Tidak lagi relevan untuk menampilkan UI ini
            print("LandingPageView: Appeared.")
            // Jika ada state yang perlu direset di landingViewModel, lakukan di sini.
        }
        // Semua NavigationLink programmatic dihapus dari sini.
        // Keputusan navigasi setelah login/register akan ditangani oleh halaman masing-masing.
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Penting untuk preview NavigationLink UI
            LandingPageView()
        }
    }
}
