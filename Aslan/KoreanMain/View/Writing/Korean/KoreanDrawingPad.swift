// AslanApp/View/Writing/DrawingPad.swift
import SwiftUI
import UIKit // Diperlukan untuk UIViewRepresentable

struct DrawingPad: UIViewRepresentable {
    @Binding var currentDrawing: [CGPoint]
    @Binding var drawings: [[CGPoint]]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> DrawingView {
        let drawingView = DrawingView()
        drawingView.delegate = context.coordinator // Menetapkan delegate
        return drawingView
    }

    func updateUIView(_ uiView: DrawingView, context: Context) {
        // Memastikan DrawingView diperbarui dengan semua gambar yang sudah selesai
        // dan gambar yang sedang dibuat dari SwiftUI State
        uiView.drawings = drawings
        uiView.currentDrawing = currentDrawing // Penting: update currentDrawing juga
        uiView.setNeedsDisplay() // Memaksa UIView untuk menggambar ulang
    }

    class Coordinator: NSObject, DrawingViewDelegate {
        var parent: DrawingPad
        // Tambahkan reference ke DrawingView untuk update yang lebih efisien
        weak var drawingView: DrawingView?

        init(_ parent: DrawingPad) {
            self.parent = parent
        }

        func drawingDidStart(at point: CGPoint) {
            parent.currentDrawing = [point]
            drawingView?.currentDrawing = parent.currentDrawing // Update view langsung
            drawingView?.setNeedsDisplay()
        }

        func drawingDidMove(to point: CGPoint) {
            parent.currentDrawing.append(point)
            drawingView?.currentDrawing = parent.currentDrawing // Update view langsung
            drawingView?.setNeedsDisplay()
        }

        func drawingDidEnd() {
            if !parent.currentDrawing.isEmpty {
                parent.drawings.append(parent.currentDrawing)
            }
            parent.currentDrawing = [] // Reset currentDrawing setelah selesai
            drawingView?.currentDrawing = [] // Reset view punya currentDrawing
            drawingView?.setNeedsDisplay()
        }
    }
}

// MARK: - DrawingViewDelegate Protocol
protocol DrawingViewDelegate: AnyObject {
    func drawingDidStart(at point: CGPoint)
    func drawingDidMove(to point: CGPoint)
    func drawingDidEnd()
}

// MARK: - DrawingView (Custom UIView untuk menggambar)
class DrawingView: UIView {
    weak var delegate: DrawingViewDelegate?
    var currentDrawing: [CGPoint] = [] {
        didSet {
            // Ketika currentDrawing berubah, paksa redraw
            setNeedsDisplay()
        }
    }
    var drawings: [[CGPoint]] = [] {
        didSet {
            // Ketika drawings berubah, paksa redraw
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGestureRecognizers() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let currentPoint = gesture.location(in: self)

        switch gesture.state {
        case .began:
            delegate?.drawingDidStart(at: currentPoint)
        case .changed:
            delegate?.drawingDidMove(to: currentPoint)
            // setNeedsDisplay() // Tidak perlu lagi di sini karena didSet currentDrawing sudah memanggilnya
        case .ended, .cancelled:
            delegate?.drawingDidEnd()
            // setNeedsDisplay() // Tidak perlu lagi di sini karena didSet currentDrawing sudah memanggilnya
        default:
            break
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(5)
        context.setLineCap(.round)

        // Gambar semua drawing yang sudah selesai
        for drawing in drawings {
            if drawing.count > 1 {
                context.beginPath()
                context.move(to: drawing[0])
                for i in 1..<drawing.count {
                    context.addLine(to: drawing[i])
                }
                context.strokePath()
            }
        }

        // Gambar currentDrawing yang sedang berlangsung
        if currentDrawing.count > 1 {
            context.beginPath()
            context.move(to: currentDrawing[0])
            for i in 1..<currentDrawing.count {
                context.addLine(to: currentDrawing[i])
            }
            context.strokePath()
        }
    }
}

// MARK: - Preview
struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        // Inisialisasi State Binding yang benar untuk Preview
        DrawingPad(currentDrawing: .constant([]), drawings: .constant([
            [CGPoint(x: 50, y: 50), CGPoint(x: 100, y: 100), CGPoint(x: 150, y: 50)],
            [CGPoint(x: 200, y: 50), CGPoint(x: 200, y: 150), CGPoint(x: 250, y: 100)]
        ]))
        .frame(width: 300, height: 300)
        .border(Color.gray)
    }
}
