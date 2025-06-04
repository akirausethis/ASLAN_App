// AslanApp/View/Progress/ProgressPageView.swift
import SwiftUI

struct ProgressPageView: View {
    @StateObject private var viewModel = ProgressViewModel()
    // Anda mungkin perlu @EnvironmentObject untuk user ID jika menggunakan Firebase Auth

    var body: some View {
        GeometryReader { geometry in // Tambahkan GeometryReader
            NavigationView { // Untuk judul navigation bar
                ScrollView {
                    VStack(spacing: 25) {
                        // Lingkaran Progress
                        CircularProgressView(
                            progress: viewModel.progressPercentage,
                            totalCompleted: viewModel.totalCompletedCount,
                            totalPossible: viewModel.totalPossibleCourses
                        )
                        .padding(.top, 30)
                        .padding(.bottom, 20)

                        // Histori Penyelesaian
                        VStack(alignment: .leading) {
                            Text("Completion History")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                                .padding(.bottom, 5)

                            if viewModel.isLoading {
                                ProgressView("Loading history...")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            } else if viewModel.completedCourseItems.isEmpty {
                                Text("No courses completed yet. Keep learning!")
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                // Daftar kursus yang sudah selesai
                                // Dibuat agar tidak menggunakan List agar bisa di dalam ScrollView utama
                                // dan tidak ada efek visual List default
                                ForEach(viewModel.completedCourseItems) { item in
                                    CompletedCourseRow(item: item)
                                    Divider().padding(.leading)
                                }
                                .padding(.horizontal)
                            }
                        }
                        Spacer() // Mendorong konten ke atas jika sedikit
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 10) // Sesuaikan padding bawah
                }
                .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea()) // Latar belakang abu-abu muda
                .navigationTitle("My Progress") // Judul di Navigation Bar
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    // Panggil fetchUserProgress saat view muncul.
                    // Ganti "dummyUser" dengan User ID yang sebenarnya dari Firebase Auth.
                    viewModel.fetchUserProgress(userID: "dummyUser") // Memastikan data di-load ulang setiap kali page muncul
                }
            }
            .navigationViewStyle(StackNavigationViewStyle()) // Untuk konsistensi navigasi
        }
    }
}

// View untuk satu baris di histori
struct CompletedCourseRow: View {
    let item: CompletedCourseDisplayItem

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.iconName.isEmpty ? "questionmark.circle.fill" : item.iconName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .background(Color.blue) // Warna background ikon bisa disesuaikan
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .fontWeight(.medium)
                Text(item.category) // Tampilkan kategori kursus
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    ProgressPageView()
}
