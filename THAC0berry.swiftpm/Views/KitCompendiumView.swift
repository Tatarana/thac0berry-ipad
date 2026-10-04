import SwiftUI

/// Tela de consulta da base de Kits — mesmo espírito do `SpellbookView`
/// (ver TODO.md item 9): folhear a base inteira, sem estar presa a nenhum
/// personagem. Agrupada por `classEligibility.subclass` em vez de por
/// círculo — é a divisão que já vem pronta nos dados e é a mais útil pra
/// achar um kit rápido (jogador de Druid não quer folhear os de Cleric).
///
/// Generalizada (2026-09-29) com `classGroup` pra também servir os 41
/// kits de mago (`classEligibility.classGroup == "Wizard"`, ver
/// `Scripts/convert_wizard_kits.py`) do mesmo jeito que `SpellbookView`
/// ganhou `caster` quando o Grimório do Mago foi criado — mesmo array
/// `kitDatabase.kits` (sacerdote + mago juntos, um só arquivo
/// `kits.json`), só filtrado por classe aqui na view. `classGroup: nil`
/// (usado só internamente, nunca pelas duas telas públicas) mostraria os
/// dois grupos misturados — não usado hoje, mas mantido como
/// possibilidade barata caso um "todos os kits" faça sentido depois.
struct KitCompendiumView: View {
    var classGroup: String = "Priest"

    @EnvironmentObject private var kitDatabase: KitDatabase

    @State private var query: String = ""
    @State private var expandedGroups: Set<String> = []
    @State private var detailKit: Kit? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField

            // Mostrado mesmo com a lista vazia — sem isso, um bundle que
            // falhou pra carregar (`KitDatabase.loadError`) aparecia como
            // uma tela em branco sem explicação nenhuma, igual o bug já
            // visto com `spells.json` (ver TODO.md item 1 e o comentário
            // em `KitDatabase.load()`).
            if let error = kitDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedKits.isEmpty {
                Text("No kits match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedKits, id: \.subclass) { group in
                    KitGroupSection(
                        label: group.subclass,
                        kits: group.kits,
                        isExpanded: isExpanded(group.subclass),
                        onToggleExpand: { toggleExpand(group.subclass) },
                        onSelect: { detailKit = $0 }
                    )
                }
            }
        }
        .sheet(item: $detailKit) { kit in
            KitDetailSheet(kit: kit)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(classGroup) Kits")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(classScopedKits.count) kits")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "kit or deity name")
    }

    // MARK: - Dados derivados

    /// `kitDatabase.kits` restrito a este `classGroup` — sacerdote e mago
    /// compartilham o mesmo array/arquivo (ver comentário no topo do
    /// arquivo), então toda busca/agrupamento abaixo parte daqui em vez
    /// da base inteira.
    private var classScopedKits: [Kit] {
        kitDatabase.kits.filter { $0.classEligibility.classGroup == classGroup }
    }

    /// Ordem fixa em vez de alfabética — é a leitura mais natural pra
    /// quem já sabe qual grupo procura (Cleric/Druid primeiro, os
    /// sacerdotes especializados por último por serem de longe o grupo
    /// maior, 57 dos 91 kits de sacerdote). Kit de mago tem um grupo só
    /// hoje (`"Wizard"` — os dados de origem não distinguem generalista
    /// de especialista aqui), então essa lista nem entra em jogo pra ele.
    private static let priestGroupOrder = ["Cleric", "Druid", "Any Priest", "Specialty Priest"]

    /// Ordem por subclasse dentro do grupo Warrior (`Scripts/convert_warrior_rogue_kits.py`,
    /// 2026-09-30) — Fighter primeiro por ser de longe o maior (66 dos 114),
    /// Barbarian por último por ser tecnicamente um Kit de Fighter e não
    /// uma `CharacterClass` própria (ver `classEligibility.allowedClasses`
    /// no conversor).
    private static let warriorGroupOrder = ["Fighter", "Paladin", "Ranger", "Barbarian"]

    /// Ordem por subclasse dentro do grupo Rogue — mesmo conversor, Thief
    /// primeiro (o maior, e a única subclasse já jogável desde o PHB).
    private static let rogueGroupOrder = ["Thief", "Bard", "Ninja"]

    private var groupOrder: [String] {
        switch classGroup {
        case "Priest": return Self.priestGroupOrder
        case "Warrior": return Self.warriorGroupOrder
        case "Rogue": return Self.rogueGroupOrder
        default: return ["Wizard"]
        }
    }

    private var filtered: [Kit] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return classScopedKits }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return classScopedKits }

        return classScopedKits.filter { kit in
            Fuzzy.normalize(kit.name).contains(normalizedQuery)
                || (kit.deity.map { Fuzzy.normalize($0).contains(normalizedQuery) } ?? false)
                || (kit.titleInChurch.map { Fuzzy.normalize($0).contains(normalizedQuery) } ?? false)
        }
    }

    private struct SubclassGroup { let subclass: String; let kits: [Kit] }

    private var groupedKits: [SubclassGroup] {
        let bySubclass = Dictionary(grouping: filtered, by: { $0.classEligibility.subclass })
        return groupOrder.compactMap { subclass in
            guard let kits = bySubclass[subclass], !kits.isEmpty else { return nil }
            return SubclassGroup(subclass: subclass, kits: kits.sorted { $0.name < $1.name })
        }
    }

    /// Enquanto tem busca ativa, o grupo com resultado abre sozinho — mesmo
    /// comportamento do Grimório.
    private func isExpanded(_ subclass: String) -> Bool {
        if expandedGroups.contains(subclass) { return true }
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func toggleExpand(_ subclass: String) {
        if expandedGroups.contains(subclass) {
            expandedGroups.remove(subclass)
        } else {
            expandedGroups.insert(subclass)
        }
    }
}

