// AslanApp/View/Grammar/JapaneseGrammarCourseCardView.swift
import SwiftUI

struct JapaneseGrammarCourseCardView: View {
    let course: JapaneseCourse
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: course.iconName)
                .font(.largeTitle)
                .foregroundColor(isSelected ? .white : .blue) // Icon color changes based on selection
                .frame(width: 60, height: 60) // Adjust size as needed
                .background(isSelected ? Color.blue : Color.white) // Background color changes
                .clipShape(RoundedRectangle(cornerRadius: 15)) // Rounded background for the icon

            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .primary) // Text color changes
                Text(course.subtitle)
                    .font(.subheadline)
                    .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary) // Subtitle color changes
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.blue : Color.white) // Card background color changes
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: isSelected ? 0 : 1) // Outline when not selected
        )
        .padding(.horizontal) // Padding from the screen edges
    }
}

#Preview {
    JapaneseGrammarCourseCardView(course: JapaneseCourse(title: "Particles", subtitle: "Learn basic particles", iconName: "text.book.closed.fill"), isSelected: false)
        .previewLayout(.sizeThatFits)
        .padding()
}
