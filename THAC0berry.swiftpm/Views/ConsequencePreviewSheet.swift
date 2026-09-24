import SwiftUI

/// Sinal de consequência pendente — acende quando
/// `character.hasPendingConsequences` é `true` (nível ou atributo mudou
/// desde a última revisão, ver `PlayerCharacter.markConsequencesReviewed`).
/// Tocar abre `ConsequencePreviewSheet`; não abre sozinho, de propósito —
/// o jogador pode mudar Força e Constituição em sequência antes de querer
/// ver a consequência de cada uma.
///
/// Ícone flutuante de verdade: `icon_consequence_signal.png` (escudo com
/// flecha flamejante, arte ilustrada entregue pela LLM de imagem — mesmo
/// padrão de `Docs/icon-button-spec.md` dos outros ícones do app) dentro
/// de um círculo com gradiente/sombra; sem a arte no bundle (por algum
/// motivo), cai pro símbolo antigo ("wand.and.stars") em vez de não
/// mostrar nada. Gradiente `Ember.mintGlow`/`.mintDeep` — verde-claro,
/// pra combinar com a chama turquesa do escudo. Entrada com bounce pra
/// chamar a atenção só no instante em que aparece — sem repetir a
/// animação enquanto o sinal continuar aceso.
///
/// Histórico de posição/tamanho (por ordem): começou como um "•" de 22pt
/// grudado no campo Level (difícil de acertar o toque); virou este ícone
/// de 34pt; depois virou parametrizado — um badge por campo (`isActive`
/// lendo `hasPendingLevelChange`/`hasPendingAbilityChange(_:)`), 68pt,
/// pipocando ao lado do Level OU de uma das seis linhas de Ability
/// Scores, dependendo de qual campo mudou por último. Usuário achou esse
/// vai-e-vem ruim ("tá aparecendo em pontos diversos") e pediu um lugar
/// FIXO: agora só existe uma chamada deste componente na ficha inteira,
/// em `RecordHeaderForm.body` — substitui o dragão (`record_badge.png`)
/// no mesmo lugar e tamanho (92pt) quando `hasPendingConsequences` é
/// `true`, volta a mostrar o dragão quando `false`. `isActive`/`diameter`
/// continuam parâmetros abertos (não hardcoded pro caso de precisar de
/// outro tamanho/gatilho no futuro), só que hoje só um call site existe.
/// O ícone interno escala com o círculo (proporção ~0.76) e a área de
/// toque nunca fica menor que 44×44pt (mínimo recomendado pela Apple),
/// mesmo em diâmetros pequenos.
struct ConsequenceSignalBadge: View {
    @Binding var character: PlayerCharacter
    var isActive: Bool
    var diameter: CGFloat = 68
    @State private var showSheet = false

    private var iconSize: CGFloat { diameter * 0.76 }
    private var tapArea: CGFloat { max(diameter, 44) }

    var body: some View {
        if isActive {
            Button(action: { showSheet = true }) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: [Ember.mintGlow, Ember.mintDeep],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: diameter, height: diameter)
                        .shadow(color: Ember.mintDeep.opacity(0.55), radius: 4, y: 1.5)
                        .overlay(Circle().stroke(Paper.sheet, lineWidth: 1.6))
                    if let art = Image.bundled("icon_consequence_signal") {
                        art
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: iconSize, height: iconSize)
                    } else {
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: iconSize * 0.6, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: tapArea, height: tapArea)
                .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Consequências pendentes — toque para revisar")
            .transition(.scale(scale: 0.4).combined(with: .opacity))
            .animation(.spring(response: 0.35, dampingFraction: 0.55), value: isActive)
            .sheet(isPresented: $showSheet) {
                ConsequencePreviewSheet(character: $character)
            }
        }
    }
}

/// Realce pros campos que também dependem de nível/atributo mas o
/// `ConsequenceSignalBadge` (o ícone circular acima) não cabe bem perto
/// deles — Saving Throws e THAC0 não são um valor único editável, são uma
/// SEÇÃO inteira ou um campo que o jogador atualiza na mão consultando a
/// tabela do livro. Pedido do usuário (2026-09-22, TODO.md item 41): "ao
/// invés de deixar os campos alterados em verde, você exibiu o ícone
/// pequeno ao lado deles. Tá errado" — troca o ícone por um fundo/borda
/// verde de verdade em cima do próprio campo/título, igual o resto do app
/// já faz pra "algo mudou" (`ChangeFlash`). Diferença pro `ChangeFlash`:
/// aqui NÃO é uma piscada que passa sozinha depois de alguns segundos —
/// fica aceso enquanto `character.hasPendingConsequences` continuar
/// `true` (revisado só quando o jogador abre e fecha o
/// `ConsequencePreviewSheet`, igual o badge). Puramente visual, sem
/// `Button`/toque próprio — pra não embrulhar um `Button` em cima de
/// campos que já são tocáveis sozinhos (`EditableNumber`, etc.), o que
/// quebraria o toque deles.
struct PendingConsequenceHighlight: ViewModifier {
    var isActive: Bool
    var color: Color = Ember.mintGlow

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color.opacity(isActive ? 0.3 : 0))
                    .padding(-3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: isActive ? 2 : 0)
                    .padding(-3)
            )
            .animation(.easeInOut(duration: 0.25), value: isActive)
    }
}

