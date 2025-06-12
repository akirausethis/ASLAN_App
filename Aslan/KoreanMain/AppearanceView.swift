import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Choose an accent color for the entire app.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    // Grid untuk menampilkan pilihan warna
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(themeManager.themes) { theme in
                            Button(action: {
                                // Saat tombol ditekan, ubah tema
                                themeManager.setAccentColor(to: theme)
                            }) {
                                VStack(spacing: 10) {
                                    Rectangle()
                                        .fill(theme.color)
                                        .frame(height: 60)
                                        .cornerRadius(12)
                                        .overlay(
                                            // Tampilkan checkmark jika warna ini yang terpilih
                                            (theme.color == themeManager.accentColor) ?
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .shadow(radius: 5) : nil
                                        )
                                    
                                    Text(theme.name)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                    
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Appearance")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AppearanceView()
        .environmentObject(ThemeManager())
}
