import SwiftUI

/// Badge de contagem — número simples num círculo colorido por categoria.
///
/// Isso substitui três rodadas de ilustração de dado (contorno vetorial →
/// duas faces sombreadas → PNG facetado arredondado): em qualquer variação,
/// um polígono escuro com borda de latão sobre fundo obsidiana lê como
/// lápide/caixão, não como dado — o padrão visual "preenchimento escuro +
/// contorno metálico" é o problema, não o arredondamento nem o tom exato.
/// A forma do dado (d20/d10/d8/d4) nunca carregou informação nova pro
/// usuário além da cor por categoria (HP, contagem de sessões, páginas do
/// caderno) — sem utilidade real, então some. `DiceGeometry.Kind` continua
/// só pra escolher a cor de cada contexto.
enum DiceGeometry {
    enum Kind {
        case d20, d10, d8, d4
    }
}

/// Mesma família do `RoundIconBadge`: um círculo com um valor real (HP,
/// contagem de sessões/páginas — nunca um número decorativo) escrito por
/// cima, colorido pela categoria que ele representa.
struct DiceIconBadge: View {
    let kind: DiceGeometry.Kind
    var value: String? = nil
    var diameter: CGFloat = 44
    /// Brilho de "quente" — pro item em destaque hoje, por exemplo. Sutil,
    /// não é pra competir com o resto da tela.
    var isHot: Bool = false

    private var accent: Color {
        switch kind {
        case .d20: return Ember.brass
        case .d10: return Ember.amberAccent
        case .d8: return Ember.crimson
        case .d4: return Ember.teal
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(RadialGradient(
                    colors: [accent.opacity(0.95), accent.opacity(0.55)],
                    center: UnitPoint(x: 0.35, y: 0.3),
                    startRadius: 0,
                    endRadius: diameter * 0.7
                ))
                .overlay(Circle().stroke(Color.black.opacity(0.3), lineWidth: 1))
                .shadow(color: isHot ? Ember.glow.opacity(0.7) : .clear, radius: 6)

            if let value {
                Text(value)
                    .font(.system(size: diameter * 0.30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .padding(.horizontal, 4)
                    .shadow(color: .black.opacity(0.6), radius: 1.5)
            }
        }
        .frame(width: diameter, height: diameter)
        // Mesmo cuidado do `RoundIconBadge`: menor que os 44×44pt mínimos
        // recomendados pra alvo de toque, sem isso volta o mesmo bug de
        // "preciso tocar bem no centro" que já resolvemos no `SessionBadge`
        // antes.
        .frame(minWidth: 44, minHeight: 44)
        .contentShape(Rectangle())
        .accessibilityLabel(value ?? "")
    }
}
