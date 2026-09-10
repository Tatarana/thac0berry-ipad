import SwiftUI
import UIKit

/// A identidade visual do app é uma folha de ficha: pergaminho, tinta
/// marrom-escura, valores escritos à caneta azul, correções em vermelho.
/// Nada de Form, List ou controle padrão do sistema à vista.
enum Paper {

    // MARK: - Cores

    static let sheet = Color(red: 0.914, green: 0.863, blue: 0.745)   // #E9DCBE
    static let sheetDeep = Color(red: 0.859, green: 0.792, blue: 0.647)
    static let ink = Color(red: 0.184, green: 0.153, blue: 0.110)     // #2F271C
    static let inkSoft = Color(red: 0.420, green: 0.361, blue: 0.275) // #6B5C46
    static let penInk = Color(red: 0.118, green: 0.208, blue: 0.341)  // #1E3557 caneta azul
    static let redInk = Color(red: 0.549, green: 0.184, blue: 0.133)  // #8C2F22

    static let hairline = Color(red: 0.184, green: 0.153, blue: 0.110).opacity(0.42)

    /// Tarja de cabeçalho só do bloco de Turn Undead — um vinho escuro, pra
    /// não ser confundido de relance com a tarja preta dos círculos de magia.
    static let turnHeader = Color(red: 0.361, green: 0.145, blue: 0.129)

    // MARK: - Tipografia

    /// Texto impresso da ficha: rótulos, títulos, notas de rodapé.
    static func printed(_ size: CGFloat) -> Font {
        custom(["Baskerville", "Palatino", "Georgia"], size: size, fallback: .serif)
    }

    static func printedItalic(_ size: CGFloat) -> Font {
        custom(["Baskerville-Italic", "Palatino-Italic", "Georgia-Italic"],
               size: size, fallback: .serif).italic()
    }

    /// Tudo que o jogador "escreveu" na ficha: nomes, números, magias.
    static func hand(_ size: CGFloat) -> Font {
        custom(["Bradley Hand", "BradleyHandITCTT-Bold", "Noteworthy-Bold", "MarkerFelt-Thin"],
               size: size, fallback: .rounded)
    }

    private static func custom(_ names: [String], size: CGFloat, fallback: Font.Design) -> Font {
        for name in names where UIFont(name: name, size: size) != nil {
            return Font.custom(name, size: size)
        }
        return Font.system(size: size, design: fallback)
    }

    // MARK: - Grão do papel

    /// Ruído gerado uma única vez e reaproveitado como textura repetida.
    /// Sem isso o pergaminho fica com cara de retângulo bege.
    static let grain: Image = {
        let side = 128
        let bytesPerPixel = 4
        var pixels = [UInt8](repeating: 255, count: side * side * bytesPerPixel)

        for index in stride(from: 0, to: pixels.count, by: bytesPerPixel) {
            let value = UInt8.random(in: 120...255)
            pixels[index] = value
            pixels[index + 1] = value
            pixels[index + 2] = value
            pixels[index + 3] = 255
        }

        // Os bytes vão para um CGDataProvider: passar &pixels direto ao
        // CGContext deixaria um ponteiro pendurado depois do escopo.
        let bitmap = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let provider = CGDataProvider(data: Data(pixels) as CFData),
              let cgImage = CGImage(width: side, height: side,
                                    bitsPerComponent: 8, bitsPerPixel: 32,
                                    bytesPerRow: side * bytesPerPixel,
                                    space: CGColorSpaceCreateDeviceRGB(),
                                    bitmapInfo: bitmap,
                                    provider: provider, decode: nil,
                                    shouldInterpolate: false, intent: .defaultIntent)
        else { return Image(systemName: "square") }

        return Image(decorative: cgImage, scale: 2)
    }()
}

/// Fundo de pergaminho: base, manchas de envelhecimento, grão e sombra das
/// bordas — na ordem em que o papel envelhece de verdade.
struct PaperBackground: View {
    var body: some View {
        ZStack {
            Paper.sheet

            RadialGradient(colors: [Color.white.opacity(0.45), Color.clear],
                           center: UnitPoint(x: 0.18, y: 0.12),
                           startRadius: 10, endRadius: 620)

            RadialGradient(colors: [Paper.sheetDeep.opacity(0.55), Color.clear],
                           center: UnitPoint(x: 0.84, y: 0.80),
                           startRadius: 20, endRadius: 640)

            Paper.grain
                .resizable(resizingMode: .tile)
                .blendMode(.multiply)
                .opacity(0.10)

            // Bordas escurecidas, como papel manuseado por anos.
            RoundedRectangle(cornerRadius: 2)
                .stroke(Paper.ink.opacity(0.30), lineWidth: 34)
                .blur(radius: 26)
                .padding(-16)
        }
        .drawingGroup()
        .ignoresSafeArea()
    }
}

// MARK: - Peças da ficha

/// Um quadro da ficha, com tarja escura de título — como nas fichas impressas.
struct SheetBlock<Content: View>: View {
    let title: String
    var trailing: String? = nil
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title.uppercased())
                    .font(Paper.printed(11))
                    .tracking(2.4)
                    .foregroundStyle(Paper.sheet)
                Spacer(minLength: 6)
                if let trailing {
                    Text(trailing.uppercased())
                        .font(Paper.printed(9))
                        .tracking(1.6)
                        .foregroundStyle(Paper.sheet.opacity(0.75))
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Paper.ink)

            content
                .padding(.horizontal, 12)
                .padding(.vertical, 9)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.white.opacity(0.12))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.4))
    }
}

/// Rótulo impresso pequeno, em versalete espaçado.
struct FieldLabel: View {
    let text: String

    var body: some View {
        Text(text.uppercased())
            .font(Paper.printed(9.5))
            .tracking(2)
            .foregroundStyle(Paper.inkSoft)
    }
}

/// Valor escrito à mão, com uma inclinação mínima para não parecer digitado.
struct HandValue: View {
    let text: String
    var size: CGFloat = 26
    var color: Color = Paper.penInk
    var tilt: Double = -0.5

    var body: some View {
        Text(text)
            .font(Paper.hand(size))
            .foregroundStyle(color)
            .rotationEffect(.degrees(tilt))
    }
}

/// Linha pontilhada de separação entre itens da ficha.
struct DottedRule: View {
    var body: some View {
        Rectangle()
            .fill(Paper.hairline)
            .frame(height: 1)
    }
}

/// Círculo de slot de magia: cheio = pronto, com X vermelho = gasto.
struct SlotCircle: View {
    let isSpent: Bool
    var diameter: CGFloat = 26

    var body: some View {
        ZStack {
            Circle()
                .fill(isSpent ? Color.clear : Color.white.opacity(0.45))
            Circle()
                .stroke(Paper.ink, lineWidth: 1.6)
            if isSpent {
                Text("✕")
                    .font(Paper.hand(diameter * 0.95))
                    .foregroundStyle(Paper.redInk)
                    .rotationEffect(.degrees(-8))
            }
        }
        .frame(width: diameter, height: diameter)
        .contentShape(Circle())
    }
}
