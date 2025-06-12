// AslanApp/Model/Progress/ProgressModel.swift
import Foundation

struct CompletedCourseDisplayItem: Identifiable, Hashable {
    let id: String
    let title: String
    let topicTitle: String? // PERUBAIKAN: Diubah dari String menjadi String? (Optional)
    let category: String
    let iconName: String
    let completionDate: Date?
}