private struct KitGroupSection: View {
    let label: String
    let kits: [Kit]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (Kit) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(kits.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(kits) { kit in
                        KitCompendiumRow(kit: kit, onSelect: { onSelect(kit) })
                    }
                }
            }
        }
    }
}

private struct KitCompendiumRow: View {
    let kit: Kit
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(kit.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(kit.sourceBook)
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                Text(kit.description.briefSummary)
                    .font(Paper.printed(12))
                    .foregroundStyle(Paper.inkSoft)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Descrição completa do kit

/// Janela de detalhe, aberta a partir do Compendium (só consulta) ou do
/// seletor de Kit na ficha (`KitPickerSheet`, que soma um botão "Choose
/// this kit" — ver `onChoose`).
struct KitDetailSheet: View {
    let kit: Kit
    /// `nil` no Compendium (só consulta); preenchido quando aberto a
    /// partir do seletor da ficha, pra confirmar a escolha sem precisar
    /// voltar pra lista antes.
    var onChoose: (() -> Void)? = nil
    @EnvironmentObject private var deityDatabase: DeityDatabase
    @Environment(\.dismiss) private var dismiss
    @State private var showDeity = false

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(kit.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text(subtitle)
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                        // Só aparece pros 57 kits de sacerdote especializado,
                        // e só quando o nome bate com uma das 79 divindades
                        // de `DeityDatabase` (ver `DeityDatabase.deity(named:)`)
                        // — 36 dos 39 nomes de divindade distintos usados
                        // pelos kits batem hoje; os outros 3 ("Guardian",
                        // "Savage", "Shaman") são rótulos de arquétipo de
                        // kit, não nome de divindade, então corretamente não
                        // batem com nada.
                        if let deity = kit.deity, let matchedDeity = deityDatabase.deity(named: deity) {
                            Button(action: { showDeity = true }) {
                                Text("View deity: \(matchedDeity.name) →")
                                    .font(Paper.printedItalic(14))
                                    .foregroundStyle(Ember.wine)
                            }
                            .buttonStyle(.plain)
                            .sheet(isPresented: $showDeity) {
                                DeityDetailSheet(deity: matchedDeity)
                            }
                        }
                    }
                    Spacer()
                    if let onChoose {
                        Button("choose") {
                            onChoose()
                            dismiss()
                        }
                        // Item 4 do pedido do usuário (2026-09-24):
                        // "choose" numa fonte bem menor que "close" —
                        // padronizado nos 16pt do "close" ao lado.
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                    }
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)],
                                  alignment: .leading, spacing: 10) {
                            if let cash = kit.mechanics.startingCash {
                                KitDetailField(label: "Starting Cash", value: cash)
                            }
                            if !kit.mechanics.requirements.abilities.isEmpty {
                                KitDetailField(label: "Ability Requirements", value: abilityRequirementsText)
                            }
                            if !kit.mechanics.requirements.alignments.isEmpty {
                                KitDetailField(label: "Alignment", value: kit.mechanics.requirements.alignments.joined(separator: ", "))
                            }
                            if let races = kit.mechanics.requirements.races {
                                KitDetailField(label: "Races", value: races)
                            }
                            // "Turn Undead" só faz sentido pra kit de
                            // sacerdote — pros 41 kits de mago
                            // (2026-09-29), `turnUndead` vem sintetizado
                            // como "not_applicable" (ver
                            // `Scripts/convert_wizard_kits.py`) só pra
                            // manter `Kit.swift` uniforme; a UI esconde o
                            // campo em vez de mostrar um "Turn Undead: No"
                            // sem sentido nenhum num kit de mago.
                            if kit.classEligibility.classGroup == "Priest" {
                                KitDetailField(label: "Turn Undead", value: turnUndeadText)
                            }
                            if let slots = kit.mechanics.weaponSlots, slots.hasContent {
                                KitDetailField(label: "Weapon Slots", value: weaponSlotsText(slots))
                            }
                            KitDetailField(label: "Source", value: kit.sourceBook)
                        }

                        // Item 6 do pedido do usuário (2026-09-24):
                        // "Descrições de Kits com tabelas wikitext
                        // quebradas" — `fullText` cru vinha com a tabela-
                        // resumo da wiki (`{| ... |}`) grudada no texto
                        // pra 56 dos 91 kits. `displaySections` (`Models/Kit.swift`)
                        // descarta essa tabela (o dado dela já aparece
                        // estruturado no grid de cima e nos `featureSection`
                        // abaixo) e separa o resto em blocos por título.
                        VStack(alignment: .leading, spacing: 14) {
                            FieldLabel(text: "Description")
                            ForEach(kit.description.displaySections) { section in
                                VStack(alignment: .leading, spacing: 4) {
                                    if !section.title.isEmpty {
                                        Text(section.title.uppercased())
                                            .font(Paper.printed(11))
                                            .tracking(0.8)
                                            .foregroundStyle(Paper.inkSoft)
                                    }
                                    Text(section.body)
                                        .font(Paper.printed(14))
                                        .foregroundStyle(Paper.ink)
                                        .lineSpacing(4)
                                }
                            }
                        }

                        featureSection(label: "Role", text: kit.features.role)
                        featureSection(label: "Requirements", text: kit.features.requirements)
                        featureSection(label: "Special Benefits", text: kit.features.specialBenefits)
                        featureSection(label: "Special Hindrances", text: kit.features.specialHindrances)
                        featureSection(label: "Wealth Options", text: kit.features.wealthOptions)
                        featureSection(label: "Weapon Proficiencies", text: kit.features.weaponProficiencies)
                        featureSection(label: "Nonweapon Proficiencies", text: kit.features.nonweaponProficiencies)
                        featureSection(label: "Equipment", text: kit.features.equipment)
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var subtitle: String {
        var parts = [kit.classEligibility.subclass + " kit"]
        if let title = kit.titleInChurch { parts.append(title) }
        if let pantheon = kit.pantheon { parts.append(pantheon) }
        return parts.joined(separator: " · ")
    }

    private var abilityRequirementsText: String {
        kit.mechanics.requirements.abilities
            .sorted { $0.key < $1.key }
            .map { "\($0.key) \($0.value)+" }
            .joined(separator: ", ")
    }

    private var turnUndeadText: String {
        kit.mechanics.turnUndead.capable ? kit.mechanics.turnUndead.mode.capitalized : "No"
    }

    private func weaponSlotsText(_ slots: KitWeaponSlotRules) -> String {
        var parts: [String] = []
        if let initial = slots.initial { parts.append("\(initial) initial") }
        if let additional = slots.additional { parts.append("+\(additional) per level") }
        if let penalty = slots.nonproficiencyPenalty { parts.append("\(penalty) nonproficiency") }
        return parts.isEmpty ? "—" : parts.joined(separator: ", ")
    }

    @ViewBuilder
    private func featureSection(label: String, text: String?) -> some View {
        if let text, !text.isEmpty {
            VStack(alignment: .leading, spacing: 4) {
                FieldLabel(text: label)
                Text(text)
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
                    .lineSpacing(3)
            }
        }
    }
}

