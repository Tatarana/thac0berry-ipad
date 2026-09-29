import SwiftUI

// MARK: - Efeitos Ativos (2026-09-28, revisado 2026-09-28)
//
// Tela nova, sem equivalente na ficha oficial em PDF — por isso o visual
// é mais "post-it sobre a ficha" (cartões com borda arredondada) em vez
// de imitar uma tabela impressa como o resto do app. Ver
// `Models/ActiveEffect.swift` pro desenho de dados (um item = nome +
// lista dinâmica de "efeitos" mecânicos) e
// `PlayerCharacter.applyActiveEffect`/`saveEditedActiveEffect`/
// `endActiveEffect`/`applyDamage` (em `Character.swift`) pra como cada
// tipo escreve (e desfaz) na ficha.
struct ActiveEffectsView: View {
    @Binding var character: PlayerCharacter
    @State private var isAdding = false
    @State private var editingEffect: ActiveEffect? = nil

    private var effects: [ActiveEffect] { character.activeEffects ?? [] }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Active Effects")
                    .font(Paper.printed(20))
                    .foregroundStyle(Paper.ink)
                Text("Spells, potions, and other effects with a finite duration — tracked here instead of the printed sheet, since they come and go mid-session.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            if effects.isEmpty {
                VStack(spacing: 8) {
                    Text("No active effects.")
                        .font(Paper.printed(14))
                        .foregroundStyle(Paper.inkSoft)
                    Text("Tap “+ Add effect” below when your character gets buffed, debuffed, or otherwise affected for a limited time.")
                        .font(Paper.printedItalic(12.5))
                        .foregroundStyle(Paper.inkSoft.opacity(0.85))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
            } else {
                VStack(spacing: 10) {
                    ForEach(effects) { effect in
                        ActiveEffectCard(character: $character, effect: effect, onEdit: { editingEffect = effect })
                    }
                }
            }

            Button {
                isAdding = true
            } label: {
                Text("+ Add effect")
                    .font(Paper.printed(14))
                    .foregroundStyle(Paper.sheet)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 9)
                    .background(Paper.ink)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .sheet(isPresented: $isAdding) {
            ActiveEffectEditorSheet(character: $character, existing: nil)
        }
        .sheet(item: $editingEffect) { effect in
            ActiveEffectEditorSheet(character: $character, existing: effect)
        }
    }
}

