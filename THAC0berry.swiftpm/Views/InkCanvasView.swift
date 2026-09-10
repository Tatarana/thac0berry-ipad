import SwiftUI
import PencilKit

/// Canvas de tinta livre — clonado do scaffold do Just Pencil It.
/// Serve para as anotações do dia: mapas rabiscados, nomes de NPC, contas
/// de dano, o que não cabe em campo estruturado.
struct InkCanvasView: UIViewRepresentable {
    @Binding var drawingData: Data?
    var allowsFingerDrawing: Bool = false

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.delegate = context.coordinator
        canvas.drawingPolicy = allowsFingerDrawing ? .anyInput : .pencilOnly
        // O canvas é um UIScrollView: com scroll próprio dentro do ScrollView
        // da tela, os gestos brigam entre si.
        canvas.alwaysBounceVertical = false
        canvas.isScrollEnabled = false
        canvas.backgroundColor = .clear
        canvas.isOpaque = false
        canvas.tool = PKInkingTool(.pen, color: .label, width: 4)

        if let data = drawingData, let drawing = try? PKDrawing(data: data) {
            canvas.drawing = drawing
        }
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawingPolicy = allowsFingerDrawing ? .anyInput : .pencilOnly
        context.coordinator.parent = self

        // Só dá para ancorar a paleta depois que a view entrou na hierarquia
        // — em makeUIView a janela ainda é nil.
        if !context.coordinator.didAttachPicker, uiView.window != nil {
            context.coordinator.didAttachPicker = true
            context.coordinator.toolPicker.addObserver(uiView)
            context.coordinator.toolPicker.setVisible(true, forFirstResponder: uiView)
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: InkCanvasView
        let toolPicker = PKToolPicker()
        var didAttachPicker = false

        init(_ parent: InkCanvasView) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawingData = canvasView.drawing.dataRepresentation()
        }
    }
}
