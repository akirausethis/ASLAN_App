import SwiftUI

struct KoreanGrammarCourseCardView: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    let course: KoreanCourse
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName)
                .font(.largeTitle)
                .foregroundColor(isSelected ? .white : themeManager.accentColor) // 2. Gunakan warna tema
                .frame(width: 60, height: 60)
                .background(isSelected ? themeManager.accentColor : Color.white) // 3. Gunakan warna tema
                .clipShape(RoundedRectangle(cornerRadius: 15))

            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .primary)
                Text(course.subtitle)
                    .font(.subheadline)
                    .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? themeManager.accentColor : Color.white) // 4. Gunakan warna tema
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? themeManager.accentColor : Color.gray.opacity(0.3), lineWidth: isSelected ? 0 : 1) // 5. Gunakan warna tema
        )
        .padding(.horizontal)
    }
}


