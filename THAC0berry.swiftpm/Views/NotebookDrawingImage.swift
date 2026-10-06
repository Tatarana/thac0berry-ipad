import UIKit
import PencilKit

/// Imagem PNG das folhas de desenho do caderno, para quem não lê o formato
/// do PencilKit (a versão web, que mostra a folha só para leitura). Pedido
/// do usuário (2026-10-06).
///
/// Só é gerada na exportação do backup (`CharacterLibrary.exportSnapshot`),
/// longe do `DrawingCanvas` (que já teve crash por atualização de estado
/// durante a animação de página) e sem pesar no salvamento automático.
enum NotebookDrawingImage {
    /// PNG do desenho, do canto de cima da folha até o último traço (com uma
    /// pequena margem), para a posição dos traços bater com a da folha.
    /// `nil` se não há desenho ou nenhum traço.
    static func png(from data: Data?) -> Data? {
        guard let data, let drawing = try? PKDrawing(data: data), !drawing.strokes.isEmpty else { return nil }
        let bounds = drawing.bounds
        let rect = CGRect(x: 0, y: 0, width: max(bounds.maxX, 1) + 16, height: max(bounds.maxY, 1) + 16)
        var image: UIImage?
        // Modo claro: a tinta é escura sobre o papel claro, como no canvas
        // (ver `DrawingCanvas.defaultInkColor`).
        UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
            image = drawing.image(from: rect, scale: 1)
        }
        return image?.pngData()
    }

    /// Os personagens com a imagem preenchida em cada folha de desenho.
    static func addingImages(to characters: [PlayerCharacter]) -> [PlayerCharacter] {
        characters.map { character in
            guard let entries = character.notebookEntries, entries.contains(where: { $0.kind == .freeform }) else {
                return character
            }
            var copy = character
            copy.notebookEntries = entries.map { entry in
                guard entry.kind == .freeform else { return entry }
                var withImage = entry
                withImage.drawingImage = png(from: entry.drawingData)
                return withImage
            }
            return copy
        }
    }
}
