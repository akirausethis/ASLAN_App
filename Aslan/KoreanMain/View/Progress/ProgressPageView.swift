import SwiftUI

struct ProgressPageView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @EnvironmentObject var themeManager: ThemeManager

    @State private var selectedCategory: String = "All"
    
    // --- PERBAIKAN DI SINI ---
    // Ubah "Flashcards" (plural) menjadi "Flashcard" (singular) agar cocok dengan data.
    private let categories = ["All", "Flashcard", "Writing", "Speaking", "Grammar", "Quiz"]

    private var filteredItems: [CompletedCourseDisplayItem] {
        if selectedCategory == "All" {
            // Logika sorting tidak perlu diubah
            return progressViewModel.completedCourseItems.sorted {
                if $0.category != $1.category { return $0.category < $1.category }
                if $0.title != $1.title { return $0.title < $1.title }
                return ($0.topicTitle ?? "") < ($1.topicTitle ?? "")
            }
        } else {
            // Logika filter sekarang akan berfungsi dengan benar
            return progressViewModel.completedCourseItems.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    CircularProgressView(
                        progress: progressViewModel.progressPercentage,
                        totalCompleted: progressViewModel.totalCompletedCount,
                        totalPossible: progressViewModel.totalPossibleCourses
                    )
                    .padding(.vertical, 20)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                       selectedCategory = category
                                    }
                                }) {
                                    // Tampilan tombol ini tidak perlu diubah,
                                    // karena sekarang akan menggunakan nama kategori yang benar
                                    Text(category)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 15)
                                        .background(selectedCategory == category ? themeManager.accentColor : Color(UIColor.secondarySystemGroupedBackground))
                                        .foregroundColor(selectedCategory == category ? .white : themeManager.accentColor)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 15)
                    
                    Text("Completion History")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 5)

                    ScrollView {
                        if progressViewModel.isLoading {
                            ProgressView("Loading history...")
                                .padding()
                        } else if filteredItems.isEmpty {
                            // Pesan ini sekarang akan tampil dengan benar jika memang tidak ada data
                            Text(selectedCategory == "All" ? "No topics completed yet." : "No '\(selectedCategory)' topics completed yet.")
                                .foregroundColor(.gray)
                                .padding(40)
                                .frame(maxHeight: .infinity)
                        } else {
                            LazyVStack(spacing: 0) {
                                ForEach(filteredItems) { item in
                                    CompletedCourseRow(item: item)
                                        .padding(.horizontal)
                                    Divider().padding(.leading, 68)
                                }
                            }
                            .padding(.bottom, geometry.safeAreaInsets.bottom + 90)
                        }
                    }
                }
                .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                .navigationTitle("My Progress")
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    progressViewModel.fetchUserProgress(userID: "dummyUser")
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

// Tidak ada perubahan yang diperlukan pada CompletedCourseRow
struct CompletedCourseRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let item: CompletedCourseDisplayItem

    private var subtitleText: String {
        if let topic = item.topicTitle, !topic.isEmpty {
            return topic
        }
        return item.category
    }

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.iconName.isEmpty ? "questionmark.circle.fill" : item.iconName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .background(themeManager.accentColor.gradient)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .fontWeight(.medium)
                Text(subtitleText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct ProgressPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressPageView()
            .environmentObject(ProgressViewModel())
            .environmentObject(ThemeManager())
    }
}
