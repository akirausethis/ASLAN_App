// File: Aslan/Views/ContinueSetUsernamePageView.swift
import SwiftUI

struct ContinueSetUsernamePageView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    private var displayName: String {
        userViewModel.onboardingUsername.isEmpty ? (userViewModel.currentUsername ?? "User") : userViewModel.onboardingUsername
    }
    
    @State private var animateCheckmark: Bool = false
    
    let peachColor = Color(red: 253/255, green: 213/255, blue: 179/255)

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()

                Image("orang_jabattangan")
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
                    userViewModel.isUserLoggedIn = true
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
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.55, blendDuration: 0.1)) {
                    self.animateCheckmark = true
                }
            }
        }
        .navigationBarHidden(true)
    }
}
