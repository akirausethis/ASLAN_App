// AslanApp/View/Quiz/JapaneseQuizCourseCardView.swift
import SwiftUI

struct JapaneseQuizCourseCardView: View {
    let course: JapaneseCourse // Menggunakan model JapaneseCourse yang sudah ada
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName.isEmpty ? "questionmark.diamond.fill" : course.iconName)
                .font(.largeTitle)
                .foregroundColor(isSelected ? .white : .blue)
                .frame(width: 60, height: 60)
                .background(isSelected ? Color.blue : Color(UIColor.systemBackground))
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
        .background(isSelected ? Color.blue : Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue.opacity(0) : Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    VStack {
        JapaneseQuizCourseCardView(
            course: JapaneseCourse(title: "Hiragana Quiz", subtitle: "Test your Hiragana", iconName: "pencil.and.ruler.fill"),
            isSelected: false
        )
        JapaneseQuizCourseCardView(
            course: JapaneseCourse(title: "Kanji N5 Quiz", subtitle: "Basic Kanji test", iconName: "doc.text.magnifyingglass"),
            isSelected: true
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
