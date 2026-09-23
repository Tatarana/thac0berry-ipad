import SwiftUI
import UIKit

extension Image {
    /// Carrega um PNG do bundle pelo nome (sem extensão) via `UIImage`, não
    /// via `Image(_:)` direto — mesmo truque que `HomeView.mascotBadge` já
    /// usava sozinha: o catálogo de assets do Swift Playgrounds às vezes
    /// não enxerga um PNG solto em `Resources/`, mas `Bundle.main.url`
    /// sempre encontra. Usado pelos ícones ilustrados entregues pela LLM de
    /// imagem (ver `Docs/icon-button-spec.md`) — todos PNG com fundo
    /// transparente.
    static func bundled(_ name: String) -> Image? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "png"),
              let uiImage = UIImage(contentsOfFile: url.path)
        else { return nil }
        return Image(uiImage: uiImage)
    }
}

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

    /// A "capa" do caderno — fundo escuro de couro que envolve a navegação
    /// (a fileira de abas, o menu) por fora das folhas de verdade. Só o
    /// conteúdo (a ficha, a folha de magia, a página do caderno) continua
    /// com cara de pergaminho; a moldura ao redor agora é a capa, não mais
    /// mais uma folha igual às de dentro.
    static let chrome = Color(red: 0.176, green: 0.129, blue: 0.098)   // #2D2119 couro escuro
    static let chromeDeep = Color(red: 0.129, green: 0.094, blue: 0.071)

    /// Tarja de cabeçalho só do bloco de Turn Undead — um vinho escuro, pra
    /// não ser confundido de relance com a tarja preta dos círculos de magia.
    static let turnHeader = Color(red: 0.361, green: 0.145, blue: 0.129)

    /// Paleta pastel das divisórias de sessão — tons discretos que ainda
    /// combinam com o papel, em vez de cor saturada de app.
    static let sessionPalette: [Color] = [
        Color(red: 0.80, green: 0.62, blue: 0.38),  // ocre
        Color(red: 0.55, green: 0.64, blue: 0.52),  // salvia
        Color(red: 0.54, green: 0.60, blue: 0.72),  // azul-acinzentado
        Color(red: 0.76, green: 0.48, blue: 0.42),  // terracota
        Color(red: 0.66, green: 0.55, blue: 0.72),  // ameixa
        Color(red: 0.80, green: 0.70, blue: 0.36)   // mostarda
    ]

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

