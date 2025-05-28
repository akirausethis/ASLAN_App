//
//  LandingPageViewModel.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

import SwiftUI

class LandingPageViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    @Published var showForm: Bool = false
    
    func checkUserLoginStatus() {
        isUserLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func startLearning() {
        showForm = true
    }
}
