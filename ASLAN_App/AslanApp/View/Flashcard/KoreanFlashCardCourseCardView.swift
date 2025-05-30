import SwiftUI

struct KoreanFlashCardCourseCardView: View {
    let course: KoreanCourse // Menggunakan KoreanCourse
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName)
                .font(.largeTitle)
                .foregroundColor(isSelected ? .white : .blue)
                .frame(width: 60, height: 60)
                .background(isSelected ? Color.blue : Color.white)
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
        .background(isSelected ? Color.blue : Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: isSelected ? 0 : 1)
        )
        .padding(.horizontal)
    }
}


