import SwiftUI

// Struct untuk merepresentasikan warna tema yang bisa dipilih
struct Theme: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

class ThemeManager: ObservableObject {
    // @Published akan memberi tahu semua view jika accentColor berubah
    @Published var accentColor: Color = .blue
    
    // Daftar warna yang bisa dipilih oleh pengguna
    let themes: [Theme] = [
        Theme(name: "Default Blue", color: .blue),
        Theme(name: "Vibrant Green", color: .green),
        Theme(name: "Sunny Orange", color: .orange),
        Theme(name: "Royal Purple", color: .purple),
        Theme(name: "Fiery Red", color: .red),
        Theme(name: "Deep Indigo", color: Color(red: 0.3, green: 0.0, blue: 0.5)),
        Theme(name: "Teal", color: .teal)
    ]
    
    // Key untuk menyimpan di UserDefaults
    private let userDefaultsKey = "app_accent_color_name"

    init() {
        loadAccentColor()
    }
    
    // Memuat warna yang tersimpan saat aplikasi dibuka
    func loadAccentColor() {
        let savedColorName = UserDefaults.standard.string(forKey: userDefaultsKey) ?? "Default Blue"
        if let savedTheme = themes.first(where: { $0.name == savedColorName }) {
            self.accentColor = savedTheme.color
        } else {
            self.accentColor = .blue // Fallback ke default
        }
    }
    
    // Mengatur dan menyimpan warna baru yang dipilih
    func setAccentColor(to theme: Theme) {
        self.accentColor = theme.color
        UserDefaults.standard.set(theme.name, forKey: userDefaultsKey)
    }
}
