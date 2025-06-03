//
//  LoginPageViewModel.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

import Foundation
import FirebaseAuth

class LoginPageViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    @Published var didLoginSuccessfully: Bool = false

    func validateAndLogin() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Email and Password are required!"
            showAlert = true
            didLoginSuccessfully = false
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    self.didLoginSuccessfully = false
                    print("Firebase login error: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully! UID: \(authResult?.user.uid ?? "N/A")")
                    self.alertMessage = ""
                    self.showAlert = false
                    
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    self.didLoginSuccessfully = true
                    
                }
            }
        }
    }
}
