// AslanApp/ViewModel/ProgressViewModel.swift
import SwiftUI
import Combine
class ProgressViewModel: ObservableObject {
    @Published var completedCourseItems: [CompletedCourseDisplayItem] = []
    @Published var progressPercentage: Double = 0.0
    @Published var totalCompletedCount: Int = 0
    @Published var isLoading: Bool = false
    
    // --- PERUBAHAN 1: Tambahkan properti untuk nama kursus terakhir ---
    @Published var lastCourseName: String = "Start a course!"
    let totalPossibleCourses: Int
    private var courseDataProvider = CourseDataProvider.shared
    private var firebaseService = FirebaseDatabaseService()
    private var cancellables = Set<AnyCancellable>()
    init() {
        self.totalPossibleCourses = courseDataProvider.totalPossibleCourses
        print("ProgressViewModel: Total possible completable units (topics/courses): \(self.totalPossibleCourses)")
        fetchUserProgress()
    }
    func fetchUserProgress(userID: String = "dummyUser") {
        isLoading = true
        // --- PERUBAHAN 2: Terima [String] bukan Set<String> ---
        firebaseService.fetchCompletedCourseIDs(forUser: userID) { [weak self] completedIdentifiersFromService in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.processCompletedIdentifiers(completedIdentifiersFromService)
            }
        }
    }
    
    // --- PERUBAHAN 3: Update fungsi untuk menerima [String] dan mencari item terakhir ---
    func processCompletedIdentifiers(_ completedIdentifiers: [String]) {
        var items: [CompletedCourseDisplayItem] = []
        
        // --- LOGIKA BARU: Cari detail untuk kursus/topik terakhir ---
        if let lastIdentifier = completedIdentifiers.last {
            var foundName: String?
            let components = lastIdentifier.components(separatedBy: "__")
            
            if components.count == 2, let material = KoreanGrammarContentData.allMaterials.first(where: { "\($0.courseTitle)__\($0.topicTitle)" == lastIdentifier }) {
                // Jika itu adalah topik grammar, gunakan judul topiknya
                foundName = material.topicTitle
            } else if let appCourse = self.courseDataProvider.getCourseDetail(forId: lastIdentifier) {
                // Jika itu kursus lain, gunakan judul kursusnya
                foundName = appCourse.title
            }
            // Update properti lastCourseName
            self.lastCourseName = foundName ?? "Unknown Course"
        } else {
            // Jika tidak ada progres, set ke pesan default
            self.lastCourseName = "Start a course!"
        }
        // --- AKHIR LOGIKA BARU ---
        for identifier in completedIdentifiers {
            let components = identifier.components(separatedBy: "__")
            
            if components.count == 2, let material = KoreanGrammarContentData.allMaterials.first(where: { "\($0.courseTitle)__\($0.topicTitle)" == identifier }) {
                items.append(CompletedCourseDisplayItem(
                    id: identifier,
                    title: material.courseTitle,
                    topicTitle: material.topicTitle,
                    category: "Grammar",
                    iconName: "text.book.closed.fill",
                    completionDate: nil
                ))
            }
            else if let appCourse = self.courseDataProvider.getCourseDetail(forId: identifier) {
                items.append(CompletedCourseDisplayItem(
                    id: identifier,
                    title: appCourse.title,
                    topicTitle: nil,
                    category: appCourse.category,
                    iconName: appCourse.iconName,
                    completionDate: nil
                ))
            } else {
                print("ProgressViewModel: Warning - Detail not found for identifier: \(identifier)")
            }
        }
        
        DispatchQueue.main.async {
            self.completedCourseItems = items.sorted { item1, item2 in
                if item1.category != item2.category {
                    return item1.category < item2.category
                }
                if item1.title != item2.title {
                    return item1.title < item2.title
                }
                return (item1.topicTitle ?? "") < (item2.topicTitle ?? "")
            }
            
            self.totalCompletedCount = self.completedCourseItems.count
            
            if self.totalPossibleCourses > 0 {
                self.progressPercentage = Double(self.totalCompletedCount) / Double(self.totalPossibleCourses)
            } else {
                self.progressPercentage = 0.0
            }
            self.isLoading = false
            print("ProgressViewModel: Processed. Completed units: \(self.totalCompletedCount), Last Course: \(self.lastCourseName), Percentage: \(self.progressPercentage * 100)%")
        }
    }
    func userCompletedCourse(courseTitle: String, topicTitle: String, category: String, forUser userID: String = "dummyUser") {
        if category == "Grammar" {
            firebaseService.markCourseAsCompleted(courseID: courseTitle, topicID: topicTitle, forUser: userID)
        } else {
            firebaseService.markCourseAsCompleted(courseID: courseTitle, topicID: "", forUser: userID)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchUserProgress(userID: userID)
        }
    }
}
