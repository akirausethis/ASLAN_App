//
//  LoginView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// LoginPageView.swift

import SwiftUI

struct LoginPageView: View {
    @StateObject private var loginViewModel = LoginPageViewModel()
    @StateObject private var userViewModel = UserViewModel()

    // ... (properti lainnya tetap sama) ...
    // let activeColor = Color(red:255/255, green:195/255, blue:130/255) // Anda sudah punya ini

    var body: some View {
        ZStack {
            // ... (VStack utama Anda untuk UI form login tetap sama) ...
            VStack {
                 Spacer(minLength: 200)
                VStack {
                    Image("orang_duduk").resizable().scaledToFit().frame(width: 350, height: 150)
                    Text("Don't stop your journey").font(.subheadline).foregroundColor(.black)
                    Text("Login to your account").font(.title).fontWeight(.bold)
                }.offset(y: offsetY) // Pastikan offsetY dan showForm didefinisikan jika masih digunakan
                VStack {
                    Spacer()
                    Image(systemName: isArrowUp ? "arrow.up.circle.fill" : "arrow.down.circle.fill") // Pastikan isArrowUp didefinisikan
                        .resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(.blue)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                if isArrowUp { offsetY = -50; showForm = true; isArrowUp = false } // Pastikan showForm didefinisikan
                                else { offsetY = 0; showForm = false; isArrowUp = true }
                            }
                        }
                }
                if showForm { // Pastikan showForm didefinisikan
                    // ... (VStack form login Anda tetap sama) ...
                    VStack(spacing: 15) {
                        Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white)
                        Text("Continue your Journey!").font(.subheadline).foregroundColor(.white)
                        VStack(alignment: .leading, spacing: 5) {
                             HStack(spacing: 5) {
                                Image(systemName: "envelope.fill").foregroundColor(activeColor) // Pastikan activeColor didefinisikan
                                Text("Email Address").font(.footnote).foregroundColor(.white)
                            }
                            TextField("Enter your email", text: $loginViewModel.email).padding().frame(height: 50)
                                .background(Color.white).cornerRadius(10).keyboardType(.emailAddress).autocapitalization(.none)
                                .textContentType(.emailAddress)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 5) {
                                Image(systemName: "lock.fill").foregroundColor(activeColor) // Pastikan activeColor didefinisikan
                                Text("Password").font(.footnote).foregroundColor(.white)
                            }
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible { // Pastikan isPasswordVisible didefinisikan
                                    TextField("Enter your password", text: $loginViewModel.password).padding().frame(height: 50)
                                        .background(Color.white).cornerRadius(10).textContentType(.password)
                                } else {
                                    SecureField("Enter your password", text: $loginViewModel.password).padding().frame(height: 50)
                                        .background(Color.white).cornerRadius(10).textContentType(.password)
                                }
                                Button(action: { withAnimation(.easeInOut(duration: 0.2)) { isPasswordVisible.toggle() }}) { // Pastikan isPasswordVisible didefinisikan
                                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill") // Pastikan isPasswordVisible didefinisikan
                                        .foregroundColor(.gray).frame(width: 22, height: 22)
                                }.padding(.trailing, 15)
                            }
                        }
                        Button(action: {
                                                    loginViewModel.validateAndLogin()
                                                }) {
                                                    Text("Login")
                                                        .fontWeight(.bold)
                                                        // Warna teks bisa juga diubah jika diinginkan,
                                                        // misalnya .foregroundColor(loginViewModel.email.isEmpty || loginViewModel.password.isEmpty ? Color.white.opacity(0.7) : .white)
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .frame(maxWidth: .infinity, minHeight: 50)
                                                        // Modifikasi bagian .background di sini
                                                        .background(loginViewModel.email.isEmpty || loginViewModel.password.isEmpty ? Color.gray.opacity(0.5) : activeColor)
                                                        .cornerRadius(10)
                                                }
                                                .padding(.horizontal, 30)
                                                // .disabled sudah benar
                                                .disabled(loginViewModel.email.isEmpty || loginViewModel.password.isEmpty)

                        HStack {
                            Text("Don't have an Account?").font(.footnote).foregroundColor(.white)
                            NavigationLink(destination: RegisterPageView()) {
                                Text("Register").font(.footnote).fontWeight(.bold).foregroundColor(.yellow)
                            }
                        }.padding(.top, 10)
                    }
                    .frame(maxWidth: 350, minHeight: 450, maxHeight: .infinity, alignment: .top)
                    .padding(30).background(Color.blue).cornerRadius(30).shadow(radius: 10)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                 Spacer()
            }.padding(.bottom).navigationBarHidden(true)
            .alert(isPresented: $loginViewModel.showAlert) {
                Alert(title: Text("Login Failed"), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .onChange(of: loginViewModel.didLoginSuccessfully) { isLoggedIn in
            if isLoggedIn {
                print("LoginPageView: Login successful, fetching user profile...")
                userViewModel.fetchUserProfile()
            }
        }
        .onChange(of: userViewModel.determinedInitialView) { isDetermined in
            if isDetermined && loginViewModel.didLoginSuccessfully {
                print("LoginPageView: determinedInitialView is now \(isDetermined) after login. Triggering main page navigation determination.")
                userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
            }
        }
        .onAppear {
            loginViewModel.didLoginSuccessfully = false
            userViewModel.resetOnboardingDataForNewUser()
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .background(
            Group {
                // Tambahkan kondisi if loginViewModel.didLoginSuccessfully di sini
                if loginViewModel.didLoginSuccessfully {
                    NavigationLink(
                        destination: JapaneseMainPageView(userViewModel: self.userViewModel) // Teruskan instance userViewModel
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        isActive: $userViewModel.navigateToJapaneseMain, //
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: Text("Korean Main Page - Placeholder")
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        isActive: $userViewModel.navigateToKoreanMain,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: Text("Chinese Main Page - Placeholder")
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        isActive: $userViewModel.navigateToChineseMain,
                        label: { EmptyView() }
                    )
                    NavigationLink(
                        destination: ChooseLanguagePageView()
                            .navigationBarBackButtonHidden(true),
                        isActive: $userViewModel.needsOnboarding,
                        label: { EmptyView() }
                    )
                } else {
                    EmptyView() // Jika belum login, jangan tampilkan NavigationLink programmatic
                }
            }
        )
    }

    @State private var offsetY: CGFloat = 0
    @State private var isArrowUp = true
    @State private var showForm = false
    @State private var isPasswordVisible = false
    let activeColor = Color(red:255/255, green:195/255, blue:130/255)
}

// Preview Anda
struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginPageView()
        }
    }
}
