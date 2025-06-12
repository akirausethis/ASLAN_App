import SwiftUI

struct KoreanQuizCourseCardView: View {
    @EnvironmentObject var themeManager: ThemeManager // 1. Ambil data tema
    let course: KoreanQuizCourse
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName)
                .font(.largeTitle)
                .foregroundColor(themeManager.accentColor) // 2. Gunakan warna tema
                .frame(width: 60, height: 60)
                .background(themeManager.accentColor.opacity(0.1)) // 3. Gunakan warna tema
                .clipShape(RoundedRectangle(cornerRadius: 15))

            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(course.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.7))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
