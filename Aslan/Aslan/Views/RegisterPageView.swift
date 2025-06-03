//
//  RegisterView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//
import SwiftUI

struct RegisterPageView: View {
    @StateObject private var viewModel = RegisterPageViewModel()
    @State private var showForm = false
    @State private var offsetY: CGFloat = 0
    @State private var isArrowUp = true
    @State private var isPasswordVisible = false
    

    let activeColor = Color(red:255/255, green:195/255, blue:130/255)

    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 200)
                
                VStack {
                    Image("orang_duduk")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 150)
                    
                    Text("Begin your journey by")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Text("Creating an Account")
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
                        Text("Register")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("Start your Journey!")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 5) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(activeColor)
                                Text("Email Address")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                            TextField("Enter your email", text: $viewModel.email)
                                .padding()
                                .frame(height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .textContentType(.emailAddress)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 5) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(activeColor)
                                Text("Password")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                            
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible {
                                    TextField("Enter your password", text: $viewModel.password)
                                        .padding()
                                        .frame(height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .textContentType(.newPassword)
                                } else {
                                    SecureField("Enter your password", text: $viewModel.password)
                                        .padding()
                                        .frame(height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .textContentType(.newPassword)
                                }
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        isPasswordVisible.toggle()
                                    }
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.gray)
                                        .frame(width: 22, height: 22)
                                }
                                .padding(.trailing, 15)
                            }
                        }
                        
                        Button(action: {
                            viewModel.validateAndRegister()
                        }) {
                            Text("Register")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(viewModel.email.isEmpty || viewModel.password.isEmpty ? Color.gray.opacity(0.7) : activeColor)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 30)
                        .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                        
                        HStack {
                            Text("Already have an Account?")
                                .font(.footnote)
                                .foregroundColor(.white)
                            NavigationLink(destination: LoginPageView()) {
                                Text("Log In")
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
            .alert(isPresented: $viewModel.showAlert) { 
                Alert(title: Text("Registration Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .onReceive(viewModel.$didRegisterSuccessfully) { successState in
                print("RegisterPageView: didRegisterSuccessfully di View berubah menjadi: \(successState)")
            }
            .onAppear {
                 if viewModel.didRegisterSuccessfully {
                     viewModel.didRegisterSuccessfully = false
                 }
            }
            
            .background(
                NavigationLink(
                    destination: ContinueRegisterPageView().navigationBarBackButtonHidden(true),
                    isActive: $viewModel.didRegisterSuccessfully,
                    label: { EmptyView() }
                )
            )
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct RegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { 
            RegisterPageView()
        }
    }
}