/// Um cartão por item — cabeçalho comum (nome, duração, "Edit"/"End"),
/// e um bloco por componente mecânico (`effect.components`).
private struct ActiveEffectCard: View {
    @Binding var character: PlayerCharacter
    let effect: ActiveEffect
    let onEdit: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(effect.name.isEmpty ? "Effect" : effect.name)
                        .font(Paper.hand(20))
                        .foregroundStyle(Paper.penInk)
                    if !effect.durationLabel.isEmpty {
                        Text(effect.durationLabel)
                            .font(Paper.printedItalic(11.5))
                            .foregroundStyle(Paper.inkSoft)
                    }
                }
                Spacer(minLength: 8)
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .font(.system(size: 13))
                        .foregroundStyle(Paper.inkSoft)
                        .frame(width: 26, height: 26)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                Button {
                    withAnimation(.easeOut(duration: 0.18)) {
                        character.endActiveEffect(id: effect.id)
                    }
                } label: {
                    Text("End")
                        .font(Paper.printed(11.5))
                        .foregroundStyle(Paper.redInk)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 4)
                        .overlay(RoundedRectangle(cornerRadius: 6, style: .continuous).stroke(Paper.redInk.opacity(0.6), lineWidth: 1))
                }
                .buttonStyle(.plain)
            }

            ForEach(effect.components) { component in
                componentBody(component)
                    .padding(.top, 2)
            }

            if !effect.notes.isEmpty {
                Text(effect.notes)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
        }
        .padding(12)
        .background(Color.white.opacity(0.12))
        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Paper.ink, lineWidth: 1.2))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    @ViewBuilder
    private func componentBody(_ component: EffectComponent) -> some View {
        switch component.kind {
        case .flatBonus, .statOverride, .note:
            Text(component.summary)
                .font(Paper.printed(13))
                .foregroundStyle(Paper.ink)

        case .attackNegation:
            counterRow(component, unit: "attacks negated")

        case .bankedHeal:
            bankedHealBody(component)

        case .tempHP:
            Text("\(component.summary) added to Current HP — what's lost to damage while this is active never heals back.")
                .font(Paper.printed(13))
                .foregroundStyle(Paper.ink)
        }
    }

    /// Linha "X of Y" com o mesmo `TallyBoard` já usado pelos itens
    /// mágicos/Turn Undead — usada só por `.attackNegation` agora
    /// (`.tempHP` não tem mais contador visível, pedido do usuário:
    /// "não fez sentido existir" — o total já aparece direto no PV
    /// atual).
    private func counterRow(_ component: EffectComponent, unit: String) -> some View {
        HStack(spacing: 8) {
            TallyBoard(
                count: component.usedCount,
                isExhausted: component.isExhausted,
                onAdd: { updateComponent(component) { $0.usedCount = min($0.usedCount + 1, $0.maxUses) } },
                onRemove: {
                    guard component.usedCount > 0 else { return }
                    updateComponent(component) { $0.usedCount -= 1 }
                }
            )
            Text("\(component.usedCount) of \(component.maxUses)")
                .font(Paper.hand(15))
                .foregroundStyle(component.isExhausted ? Paper.redInk : Paper.penInk)
            Text(unit)
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private func bankedHealBody(_ component: EffectComponent) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            if component.healIsBanked {
                Text("Banked — starts healing 1/round the moment this character next takes damage (window: \(component.healWindowLabel), or it fades).")
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
                Button {
                    updateComponent(component) { $0.healIsBanked = false }
                } label: {
                    Text("Activate now (took damage)")
                        .font(Paper.printedItalic(12.5))
                        .foregroundStyle(Paper.inkSoft)
                }
                .buttonStyle(.plain)
            } else {
                Text("Healing 1/round — tap to log this round's point (also raises Current HP).")
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
                HStack(spacing: 8) {
                    TallyBoard(
                        count: component.usedCount,
                        isExhausted: component.isExhausted,
                        onAdd: {
                            guard component.usedCount < component.maxUses else { return }
                            updateComponent(component) { $0.usedCount += 1 }
                            character.hitPointsCurrent = min(character.hitPointsMax, character.hitPointsCurrent + 1)
                        },
                        onRemove: {
                            guard component.usedCount > 0 else { return }
                            updateComponent(component) { $0.usedCount -= 1 }
                            character.hitPointsCurrent -= 1
                        }
                    )
                    Text("\(component.usedCount) of \(component.maxUses) HP healed")
                        .font(Paper.hand(15))
                        .foregroundStyle(component.isExhausted ? Paper.redInk : Paper.penInk)
                }
            }
        }
    }

    /// Atualiza UM componente dentro do item e grava o item inteiro de
    /// volta — usado pelos contadores/toggles que o próprio cartão
    /// controla (sem abrir a tela de edição).
    private func updateComponent(_ component: EffectComponent, _ change: (inout EffectComponent) -> Void) {
        guard let index = effect.components.firstIndex(where: { $0.id == component.id }) else { return }
        var updated = effect
        change(&updated.components[index])
        character.updateActiveEffect(updated)
    }
}

