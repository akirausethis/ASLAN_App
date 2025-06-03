//
//  LoginView.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// File: LoginPageView.swift
import SwiftUI

struct LoginPageView: View {
    @StateObject private var loginViewModel = LoginPageViewModel() // ViewModel untuk proses login Auth
    // Inisialisasi UserViewModel di sini juga untuk menangani alur setelah login
    @StateObject private var userViewModel = UserViewModel()

    @State private var showForm = false
    @State private var offsetY: CGFloat = 0
    @State private var isArrowUp = true
    @State private var isPasswordVisible = false
    let activeColor = Color(red:255/255, green:195/255, blue:130/255)

    var body: some View {
        ZStack {
            // UI Form Login Anda
            VStack {
                 Spacer(minLength: 200)
                VStack {
                    Image("orang_duduk").resizable().scaledToFit().frame(width: 350, height: 150)
                    Text("Don't stop your journey").font(.subheadline).foregroundColor(.black)
                    Text("Login to your account").font(.title).fontWeight(.bold)
                }.offset(y: offsetY)
                VStack {
                    Spacer()
                    Image(systemName: isArrowUp ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                        .resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(.blue)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                if isArrowUp { offsetY = -50; showForm = true; isArrowUp = false }
                                else { offsetY = 0; showForm = false; isArrowUp = true }
                            }
                        }
                }
                if showForm {
                    VStack(spacing: 15) {
                        Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white)
                        Text("Continue your Journey!").font(.subheadline).foregroundColor(.white)
                        VStack(alignment: .leading, spacing: 5) {
                             HStack(spacing: 5) {
                                Image(systemName: "envelope.fill").foregroundColor(activeColor)
                                Text("Email Address").font(.footnote).foregroundColor(.white)
                            }
                            TextField("Enter your email", text: $loginViewModel.email).padding().frame(height: 50)
                                .background(Color.white).cornerRadius(10).keyboardType(.emailAddress).autocapitalization(.none)
                                .textContentType(.emailAddress)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 5) {
                                Image(systemName: "lock.fill").foregroundColor(activeColor)
                                Text("Password").font(.footnote).foregroundColor(.white)
                            }
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible {
                                    TextField("Enter your password", text: $loginViewModel.password).padding().frame(height: 50)
                                        .background(Color.white).cornerRadius(10).textContentType(.password)
                                } else {
                                    SecureField("Enter your password", text: $loginViewModel.password).padding().frame(height: 50)
                                        .background(Color.white).cornerRadius(10).textContentType(.password)
                                }
                                Button(action: { withAnimation(.easeInOut(duration: 0.2)) { isPasswordVisible.toggle() }}) {
                                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.gray).frame(width: 22, height: 22)
                                }.padding(.trailing, 15)
                            }
                        }
                        Button(action: {
                            loginViewModel.validateAndLogin()
                        }) {
                            Text("Login").fontWeight(.bold).foregroundColor(.white).padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(activeColor)
                                .cornerRadius(10)
                        }.padding(.horizontal, 30)
                        .disabled(loginViewModel.email.isEmpty || loginViewModel.password.isEmpty /* || loginViewModel.isLoggingIn */)

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
            
            // Grup NavigationLink untuk setelah login berhasil (diletakkan di ZStack agar selalu ada)
        }
        .onChange(of: loginViewModel.didLoginSuccessfully) { isLoggedIn in
            if isLoggedIn {
                print("LoginPageView: Login successful, fetching user profile...")
                // Panggil fetchUserProfile dari userViewModel yang ada di scope LoginPageView
                userViewModel.fetchUserProfile()
            }
        }
        // Pastikan Anda menangani navigasi setelah fetchUserProfile di UserViewModel selesai
        .onChange(of: userViewModel.determinedInitialView) { isDetermined in
            if isDetermined && loginViewModel.didLoginSuccessfully {
                print("LoginPageView: determinedInitialView is now \(isDetermined) after login. Triggering main page navigation determination.")
                userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
            }
        }
        .onAppear {
            loginViewModel.didLoginSuccessfully = false
            // Reset UserViewModel setiap kali halaman login muncul,
            // agar jika pengguna logout lalu login lagi, datanya fresh.
            userViewModel.resetOnboardingDataForNewUser()
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .background( // Pindahkan NavLink ke .background agar tidak mengganggu layout ZStack
            Group {
                NavigationLink(
                    destination: JapaneseMainPageView().navigationBarBackButtonHidden(true).navigationBarHidden(true),
                    isActive: $userViewModel.navigateToJapaneseMain,
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

                NavigationLink( // Jika perlu onboarding setelah login
                    destination: ChooseLanguagePageView() // Ini akan membuat UserViewModel baru untuk alur onboarding
                        .navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.needsOnboarding, // UserViewModel menentukan apakah perlu onboarding
                    label: { EmptyView() }
                )
            }
        )
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginPageView()
        }
    }
}
