import SwiftUI

/// Paleta "couro & brasa" — a pele da navegação (estante, campanha,
/// elenco). Convive com `Paper`, não substitui: o pergaminho continua
/// sendo a verdade dentro da Ficha, da Priest Spell Sheet e do Caderno.
/// Cores espelhando exatamente os tokens usados na proposta de Design
/// ("Duas Peles") já aprovada, pra não inventar uma paleta nova aqui.
enum Ember {
    static let obsidian = Color(red: 0.106, green: 0.078, blue: 0.059)       // #1B140F
    static let obsidianDeep = Color(red: 0.063, green: 0.043, blue: 0.031)   // #100B08
    static let obsidianRaise = Color(red: 0.145, green: 0.110, blue: 0.082)  // #251C15
    /// A face "de luz" dos badges de dado — só um degrau mais clara que
    /// `obsidianRaise`, o bastante pra sugerir uma faceta iluminada sem
    /// precisar de sombra de verdade nenhuma.
    static let obsidianHighlight = Color(red: 0.216, green: 0.169, blue: 0.129) // #37312C-ish, mais claro

    static let glow = Color(red: 0.878, green: 0.345, blue: 0.118)          // #E0581E
    static let glowBright = Color(red: 1.0, green: 0.698, blue: 0.235)      // #FFB23C

    static let brass = Color(red: 0.788, green: 0.635, blue: 0.153)         // #C9A227
    static let brassDim = Color(red: 0.541, green: 0.443, blue: 0.165)      // #8A712A

    static let onObsidian = Color(red: 0.937, green: 0.894, blue: 0.827)    // #EFE4D3
    static let onObsidianSoft = Color(red: 0.722, green: 0.651, blue: 0.565) // #B8A690

    /// Segundo tom — um vinho profundo, não mais um marrom só, entrando
    /// por baixo do fundo pra tirar a cara de preto-e-dourado sozinho.
    static let ember = Color(red: 0.878, green: 0.345, blue: 0.118)         // mesmo valor de `glow`, nome mais claro pra uso em texto
    static let wine = Color(red: 0.42, green: 0.086, blue: 0.098)           // #6B161A

    /// As mesmas três matizes usadas nos badges de dado (`die_d8` vermelho,
    /// `die_d10` âmbar, `die_d4` verde-água) — reaproveitadas aqui como
    /// tarja de cor nos cartões, pra a cor do dado e a cor do cartão que
    /// ele mora dentro baterem, em vez de tudo voltar a ser preto-dourado.
    static let crimson = Color(red: 0.80, green: 0.22, blue: 0.16)          // personagem / HP
    static let amberAccent = Color(red: 0.86, green: 0.62, blue: 0.20)      // campanha / contagem
    static let teal = Color(red: 0.18, green: 0.55, blue: 0.48)             // caderno / páginas
}

/// Fundo de couro e brasa pras telas de navegação — a primeira versão
/// ficou preto-e-dourado demais (a brasa do topo estava a 22% de opacidade,
/// quase invisível numa foto). Esta versão deixa o brilho de fogo de
/// verdade visível vindo de cima, e soma um segundo tom — vinho profundo —
/// vindo de baixo, pra ter duas cores conversando em vez de uma só.
struct ObsidianBackground: View {
    var body: some View {
        ZStack {
            Ember.obsidianDeep

            RadialGradient(colors: [Ember.glow.opacity(0.5), Ember.glow.opacity(0.14), Color.clear],
                           center: UnitPoint(x: 0.5, y: -0.08),
                           startRadius: 10, endRadius: 560)

            RadialGradient(colors: [Ember.wine.opacity(0.38), Color.clear],
                           center: UnitPoint(x: 0.12, y: 1.05),
                           startRadius: 10, endRadius: 500)

            RadialGradient(colors: [Ember.wine.opacity(0.22), Color.clear],
                           center: UnitPoint(x: 0.95, y: 0.6),
                           startRadius: 10, endRadius: 420)

            LinearGradient(colors: [Ember.obsidian.opacity(0.4), Ember.obsidianDeep],
                           startPoint: .top, endPoint: .bottom)

            Paper.grain
                .resizable(resizingMode: .tile)
                .blendMode(.overlay)
                .opacity(0.10)

            RoundedRectangle(cornerRadius: 2)
                .stroke(Color.black.opacity(0.5), lineWidth: 34)
                .blur(radius: 26)
                .padding(-16)
        }
        .drawingGroup()
        .ignoresSafeArea()
    }
}

/// Fundo de cartão pras telas de couro — degradê sutil (não mais um marrom
/// liso) e uma tarja de cor à esquerda ligada ao que o cartão representa
/// (campanha, personagem, caderno...), pra cada linha ter uma cor de
/// verdade em vez de todo mundo virar a mesma caixa marrom com borda
/// dourada.
struct EmberCard: ViewModifier {
    var accent: Color = Ember.amberAccent

    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(colors: [Ember.obsidianHighlight.opacity(0.55), Ember.obsidianRaise],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .overlay(alignment: .leading) {
                Rectangle().fill(accent).frame(width: 3)
            }
            .overlay(Rectangle().stroke(Ember.brass.opacity(0.5), lineWidth: 1.2))
    }
}

extension View {
    func emberCard(accent: Color = Ember.amberAccent) -> some View {
        modifier(EmberCard(accent: accent))
    }
}
