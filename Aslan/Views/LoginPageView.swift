// File: Aslan/Views/LoginPageView.swift
import SwiftUI

struct LoginPageView: View {
    @StateObject private var loginViewModel = LoginPageViewModel()
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var showForm = false
    @State private var offsetY: CGFloat = 0
    @State private var isArrowUp = true
    @State private var isPasswordVisible = false
    let activeColor = Color(red:255/255, green:195/255, blue:130/255)

    var body: some View {
        ZStack {
            mainLoginContent

            if loginViewModel.didLoginSuccessfully && userViewModel.isLoadingProfile {
                Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                ProgressView("Checking your profile...")
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .alert(isPresented: $loginViewModel.showAlert) {
            Alert(title: Text("Login Failed"), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onChange(of: loginViewModel.didLoginSuccessfully) { newValue in
            if newValue {
                userViewModel.fetchUserProfile()
            }
        }
        .onChange(of: userViewModel.determinedInitialView) { isDetermined in
             if isDetermined && loginViewModel.didLoginSuccessfully {
                 userViewModel.determineMainPageNavigationBasedOnStoredLanguage()
             }
        }
        .onAppear {
            loginViewModel.didLoginSuccessfully = false
            userViewModel.resetOnboardingDataForNewUser()
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            hideKeyboard()
        }
        .background(programmaticNavigationLinks)
    }

    private var mainLoginContent: some View {
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
                loginForm
            }
            Spacer()
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

    private var loginForm: some View {
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
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: "lock.fill").foregroundColor(activeColor)
                    Text("Password").font(.footnote).foregroundColor(.white)
                }
                ZStack(alignment: .trailing) {
                    if isPasswordVisible {
                        TextField("Enter your password", text: $loginViewModel.password).padding().frame(height: 50)
                            .background(Color.white).cornerRadius(10)
                    } else {
                        SecureField("Enter your password", text: $loginViewModel.password).padding().frame(height: 50)
                            .background(Color.white).cornerRadius(10)
                    }
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }.padding(.trailing, 15)
                }
            }
            
            Button(action: {
                loginViewModel.validateAndLogin()
            }) {
                Text("Login").fontWeight(.bold).foregroundColor(.white).padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(loginViewModel.email.isEmpty || loginViewModel.password.isEmpty ? Color.gray.opacity(0.5) : activeColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
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
    
    @ViewBuilder
    private var programmaticNavigationLinks: some View {
        if loginViewModel.didLoginSuccessfully && userViewModel.determinedInitialView {
            Group {
                NavigationLink(
                    destination: AnimatedNavbar(userViewModel: self.userViewModel).navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.navigateToKoreanMain,
                    label: { EmptyView() }
                )
                NavigationLink(
                    destination: ChooseLanguagePageView().environmentObject(self.userViewModel).navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.needsOnboarding,
                    label: { EmptyView() }
                )
            }
        } else {
            EmptyView()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
