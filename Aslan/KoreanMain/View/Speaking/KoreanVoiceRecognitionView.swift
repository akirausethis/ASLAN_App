// KoreanVoiceRecognitionView.swift
import SwiftUI

struct KoreanVoiceRecognitionView: View {
    @StateObject private var speechManager = SpeechRecognizerManager()

    var body: some View {
        VStack(spacing: 20) {
            Text("Pengenalan Suara Korea")
                .font(.largeTitle)
                .padding(.bottom, 20)

            TextEditor(text: .constant(speechManager.recognizedText))
                .frame(minHeight: 100, maxHeight: 200) // Beri tinggi minimal dan maksimal
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                .disabled(true) // Agar tidak bisa diedit manual

            if let errorMsg = speechManager.errorDescription {
                Text("Info: \(errorMsg)") // Ubah "Error" jadi "Info" karena bisa jadi pesan status
                    .foregroundColor(errorMsg.lowercased().contains("error") ? .red : .orange) // Warna beda untuk error vs info
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            if !speechManager.isSpeechRecognitionAuthorized || !speechManager.isMicrophoneAuthorized {
                VStack(spacing: 10) {
                    Text("Aplikasi ini memerlukan izin untuk Pengenalan Ucapan dan Mikrofon agar dapat berfungsi.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack {
                        Button("Minta Izin") {
                            speechManager.requestPermissions()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Buka Pengaturan") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.top)
            }

            Button(action: {
                speechManager.toggleRecording()
            }) {
                Text(speechManager.isRecording ? "Stop Merekam" : "Mulai Merekam")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(speechManager.isRecording ? Color.red : (speechManager.isSpeechRecognizerAvailable ? Color.blue : Color.gray)) // Tombol abu jika tidak tersedia
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            // Tombol dinonaktifkan jika izin belum ada DAN tidak sedang merekam
            .disabled((!speechManager.isSpeechRecognitionAuthorized || !speechManager.isMicrophoneAuthorized || !speechManager.isSpeechRecognizerAvailable) && !speechManager.isRecording)


            Spacer()
        }
        .padding()
        .onAppear {
            speechManager.checkPermissionsAndSetup()
        }
    }
}

// MARK: - Preview
struct KoreanVoiceRecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Bungkus dengan NavigationView agar judul dan tombol kembali (jika ada) terlihat baik
            KoreanVoiceRecognitionView()
        }
    }
}
