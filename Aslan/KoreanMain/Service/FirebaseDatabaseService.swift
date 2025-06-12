// AslanApp/Service/FirebaseDatabaseService.swift
import Foundation
import FirebaseDatabase // Import FirebaseDatabase
class FirebaseDatabaseService {
    private let databaseRef = Database.database().reference() // Root reference ke database
    // Mengambil ID topik yang sudah selesai (sekarang ID adalah kombinasi course dan topic)
    // PERUBAHAN: Mengembalikan [String] (Array) bukan Set<String> untuk menjaga urutan
    func fetchCompletedCourseIDs(forUser userID: String, completion: @escaping ([String]) -> Void) {
        databaseRef.child("users").child(userID).child("completedTopics").observeSingleEvent(of: .value) { snapshot in // Ganti "completedCourseIDs" jadi "completedTopics"
            if let completedTopicsData = snapshot.value as? [String] {
                print("FirebaseDatabaseService: Fetched \(completedTopicsData.count) completed topics for user \(userID).")
                completion(completedTopicsData) // KEMBALIKAN SEBAGAI ARRAY
            } else {
                print("FirebaseDatabaseService: No completed topics found or data format incorrect for user \(userID).")
                completion([])
            }
        } withCancel: { error in
            print("FirebaseDatabaseService Error fetching data: \(error.localizedDescription)")
            completion([])
        }
    }
    // Menandai topik sebagai selesai
    func markCourseAsCompleted(courseID: String, topicID: String, forUser userID: String) { // Tambah parameter topicID
        let fullTopicIdentifier: String
        // Jika topicID kosong, gunakan courseID secara langsung sebagai identifier.
        // Jika tidak, gabungkan seperti sebelumnya.
        if topicID.isEmpty {
            fullTopicIdentifier = courseID // Untuk kursus non-grammar, gunakan ID kursus tunggal
        } else {
            fullTopicIdentifier = "\(courseID)__\(topicID)" // Untuk topik grammar
        }
        
        let userCompletedTopicsRef = databaseRef.child("users").child(userID).child("completedTopics") // Ganti "completedCourseIDs" jadi "completedTopics"
        // Ambil data yang sudah ada, lalu tambahkan fullTopicIdentifier baru jika belum ada
        userCompletedTopicsRef.observeSingleEvent(of: .value) { snapshot in
            var completedTopics: [String] = []
            if let existingTopics = snapshot.value as? [String] {
                completedTopics = existingTopics
            }
            if !completedTopics.contains(fullTopicIdentifier) {
                completedTopics.append(fullTopicIdentifier)
                userCompletedTopicsRef.setValue(completedTopics) { error, _ in
                    if let error = error {
                        print("FirebaseDatabaseService Error saving data: \(error.localizedDescription)")
                    } else {
                        print("FirebaseDatabaseService: Identifier '\(fullTopicIdentifier)' marked as completed for user \(userID). Total: \(completedTopics.count)")
                    }
                }
            } else {
                print("FirebaseDatabaseService: Identifier '\(fullTopicIdentifier)' was already completed for user \(userID).")
            }
        } withCancel: { error in
            print("FirebaseDatabaseService Error checking existing data: \(error.localizedDescription)")
        }
    }
}
