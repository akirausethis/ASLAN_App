import SwiftUI

// Model untuk satu partikel confetti
fileprivate struct Confetto: Identifiable {
    let id = UUID()
    var position: CGPoint
    let color: Color
    let size: CGSize
    let rotation: Angle
    
    // Properti untuk simulasi fisika
    let velocity: CGVector
    let angularVelocity: Double // Kecepatan rotasi
    let creationDate = Date()
}

// View utama untuk menampilkan ledakan confetti
struct ConfettiCannonView: View {
    @Binding var counter: Int
    
    @State private var particles: [Confetto] = []
    private let colors: [Color] = [.blue, .green, .red, .yellow, .purple, .orange, .pink, .cyan]
    
    var body: some View {
        TimelineView(.animation) { context in
            Canvas { canvas, size in
                particles.removeAll { particle in
                    let elapsedTime = context.date.timeIntervalSince(particle.creationDate)
                    return elapsedTime > 4 // Hapus setelah 4 detik
                }

                for particle in particles {
                    var particleCopy = canvas
                    let elapsedTime = context.date.timeIntervalSince(particle.creationDate)
                    let currentPosition = CGPoint(
                        x: particle.position.x + particle.velocity.dx * elapsedTime,
                        y: particle.position.y + particle.velocity.dy * elapsedTime + (400 * elapsedTime * elapsedTime) // Gravitasi
                    )
                    let currentRotation = particle.rotation + .degrees(particle.angularVelocity * elapsedTime)

                    particleCopy.translateBy(x: currentPosition.x, y: currentPosition.y)
                    particleCopy.rotate(by: currentRotation)
                    
                    let rect = CGRect(origin: .zero, size: particle.size)
                    particleCopy.fill(Path(roundedRect: rect, cornerRadius: 2), with: .color(particle.color))
                }
            }
            .onChange(of: counter) {
                addBurst(center: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY))
            }
        }
    }
    
    private func addBurst(center: CGPoint) {
        for _ in 0..<150 {
            let angle = Double.random(in: 0..<(2 * .pi))
            let radius = Double.random(in: 0...600)
            let velocity = CGVector(dx: radius * cos(angle), dy: radius * sin(angle))
            
            let particle = Confetto(
                position: center,
                color: colors.randomElement()!,
                size: CGSize(width: .random(in: 8...12), height: .random(in: 5...8)),
                rotation: .degrees(.random(in: 0...360)),
                velocity: velocity,
                angularVelocity: .random(in: -180...180)
            )
            particles.append(particle)
        }
    }
}
