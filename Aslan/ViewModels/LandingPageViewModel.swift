//
//  LandingPageViewModel.swift
//  Aslan
//
//  Created by Student on 21/05/25.
//

// File: ViewModels/LandingPageViewModel.swift

import SwiftUI
// import FirebaseAuth // Tidak lagi diperlukan di sini jika hanya untuk menampilkan landing

class LandingPageViewModel: ObservableObject {
    // Properti isUserLoggedIn tidak lagi digunakan untuk logika utama di LandingPageView,
    // karena LandingPageView akan selalu ditampilkan di awal.
    // @Published var isUserLoggedIn: Bool = false

    // showForm dan startLearning mungkin masih relevan untuk UI internal LandingPageView jika ada.
    @Published var showForm: Bool = false // Ini dari kode Anda, fungsinya belum jelas di UI LandingPage

    init() {
        print("LandingPageViewModel: Initialized.")
        // Tidak ada lagi pengecekan status login otomatis di sini.
    }

    // Fungsi ini mungkin tidak lagi relevan jika LandingPage selalu tampil.
    // func checkUserLoginStatus() {
    //     isUserLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn_firebase_auth")
    //     print("LandingPageViewModel: User Logged In Status from UserDefaults: \(isUserLoggedIn)")
    // }
    
    func startLearning() { // Fungsi dari kode Anda
        showForm = true
    }
}
