// AslanApp/View/Spelling/JapaneseSpellingCourseCardView.swift
import SwiftUI

struct JapaneseSpellingCourseCardView: View {
    let course: JapaneseCourse // Menggunakan model JapaneseCourse yang sudah ada
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName.isEmpty ? "speaker.wave.2.circle.fill" : course.iconName)
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
        JapaneseSpellingCourseCardView(
            course: JapaneseCourse(title: "Basic Greetings", subtitle: "Practice saying hello", iconName: "speaker.wave.2.fill"),
            isSelected: false
        )
        JapaneseSpellingCourseCardView(
            course: JapaneseCourse(title: "Numbers", subtitle: "Practice counting", iconName: "number.circle.fill"),
            isSelected: true
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
