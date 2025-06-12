//
//  ChooseReasonPageView.swift
//  Aslan
//
//  Created by student on 27/05/25.
//
// File: ChooseReasonPageView.swift
import SwiftUI

struct ChooseReasonPageView: View {
    @ObservedObject var userViewModel: UserViewModel // Diterima dari ChooseLevelPageView
    @State private var navigateToSetUsername: Bool = false // State lokal untuk navigasi

    // ... (reasons, activeSelectionColor tetap sama) ...
    let reasons = [
        "To improve my global communication skills",
        "I'm interested in the culture and want to understand it better through its language",
        "To support my future career or studies",
        "I enjoy challenges and want to learn something new",
        "I plan to travel to a country that uses this language"
    ]
    let activeSelectionColor = Color(red: 255/255, green: 195/255, blue: 130/255)

    var body: some View {
        VStack(spacing: 0) { // VStack utama
            // ... (Spacer, Image, VStack biru atas (Spacer, Judul, Subjudul) - dari kode Anda) ...
            Spacer()
            Image("orang_berbicara") // Pastikan aset ini ada
                .resizable().scaledToFit().frame(width: 250, height: 250)
                .padding(.horizontal).padding(.bottom, 15) // Padding dari kode Anda

            VStack(spacing: 0) { // VStack Biru
                Spacer().frame(height: 40) // Spacer dari kode Anda
                Text("Why do you want to learn this language?") // Teks dari kode Anda
                    .font(.title2).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center).foregroundColor(.white)
                    .padding(.horizontal, 30).padding(.bottom, 8)
                Text("Please select the 1 answer that is closest to you") // Teks dari kode Anda
                    .font(.footnote).fontWeight(.medium).fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center).foregroundColor(.white.opacity(0.85))
                    .padding(.horizontal, 40).padding(.bottom, 20)

                VStack(spacing: 10) { // VStack untuk tombol alasan (spacing dari kode Anda)
                    ForEach(reasons, id: \.self) { reason in
                        Button(action: {
                            userViewModel.onboardingReason = reason // Simpan ke UserViewModel
                        }) {
                            Text(reason).font(.system(size: 14, weight: .medium)) // Font dari kode Anda
                                .foregroundColor(userViewModel.onboardingReason == reason ? .white : .black) // Kondisi dari UserViewModel
                                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)) // Padding dari kode Anda
                                .frame(maxWidth: .infinity).frame(minHeight: 40) // Frame dari kode Anda
                                .background(userViewModel.onboardingReason == reason ? activeSelectionColor : Color.white) // Kondisi dari UserViewModel
                                .cornerRadius(10).shadow(radius: 2, x: 0, y: 1) // Styling dari kode Anda
                        }
                    }
                }
                .padding(.horizontal, 40) // Padding dari kode Anda

                Button(action: { // Tombol Continue
                    if userViewModel.onboardingReason != nil { // Periksa dari UserViewModel
                        self.navigateToSetUsername = true
                    }
                }) {
                    Text("Continue").fontWeight(.bold)
                        // Warna teks disesuaikan agar kontras dengan activeSelectionColor
                        .foregroundColor(userViewModel.onboardingReason != nil ? .white : .white)
                        .padding().frame(maxWidth: .infinity, minHeight: 50)
                        .background(userViewModel.onboardingReason != nil ? activeSelectionColor : Color.gray.opacity(0.4)) // Kondisi dari UserViewModel
                        .cornerRadius(10).shadow(radius: 2, x: 0, y: 1) // Shadow dari kode Anda
                }
                .disabled(userViewModel.onboardingReason == nil) // Kondisi disable dari UserViewModel
                .padding(.horizontal, 40) // Padding dari kode Anda
                .padding(.top, 15)       // Padding dari kode Anda
                .padding(.bottom, 40)    // Padding dari kode Anda

                Spacer(minLength: 0) // Spacer bawah di dalam area biru
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
            .edgesIgnoringSafeArea(.bottom)
            .background( // NavigationLink diletakkan di background VStack biru
                NavigationLink(
                    destination: SetUsernamePageView(userViewModel: self.userViewModel) // Meneruskan ViewModel
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToSetUsername, // Menggunakan state lokal untuk trigger
                    label: { EmptyView() }
                )
            )
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if navigateToSetUsername { navigateToSetUsername = false }
            // Reset state navigasi spesifik di UserViewModel jika diperlukan saat halaman ini muncul
            // userViewModel.resetSpecificNavigationStates() // Opsional, tergantung alur yang diinginkan
        }
        // .navigationBarHidden(true) // Jika Anda ingin menyembunyikan navigation bar
    }
}

struct ChooseReasonPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // Sediakan UserViewModel untuk preview
            ChooseReasonPageView(userViewModel: UserViewModel())
        }
    }
}
