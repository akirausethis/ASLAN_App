import SwiftUI

struct KoreanGrammarDetailView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema

    let materials: GrammarMaterial

    @State private var isShowingCompletionNotification: Bool = false
    @State private var completionNotificationMessage: String = ""
    @State private var completionNotificationIsSuccess: Bool = true

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        // Header Topik
                        topicHeaderView

                        // Bagian Penjelasan
                        SectionView(title: "Explanation", iconName: "text.alignleft", titleColor: themeManager.accentColor) { // 3. Gunakan warna tema
                            explanationContentView
                        }

                        // Bagian Contoh
                        SectionView(title: "Examples", iconName: "list.bullet.rectangle.portrait", titleColor: themeManager.accentColor) { // 4. Gunakan warna tema
                            examplesContentView
                        }

                        // Bagian Tip (tetap oranye untuk penekanan)
                        if let tip = materials.tip, !tip.isEmpty {
                            SectionView(title: "💡 Tip", iconName: "lightbulb.fill", titleColor: .orange) {
                                tipContentView(tip: tip)
                            }
                        }

                        Spacer()
                        
                        // Tombol Complete (tetap hijau untuk makna "sukses")
                        Button(action: {
                            progressViewModel.userCompletedCourse(
                                courseTitle: materials.courseTitle,
                                topicTitle: materials.topicTitle,
                                category: "Grammar"
                            )
                            
                            completionNotificationMessage = "You've completed this topic!"
                            completionNotificationIsSuccess = true
                            withAnimation {
                                isShowingCompletionNotification = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Complete This Topic")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green) // Tetap hijau
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 5)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 90)
                }
                .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                .navigationTitle(materials.courseTitle)
                .navigationBarTitleDisplayMode(.inline)

                // Notifikasi
                if isShowingCompletionNotification {
                    NotificationView(message: completionNotificationMessage, isSuccess: completionNotificationIsSuccess, isShowing: $isShowingCompletionNotification)
                        .padding(.top, geometry.safeAreaInsets.top + 5)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                }
            }
        }
    }

    // MARK: - Computed Properties for Subviews
    private var topicHeaderView: some View {
        Text(materials.topicTitle)
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
            .padding(.bottom, 15)
    }

    private var explanationContentView: some View {
        Text(materials.explanation)
            .font(.system(size: 16, weight: .regular))
            .lineSpacing(7)
            .foregroundColor(Color(UIColor.label))
    }

    private var examplesContentView: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(materials.examples) { example in
                ExampleSentenceView(example: example)
            }
        }
    }

    private func tipContentView(tip: String) -> some View {
        Text(tip)
            .font(.system(size: 16, weight: .regular))
            .lineSpacing(6)
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(10)
            .foregroundColor(Color(UIColor.label))
    }
}

// MARK: - Subview untuk Example Sentence (Tidak berubah)
struct ExampleSentenceView: View {
    let example: ExampleSentence
    // ... isi body tetap sama
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(example.japanese)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.primary)
            Text(example.romaji)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color.gray)
            Text(example.english)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color.secondary)
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

// MARK: - SectionView Helper
// Di sini kita tidak perlu mengubah apa pun karena warna sudah diteruskan sebagai parameter
struct SectionView<Content: View>: View {
    let title: String
    let iconName: String
    var titleColor: Color
    let content: Content

    init(title: String, iconName: String, titleColor: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.iconName = iconName
        self.titleColor = titleColor
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(titleColor) // Warna akan dinamis dari parameter
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(titleColor) // Warna akan dinamis dari parameter
            }
            .padding(.horizontal, 5)
            content
        }
    }
}

#Preview {
    NavigationView {
        Group {
            if let firstMaterial = KoreanGrammarContentData.allMaterials.first {
                KoreanGrammarDetailView(materials: firstMaterial)
                    .environmentObject(ProgressViewModel())
                    .environmentObject(ThemeManager()) // Jangan lupa tambahkan di preview
            } else {
                Text("No Korean grammar material available for preview.")
            }
        }
    }
}
