// SpeechRecognizerManager.swift
import SwiftUI
import Speech
import AVFoundation // Pastikan ini juga diimpor

// MARK: - Speech Recognizer Manager (ObservableObject)
class SpeechRecognizerManager: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    @Published var recognizedText: String = "Tekan tombol untuk mulai berbicara..."
    @Published var isRecording: Bool = false
    @Published var errorDescription: String? = nil
    @Published var isSpeechRecognitionAuthorized: Bool = SFSpeechRecognizer.authorizationStatus() == .authorized
    @Published var isMicrophoneAuthorized: Bool = AVAudioSession.sharedInstance().recordPermission == .granted
    @Published var isSpeechRecognizerAvailable: Bool = false

    public var speechRecognizer: SFSpeechRecognizer?
    public var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    public var recognitionTask: SFSpeechRecognitionTask?
    public let audioEngine = AVAudioEngine()

    override init() {
        super.init()
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
        self.speechRecognizer?.delegate = self // Set delegate

        // Cek ketersediaan awal
        if let recognizer = self.speechRecognizer {
            self.isSpeechRecognizerAvailable = recognizer.isAvailable
            if !recognizer.isAvailable {
                 self.errorDescription = "Pengenalan ucapan tidak tersedia saat ini."
            }
        } else {
            self.errorDescription = "Pengenalan ucapan tidak didukung pada perangkat atau locale ini."
            self.isSpeechRecognizerAvailable = false
        }
    }

    // Implementasi delegate method
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        DispatchQueue.main.async {
            self.isSpeechRecognizerAvailable = available
            if available {
                self.errorDescription = nil // Hapus error jika menjadi tersedia
                print("Speech recognizer kini tersedia.")
            } else {
                self.errorDescription = "Pengenalan ucapan tidak tersedia saat ini."
                if self.isRecording { // Jika sedang merekam, hentikan
                    self.stopRecording()
                }
                print("Speech recognizer kini TIDAK tersedia.")
            }
        }
    }
    
    // 1. Meminta Izin
    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                self.isSpeechRecognitionAuthorized = (authStatus == .authorized)
                if !self.isSpeechRecognitionAuthorized {
                    self.errorDescription = "Pengenalan ucapan tidak diizinkan oleh pengguna."
                    print("Status izin pengenalan ucapan: \(authStatus.rawValue)")
                }
            }
        }

        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                self.isMicrophoneAuthorized = granted
                if !granted {
                    self.errorDescription = "Akses mikrofon tidak diizinkan oleh pengguna."
                }
            }
        }
    }
    
    func checkPermissionsAndSetup() {
        DispatchQueue.main.async {
            self.isSpeechRecognitionAuthorized = (SFSpeechRecognizer.authorizationStatus() == .authorized)
            self.isMicrophoneAuthorized = (AVAudioSession.sharedInstance().recordPermission == .granted)
            
            if let recognizer = self.speechRecognizer {
                self.isSpeechRecognizerAvailable = recognizer.isAvailable
                if !recognizer.isAvailable {
                     self.errorDescription = "Pengenalan ucapan tidak tersedia saat ini. Coba lagi nanti."
                }
            } else {
                self.errorDescription = "SFSpeechRecognizer gagal diinisialisasi."
                self.isSpeechRecognizerAvailable = false
            }
        }
    }

    // 2. Mulai Merekam dan Mengenali
    func startRecording() {
        guard isSpeechRecognitionAuthorized else {
            errorDescription = "Izin pengenalan ucapan diperlukan."
            requestPermissions()
            return
        }
        guard isMicrophoneAuthorized else {
            errorDescription = "Izin mikrofon diperlukan."
            requestPermissions()
            return
        }
        
    
        guard let currentRecognizer = self.speechRecognizer, currentRecognizer.isAvailable else {
            errorDescription = "Pengenalan ucapan tidak tersedia saat ini. Mohon coba lagi nanti."
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isSpeechRecognizerAvailable = self.speechRecognizer?.isAvailable ?? false
                if !(self.speechRecognizer?.isAvailable ?? false) {
                     self.errorDescription = "Pengenalan ucapan masih tidak tersedia."
                }
            }
            return
        }
        
        guard !audioEngine.isRunning else {
            print("Audio engine sudah berjalan.")
            return
        }

        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            self.errorDescription = "Gagal mengatur sesi audio: \(error.localizedDescription)"
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let recognitionRequest = recognitionRequest else {
            self.errorDescription = "Tidak dapat membuat SFSpeechAudioBufferRecognitionRequest."
            return
        }

        recognitionRequest.shouldReportPartialResults = true

        let inputNode = audioEngine.inputNode
        
       
        recognitionTask = currentRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false

            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
                isFinal = result.isFinal
                if error == nil {
                    self.errorDescription = nil
                }
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                DispatchQueue.main.async {
                    self.isRecording = false
                }

                if let error = error {
                    self.errorDescription = "Error pengenalan: \(error.localizedDescription)"
                    print("Error pengenalan: \(error)")
                }
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
         guard recordingFormat.sampleRate > 0 else {
            self.errorDescription = "Format rekaman tidak valid (sample rate 0)."
            DispatchQueue.main.async {
                self.isRecording = false
            }
            do {
                try audioSession.setActive(false)
            } catch {
                print("Gagal menonaktifkan audio session: \(error)")
            }
            return
        }

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
            DispatchQueue.main.async {
                self.recognizedText = "Mendengarkan..."
                self.isRecording = true
                self.errorDescription = nil
            }
        } catch {
            self.errorDescription = "Gagal memulai audio engine: \(error.localizedDescription)"
            DispatchQueue.main.async {
                self.isRecording = false
            }
        }
    }

    // 3. Hentikan Perekaman
    func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }
        DispatchQueue.main.async {
             self.isRecording = false
        }
    }
    
    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording() // startRecording sudah memiliki pengecekan ketersediaan di dalamnya
        }
    }
}


