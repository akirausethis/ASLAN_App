//
//  RegisterPageViewModel.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

import Foundation
import FirebaseAuth

class RegisterPageViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var didRegisterSuccessfully: Bool = false

    func validateAndRegister() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Email and Password are required!"
            showAlert = true
            didRegisterSuccessfully = false
            return
        }
        
        if !isValidEmail(email) {
            alertMessage = "Invalid email format."
            showAlert = true
            didRegisterSuccessfully = false
            return
        }

        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            didRegisterSuccessfully = false
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    self.didRegisterSuccessfully = false
                    print("Firebase registration error: \(error.localizedDescription)")
                } else {
                    print("User registered successfully! UID: \(authResult?.user.uid ?? "N/A")")
                    self.alertMessage = ""
                    self.showAlert = false

                    self.didRegisterSuccessfully = true
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
