// AslanApp/View/Grammar/KoreanGrammarDetailView.swift
import SwiftUI

struct KoreanGrammarDetailView: View {
    let material: GrammarMaterial // Tetap menggunakan GrammarMaterial

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {

                Text(material.topicTitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                    .padding(.bottom, 15)

                SectionView(title: "Explanation", iconName: "text.alignleft") {
                    Text(material.explanation)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(7)
                        .foregroundColor(Color(UIColor.label))
                }

                SectionView(title: "Examples", iconName: "list.bullet.rectangle.portrait") {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(material.examples) { example in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(example.japanese) // Ini akan menampilkan Hangul
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
                            .padding(15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                        }
                    }
                }

                if let tip = material.tip, !tip.isEmpty {
                    SectionView(title: "💡 Tip", iconName: "lightbulb.fill", titleColor: .orange) {
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
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(material.courseTitle) // Menampilkan judul kursus
        .navigationBarTitleDisplayMode(.inline)
    }
}

// SectionView helper tetap sama seperti di JapaneseGrammarDetailView
// struct SectionView<Content: View>: View { ... }


#Preview {
    NavigationView {
        // Cari materi grammar Korea untuk preview
        if let firstMaterial = KoreanGrammarContentData.allMaterials.first(where: {$0.topicTitle.contains("은/는")}) {
            KoreanGrammarDetailView(material: firstMaterial)
        } else if let anyMaterial = KoreanGrammarContentData.allMaterials.first {
            KoreanGrammarDetailView(material: anyMaterial)
        }
        else {
            Text("No Korean grammar material available for preview.")
        }
    }
}