// MARK: - Criar/editar efeito
//
// Mesmo padrão de `NewSessionSheet` (`CampaignIndexView.swift`) — um
// `.sheet` SEM `.presentationDetents`, num cartão de largura fixa, em vez
// de um bottom sheet redimensionável. O problema "a janela é pequena e
// exige resizing" vinha daí: `.presentationDetents` no iPad troca a
// apresentação padrão (um cartão de formulário de tamanho fixo) por um
// bottom sheet de altura variável. Removendo o modifier, a apresentação
// volta a ser o cartão fixo de sempre.
//
// "A janela pula pra cima ao escrever o nome" é um problema DIFERENTE
// (revisado 2026-09-29, depois que o primeiro reparo não resolveu): esta
// tela precisa de um `ScrollView` — ao contrário de `NewSessionSheet`
// (poucos campos fixos), a lista de efeitos aqui pode crescer sem limite
// ("+ add another") e não cabe sempre no cartão. E é exatamente o
// `ScrollView` o culpado do pulo: o SwiftUI dá a QUALQUER `ScrollView`
// um desvio automático de teclado — quando um campo de texto ganha foco,
// ele reserva/rola espaço pra um teclado, mesmo quando esse campo não
// tem teclado de software NENHUM (`allowsSoftwareKeyboard: false` deixa
// o `inputView` como um `UIView()` vazio, mas pro UIKit isso ainda conta
// como "apareceu um teclado" pra fins de notificação de frame — o
// `ScrollView` do SwiftUI escuta essa notificação e desvia o conteúdo de
// qualquer forma). Por isso a mesma configuração de campo que funciona
// sem pular em `NewSessionSheet` (que é só um `VStack`, sem
// `ScrollView`) pulava aqui. `.ignoresSafeArea(.keyboard, edges: .bottom)`
// no `ScrollView` desliga esse desvio automático — como o teclado real
// nunca aparece, não existe nenhum espaço de verdade pra reservar.
private struct ActiveEffectEditorSheet: View {
    @Binding var character: PlayerCharacter
    /// `nil` = criando um item novo; não-nil = editando este (mesmo
    /// `id`) — pedido do usuário (2026-09-28): "falta opção de editar
    /// efeito salvo".
    let existing: ActiveEffect?
    @Environment(\.dismiss) private var dismiss

    @State private var draft: ActiveEffect

    init(character: Binding<PlayerCharacter>, existing: ActiveEffect?) {
        self._character = character
        self.existing = existing
        var initial = existing ?? ActiveEffect()
        // Nasce sempre com pelo menos um componente — nunca deixa o
        // formulário num estado "vazio" onde não fica claro o que
        // preencher pra poder salvar (pedido do usuário: "não sei o que
        // faltou preencher").
        if initial.components.isEmpty {
            initial.components = [EffectComponent()]
        }
        self._draft = State(initialValue: initial)
    }

    /// Único requisito real pra salvar — cada componente já nasce com
    /// valores padrão válidos pro seu tipo, então nada além do nome
    /// bloqueia o botão.
    private var canSave: Bool { !draft.name.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        ZStack {
            PaperBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(existing == nil ? "New Effect" : "Edit Effect")
                            .font(Paper.hand(26))
                            .foregroundStyle(Paper.penInk)
                        Spacer()
                        Button("close") { dismiss() }
                            .font(Paper.printed(16))
                            .foregroundStyle(Paper.inkSoft)
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        FieldLabel(text: "Name")
                        HandwritingField(text: $draft.name, placeholder: "e.g. Stone Skin",
                                         allowsSoftwareKeyboard: false, fontSize: 22)
                            .frame(height: 46)
                            .overlay(alignment: .bottom) { DottedRule() }
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        FieldLabel(text: "Duration (optional)")
                        HandwritingField(text: $draft.durationLabel, placeholder: "e.g. 3 rounds, 6 hours",
                                         allowsSoftwareKeyboard: false, fontSize: 16)
                            .frame(height: 40)
                            .overlay(alignment: .bottom) { DottedRule() }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            FieldLabel(text: "Effects")
                            Spacer()
                            Button {
                                draft.components.append(EffectComponent())
                            } label: {
                                Text("+ add another")
                                    .font(Paper.printedItalic(14))
                                    .foregroundStyle(Paper.inkSoft)
                            }
                            .buttonStyle(.plain)
                        }

                        ForEach($draft.components) { $component in
                            EffectComponentEditor(
                                component: $component,
                                onDelete: draft.components.count > 1 ? {
                                    draft.components.removeAll { $0.id == component.id }
                                } : nil
                            )
                        }
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        FieldLabel(text: "Notes (optional)")
                        HandwritingField(text: $draft.notes, placeholder: "Anything else worth remembering",
                                         allowsSoftwareKeyboard: false, fontSize: 16)
                            .frame(height: 40)
                            .overlay(alignment: .bottom) { DottedRule() }
                    }

