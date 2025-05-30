//
//  ChooseReasonPageView.swift
//  Aslan
//
//  Created by student on 27/05/25.
//
import SwiftUI

struct ChooseReasonPageView: View {
    // 1. Terima UserViewModel sebagai ObservedObject
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var navigateToSetUsername: Bool = false

    let reasons = [
        "To improve my global communication skills",
        "I'm interested in the culture and want to understand it better through its language",
        "To support my future career or studies",
        "I enjoy challenges and want to learn something new",
        "I plan to travel to a country that uses this language"
    ]
    let activeSelectionColor = Color(red: 255/255, green: 195/255, blue: 130/255)

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("orang_berbicara")
                .resizable().scaledToFit().frame(width: 250, height: 250)
                .padding(.horizontal).padding(.bottom, 15)

            VStack(spacing: 0) {
                Spacer().frame(height: 40)
                Text("Why do you want to learn this language?")
                    .font(.title2).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center).foregroundColor(.white)
                    .padding(.horizontal, 30).padding(.bottom, 8)
                Text("Please select the 1 answer that is closest to you")
                    .font(.footnote).fontWeight(.medium).fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center).foregroundColor(.white.opacity(0.85))
                    .padding(.horizontal, 40).padding(.bottom, 20)

                VStack(spacing: 10) {
                    ForEach(reasons, id: \.self) { reason in
                        Button(action: {
                            userViewModel.chosenReason = reason
                        }) {
                            Text(reason).font(.system(size: 14, weight: .medium))
                                .foregroundColor(userViewModel.chosenReason == reason ? .white : .black)
                                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                .frame(maxWidth: .infinity).frame(minHeight: 40)
                                .background(userViewModel.chosenReason == reason ? activeSelectionColor : Color.white)
                                .cornerRadius(10).shadow(radius: 2, x: 0, y: 1)
                        }
                    }
                }
                .padding(.horizontal, 40)

                Button(action: {
                    if userViewModel.chosenReason != nil {
                        print("Continue button pressed, selected reason: \(userViewModel.chosenReason!)")
                        self.navigateToSetUsername = true
                    }
                }) {
                    Text("Continue").fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding().frame(maxWidth: .infinity, minHeight: 50)
                        .background(userViewModel.chosenReason != nil ? activeSelectionColor : Color.gray.opacity(0.4))
                        .cornerRadius(10).shadow(radius: 2, x: 0, y: 1)
                }
                .disabled(userViewModel.chosenReason == nil)
                .padding(.horizontal, 40).padding(.top, 15).padding(.bottom, 40)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.blue)
            .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
            .edgesIgnoringSafeArea(.bottom)
            .background(
                NavigationLink(
                    destination: SetUsernamePageView(userViewModel: self.userViewModel) // <--- TERUSKAN VIEWMODEL
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToSetUsername,
                    label: { EmptyView() }
                )
            )
        }
        .background(Color.white).frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear { if navigateToSetUsername { navigateToSetUsername = false } }
    }
}

struct ChooseReasonPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseReasonPageView(userViewModel: UserViewModel())
        }
    }
}
