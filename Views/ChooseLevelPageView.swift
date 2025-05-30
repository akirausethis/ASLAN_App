//
//  ChooseLevelPageView.swift
//  Aslan
//
//  Created by student on 27/05/25.
//

import SwiftUI

struct ChooseLevelPageView: View {
    @ObservedObject var userViewModel: UserViewModel

    @State private var navigateToChooseReason: Bool = false

    let levels = ["Beginner", "Intermediate", "Expert"]
    let activeSelectionColor = Color(red: 255/255, green: 195/255, blue: 130/255)

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("orang_berbicara")
                .resizable().scaledToFit().frame(width: 250, height: 250)
                .padding(.horizontal).padding(.bottom, 30)

            VStack(spacing: 0) {
                Spacer().frame(height: 65)
                Text("What is your experience in this language?")
                    .font(.title2).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center).foregroundColor(.white)
                    .padding(.horizontal, 20).padding(.bottom, 10)
                Text("Select your current proficiency.")
                    .font(.subheadline).foregroundColor(.white.opacity(0.85))
                    .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    .padding(.horizontal, 20).padding(.bottom, 30)

                VStack(spacing: 15) {
                    ForEach(levels, id: \.self) { level in
                        Button(action: {
                            userViewModel.chosenLevel = level
                        }) {
                            ZStack {
                                Text(level).font(.headline).fontWeight(.medium)
                                    .foregroundColor(userViewModel.chosenLevel == level ? .white : .black)
                                if userViewModel.chosenLevel == level {
                                    HStack {
                                        Spacer()
                                        Circle().frame(width: 20, height: 20)
                                            .foregroundColor(activeSelectionColor)
                                    }
                                }
                            }
                            .padding().frame(maxWidth: .infinity)
                            .background(userViewModel.chosenLevel == level ? activeSelectionColor : Color.white)
                            .cornerRadius(10).shadow(radius: 5)
                        }
                    }
                }
                .padding(.horizontal, 35)

                Button(action: {
                    if userViewModel.chosenLevel != nil {
                        print("Continue button pressed, selected level: \(userViewModel.chosenLevel!)")
                        self.navigateToChooseReason = true
                    }
                }) {
                    Text("Continue").fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding().frame(maxWidth: .infinity, minHeight: 50)
                        .background(userViewModel.chosenLevel != nil ? activeSelectionColor : Color.gray.opacity(0.5))
                        .cornerRadius(10)
                }
                .disabled(userViewModel.chosenLevel == nil)
                .padding(.horizontal, 40).padding(.top, 20).padding(.bottom, 60)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.blue)
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
        .background(Color.white).frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear { if navigateToChooseReason { navigateToChooseReason = false } }
    }
}

struct ChooseLevelPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseLevelPageView(userViewModel: UserViewModel())
        }
    }
}
