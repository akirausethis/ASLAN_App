import Foundation

// Model untuk satu pesan dalam chat
struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let sender: Sender
    
    enum Sender {
        case user
        case bot
    }
    
    // init kustom agar kita bisa memberikan ID spesifik jika perlu.
    init(id: UUID = UUID(), text: String, sender: Sender) {
        self.id = id
        self.text = text
        self.sender = sender
    }
}

// ViewModel yang mengelola alur percakapan
class ChatbotViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    private let translationService = TranslationService()

    init() {
        // --- PERUBAHAN 1: Tambahkan contoh Bahasa Mandarin di pesan pembuka ---
        messages.append(ChatMessage(text: """
        Hello! I'm AslanBot, your smart assistant.

        I can help you with information about the app or translate words for you.

        **Example Commands:**
        - `What is the progress tab?`
        - `translate hello to korean`
        - `translate love to japanese`
        - `translate good morning to chinese`
        """, sender: .bot))
    }
    
    func sendMessage(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        messages.append(ChatMessage(text: trimmedText, sender: .user))
        
        let lowercasedText = trimmedText.lowercased()
        
        if lowercasedText.starts(with: "translate ") {
            handleTranslation(for: lowercasedText)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let botResponse = self.getCustomerServiceResponse(for: lowercasedText)
                self.messages.append(ChatMessage(text: botResponse, sender: .bot))
            }
        }
    }
    
    private func handleTranslation(for text: String) {
        let components = text.components(separatedBy: " to ")
        guard components.count == 2,
              var textToTranslate = components.first?.replacingOccurrences(of: "translate", with: "").trimmingCharacters(in: .whitespacesAndNewlines),
              !textToTranslate.isEmpty
        else {
            messages.append(ChatMessage(text: "Sorry, I didn't understand that. Please use the format: `translate [your text] to [language]`.", sender: .bot))
            return
        }
        
        textToTranslate = textToTranslate.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
        
        let languageComponent = components.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        var targetLanguageCode: String?
        var languageName: String?
        
        // --- PERUBAHAN 2: Tambahkan logika untuk mendeteksi "chinese" ---
        if languageComponent.contains("korean") {
            targetLanguageCode = "ko"
            languageName = "Korean"
        } else if languageComponent.contains("japanese") {
            targetLanguageCode = "ja"
            languageName = "Japanese"
        } else if languageComponent.contains("chinese") { // <-- TAMBAHKAN INI
            targetLanguageCode = "zh" // Kode untuk Bahasa Mandarin (umumnya Simplified)
            languageName = "Chinese"
        } else {
            // --- PERUBAHAN 3: Update pesan error untuk menyertakan Bahasa Mandarin ---
            messages.append(ChatMessage(text: "Sorry, I can only translate to Korean, Japanese, or Chinese at the moment.", sender: .bot))
            return
        }
        
        guard let langCode = targetLanguageCode, let langName = languageName else { return }

        let thinkingMessageID = UUID()
        messages.append(ChatMessage(id: thinkingMessageID, text: "Translating...", sender: .bot))
        
        // Memanggil service yang sudah ada. Karena kita pakai Google Apps Script, tidak ada perubahan di sini.
        translationService.translate(text: textToTranslate, targetLanguage: langCode, sourceLanguage: "en") { [weak self] result in
            guard let self = self else { return }
            
            self.messages.removeAll { $0.id == thinkingMessageID }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let translatedText):
                    let response = "The translation of **'\(textToTranslate.capitalized)'** to \(langName) is:\n\n**\(translatedText)**"
                    self.messages.append(ChatMessage(text: response, sender: .bot))
                case .failure(let error):
                    self.messages.append(ChatMessage(text: "Translation Error: \(error.localizedDescription)", sender: .bot))
                }
            }
        }
    }
    
    private func getCustomerServiceResponse(for message: String) -> String {
        // Fungsi ini tidak perlu diubah
        if message.contains("hello") || message.contains("hi") || message.contains("hey") {
            return "Hello there! How can I assist you with the Aslan app today?"
        }
        if message.contains("how are you") {
            return "I'm doing great, thank you for asking! I'm ready to help you with your language learning journey."
        }
        if message.contains("thank you") || message.contains("thanks") {
            return "You're very welcome! Is there anything else I can help you with?"
        }
        if message.contains("progress") || message.contains("history") || message.contains("completed") {
            return "You can track all your completed lessons on the **Progress** tab (the one with the bar chart icon). Your overall completion percentage and a detailed list of finished topics are shown there!"
        }
        if message.contains("streak") {
            return "The **Day Streak** on your profile shows how many consecutive days you've used the app. Keep learning every day to increase your streak and build a strong habit!"
        }
        if message.contains("rank") {
            return "Your **Rank** (like Newbie, Adept, or Expert) on the profile screen increases as you complete more courses. It's a fun way to see how much you've learned over time!"
        }
        if message.contains("theme") || message.contains("color") || message.contains("appearance") {
            return "Of course! You can change the app's accent color. Go to the **Profile** tab (person icon), and tap on the **Appearance** menu to choose your favorite color."
        }
        if message.contains("grammar") {
            return "The **Grammar** section provides detailed explanations, example sentences, and tips for various grammar patterns. They are sorted by difficulty level to guide your learning."
        }
        if message.contains("writing") {
            return "In the **Writing** section, you can practice writing characters by tracing them directly on the screen. This is fantastic for building muscle memory for Hangul!"
        }
        if message.contains("flashcard") {
            return "Use **Flashcards** to quickly memorize Hangul characters and vocabulary. Just swipe the cards left or right. It's a proven method for quick recall!"
        }
        if message.contains("speaking") || message.contains("pronunciation") {
            return "The **Speaking** section uses your phone's microphone to check your pronunciation on common Korean phrases. Give it a try to improve your conversational skills!"
        }
        if message.contains("quiz") {
            return "You can test your knowledge in the **Quiz** tab (the message icon). The quizzes are designed to reinforce what you've learned in other sections of the app."
        }
        if message.contains("problem") || message.contains("not working") || message.contains("bug") {
            return "I'm sorry to hear you're having trouble. Could you please describe the issue in more detail? Knowing what feature isn't working and what you were doing helps our developers fix it faster."
        }
        if message.contains("feedback") || message.contains("suggestion") {
            return "We love hearing feedback! Thank you for helping us improve. Please share your ideas, and I will be sure to pass them along to the team."
        }
        return "I'm sorry, I'm not sure how to answer that. You can ask me about app features like 'progress' or 'speaking'.\n\nYou can also ask me to translate something, for example: `translate hello to korean`."
    }
}
