// AslanApp/ViewModel/ProgressViewModel.swift
import SwiftUI
import Combine

// MockFirebaseService REMOVED. Use FirebaseDatabaseService now.

class ProgressViewModel: ObservableObject {
    @Published var completedCourseItems: [CompletedCourseDisplayItem] = [] //
    @Published var progressPercentage: Double = 0.0
    @Published var totalCompletedCount: Int = 0
    @Published var isLoading: Bool = false

    let totalPossibleCourses: Int
    private var courseDataProvider = CourseDataProvider.shared //
    private var firebaseService = FirebaseDatabaseService() // GANTI DENGAN INI
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.totalPossibleCourses = courseDataProvider.totalPossibleCourses
        print("ProgressViewModel: Total possible courses: \(self.totalPossibleCourses)")
        
        // Bagian .sink ini dihapus karena FirebaseDatabaseService tidak menggunakan @Published untuk array ID
        // firebaseService.$mockCompletedCourseIDs
        //     .receive(on: DispatchQueue.main)
        //     .sink { [weak self] completedIDsFromService in
        //         guard let strongSelf = self else { return }
        //         strongSelf.processCompletedIDs(completedIDsFromService)
        //     }
        //     .store(in: &cancellables)
        
        // Panggil fetch saat inisialisasi, dan juga nanti dari ProgressPageView onAppear
        fetchUserProgress()
    }

    func fetchUserProgress(userID: String = "dummyUser") {
        isLoading = true
        firebaseService.fetchCompletedCourseIDs(forUser: userID) { [weak self] completedIDsFromService in
            guard let strongSelf = self else { return }
            // Pastikan ini dipanggil di main thread karena ini update UI
            DispatchQueue.main.async {
                strongSelf.processCompletedIDs(completedIDsFromService)
            }
        }
    }
    
    private func processCompletedIDs(_ completedIDs: Set<String>) {
        var items: [CompletedCourseDisplayItem] = [] //
        for courseID in completedIDs {
            if let courseDetail = self.courseDataProvider.getCourseDetail(forId: courseID) {
                items.append(CompletedCourseDisplayItem( //
                    id: courseID,
                    title: courseDetail.title,
                    category: courseDetail.category,
                    iconName: courseDetail.iconName,
                    completionDate: nil
                ))
            } else {
                print("ProgressViewModel: Warning - Course detail not found for ID: \(courseID)")
            }
        }
        
        DispatchQueue.main.async {
            self.completedCourseItems = items.sorted {
                if $0.category != $1.category {
                    return $0.category < $1.category
                }
                return $0.title < $1.title
            }
            self.totalCompletedCount = self.completedCourseItems.count
            
            if self.totalPossibleCourses > 0 {
                self.progressPercentage = Double(self.totalCompletedCount) / Double(self.totalPossibleCourses)
            } else {
                self.progressPercentage = 0.0
            }
            self.isLoading = false
            print("ProgressViewModel: Processed. Completed: \(self.totalCompletedCount), Percentage: \(self.progressPercentage * 100)%")
        }
    }

    func userCompletedCourse(courseID: String, userID: String = "dummyUser") {
        // Panggil service untuk menandai selesai
        firebaseService.markCourseAsCompleted(courseID: courseID, forUser: userID)
        
        // Setelah menandai selesai, PENTING untuk me-fetch ulang data agar UI terupdate
        // Berikan sedikit delay agar Firebase memiliki waktu untuk memproses penulisan
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Delay 1 detik
            self.fetchUserProgress(userID: userID)
        }
    }
}
