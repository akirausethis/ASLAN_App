//
//  ChooseLanguagePageView.swift
//  Aslan
//
//  Created by student on 23/05/25.
//

import SwiftUI

struct ChooseLanguagePageView: View {
    @StateObject private var userViewModel = UserViewModel() // Pemilik UserViewModel

    @State private var navigateToChooseLevel: Bool = false

    let languages = ["China", "Korea", "Japan"]
    let activeSelectionColor = Color(red: 255/255, green: 195/255, blue: 130/255)

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("orang_berbicara")
                .resizable().scaledToFit().frame(width: 250, height: 250)
                .padding(.horizontal).padding(.bottom, 5)

            VStack(spacing: 0) {
                Spacer().frame(height: 80)
                Text("What language you wanna learn?")
                    .font(.title2).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center).foregroundColor(.white)
                    .padding(.horizontal, 20).padding(.bottom, 10)
                Text("Please choose one language you'd like to learn")
                    .font(.subheadline).foregroundColor(.white.opacity(0.85))
                    .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    .padding(.horizontal, 20).padding(.bottom, 30)

                VStack(spacing: 15) {
                    ForEach(languages, id: \.self) { language in
                        Button(action: {
                            userViewModel.onboardingLanguage = language // Gunakan onboardingLanguage
                        }) {
                            HStack {
                                Image(language == "China" ? "china_flag" :
                                      language == "Korea" ? "korea_flag" : "japan_flag")
                                    .resizable().scaledToFit().frame(width: 45, height: 30)
                                    .padding(.trailing, 10)
                                Text(language).font(.headline)
                                    .foregroundColor(userViewModel.onboardingLanguage == language ? .white : .black) // Gunakan onboardingLanguage
                                Spacer()
                                if userViewModel.onboardingLanguage == language { // Gunakan onboardingLanguage
                                    Circle().frame(width: 20, height: 20)
                                        .foregroundColor(activeSelectionColor)
                                }
                            }
                            .padding().frame(maxWidth: .infinity)
                            .background(userViewModel.onboardingLanguage == language ? activeSelectionColor : Color.white) // Gunakan onboardingLanguage
                            .cornerRadius(10).shadow(radius: 5)
                        }
                    }
                }
                .padding(.horizontal, 35)

                Button(action: {
                    if userViewModel.onboardingLanguage != nil { // Gunakan onboardingLanguage
                        print("Continue button pressed, selected language: \(userViewModel.onboardingLanguage!)")
                        self.navigateToChooseLevel = true
                    }
                }) {
                    Text("Continue").fontWeight(.bold)
                        .foregroundColor(userViewModel.onboardingLanguage != nil ? .black : .white) // Teks Hitam jika aktif, Putih jika non-aktif
                        .padding().frame(maxWidth: .infinity, minHeight: 50)
                        .background(userViewModel.onboardingLanguage != nil ? activeSelectionColor : Color.gray.opacity(0.5)) // Gunakan onboardingLanguage
                        .cornerRadius(10)
                }
                .disabled(userViewModel.onboardingLanguage == nil) // Gunakan onboardingLanguage
                .padding(.horizontal, 40).padding(.top, 20).padding(.bottom, 60)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.blue)
            .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
            .edgesIgnoringSafeArea(.bottom)
            .background(
                NavigationLink(
                    destination: ChooseLevelPageView(userViewModel: self.userViewModel) // Meneruskan ViewModel
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToChooseLevel,
                    label: { EmptyView() }
                )
            )
        }
        .background(Color.white).frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if navigateToChooseLevel { navigateToChooseLevel = false }
            // userViewModel.resetOnboardingDataForNewUser() // Panggil ini jika ingin reset setiap kali masuk
        }
    }
}
// Preview tidak berubah

struct ChooseLanguagePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseLanguagePageView()
        }
    }
}
