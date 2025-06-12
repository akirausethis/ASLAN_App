import SwiftUI

struct ChatbotView: View {
    @StateObject private var viewModel = ChatbotViewModel()
    @State private var inputText: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                    // Menambahkan padding di bawah konten scroll view
                    // agar tidak tertutup oleh input field saat di-scroll ke paling bawah.
                    .padding(.bottom, 60)
                }
                .onChange(of: viewModel.messages.count) {
                    if let lastMessageId = viewModel.messages.last?.id {
                        DispatchQueue.main.async {
                            withAnimation {
                                scrollViewProxy.scrollTo(lastMessageId, anchor: .bottom)
                            }
                        }
                    }
                }
            }

            // --- BAGIAN UI YANG DIPERBAIKI ---
            HStack(spacing: 12) {
                TextField("Ask AslanBot...", text: $inputText, axis: .vertical)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .clipShape(Capsule(style: .continuous)) // Diubah menjadi Capsule untuk estetika
                    .focused($isTextFieldFocused)
                    .onSubmit(sendMessage)

                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                        .symbolRenderingMode(.multicolor)
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom, 60)
            .padding(.top, 20)
            // Latar belakang material sekarang diterapkan pada view utama di bawah
            // .background(.regularMaterial) // <--- DIHAPUS
        }
        .background(Color(UIColor.systemGroupedBackground)) // Gunakan warna background yang lebih solid
        .navigationTitle("AslanBot Help Center")
        .navigationBarTitleDisplayMode(.inline)
        // .padding(.bottom, 80) // <--- DIHAPUS, ini yang menyebabkan view melayang
    }

    private func sendMessage() {
        viewModel.sendMessage(inputText)
        inputText = ""
    }
}

// MessageView dan ChatBubble tidak perlu diubah, jadi saya biarkan seperti semula
struct MessageView: View {
    let message: ChatMessage
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if message.sender == .bot {
                Image(systemName: "wand.and.stars")
                    .font(.title2)
                    .foregroundColor(themeManager.accentColor)
                    .frame(width: 40, height: 40)
                    .background(themeManager.accentColor.opacity(0.15))
                    .clipShape(Circle())
            }

            if message.sender == .user {
                Spacer(minLength: 40)
            }

            Text(.init(message.text))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(message.sender == .user ? themeManager.accentColor : Color(UIColor.secondarySystemGroupedBackground))
                .foregroundColor(message.sender == .user ? .white : .primary)
                .clipShape(ChatBubble(direction: message.sender == .user ? .right : .left))
                .shadow(color: .black.opacity(0.05), radius: 3, y: 1)

            if message.sender == .bot {
                Spacer(minLength: 40)
            }
        }
    }
}

struct ChatBubble: Shape {
    var direction: Direction
    
    enum Direction {
        case left
        case right
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 18
        let tailSize: CGFloat = 8

        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)

        if direction == .left {
            path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))
            path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
            path.addArc(center: CGPoint(x: topRight.x - cornerRadius, y: topRight.y + cornerRadius), radius: cornerRadius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
            path.addArc(center: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y - cornerRadius), radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
            path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius + tailSize, y: bottomLeft.y))
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - tailSize))
            path.addLine(to: CGPoint(x: bottomLeft.x + tailSize, y: bottomLeft.y))
            path.addArc(center: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y - cornerRadius), radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius))
            path.addArc(center: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y + cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        } else { // Direction.right
            path.move(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
            path.addLine(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))
            path.addArc(center: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y + cornerRadius), radius: cornerRadius, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - cornerRadius))
            path.addArc(center: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y - cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
            path.addLine(to: CGPoint(x: bottomRight.x - cornerRadius - tailSize, y: bottomRight.y))
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - tailSize))
            path.addLine(to: CGPoint(x: bottomRight.x - tailSize, y: bottomRight.y))
            path.addArc(center: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y - cornerRadius), radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(0), clockwise: true)
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y + cornerRadius))
            path.addArc(center: CGPoint(x: topRight.x - cornerRadius, y: topRight.y + cornerRadius), radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(-90), clockwise: true)
        }
        
        path.closeSubpath()
        return path
    }
}


#Preview {
    NavigationView {
        ChatbotView()
            .environmentObject(ThemeManager())
    }
}
