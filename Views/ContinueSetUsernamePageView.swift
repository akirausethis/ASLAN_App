//
//  ContinueSetUsernamePageView.swift
//  Aslan
//
//  Created by Student on 28/05/25.
//

import SwiftUI
import FirebaseAuth     
import FirebaseDatabase

struct ContinueSetUsernamePageView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var displayName: String
    @State private var animateCheckmark: Bool = false
    @State private var navigateToMainApp: Bool = false

    private var dbRef: DatabaseReference = Database.database().reference()

    let peachColor = Color(red: 253/255, green: 213/255, blue: 179/255)

    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        self._displayName = State(initialValue: userViewModel.username.isEmpty ? "User" : userViewModel.username)
    }

    func confirmUsernameFromDB() {
        guard let currentUser = Auth.auth().currentUser else {
            print("Cannot confirm username: User not authenticated.")
            return
        }
        let userID = currentUser.uid

        dbRef.child("users").child(userID).child("profileDetails").child("username").observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists(), let fetchedName = snapshot.value as? String, !fetchedName.isEmpty {
                print("Username from DB: \(fetchedName). Currently displaying: \(self.displayName)")
            } else {
                print("Username not found/empty in DB, or not a String. Display name remains: \(self.displayName)")
            }
        } withCancel: { error in
            print("Failed to fetch/confirm username from DB: \(error.localizedDescription)")
        }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()

                Image("orang_jabattangan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)

                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(peachColor)
                    .scaleEffect(animateCheckmark ? 1.0 : 0.2)
                    .opacity(animateCheckmark ? 1.0 : 0.0)
                    .padding(.top, 10)
                    .padding(.bottom, 5)

                Text("Hello, \(displayName)!")
                    .font(.system(size: 26, weight: .bold))
                    .multilineTextAlignment(.center)

                Text("Let's start your Journey!")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 20)

                Button(action: {
                    self.navigateToMainApp = true
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)

                Spacer()
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.edgesIgnoringSafeArea(.all))

            NavigationLink(
                destination: Text("HALAMAN UTAMA APLIKASI ANDA")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true),
                isActive: $navigateToMainApp,
                label: { EmptyView() }
            )
        }
        .onAppear {
            confirmUsernameFromDB()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.55, blendDuration: 0.1)) {
                    self.animateCheckmark = true
                }
            }
            
            if self.navigateToMainApp {
                self.navigateToMainApp = false
            }
        }
    }
}

struct ContinueSetUsernamePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let previewVM = UserViewModel()
            previewVM.username = "Kenneth"
            return ContinueSetUsernamePageView(userViewModel: previewVM)
        }
    }
}