extension View {
    func pendingConsequenceHighlight(isActive: Bool) -> some View {
        modifier(PendingConsequenceHighlight(isActive: isActive))
    }
}

/// A janela em si: compara o retrato "antes" (`character.lastAppliedRuleContext`)
/// com o "agora" (`character.currentRuleContext`) através do
/// `ConsequenceEngine`/`RulesetRegistry`, e mostra uma linha por regra que
/// mudou — com o "antes → depois", de onde a conta vem (`RuleDetailSheet`,
/// reaproveitado igual ao atalho "?" da ficha), e se dá pra aplicar sozinho.
struct ConsequencePreviewSheet: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var ruleset: RulesetRegistry
    @EnvironmentObject private var rulesDatabase: RulesDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var detailRuleID: String? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("What Changes")
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text("\(character.name.isEmpty ? "This character" : character.name) — level \(character.level), \(character.characterClass.rawValue)")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    Button("close") { closeTapped() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                if items.isEmpty {
                    Text("No tracked rule changed value for this edit.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(items) { item in
                                ConsequenceItemRow(item: item, onShowRule: {
                                    if let id = item.sourceRuleID { detailRuleID = id }
                                })
                            }
                        }
                        .padding(.vertical, 4)
                    }

                    if hasAutoApplicable {
                        Button(action: applyAutomatic) {
                            Text("Apply automatic changes")
                                .font(Paper.printed(14))
                                .foregroundStyle(Paper.sheet)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Paper.ink)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(24)
        }
        .sheet(isPresented: Binding(get: { detailRuleID != nil }, set: { if !$0 { detailRuleID = nil } })) {
            if let id = detailRuleID, let entry = rulesDatabase.entry(id: id) {
                RuleDetailSheet(entry: entry)
            }
        }
    }

    private var items: [ConsequenceItem] {
        guard let old = character.lastAppliedRuleContext else { return [] }
        return ConsequenceEngine.diff(old: old, new: character.currentRuleContext, registry: ruleset)
    }

    private var hasAutoApplicable: Bool {
        items.contains { $0.kind == .autoApplicable }
    }

    private func applyAutomatic() {
        ConsequenceEngine.applyAutomatic(items, to: &character)
        character.markConsequencesReviewed()
        dismiss()
    }

    /// Bug relatado pelo usuário (2026-09-22): subiu o Kelmon pro nível
    /// 12, o sinal acendeu certinho, mas as únicas mudanças rastreadas
    /// eram de slots de magia (`.alreadyAutomatic` — já em vigor sozinho,
    /// só informativo) — sem NENHUM item `.autoApplicable`, o botão
    /// "Apply automatic changes" nunca aparecia, só "close". E "close"
    /// sozinho nunca chamava `markConsequencesReviewed()`, então o sinal
    /// ficava aceso pra sempre, sem jeito nenhum de apagar.
    ///
    /// Quando não há nada PRA aplicar (`!hasAutoApplicable`), só abrir e
    /// ler esta janela já é a revisão completa — não faz sentido o sinal
    /// continuar preso. "close" nesse caso também marca revisado. Quando
    /// HÁ algo aplicável e o jogador fecha sem aplicar, o sinal continua
    /// aceso de propósito (ainda existe uma ação pendente de verdade).
    private func closeTapped() {
        if !hasAutoApplicable {
            character.markConsequencesReviewed()
        }
        dismiss()
    }
}

private struct ConsequenceItemRow: View {
    let item: ConsequenceItem
    let onShowRule: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(item.label)
                    .font(Paper.hand(18))
                    .foregroundStyle(Paper.penInk)
                Spacer()
                if item.kind == .alreadyAutomatic {
                    Text("auto-updates")
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                }
            }

            HStack(spacing: 6) {
                Text(item.oldValue?.displaySummary ?? "—")
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.inkSoft)
                Image(systemName: "arrow.right")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(Paper.inkSoft)
                Text(item.newValue?.displaySummary ?? "—")
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.penInk)

                if item.sourceRuleID != nil {
                    Spacer()
                    Button(action: onShowRule) {
                        Text("ver regra")
                            .font(Paper.printedItalic(11.5))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.vertical, 4)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}