                    Button(action: save) {
                        Text(existing == nil ? "add effect" : "save changes")
                            .font(Paper.printed(13))
                            .tracking(1)
                            .foregroundStyle(canSave ? Paper.ink : Paper.inkSoft.opacity(0.4))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .overlay(Rectangle().stroke(canSave ? Paper.ink : Paper.inkSoft.opacity(0.4), lineWidth: 1.2))
                    }
                    .buttonStyle(.plain)
                    .disabled(!canSave)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(24)
                .frame(width: 460)
            }
            // Desliga o desvio automático de teclado do ScrollView — ver
            // comentário acima. Sem isto, o cartão pula pra cima no
            // instante em que qualquer HandwritingField ganha foco,
            // mesmo sem nenhum teclado de software real aparecendo.
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    private func save() {
        var toSave = draft
        if let existing {
            character.saveEditedActiveEffect(replacing: existing, with: &toSave)
            character.updateActiveEffect(toSave)
        } else {
            character.applyActiveEffect(&toSave)
            character.addActiveEffect(toSave)
        }
        dismiss()
    }
}

/// Editor de UM componente dentro do item — tipo + campos daquele tipo.
private struct EffectComponentEditor: View {
    @Binding var component: EffectComponent
    /// `nil` esconde o botão de remover — o último componente de um item
    /// não pode ser removido (o item sempre precisa de pelo menos um).
    let onDelete: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Menu {
                    ForEach(EffectComponent.Kind.allCases, id: \.self) { kind in
                        Button(kind.label) { component.kind = kind }
                    }
                } label: {
                    HStack(spacing: 4) {
                        HandValue(text: component.kind.label, size: 16)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundStyle(Paper.inkSoft)
                    }
                }
                .buttonStyle(.plain)
                Spacer()
                if let onDelete {
                    Button(action: onDelete) {
                        Image(systemName: "minus.circle")
                            .font(.system(size: 15))
                            .foregroundStyle(Paper.redInk.opacity(0.75))
                    }
                    .buttonStyle(.plain)
                }
            }
            Text(component.kind.hint)
                .font(Paper.printedItalic(13))
                .foregroundStyle(Paper.inkSoft)

            fields
        }
        .padding(10)
        .background(Color.white.opacity(0.5))
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.hairline, lineWidth: 1))
    }

    @ViewBuilder
    private var fields: some View {
        switch component.kind {
        case .flatBonus:
            row("Applies to") {
                Menu {
                    ForEach(EffectComponent.BonusTarget.allCases, id: \.self) { target in
                        Button(target.label) { component.bonusTarget = target }
                    }
                } label: {
                    HandValue(text: component.bonusTarget.label, size: 15)
                }
                .buttonStyle(.plain)
            }
            row("Amount") {
                EditableNumber(value: $component.bonusAmount, size: 18, lower: -99, upper: 99)
            }
            if component.bonusTarget == .allSaves {
                savingThrowPicker
            }
            if !component.bonusTarget.reflectsOnSheet {
                Text("No single Damage number exists on the sheet — this only adds a reminder row to Damage Modifiers.")
                    .font(Paper.printedItalic(12.5))
                    .foregroundStyle(Paper.inkSoft)
            }

        case .statOverride:
            row("Stat") {
                Menu {
                    ForEach(EffectComponent.OverrideStat.allCases, id: \.self) { stat in
                        Button(stat.label) { component.overrideStat = stat }
                    }
                } label: {
                    HandValue(text: component.overrideStat.label, size: 15)
                }
                .buttonStyle(.plain)
            }
            row("New value") {
                EditableNumber(value: $component.overrideValue, size: 18, lower: -10, upper: 99)
            }

        case .attackNegation:
            row("Total attacks negated") {
                EditableNumber(value: $component.maxUses, size: 18, lower: 1, upper: 99)
            }

        case .bankedHeal:
            row("Healing pool (total HP)") {
                EditableNumber(value: $component.maxUses, size: 18, lower: 1, upper: 999)
            }
            VStack(alignment: .leading, spacing: 0) {
                FieldLabel(text: "Window to trigger")
                HandwritingField(text: $component.healWindowLabel, placeholder: "e.g. 6 hours, until next dawn",
                                 allowsSoftwareKeyboard: false, fontSize: 15)
                    .frame(height: 36)
                    .overlay(alignment: .bottom) { DottedRule() }
            }
            Text("Roll the pool once now (e.g. 3d4+6) and enter the total above — it heals 1/round once activated, starting the moment this character next takes damage.")
                .font(Paper.printedItalic(12.5))
                .foregroundStyle(Paper.inkSoft)

        case .tempHP:
            row("Amount") {
                EditableNumber(value: $component.tempHPGranted, size: 18, lower: 1, upper: 999)
            }
            Text("Added straight to Current HP when saved. Damage burns this first, and what's lost can never be healed back.")
                .font(Paper.printedItalic(12.5))
                .foregroundStyle(Paper.inkSoft)

        case .note:
            EmptyView()
        }
    }

    /// Escolha de QUAIS jogadas de resistência recebem o bônus — pedido
    /// do usuário (2026-09-29): antes só existia "todos os cinco saves de
    /// uma vez". Chips que ligam/desligam (sem `Picker`/`List` nativo,
    /// mesma família visual do resto do app) — cada toque inclui/exclui
    /// aquele save de `component.savingThrowIDs`; "All" é um atalho que
    /// volta pro `nil` (comportamento padrão de sempre).
    private var savingThrowPicker: some View {
        let allIDs = Set(SavingThrows.labels.map(\.id))
        let isAll = component.savingThrowIDs == nil
        return VStack(alignment: .leading, spacing: 6) {
            FieldLabel(text: "Which saves")
            FlowChips {
                chip(label: "All", isOn: isAll) {
                    component.savingThrowIDs = nil
                }
                ForEach(SavingThrows.labels) { entry in
                    chip(label: entry.label, isOn: component.effectiveSaveIDs.contains(entry.id)) {
                        var current = component.effectiveSaveIDs
                        if current.contains(entry.id) {
                            current.remove(entry.id)
                        } else {
                            current.insert(entry.id)
                        }
                        // Marcar todos os cinco de novo volta a ser "All"
                        // (`nil`) em vez de um conjunto explícito com os
                        // cinco — mantém o resumo como "(all)" em vez de
                        // listar os cinco nomes por extenso.
                        component.savingThrowIDs = (current == allIDs) ? nil : current
                    }
                }
            }
        }
    }

    private func chip(label: String, isOn: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(Paper.printed(12.5))
                .foregroundStyle(isOn ? Paper.sheet : Paper.inkSoft)
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(isOn ? Paper.ink : Color.clear)
                .overlay(RoundedRectangle(cornerRadius: 6, style: .continuous).stroke(Paper.inkSoft.opacity(0.6), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private func row<Content: View>(_ label: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(label).font(Paper.printed(12)).foregroundStyle(Paper.inkSoft)
            Spacer()
            content()
        }
    }
}

/// Quebra os chips em linhas conforme a largura disponível — usado só
/// pelo `savingThrowPicker` (6 chips não cabem numa linha só no cartão de
/// 460pt). Genérico o bastante pra reaproveitar se algum outro seletor
/// de múltipla escolha aparecer depois.
private struct FlowChips: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .infinity
        var rowWidth: CGFloat = 0
        var totalHeight: CGFloat = 0
        var rowHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if rowWidth + size.width > width, rowWidth > 0 {
                totalHeight += rowHeight + spacing
                rowWidth = 0
                rowHeight = 0
            }
            rowWidth += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        totalHeight += rowHeight
        return CGSize(width: width == .infinity ? rowWidth : width, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
