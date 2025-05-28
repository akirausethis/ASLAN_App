//
//  LoginView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

import SwiftUI

struct LoginPageView: View {
    @StateObject private var viewModel = LoginPageViewModel()
    @State private var showForm = false
    @State private var offsetY: CGFloat = 0
    @State private var isArrowUp = true
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 200)
            
            VStack {
                Image("orang_duduk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 150)
                
                Text("Don't stop your journey")
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Text("Login to your account")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .offset(y: offsetY)
            
            VStack {
                Spacer()
                
                Image(systemName: isArrowUp ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if isArrowUp {
                                offsetY = -50
                                showForm = true
                                isArrowUp = false
                            } else {
                                offsetY = 0
                                showForm = false
                                isArrowUp = true
                            }
                        }
                    }
            }
            
            if showForm {
                VStack(spacing: 15) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Continue your Journey!")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 5) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color(red:255/255, green:195/255, blue:130/255))
                            Text("Email Address")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        TextField("", text: $viewModel.email)
                            .padding()
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 5) {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color(red:255/255, green:195/255, blue:130/255))
                            Text("Password")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("", text: $viewModel.password)
                                    .padding()
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            } else {
                                SecureField("", text: $viewModel.password)
                                    .padding()
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isPasswordVisible.toggle()
                                }
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                                    .opacity(isPasswordVisible ? 1.0 : 0.6)
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.trailing, 15)
                        }
                    }
                    
                    Button(action: {
                        viewModel.validateAndLogin()
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(red:255/255, green:195/255, blue:130/255))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    
                    HStack {
                        Text("Don't have an Account?")
                            .font(.footnote)
                            .foregroundColor(.white)
                        NavigationLink(destination: RegisterPageView()) {
                            Text("Register")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.top, 10)
                }
                .frame(
                        maxWidth: 350,
                        minHeight: 450,
                        maxHeight: .infinity,
                        alignment: .top
                    )
                .padding(30)
                .background(Color.blue)
                .cornerRadius(30)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            Spacer()
        }
        .padding(.bottom) 
        .navigationBarHidden(true)
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
