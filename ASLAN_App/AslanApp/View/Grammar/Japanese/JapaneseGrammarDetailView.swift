// AslanApp/View/Grammar/JapaneseGrammarDetailView.swift
import SwiftUI

struct JapaneseGrammarDetailView: View {
    let material: GrammarMaterial

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {

                // Judul Topik Utama
                Text(material.topicTitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center) // Untuk memastikan semua baris di tengah
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20) // Tambah padding atas
                    .padding(.bottom, 15)

                // Bagian Penjelasan
                SectionView(title: "Explanation", iconName: "text.alignleft") {
                    Text(material.explanation)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(7)
                        .foregroundColor(Color(UIColor.label))
                }

                // Bagian Contoh Kalimat
                SectionView(title: "Examples", iconName: "list.bullet.rectangle.portrait") {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(material.examples) { example in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(example.japanese)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color.primary)
                                Text(example.romaji)
                                    .font(.system(size: 15, weight: .regular))
                                    .italic()
                                    .foregroundColor(Color.gray)
                                Text(example.english)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(Color.secondary)
                            }
                            .padding(15) // Padding internal untuk setiap kotak contoh
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                        }
                    }
                }

                // Bagian Tip (Opsional)
                if let tip = material.tip, !tip.isEmpty {
                    SectionView(title: "💡 Tip", iconName: "lightbulb.fill", titleColor: .orange) {
                        Text(tip)
                            .font(.system(size: 16, weight: .regular))
                            .lineSpacing(6)
                            .padding(15) // Padding internal untuk kotak tip
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(Color(UIColor.label))
                    }
                }
                
                Spacer()
            }
            // Padding horizontal utama untuk seluruh konten di dalam ScrollView
            .padding(.horizontal, 24) // Lebih besar agar tidak mepet
            .padding(.bottom, 30)    // Padding bawah lebih besar
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(material.courseTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// SectionView helper (tetap sama)
struct SectionView<Content: View>: View {
    let title: String
    var iconName: String? = nil
    var titleColor: Color = .blue
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.title3)
                        .foregroundColor(titleColor)
                }
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(titleColor)
            }
            .padding(.bottom, 4)

            content
        }
        .padding(.vertical, 10) // Padding vertikal untuk setiap SectionView
    }
}


#Preview {
    NavigationView {
        if let firstMaterial = GrammarContentData.allMaterials.first(where: {$0.topicTitle.contains("Particle は (wa)")}) { // Mencari contoh dengan judul panjang
            JapaneseGrammarDetailView(material: firstMaterial)
        } else if let anyMaterial = GrammarContentData.allMaterials.first {
            JapaneseGrammarDetailView(material: anyMaterial)
        }
        else {
            Text("No material available for preview.")
        }
    }
}
