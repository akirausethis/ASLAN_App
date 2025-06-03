//
//  ChooseLevelPageView.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

// File: Views/ChooseLevelPageView.swift

import SwiftUI

struct ChooseLevelPageView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var navigateToChooseReason: Bool = false

    // Konstanta levels dan activeSelectionColor bisa tetap di sini
    // atau dipindahkan ke LevelSelectionContentView jika hanya digunakan di sana.
    // Untuk saat ini, saya biarkan di sini dan akan di-pass jika perlu.

    var body: some View {
        VStack(spacing: 0) { // Ini adalah VStack utama yang mungkin menyebabkan masalah
            Spacer()

            Image("orang_berbicara")
                .resizable().scaledToFit().frame(width: 250, height: 250)
                .padding(.horizontal).padding(.bottom, 30) // Sesuai kode Anda

            // Menggunakan struct baru untuk konten area biru
            LevelSelectionContentView(
                userViewModel: userViewModel,
                navigateToChooseReason: $navigateToChooseReason
            )
        }
        .background(Color.white.edgesIgnoringSafeArea(.all)) // Background untuk seluruh halaman
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if navigateToChooseReason {
                navigateToChooseReason = false
            }
        }
        // .navigationBarHidden(true) // Jika Anda ingin menyembunyikan navigation bar
    }
}

// Struct baru untuk konten di dalam area biru
private struct LevelSelectionContentView: View {
    @ObservedObject var userViewModel: UserViewModel
    @Binding var navigateToChooseReason: Bool

    let levels = ["Beginner", "Intermediate", "Expert"]
    let activeSelectionColor = Color(red: 255/255, green: 195/255, blue: 130/255)

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 65) // Sesuai kode Anda

            Text("What is your experience in this language?")
                .font(.title2).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center).foregroundColor(.white)
                .padding(.horizontal, 20).padding(.bottom, 10)

            Text("Select your current proficiency.")
                .font(.subheadline).foregroundColor(.white.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                .padding(.horizontal, 20).padding(.bottom, 30)

            VStack(spacing: 15) { // Daftar Tombol Level (spacing dari kode Anda)
                ForEach(levels, id: \.self) { level in
                    Button(action: {
                        userViewModel.onboardingLevel = level
                    }) {
                        ZStack {
                            Text(level).font(.headline).fontWeight(.medium)
                                .foregroundColor(userViewModel.onboardingLevel == level ? .white : .black)

                            if userViewModel.onboardingLevel == level {
                                HStack {
                                    Spacer()
                                    Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(activeSelectionColor)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(userViewModel.onboardingLevel == level ? activeSelectionColor : Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
            }
            .padding(.horizontal, 35) // Sesuai kode Anda

            Button(action: {
                if userViewModel.onboardingLevel != nil {
                    // print("Continue button pressed, selected level: \(userViewModel.onboardingLevel!)") // Debugging
                    self.navigateToChooseReason = true
                }
            }) {
                Text("Continue").fontWeight(.bold)
                    .foregroundColor(userViewModel.onboardingLevel != nil ? .black : .white) // Disesuaikan agar teks hitam di atas activeSelectionColor
                    .padding().frame(maxWidth: .infinity, minHeight: 50)
                    .background(userViewModel.onboardingLevel != nil ? activeSelectionColor : Color.gray.opacity(0.5))
                    .cornerRadius(10)
            }
            .disabled(userViewModel.onboardingLevel == nil)
            .padding(.horizontal, 40) // Sesuai kode Anda
            .padding(.top, 20)
            .padding(.bottom, 60) // Sesuai kode Anda

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // VStack biru mengisi sisa ruang
        .background(Color.blue)
        .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
        .edgesIgnoringSafeArea(.bottom)
        .background(
            NavigationLink(
                destination: ChooseReasonPageView(userViewModel: self.userViewModel)
                    .navigationBarBackButtonHidden(true),
                isActive: $navigateToChooseReason,
                label: { EmptyView() }
            )
        )
    }
}

struct ChooseLevelPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // Sediakan UserViewModel untuk preview
            ChooseLevelPageView(userViewModel: UserViewModel())
        }
    }
}
