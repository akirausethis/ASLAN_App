//
//  LandingPageView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

import SwiftUI

struct LandingPageView: View {
    @StateObject private var viewModel = LandingPageViewModel()

    var body: some View {
        VStack {
            Spacer(minLength: 40)

            HStack(spacing: 10) {
                Image("icon_buku")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)

                Text("ASLAN")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 5)

            Image("orang_duduk")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 300)
                .padding(.bottom, 5)

            Text("Learn a language")
                .font(.title2)
                .fontWeight(.bold)

            Text("in 3 minutes a day")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 2)

            Text("Let’s start your Journey!")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.bottom, 10)

            NavigationLink(destination: RegisterPageView()) {
                Text("Start Learning")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 5)

            HStack {
                Text("Already have an Account?")
                    .font(.footnote)
                NavigationLink(destination: LoginPageView()) {
                    Text("Log In")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 5)

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.checkUserLoginStatus()
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