extension Campaign {
    /// Cor da divisória de uma sessão — sempre a mesma pra mesma sessão,
    /// calculada pela posição cronológica dela entre todas as sessões da
    /// campanha (não pela posição na lista filtrada/ordenada de exibição),
    /// pra não mudar de cor conforme sessões são arquivadas ou criadas.
    func sessionColor(_ session: Session) -> Color {
        let chronological = sessions.sorted { $0.date < $1.date }
        let index = chronological.firstIndex { $0.id == session.id } ?? 0
        return Paper.sessionPalette[index % Paper.sessionPalette.count]
    }
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

/// Fundo da capa de couro que envolve a navegação (fileira de abas) — o
/// mesmo grão de ruído do pergaminho, só que multiplicado sobre um marrom
/// bem mais escuro, com manchas de desgaste e uma linha de costura sutil
/// rente à borda de baixo, como a lombada de um caderno de couro de verdade.
struct ChromeBackground: View {
    var body: some View {
        ZStack {
            Paper.chrome

            RadialGradient(colors: [Color.white.opacity(0.07), Color.clear],
                           center: UnitPoint(x: 0.2, y: 0.1),
                           startRadius: 4, endRadius: 260)

            RadialGradient(colors: [Paper.chromeDeep.opacity(0.8), Color.clear],
                           center: UnitPoint(x: 0.85, y: 0.9),
                           startRadius: 10, endRadius: 320)

            Paper.grain
                .resizable(resizingMode: .tile)
                .blendMode(.multiply)
                .opacity(0.24)

            // Um fio de costura, rente à borda de baixo da capa.
            Rectangle()
                .fill(Paper.chromeDeep)
                .frame(height: 1)
                .frame(maxHeight: .infinity, alignment: .bottom)
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

/// Rótulo impresso pequeno, em versalete espaçado. Componente compartilhado
/// por praticamente todo o app (rótulos de campo nos Compêndios, cabeçalhos
/// de tabela na Ficha de Magias, etc.) — a MAIORIA dos usos tem largura
/// flexível (rótulo em cima, valor embaixo, numa `VStack` sem `frame`
/// travado), mas alguns cabeçalhos de tabela estreitos (ex.: "Cast"/
/// "Dmg/Heal" na Ficha de Magias, `frame(width: 42)`/`frame(width: 70)`)
/// travam a largura de fora. 9.5→10.5pt (fase 2 de fonte, "confirmar Spell
/// Sheet", 2026-09-22 — achei este componente abaixo do piso de 10pt
/// estabelecido nas rodadas anteriores) + `lineLimit`/`minimumScaleFactor`
/// de segurança pros casos de largura travada — mesmo padrão já usado no
/// cabeçalho "Start/Mod/Total" de Saving Throws (TODO.md item 45).
struct FieldLabel: View {
    let text: String

    var body: some View {
        Text(text.uppercased())
            .font(Paper.printed(10.5))
            .tracking(2)
            .foregroundStyle(Paper.inkSoft)
            .lineLimit(1)
            .minimumScaleFactor(0.75)
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

/// Um ícone redondo — a mesma "moeda" visual usada em vários cantos do
/// app pra ações que antes eram caixinhas de texto ("+ new campaign",
/// "Archive", "< Campaigns"...). Só o desenho, sem ação própria: quem usa
/// decide se embrulha num `Button` simples (`RoundIconButton`, logo
/// abaixo) ou no label de um `NavigationLink`, pra nunca acabar com um
/// botão dentro de outro botão.
struct RoundIconBadge: View {
    let systemImage: String
    var style: Style = .badge

    enum Style {
        /// Selo escuro de couro — pra ação "especial", meio fora do fluxo
        /// normal de conteúdo (o Grimório, atalhos de topo de tela).
        case badge
        /// Contorno de tinta sobre pergaminho — pro resto dos ícones de
        /// ação dentro do conteúdo (arquivar, voltar, os "+").
        case paper
    }

    var body: some View {
        Image(systemName: systemImage)
            .font(.system(size: style == .badge ? 18 : 14, weight: .medium))
            .foregroundStyle(style == .badge ? Paper.sheet : Paper.ink)
            .frame(width: style == .badge ? 42 : 34, height: style == .badge ? 42 : 34)
            .background(style == .badge ? Paper.ink : Color.white.opacity(0.16))
            .clipShape(Circle())
            .overlay(Circle().stroke(style == .badge ? Paper.chromeDeep : Paper.ink,
                                     lineWidth: style == .badge ? 1.5 : 1.2))
            .shadow(color: Paper.ink.opacity(style == .badge ? 0.3 : 0), radius: 3, y: 1.5)
            // O círculo desenhado (34-42pt) fica menor que o mínimo de
            // 44×44pt que a Apple recomenda pra alvo de toque — sem isso,
            // um toque perto da borda (não bem no centro) não registra, e
            // o botão parece "não funcionar" de primeira. `clipShape`
            // sozinho restringe o toque à forma recortada; o
            // `contentShape` por cima devolve a área cheia.
            .frame(minWidth: 44, minHeight: 44)
            .contentShape(Rectangle())
    }
}

/// Atalho pra quando o ícone É o botão inteiro (sem `NavigationLink` por
/// perto pra fornecer a ação) — "+ novo", arquivar, voltar.
struct RoundIconButton: View {
    let systemImage: String
    var style: RoundIconBadge.Style = .badge
    let action: () -> Void
    var accessibilityLabel: String = ""
    /// Texto que aparece num balãozinho ao tocar e segurar — só vale a
    /// pena nos botões maiores/mais importantes (a estante de Campanhas e
    /// a tela de uma Campanha); nos outros o ícone já fala por si, e um
    /// tooltip a mais só polui a tela.
    var tooltip: String? = nil

    var body: some View {
        Button(action: action) {
            RoundIconBadge(systemImage: systemImage, style: style)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
        .modifier(OptionalTooltip(text: tooltip))
    }
}

/// Toque e segure num botão pra ver o nome da ação escrito — pensado pra
/// quem ainda não decorou o que cada ícone novo faz. `simultaneousGesture`
/// (em vez de substituir o gesto do Button) garante que o toque normal
/// continua funcionando exatamente igual, o long press só é mais uma
/// observação por cima.
struct LongPressTooltip: ViewModifier {
    let text: String
    @State private var isShowing = false

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isShowing {
                    Text(text)
                        .font(Paper.printed(11))
                        .tracking(0.4)
                        .foregroundStyle(Paper.sheet)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Paper.ink)
                        .clipShape(Capsule())
                        .fixedSize()
                        .offset(y: -40)
                        .transition(.opacity.combined(with: .scale(scale: 0.92)))
                        .zIndex(1)
                        .allowsHitTesting(false)
                }
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.45).onEnded { _ in
                    withAnimation(.easeOut(duration: 0.15)) { isShowing = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        withAnimation(.easeIn(duration: 0.2)) { isShowing = false }
                    }
                }
            )
    }
}

/// Aplica o `LongPressTooltip` só quando há texto — deixa `RoundIconButton`
/// usável sem tooltip nenhum sem precisar de dois inits diferentes.
private struct OptionalTooltip: ViewModifier {
    let text: String?

    func body(content: Content) -> some View {
        if let text {
            content.modifier(LongPressTooltip(text: text))
        } else {
            content
        }
    }
}

extension View {
    /// Mesmo tooltip de toque-e-segure do `RoundIconButton`, exposto pra
    /// quando o botão de verdade não é um `Button` (o label de um
    /// `NavigationLink`, por exemplo — o Grimório na estante).
    func actionTooltip(_ text: String) -> some View {
        modifier(LongPressTooltip(text: text))
    }
}
