import Foundation

class TranslationService {
    
    // The URL you got from deploying your Google Apps Script.
    // PASTE YOUR GOOGLE APPS SCRIPT URL HERE.
    private let a_ppScriptURL = "https://script.google.com/macros/s/AKfycbzNsodGfgR3OIZ1INbgVPosGIof4yv4gOmkeljgjBG69lB32kFqh8rwCVn5msqjPeFe/exec"

    // Struct to decode the JSON response from our Apps Script
    private struct TranslationResponse: Decodable {
        let status: String
        let translatedText: String?
        let message: String?
    }
    
    /// Translates text using a free Google Apps Script endpoint.
    /// - Parameters:
    ///   - text: The text to translate.
    ///   - targetLanguage: The target language code (e.g., "ko" for Korean, "ja" for Japanese).
    ///   - sourceLanguage: The source language code (e.g., "en" for English).
    ///   - completion: The completion handler.
    func translate(text: String, targetLanguage: String, sourceLanguage: String = "en", completion: @escaping (Result<String, Error>) -> Void) {
        
        // 1. Construct the URL with query parameters
        var components = URLComponents(string: a_ppScriptURL)
        components?.queryItems = [
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "target", value: targetLanguage),
            URLQueryItem(name: "source", value: sourceLanguage)
        ]

        guard let url = components?.url else {
            let error = NSError(domain: "TranslationService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])
            DispatchQueue.main.async { completion(.failure(error)) }
            return
        }
        
        // 2. Perform a simple GET request
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle network errors
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            // Ensure we have data
            guard let data = data else {
                let error = NSError(domain: "TranslationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from server."])
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            // 3. Decode the JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)

                if decodedResponse.status == "success", let translatedText = decodedResponse.translatedText {
                    // Success! Use the translated text.
                    let decodedString = translatedText.decodingHTMLEntities()
                    DispatchQueue.main.async { completion(.success(decodedString)) }
                } else {
                    // Handle errors reported by the Apps Script itself
                    let errorMessage = decodedResponse.message ?? "An unknown translation error occurred."
                    let apiError = NSError(domain: "TranslationService", code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    DispatchQueue.main.async { completion(.failure(apiError)) }
                }
            } catch {
                // Handle JSON decoding errors
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
}

// Ekstensi untuk handle karakter HTML (tidak berubah)
extension String {
    func decodingHTMLEntities() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        return attributedString.string
    }
}
