// File: Aslan/KoreanMain/View/Profile/KoreanProfileView.swift

import SwiftUI

// MARK: - Main Profile View
struct ProfileView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var showingEditSheet = false
    @State private var showingAppearanceSheet = false
    @State private var animate = false
    
    // Computed property yang membaca langsung dari EnvironmentObject.
    // Ini memastikan view selalu menampilkan data terbaru.
    private var displayUserName: String {
        userViewModel.currentUsername ?? "Aslan User"
    }
    
    private var displayUserEmail: String {
        userViewModel.currentEmail ?? "user@example.com"
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header dengan Avatar
                VStack(spacing: 10) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 45))
                        .padding(20)
                        .background(Circle().fill(Color.white.opacity(0.2)))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.8), lineWidth: 3))
                        .shadow(radius: 10)

                    // Tampilkan nama dan email dari computed property yang reaktif
                    Text(displayUserName)
                        .font(.title).fontWeight(.bold).foregroundColor(.white)
                    
                    Text(displayUserEmail)
                        .font(.subheadline).foregroundColor(.white.opacity(0.8))
                    
                    Button(action: { showingEditSheet = true }) {
                        Text("Edit Profile")
                            .font(.footnote).fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12).padding(.vertical, 5)
                            .background(Color.white.opacity(0.25)).cornerRadius(12)
                    }
                    .padding(.top, 4)
                }
                .padding(.top, 50).padding(.bottom, 30)
                .frame(maxWidth: .infinity)
                .background(themeManager.accentColor.gradient)

                // Bagian "Learning Activity"
                VStack(alignment: .leading) {
                    Text("Learning Activity")
                        .font(.headline).fontWeight(.bold)
                        .padding([.leading, .top]).padding(.bottom, 5)
                    
                    ProfileRowView(item: ProfileRowItem(iconName: "checkmark.circle.fill", iconColor: .green, label: "Courses Completed", value: "\(progressViewModel.totalCompletedCount)"))
                        .padding(.horizontal)
                    
                    Divider().padding(.horizontal)

                    // Mengambil nama kursus terakhir dari ViewModel
                    ProfileRowView(item: ProfileRowItem(
                        iconName: "book.fill",
                        iconColor: .orange,
                        label: "Last Course Opened",
                        value: progressViewModel.lastCourseName
                    ))
                    .padding(.horizontal)
                }
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Menu dan Tombol Logout
                MenuAndLogoutButtons(showingAppearanceSheet: $showingAppearanceSheet)

            }
            .padding(.bottom, 140)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 10)
            .animation(.easeOut(duration: 0.4), value: animate)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $showingEditSheet) {
            // Teruskan seluruh ViewModel ke sheet
            EditProfileSheet(userViewModel: userViewModel)
        }
        .sheet(isPresented: $showingAppearanceSheet) {
            AppearanceView()
        }
        .onAppear {
            // Logika .onAppear sekarang lebih sederhana
            animate = true
            progressViewModel.fetchUserProgress(userID: "dummyUser")
        }
    }
}


// MARK: - Sub-view untuk merapikan kode
private struct MenuAndLogoutButtons: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var showingAppearanceSheet: Bool
    
    @State private var showingLogoutAlert: Bool = false
    
    private let accountItems: [ProfileRowItem] = [
        ProfileRowItem(iconName: "paintpalette.fill", iconColor: .purple, label: "Appearance"),
    ]
    private let supportItems: [ProfileRowItem] = [
        ProfileRowItem(iconName: "questionmark.circle.fill", iconColor: .blue, label: "Help Center"),
    ]

    var body: some View {
        VStack {
            // Menu Section
            VStack(alignment: .leading) {
                Section {
                    ForEach(accountItems) { item in
                        if item.label == "Appearance" {
                            Button(action: { showingAppearanceSheet = true }) {
                                ProfileRowView(item: item)
                            }.buttonStyle(.plain)
                        }
                        if item.id != accountItems.last?.id { Divider().padding(.leading, 50) }
                    }
                } header: {
                    Text("Account").font(.headline).fontWeight(.bold)
                        .padding([.leading, .top]).padding(.bottom, 5)
                }
                
                Section {
                    ForEach(supportItems) { item in
                         if item.label == "Help Center" {
                            NavigationLink(destination: ChatbotView()) {
                                ProfileRowView(item: item)
                            }
                        }
                    }
                } header: {
                    Text("Support & Feedback").font(.headline).fontWeight(.bold)
                        .padding([.leading, .top]).padding(.bottom, 5)
                }
            }
            .padding(.horizontal)
            
            // Tombol Logout
            Button(action: {
                showingLogoutAlert = true
            }) {
                Text("Sign Out")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .alert("Confirm Logout", isPresented: $showingLogoutAlert) {
            Button("Yes, Logout", role: .destructive) {
                userViewModel.logout()
            }
            Button("No", role: .cancel) {}
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
}


// MARK: - Helper Views
struct ProfileRowItem: Identifiable {
    let id = UUID()
    let iconName: String
    let iconColor: Color
    let label: String
    var value: String? = nil
}

struct ProfileRowView: View {
    let item: ProfileRowItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: item.iconName)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(item.iconColor)
                .frame(width: 30, height: 30)
                .background(item.iconColor.opacity(0.1))
                .clipShape(Circle())

            Text(item.label)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            if let value = item.value {
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.secondary.opacity(0.7))
            }
        }
        .padding(.vertical, 12)
    }
}

struct EditProfileSheet: View {
    // Terima ViewModel sebagai ObservedObject
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    // State lokal untuk menampung editan sementara
    @State private var tempUserName: String
    @State private var tempUserEmail: String
    
    // Custom initializer untuk mengisi state lokal dari ViewModel
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        self._tempUserName = State(initialValue: userViewModel.currentUsername ?? "")
        self._tempUserEmail = State(initialValue: userViewModel.currentEmail ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $tempUserName)
                    TextField("Email Address", text: $tempUserEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Simpan perubahan kembali ke ViewModel
                        userViewModel.currentUsername = tempUserName
                        userViewModel.currentEmail = tempUserEmail
                        
                        // TODO: Tambahkan fungsi di UserViewModel untuk menyimpan
                        // data yang sudah diperbarui ini ke Firebase.
                        
                        dismiss()
                    }.fontWeight(.bold)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let mockUserViewModel = UserViewModel()
    let mockProgressViewModel = ProgressViewModel()
    let mockThemeManager = ThemeManager()

    mockUserViewModel.currentUsername = "Kenneth Preview"
    mockUserViewModel.currentEmail = "kenneth@preview.com"
    mockProgressViewModel.lastCourseName = "Basic Particles"
    mockProgressViewModel.totalCompletedCount = 10

    return NavigationView {
        ProfileView()
    }
    .environmentObject(mockUserViewModel)
    .environmentObject(mockProgressViewModel)
    .environmentObject(mockThemeManager)
}
