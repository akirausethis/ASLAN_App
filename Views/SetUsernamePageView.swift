//
//  SetUsernamePageView.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

// File: SetUsernamePageView.swift
import SwiftUI

struct SetUsernamePageView: View {
    @ObservedObject var userViewModel: UserViewModel // Tetap terima UserViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 0) { // VStack utama
                Spacer()

                VStack(spacing: 25) {
                    Image("orang_berbicara")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)

                    Text("Just a little bit more")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Now let us know what should we call you")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    TextField("Enter your name", text: $userViewModel.username)
                        .font(.system(size: 16))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(userViewModel.onboardingDataSaveError != nil && userViewModel.username.isEmpty ? Color.red : Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .padding(.horizontal, 40)

                    if let errorMessage = userViewModel.onboardingDataSaveError {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.top, 5)
                    }
                    
                    Button(action: {
                        userViewModel.saveUserOnboardingChoices()
                    }) {
                        if userViewModel.isSavingOnboardingData {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(10)
                        } else {
                            Text("Continue")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(userViewModel.username.isEmpty ? Color.gray.opacity(0.5) : Color.blue) // Tombol biru saat aktif
                                .cornerRadius(10)
                        }
                    }
                    .disabled(userViewModel.username.isEmpty || userViewModel.isSavingOnboardingData)
                    .padding(.horizontal, 40)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .onTapGesture {
                 UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .background(
                // MODIFIKASI TUJUAN NAVIGASI:
                NavigationLink(
                    destination: ContinueSetUsernamePageView(userViewModel: self.userViewModel) // Teruskan ViewModel
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true), // Nav bar tetap hidden
                    isActive: $userViewModel.didCompleteOnboarding,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
             if userViewModel.didCompleteOnboarding { userViewModel.didCompleteOnboarding = false }
             userViewModel.onboardingDataSaveError = nil
        }
    }
}
struct SetUsernamePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetUsernamePageView(userViewModel: UserViewModel())
        }
    }
}
