// File: Aslan/Views/SetUsernamePageView.swift
import SwiftUI

struct SetUsernamePageView: View {
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 25) {
                    Image("orang_berbicara")
                        .resizable().scaledToFit().frame(width: 230, height: 230)

                    Text("Just a little bit more")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Now let us know what should we call you")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    TextField("Enter your name", text: $userViewModel.onboardingUsername)
                        .font(.system(size: 16))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(userViewModel.onboardingDataSaveError != nil && userViewModel.onboardingUsername.isEmpty ? Color.red : Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .padding(.horizontal, 40)

                    if let errorMessage = userViewModel.onboardingDataSaveError {
                        Text(errorMessage).font(.caption).foregroundColor(.red)
                            .multilineTextAlignment(.center).padding(.horizontal, 40).padding(.top, 5)
                    }
                    
                    Button(action: {
                        userViewModel.saveUserOnboardingChoices()
                    }) {
                        if userViewModel.isSavingOnboardingData {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding().frame(maxWidth: .infinity).frame(height: 50)
                                .background(Color.blue.opacity(0.7)).cornerRadius(10)
                        } else {
                            Text("Continue").font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white).padding()
                                .frame(maxWidth: .infinity).frame(height: 50)
                                .background(userViewModel.onboardingUsername.isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .disabled(userViewModel.onboardingUsername.isEmpty || userViewModel.isSavingOnboardingData)
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
                NavigationLink(
                    destination: ContinueSetUsernamePageView(userViewModel: self.userViewModel)
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true),
                    isActive: $userViewModel.didCompleteOnboarding,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
             userViewModel.onboardingDataSaveError = nil
        }
    }
}