//// SpeechRecognizerManager.swift
//import SwiftUI // Untuk ObservableObject, @Published agar UI bisa memantau perubahan.
//import Speech   // Framework inti untuk pengenalan suara (SFSpeechRecognizer, dll.).
//import AVFoundation // Untuk mengelola audio (AVAudioSession, AVAudioEngine).
//
//// MARK: - Speech Recognizer Manager (ObservableObject)
//// Kelas SpeechRecognizerManager.
//// - NSObject: Diperlukan karena SFSpeechRecognizerDelegate adalah protokol Objective-C.
//// - ObservableObject: Agar properti @Published bisa dipantau oleh View SwiftUI.
//// - SFSpeechRecognizerDelegate: Agar bisa menerima callback (panggilan balik) dari SFSpeechRecognizer,
////   misalnya ketika ketersediaan layanan pengenalan suara berubah.
//class SpeechRecognizerManager: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
//    // @Published: Property wrapper yang membuat properti ini bisa "diamati".
//    // Perubahan pada nilainya akan otomatis memberitahu View yang menggunakannya untuk update.
//    @Published var recognizedText: String = "Tekan tombol untuk mulai berbicara..." // Teks hasil pengenalan.
//    @Published var isRecording: Bool = false // Status apakah sedang merekam atau tidak.
//    @Published var errorDescription: String? = nil // Pesan error jika ada (opsional).
//    // Status izin pengenalan suara, diinisialisasi dengan status saat ini dari sistem.
//    @Published var isSpeechRecognitionAuthorized: Bool = SFSpeechRecognizer.authorizationStatus() == .authorized
//    // Status izin mikrofon, diinisialisasi dengan status saat ini dari sistem.
//    @Published var isMicrophoneAuthorized: Bool = AVAudioSession.sharedInstance().recordPermission == .granted
//    // Status apakah layanan pengenalan suara tersedia untuk digunakan saat ini.
//    @Published var isSpeechRecognizerAvailable: Bool = false
//
//    // Properti private (atau public dalam kode yang Anda berikan) untuk penggunaan internal kelas.
//    // Dalam versi yang Anda berikan, ini diubah menjadi public, kemungkinan untuk unit testing.
//    public var speechRecognizer: SFSpeechRecognizer? // Objek inti pengenalan suara. Opsional karena bisa gagal inisialisasi.
//    public var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // Permintaan pengenalan dari buffer audio.
//    public var recognitionTask: SFSpeechRecognitionTask? // Tugas/sesi pengenalan suara yang sedang berjalan.
//    public let audioEngine = AVAudioEngine() // Mesin audio untuk mengelola input/output, terutama dari mikrofon.
//
//    // Konstruktor kelas. 'override' karena SpeechRecognizerManager sekarang mewarisi dari NSObject.
//    override init() {
//        super.init() // Memanggil konstruktor dari kelas induk (NSObject).
//        // Inisialisasi speechRecognizer dengan locale Bahasa Korea ("ko-KR").
//        // Ini memberitahu sistem untuk menggunakan model bahasa, akustik, dan kamus Bahasa Korea.
//        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
//        // Mengatur 'self' (instance kelas ini) sebagai delegate untuk speechRecognizer.
//        // Ini memungkinkan kelas ini menerima callback dari SFSpeechRecognizer, seperti availabilityDidChange.
//        self.speechRecognizer?.delegate = self
//
//        // Pengecekan awal ketersediaan speech recognizer saat objek ini dibuat.
//        if let recognizer = self.speechRecognizer {
//            self.isSpeechRecognizerAvailable = recognizer.isAvailable // Update status ketersediaan.
//            if !recognizer.isAvailable { // Jika tidak tersedia.
//                 self.errorDescription = "Pengenalan ucapan tidak tersedia saat ini." // Set pesan error.
//            }
//        } else { // Jika speechRecognizer gagal diinisialisasi (misalnya, locale "ko-KR" tidak didukung).
//            self.errorDescription = "Pengenalan ucapan tidak didukung pada perangkat atau locale ini."
//            self.isSpeechRecognizerAvailable = false // Pastikan status ketersediaan false.
//        }
//    }
//
//    // Implementasi fungsi dari protokol SFSpeechRecognizerDelegate.
//    // Fungsi ini akan dipanggil secara otomatis oleh sistem ketika ketersediaan
//    // layanan SFSpeechRecognizer berubah (misalnya, karena masalah jaringan,
//    // batasan server Apple, atau pengguna mengubah pengaturan bahasa).
//    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
//        // Semua pembaruan pada @Published property (yang akan mempengaruhi UI)
//        // harus dilakukan di main thread.
//        DispatchQueue.main.async {
//            self.isSpeechRecognizerAvailable = available // Update status ketersediaan.
//            if available { // Jika layanan menjadi tersedia.
//                self.errorDescription = nil // Hapus pesan error sebelumnya.
//                print("Speech recognizer kini tersedia.")
//            } else { // Jika layanan menjadi tidak tersedia.
//                self.errorDescription = "Pengenalan ucapan tidak tersedia saat ini."
//                if self.isRecording { // Jika sedang merekam saat layanan menjadi tidak tersedia.
//                    self.stopRecording() // Hentikan proses perekaman.
//                }
//                print("Speech recognizer kini TIDAK tersedia.")
//            }
//        }
//    }
//    
//    // Fungsi untuk meminta izin pengenalan ucapan dan akses mikrofon kepada pengguna.
//    func requestPermissions() {
//        // Meminta izin untuk pengenalan ucapan. Ini akan menampilkan dialog sistem.
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//            DispatchQueue.main.async { // Update UI di main thread.
//                // Update status isSpeechRecognitionAuthorized berdasarkan respons pengguna.
//                self.isSpeechRecognitionAuthorized = (authStatus == .authorized)
//                if !self.isSpeechRecognitionAuthorized { // Jika tidak diizinkan.
//                    self.errorDescription = "Pengenalan ucapan tidak diizinkan oleh pengguna."
//                    print("Status izin pengenalan ucapan: \(authStatus.rawValue)") // Cetak status untuk debug.
//                }
//            }
//        }
//
//        // Meminta izin untuk akses mikrofon. Ini juga akan menampilkan dialog sistem.
//        AVAudioSession.sharedInstance().requestRecordPermission { granted in
//            DispatchQueue.main.async { // Update UI di main thread.
//                self.isMicrophoneAuthorized = granted // Update status izin mikrofon.
//                if !granted { // Jika tidak diizinkan.
//                    self.errorDescription = "Akses mikrofon tidak diizinkan oleh pengguna."
//                }
//            }
//        }
//    }
//    
//    // Fungsi untuk memeriksa status izin saat ini dan ketersediaan recognizer.
//    // Berguna untuk dipanggil saat view muncul pertama kali (onAppear).
//    func checkPermissionsAndSetup() {
//        DispatchQueue.main.async {
//            // Perbarui status izin berdasarkan kondisi sistem saat ini.
//            self.isSpeechRecognitionAuthorized = (SFSpeechRecognizer.authorizationStatus() == .authorized)
//            self.isMicrophoneAuthorized = (AVAudioSession.sharedInstance().recordPermission == .granted)
//            
//            // Perbarui status ketersediaan recognizer.
//            if let recognizer = self.speechRecognizer {
//                self.isSpeechRecognizerAvailable = recognizer.isAvailable
//                if !recognizer.isAvailable {
//                     self.errorDescription = "Pengenalan ucapan tidak tersedia saat ini. Coba lagi nanti."
//                }
//            } else {
//                self.errorDescription = "SFSpeechRecognizer gagal diinisialisasi."
//                self.isSpeechRecognizerAvailable = false
//            }
//        }
//    }
//
//    // Fungsi utama untuk memulai proses perekaman dan pengenalan suara.
//    func startRecording() {
//        // Guard clause: Pastikan izin pengenalan ucapan sudah diberikan.
//        guard isSpeechRecognitionAuthorized else {
//            errorDescription = "Izin pengenalan ucapan diperlukan."
//            requestPermissions() // Jika belum, panggil fungsi untuk meminta izin.
//            return // Keluar dari fungsi startRecording.
//        }
//        // Guard clause: Pastikan izin mikrofon sudah diberikan.
//        guard isMicrophoneAuthorized else {
//            errorDescription = "Izin mikrofon diperlukan."
//            requestPermissions() // Jika belum, panggil fungsi untuk meminta izin.
//            return // Keluar dari fungsi.
//        }
//        
//        // Guard clause: Pastikan speechRecognizer (currentRecognizer) sudah diinisialisasi dan tersedia.
//        guard let currentRecognizer = self.speechRecognizer, currentRecognizer.isAvailable else {
//            errorDescription = "Pengenalan ucapan tidak tersedia saat ini. Mohon coba lagi nanti."
//            // Coba perbarui status ketersediaan setelah jeda singkat, siapa tahu baru saja berubah.
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.isSpeechRecognizerAvailable = self.speechRecognizer?.isAvailable ?? false
//                if !(self.speechRecognizer?.isAvailable ?? false) {
//                     self.errorDescription = "Pengenalan ucapan masih tidak tersedia."
//                }
//            }
//            return // Keluar dari fungsi.
//        }
//        
//        // Guard clause: Pastikan audioEngine (untuk mikrofon) tidak sedang berjalan.
//        // Ini mencegah memulai rekaman ganda.
//        guard !audioEngine.isRunning else {
//            print("Audio engine sudah berjalan.") // Pesan debug.
//            return // Keluar jika sudah berjalan.
//        }
//
//        // Jika ada task pengenalan sebelumnya yang mungkin belum selesai, batalkan dan hapus.
//        if recognitionTask != nil {
//            recognitionTask?.cancel()
//            recognitionTask = nil
//        }
//
//        // Dapatkan instance shared dari AVAudioSession untuk mengonfigurasi sesi audio.
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            // Atur kategori sesi audio:
//            // - .record: Memberi tahu sistem bahwa tujuan utama sesi adalah merekam.
//            // - mode: .measurement: Mengoptimalkan input audio untuk analisis (minimalkan pemrosesan sistem).
//            // - options: .duckOthers: Mengecilkan volume audio dari aplikasi lain saat aplikasi ini merekam.
//            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
//            // Aktifkan sesi audio dengan opsi untuk memberitahu aplikasi lain saat deaktivasi.
//            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        } catch { // Jika gagal mengatur atau mengaktifkan sesi audio.
//            self.errorDescription = "Gagal mengatur sesi audio: \(error.localizedDescription)"
//            return
//        }
//
//        // Buat objek SFSpeechAudioBufferRecognitionRequest baru.
//        // Request ini akan digunakan untuk mengirim buffer (potongan) data audio secara streaming.
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//
//        // Guard clause: Pastikan recognitionRequest berhasil dibuat.
//        guard let recognitionRequest = recognitionRequest else {
//            self.errorDescription = "Tidak dapat membuat SFSpeechAudioBufferRecognitionRequest."
//            return
//        }
//
//        // shouldReportPartialResults = true: Menginstruksikan SFSpeechRecognizer untuk
//        // melaporkan hasil sementara (parsial) saat pengguna masih berbicara.
//        // Ini memberikan feedback real-time di UI.
//        recognitionRequest.shouldReportPartialResults = true
//
//        // Dapatkan input node dari audioEngine. Ini adalah representasi dari sumber input audio (mikrofon).
//        let inputNode = audioEngine.inputNode
//        
//        // Mulai task pengenalan suara menggunakan currentRecognizer (yang sudah dikonfigurasi untuk Korea).
//        // Ini adalah operasi asynchronous. Closure (blok kode setelah 'in') akan dipanggil
//        // beberapa kali oleh sistem:
//        // 1. Saat hasil parsial tersedia.
//        // 2. Saat hasil final (akhir dari ucapan) tersedia.
//        // 3. Jika terjadi error selama proses pengenalan.
//        recognitionTask = currentRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//            var isFinal = false // Flag untuk menandakan apakah ini hasil pengenalan final.
//
//            if let result = result { // Jika ada objek hasil (bisa parsial atau final).
//                // Ambil transkripsi teks terbaik dari hasil.
//                self.recognizedText = result.bestTranscription.formattedString
//                isFinal = result.isFinal // Cek apakah ini hasil final.
//                if error == nil { // Jika tidak ada error baru dari task ini, hapus pesan error lama.
//                    self.errorDescription = nil
//                }
//            }
//
//            // Kondisi ini terpenuhi jika ada error ATAU jika ini adalah hasil final.
//            // Artinya, sesi pengenalan untuk ucapan saat ini sudah selesai atau gagal.
//            if error != nil || isFinal {
//                self.audioEngine.stop() // Hentikan audio engine (berhenti merekam dari mikrofon).
//                inputNode.removeTap(onBus: 0) // Lepas "tap" dari input node (berhenti mengirim buffer audio).
//
//                // Reset request dan task untuk sesi berikutnya.
//                self.recognitionRequest = nil
//                self.recognitionTask = nil
//                
//                // Update status isRecording di main thread karena akan mempengaruhi UI.
//                DispatchQueue.main.async {
//                    self.isRecording = false
//                }
//
//                if let error = error { // Jika ada error dari proses pengenalan.
//                    self.errorDescription = "Error pengenalan: \(error.localizedDescription)"
//                    print("Error pengenalan: \(error)") // Cetak error untuk debug.
//                }
//            }
//        }
//
//        // Dapatkan format rekaman (seperti sample rate, jumlah channel) dari input node.
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        // Guard clause: Pastikan sample rate format rekaman valid (lebih dari 0).
//        // Sample rate 0 berarti input audio tidak bisa digunakan.
//         guard recordingFormat.sampleRate > 0 else {
//            self.errorDescription = "Format rekaman tidak valid (sample rate 0)."
//            DispatchQueue.main.async { // Update UI.
//                self.isRecording = false
//            }
//            // Nonaktifkan sesi audio jika gagal mendapatkan format yang valid.
//            do {
//                try audioSession.setActive(false)
//            } catch {
//                print("Gagal menonaktifkan audio session: \(error)")
//            }
//            return
//        }
//
//        // Install "tap" pada input node (mikrofon).
//        // Ini seperti memasang "keran" yang akan mengalirkan potongan-potongan (buffer) data audio
//        // dari mikrofon ke blok closure ini.
//        // bufferSize: ukuran buffer yang diinginkan.
//        // format: format audio yang diharapkan.
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
//            // Setiap kali buffer audio diterima, kirimkan ke recognitionRequest.
//            self.recognitionRequest?.append(buffer)
//        }
//
//        audioEngine.prepare() // Siapkan audio engine untuk memulai.
//
//        do {
//            try audioEngine.start() // Mulai audio engine (mulai menangkap audio dari mikrofon).
//            // Update UI di main thread untuk menandakan proses rekaman dimulai.
//            DispatchQueue.main.async {
//                self.recognizedText = "Mendengarkan..." // Set pesan placeholder.
//                self.isRecording = true // Set status sedang merekam.
//                self.errorDescription = nil // Hapus pesan error lama.
//            }
//        } catch { // Jika gagal memulai audio engine.
//            self.errorDescription = "Gagal memulai audio engine: \(error.localizedDescription)"
//            DispatchQueue.main.async { // Update UI.
//                self.isRecording = false
//            }
//        }
//    }
//
//    // Fungsi untuk menghentikan perekaman dan pengenalan suara.
//    func stopRecording() {
//        if audioEngine.isRunning { // Jika audio engine sedang berjalan.
//            audioEngine.stop() // Hentikan.
//            // Memberitahu recognitionRequest bahwa tidak ada lagi audio yang akan dikirim.
//            // Ini penting agar SFSpeechRecognizer tahu untuk memproses sisa buffer
//            // dan menghasilkan hasil pengenalan final.
//            recognitionRequest?.endAudio()
//        }
//        // Update status isRecording di main thread.
//        DispatchQueue.main.async {
//             self.isRecording = false
//             // recognizedText tidak direset di sini agar hasil terakhir dari ucapan
//             // tetap terlihat oleh pengguna di UI.
//        }
//    }
//    
//    // Fungsi helper untuk switch antara memulai dan menghentikan rekaman.
//    // Dipanggil oleh tombol di UI.
//    func toggleRecording() {
//        if isRecording { // Jika sedang merekam, maka hentikan.
//            stopRecording()
//        } else { // Jika tidak sedang merekam, maka mulai.
//            // Fungsi startRecording() sudah memiliki pengecekan izin dan ketersediaan di dalamnya.
//            startRecording()
//        }
//    }
//}
