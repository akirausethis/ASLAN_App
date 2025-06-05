// AslanApp/View/Profile/ProfileView.swift
import SwiftUI

// Asumsikan Anda memiliki struct atau class untuk data pengguna
struct UserProfile {
    var name: String = "Pengguna Aslan"
    var email: String = "pengguna@example.com"
    var joinDate: Date = Calendar.current.date(byAdding: .year, value: -1, to: Date())! // Bergabung setahun lalu
    var profileImageName: String? = "person.circle.fill" // Nama SF Symbol atau nama aset gambar
}

// Asumsikan Anda memiliki ViewModel untuk data progres jika diperlukan
// class ProfileViewModel: ObservableObject {
//     @Published var coursesCompleted: Int = 10
//     @Published var lessonsCompleted: Int = 150
//     // ... data progres lainnya
// }

struct ProfileView: View {
    @State private var userProfile = UserProfile() // Data pengguna dummy
    // @StateObject private var profileViewModel = ProfileViewModel() // Jika menggunakan ViewModel

    // State untuk pengaturan (contoh)
    @State private var SelesaikanNotifikasi: Bool = true
    @State private var darkModeEnabled: Bool = false // Anda perlu mengelola ini dengan AppStorage atau UserDef.

    var body: some View {
        NavigationView {
            List {
                // MARK: - User Info Section
                Section {
                    HStack(spacing: 15) {
                        if let imageName = userProfile.profileImageName {
                            Image(systemName: imageName) // Ganti dengan Image(userProfile.imageName) jika dari aset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                                .padding(.vertical, 5)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(userProfile.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(userProfile.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Bergabung: \(userProfile.joinDate, style: .date)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground)) // Menghilangkan background default baris jika perlu


                // MARK: - Progres Belajar (Contoh)
                Section(header: Text("Progres Belajar Saya").font(.headline).padding(.leading, -5)) {
                    InfoRow(iconName: "graduationcap.fill", iconColor: .blue, title: "Kursus Selesai", value: "5") // Ganti dengan data dari ViewModel
                    InfoRow(iconName: "book.closed.fill", iconColor: .green, title: "Pelajaran Selesai", value: "72")
                    InfoRow(iconName: "flame.fill", iconColor: .orange, title: "Streak Harian", value: "12 Hari")
                }

                // MARK: - Pengaturan Aplikasi
                Section(header: Text("Pengaturan").font(.headline).padding(.leading, -5)) {
                    Toggle(isOn: $SelesaikanNotifikasi) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.purple)
                            Text("Notifikasi Kursus")
                        }
                    }

                    // Contoh pengaturan Dark Mode (memerlukan logika lebih lanjut)
                    // Toggle(isOn: $darkModeEnabled) {
                    //     HStack {
                    //         Image(systemName: darkModeEnabled ? "moon.fill" : "sun.max.fill")
                    //             .foregroundColor(.yellow)
                    //         Text("Mode Gelap")
                    //     }
                    // }
                    // .onChange(of: darkModeEnabled) { oldValue, newValue in
                    //     // Implementasikan logika untuk mengubah tema aplikasi
                    //     // Misalnya dengan mengubah preferredColorScheme
                    //     guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    //     windowScene.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                    // }


                    NavigationLink(destination: Text("Halaman Bantuan (Belum Dibuat)")) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.orange)
                            Text("Bantuan & Dukungan")
                        }
                    }
                    NavigationLink(destination: Text("Halaman Tentang Aplikasi (Belum Dibuat)")) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.teal)
                            Text("Tentang Aplikasi")
                        }
                    }
                }

                // MARK: - Akun
                Section(header: Text("Akun").font(.headline).padding(.leading, -5)) {
                    Button(action: {
                        // Aksi untuk keluar
                        print("Pengguna keluar")
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.square.fill")
                            Text("Keluar")
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle()) // Style list yang modern
            .navigationTitle("Profil Saya")
        }
    }
}

// Helper View untuk baris info dengan ikon
struct InfoRow: View {
    let iconName: String
    let iconColor: Color
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
                .frame(width: 25, alignment: .center)
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ProfileView()
        // .environmentObject(ProfileViewModel()) // Jika Anda menggunakan ProfileViewModel
}
