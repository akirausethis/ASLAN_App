// AslanApp/View/Quiz/KoreanQuizCourseCardView.swift
import SwiftUI

struct KoreanQuizCourseCardView: View {
    let course: KoreanQuizCourse
    let isSelected: Bool // Jika ingin ada efek terpilih

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName)
                .font(.largeTitle)
                .foregroundColor(isSelected ? .white : .blue)
                .frame(width: 60, height: 60)
                .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
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

#Preview {
    KoreanQuizCourseCardView(course: KoreanQuizCourse(title: "Basic Vocabulary Quiz", subtitle: "Test your knowledge of basic Korean words and their meanings.", iconName: "questionmark.folder.fill"), isSelected: false)
        .previewLayout(.sizeThatFits)
}
