// Aslan_Testing/FirebaseTestHelper.swift

import Foundation
import FirebaseCore

// Helper class untuk memastikan Firebase hanya dikonfigurasi sekali
// selama sesi pengujian berjalan.
enum FirebaseTestHelper {
    
    // Menggunakan dispatch_once untuk menjamin kode hanya dijalankan sekali
    // secara thread-safe.
    private static var configureOnce: () = {
        // Cek jika sudah ada default app yang terkonfigurasi untuk menghindari crash
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            print("Firebase configured for Testing.")
        }
    }()
    
    // Fungsi yang akan kita panggil dari test class
    static func configure() {
        _ = configureOnce
    }
}
