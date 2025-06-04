// AslanApp/Services/FirebaseDatabaseService.swift
import Foundation
import FirebaseDatabase // Import FirebaseDatabase

class FirebaseDatabaseService {
    private let databaseRef = Database.database().reference() // Root reference ke database

    // Mengambil ID kursus yang sudah selesai
    func fetchCompletedCourseIDs(forUser userID: String, completion: @escaping (Set<String>) -> Void) {
        databaseRef.child("users").child(userID).child("completedCourseIDs").observeSingleEvent(of: .value) { snapshot in
            if let completedCoursesData = snapshot.value as? [String] {
                print("FirebaseDatabaseService: Fetched \(completedCoursesData.count) completed courses for user \(userID).")
                completion(Set(completedCoursesData))
            } else {
                print("FirebaseDatabaseService: No completed courses found or data format incorrect for user \(userID).")
                completion([])
            }
        } withCancel: { error in
            print("FirebaseDatabaseService Error fetching data: \(error.localizedDescription)")
            completion([])
        }
    }

    // Menandai kursus sebagai selesai
    func markCourseAsCompleted(courseID: String, forUser userID: String) {
        let userCompletedCoursesRef = databaseRef.child("users").child(userID).child("completedCourseIDs")

        // Ambil data yang sudah ada, lalu tambahkan courseID baru jika belum ada
        userCompletedCoursesRef.observeSingleEvent(of: .value) { snapshot in
            var completedCourses: [String] = []
            if let existingCourses = snapshot.value as? [String] {
                completedCourses = existingCourses
            }

            if !completedCourses.contains(courseID) {
                completedCourses.append(courseID)
                userCompletedCoursesRef.setValue(completedCourses) { error, _ in
                    if let error = error {
                        print("FirebaseDatabaseService Error saving data: \(error.localizedDescription)")
                    } else {
                        print("FirebaseDatabaseService: Course '\(courseID)' marked as completed for user \(userID). Total: \(completedCourses.count)")
                    }
                }
            } else {
                print("FirebaseDatabaseService: Course '\(courseID)' was already completed for user \(userID).")
            }
        } withCancel: { error in
            print("FirebaseDatabaseService Error checking existing data: \(error.localizedDescription)")
        }
    }
}