// MARK: - Seletor de Kit (usado no campo "Class / Kit" da ficha)

/// Sheet aberta a partir do cabeçalho da ficha (`RecordHeaderForm`) pra
/// trocar o texto livre do campo Kit por uma escolha vinda da base real —
/// ver TODO.md item 9. `selection` continua sendo o `String?` de sempre
/// (`PlayerCharacter.kit`): escolher um kit aqui só grava `kit.name` nele,
/// não muda o tipo do campo nem exige migração de fichas salvas.
///
/// Toque no nome escolhe direto (mesmo gesto de "tap pra atribuir" que já
/// existe em `SpellPaperRow`); o botão "ⓘ" abre a descrição completa antes
/// de decidir, com "choose" lá dentro pra quem só queria confirmar depois
/// de ler.
struct KitPickerSheet: View {
    @Binding var selection: String?
    /// Classe do personagem (`CharacterClass.rawValue`, ex. "Cleric") —
    /// quando presente, a lista só mostra kits elegíveis pra ela (ver
    /// `KitDatabase.kits(allowedFor:)`). `nil` devolve a base inteira sem
    /// filtro, pra não quebrar nenhum outro lugar que ainda não passe isso.
    var className: String? = nil
    @EnvironmentObject private var kitDatabase: KitDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var detailKit: Kit? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text("Choose a Kit")
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField

