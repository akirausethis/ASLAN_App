//
//  ContinueRegisterPageView.swift
//  Aslan
//
//  Created by student on 23/05/25.
//

// File: Views/ContinueRegisterPageView.swift
// Menggunakan kode terakhir yang Anda berikan, yang sudah benar memanggil
// ChooseLanguagePageView() tanpa argumen.
// Fungsi markAsContinuedFromRegister() Anda juga sudah ada di sana.
// Tidak ada perubahan besar diperlukan di sini jika sudah sesuai dengan versi terakhir Anda.
// Pastikan import Firebase Auth & Database ada jika markAsContinuedFromRegister memerlukannya.
import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ContinueRegisterPageView: View {
    @State private var navigateToChooseLanguage: Bool = false
    @State private var isSavingStatus: Bool = false
    @State private var saveError: String? = nil
    private var dbRef: DatabaseReference = Database.database().reference()

    // Fungsi ini dari kode Anda
    private func markAsContinuedFromRegisterAndNavigate() {
        guard let currentUser = Auth.auth().currentUser else {
            self.saveError = "User not authenticated."
            self.navigateToChooseLanguage = true
            return
        }
        let userID = currentUser.uid
        isSavingStatus = true
        saveError = nil
        
        let statusData: [String: Any] = ["hasSeenContinueRegisterPage": true, "timestamp": ServerValue.timestamp()]
        dbRef.child("users").child(userID).child("onboardingStatus").child("passedContinueRegister").setValue(statusData) { error, _ in
            DispatchQueue.main.async {
                self.isSavingStatus = false
                if let error = error { self.saveError = error.localizedDescription }
                self.navigateToChooseLanguage = true
            }
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("orang_berbicara")
                    .resizable().scaledToFit().frame(width: 300, height: 300)
                    .padding(.bottom, 20)
                Text("Before we get any further")
                    .font(.title).fontWeight(.bold).multilineTextAlignment(.center)
                    .padding(.horizontal, 20).padding(.bottom, 5)
                Text("Let us know you by answering some question")
                    .font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center)
                    .padding(.horizontal, 40).padding(.bottom, 40)
                
                if let error = saveError {
                    Text(error).font(.caption).foregroundColor(.red).padding(.bottom, 10)
                }

                Button(action: {
                    markAsContinuedFromRegisterAndNavigate()
                }) {
                    if isSavingStatus {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity).frame(height: 50)
                            .background(Color.blue.opacity(0.7)).cornerRadius(10)
                    } else {
                        Text("Continue")
                            .fontWeight(.bold).foregroundColor(.white).padding()
                            .frame(maxWidth: .infinity).frame(height: 50)
                            .background(Color.blue).cornerRadius(10)
                    }
                }
                .disabled(isSavingStatus)
                .padding(.horizontal, 40).padding(.bottom, 30)
                Spacer()
            }
            .padding().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)

            NavigationLink(
                destination: ChooseLanguagePageView() // Panggil tanpa argumen
                    .navigationBarBackButtonHidden(true),
                isActive: $navigateToChooseLanguage,
                label: { EmptyView() }
            )
        }
        .onAppear {
            if navigateToChooseLanguage { navigateToChooseLanguage = false }
            saveError = nil
        }
    }
}

struct ContinueRegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContinueRegisterPageView()
        }
    }
}