                // Era só um link de texto pequeno ("Clear current kit"),
                // abaixo da busca — usuário relatou que depois de escolher
                // um Kit não conseguia mais "voltar pro None" (Kit não é
                // obrigatório). Virou uma linha de verdade no topo da
                // lista, com a MESMA cara de qualquer outro Kit escolhível
                // (estrela quando é a seleção atual) — mais fácil de achar
                // do que um linkzinho, e sempre visível, não só quando já
                // há um kit escolhido.
                Button {
                    selection = nil
                    dismiss()
                } label: {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(selection?.isEmpty ?? true ? "★" : "")
                            .font(Paper.printed(14))
                            .foregroundStyle(Ember.crimson)
                            .frame(width: 14)
                        Text("None")
                            .font(Paper.hand(19))
                            .foregroundStyle(Paper.penInk)
                        Spacer(minLength: 4)
                        Text("no kit")
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.vertical, 4)
                .overlay(alignment: .bottom) { DottedRule() }

                if let error = kitDatabase.loadError {
                    Text(error)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.redInk)
                } else if filtered.isEmpty {
                    Text(emptyMessage)
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered) { kit in
                            KitPickerRow(
                                kit: kit,
                                isSelected: selection == kit.name,
                                onSelect: {
                                    selection = kit.name
                                    dismiss()
                                },
                                onInfo: { detailKit = kit }
                            )
                        }
                    }
                }
            }
            .padding(24)
        }
        .sheet(item: $detailKit) { kit in
            KitDetailSheet(kit: kit, onChoose: { selection = kit.name })
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "kit or deity name")
    }

    private var filtered: [Kit] {
        let all = kitDatabase.kits(allowedFor: className)
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return all }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return all }

        return all.filter { kit in
            Fuzzy.normalize(kit.name).contains(normalizedQuery)
                || (kit.deity.map { Fuzzy.normalize($0).contains(normalizedQuery) } ?? false)
                || (kit.titleInChurch.map { Fuzzy.normalize($0).contains(normalizedQuery) } ?? false)
        }
    }

    /// Diferencia "essa classe não tem kit nenhum (ainda)" de "sua busca
    /// não achou nada" — mensagens genéricas de "sem resultado" confundem
    /// quando a causa é a classe escolhida, não o texto digitado.
    ///
    /// 2026-09-30: o caso especial do grupo Warrior ("kits ainda não estão
    /// na base — só o texto de regras veio no zip") saiu daqui — os 114
    /// kits de Warrior (Fighter/Paladin/Ranger + Barbarian, dobrado dentro
    /// de Fighter) e os 73 de Rogue (Thief/Bard/Ninja) chegaram via
    /// `Scripts/convert_warrior_rogue_kits.py`, então `unfilteredByClass`
    /// não fica mais vazio pra nenhuma dessas classes — este branch virou
    /// morto na prática, mas a mensagem genérica abaixo continua certa
    /// pra qualquer classe futura sem kit nenhum.
    private var emptyMessage: String {
        let unfilteredByClass = kitDatabase.kits(allowedFor: className)
        guard unfilteredByClass.isEmpty, let className else {
            return "No kits match — try a different search."
        }
        return "\(className) has no kits in the compendium yet."
    }
}

private struct KitPickerRow: View {
    let kit: Kit
    let isSelected: Bool
    let onSelect: () -> Void
    let onInfo: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onSelect) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(isSelected ? "★" : "")
                        .font(Paper.printed(14))
                        .foregroundStyle(Ember.crimson)
                        .frame(width: 14)
                    Text(kit.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(kit.classEligibility.subclass)
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button(action: onInfo) {
                Text("ⓘ")
                    .font(Paper.printed(15))
                    .foregroundStyle(Paper.inkSoft)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

private struct KitDetailField: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            FieldLabel(text: label)
            Text(value)
                .font(Paper.hand(18))
                .foregroundStyle(Paper.penInk)
        }
    }
}
