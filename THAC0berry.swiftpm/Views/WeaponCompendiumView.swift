import SwiftUI

/// Tela de consulta da base de Armas mundanas do PHB — mesmo espírito do
/// `KitCompendiumView`/`ProficiencyCompendiumView`: folhear a base inteira,
/// sem estar presa a nenhum personagem. Agrupada por `type` (Piercing/
/// Slashing/Bludgeoning/misturado/sem classificação) em vez de alfabética
/// corrida — 75 armas (69 do PHB + 6 do Complete Priest's Handbook) cabem
/// bem numa divisão assim, e é a mesma pergunta
/// que a tabela do PHB já responde com a coluna "Type".
struct WeaponCompendiumView: View {
    @EnvironmentObject private var weaponDatabase: WeaponDatabase

    @State private var query: String = ""
    @State private var expandedGroups: Set<String> = []
    @State private var detailWeapon: Weapon? = nil

    // Larguras fixas de coluna — mesmo espírito de `WeaponCombatForm` na
    // ficha (`CharacterSheetView.swift`), só que aqui é só consulta (sem
    // campo editável). Usuário pediu formato de tabela porque arma/
    // armadura/item não têm descrição de verdade pra abrir num toque —
    // ver todos os valores direto na lista é mais rápido que abrir cada
    // uma. `nameWidth`/`colWidth`/`rangeWidth` não são `private` de
    // propósito — `WeaponCompendiumRow`/`tableHeader` (mesmo arquivo)
    // usam os mesmos valores, e ficam juntos aqui em vez de duplicados.
    static let nameWidth: CGFloat = 190
    static let colWidth: CGFloat = 56
    static let rangeWidth: CGFloat = 130

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField

            // Mesmo motivo do `KitCompendiumView`/`ProficiencyCompendiumView`
            // — nunca deveria disparar (`loadError` é sempre `nil` na base
            // embutida), mas mantido pra bater o padrão das outras telas.
            if let error = weaponDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedWeapons.isEmpty {
                Text("No weapons match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 10) {
                        tableHeader
                        ForEach(groupedWeapons, id: \.label) { group in
                            WeaponGroupSection(
                                label: group.label,
                                weapons: group.weapons,
                                isExpanded: isExpanded(group.label),
                                onToggleExpand: { toggleExpand(group.label) },
                                onSelect: { detailWeapon = $0 }
                            )
                        }
                    }
                }
            }
        }
        .sheet(item: $detailWeapon) { weapon in
            WeaponDetailSheet(weapon: weapon)
        }
    }

    private var tableHeader: some View {
        HStack(spacing: 0) {
            Text("Weapon").frame(width: Self.nameWidth, alignment: .leading)
            Text("Size").frame(width: Self.colWidth)
            Text("Type").frame(width: Self.colWidth)
            Text("Speed").frame(width: Self.colWidth)
            Text("#AT").frame(width: Self.colWidth)
            Text("Dmg S/M").frame(width: Self.colWidth + 12)
            Text("Dmg L").frame(width: Self.colWidth + 12)
            Text("Range S/M/L").frame(width: Self.rangeWidth, alignment: .leading)
        }
        .font(Paper.printed(10.5))
        .foregroundStyle(Paper.ink)
        .padding(.vertical, 5)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1.2) }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Weapons")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(weaponDatabase.weapons.count) weapons")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "weapon name")
    }

    // MARK: - Dados derivados

    private var filtered: [Weapon] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return weaponDatabase.weapons }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return weaponDatabase.weapons }

        return weaponDatabase.weapons.filter {
            Fuzzy.normalize($0.name).contains(normalizedQuery)
        }
    }

    private struct TypeGroup { let label: String; let weapons: [Weapon] }

    /// "P"/"S"/"B" primeiro (na ordem que a coluna "Type" do PHB usa),
    /// depois qualquer combinação (ex. "P/S") em ordem alfabética, e por
    /// último "Unclassified" — armas que o próprio livro não classifica
    /// (Scourge, Whip; ver `Weapon.type`), sempre no fim pra não interromper
    /// a leitura das categorias de verdade.
    private static let typeOrder = ["P", "S", "B"]

    private static func label(forType type: String?) -> String {
        switch type {
        case "P": return "Piercing"
        case "S": return "Slashing"
        case "B": return "Bludgeoning"
        case .some(let combined): return combined
        case nil: return "Unclassified"
        }
    }

    private var groupedWeapons: [TypeGroup] {
        let byType = Dictionary(grouping: filtered, by: { $0.type })
        let knownKeys = Self.typeOrder
        let otherKeys = byType.keys
            .filter { key in !(key.map(knownKeys.contains) ?? false) && key != nil }
            .compactMap { $0 }
            .sorted()

        var orderedKeys: [String?] = knownKeys.map { $0 as String? }
        orderedKeys.append(contentsOf: otherKeys.map { $0 as String? })
        orderedKeys.append(nil)

        return orderedKeys.compactMap { key in
            guard let weapons = byType[key], !weapons.isEmpty else { return nil }
            return TypeGroup(label: Self.label(forType: key), weapons: weapons.sorted { $0.name < $1.name })
        }
    }

    /// Enquanto tem busca ativa, o grupo com resultado abre sozinho — mesmo
    /// comportamento do Grimório/Kits.
    private func isExpanded(_ label: String) -> Bool {
        if expandedGroups.contains(label) { return true }
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func toggleExpand(_ label: String) {
        if expandedGroups.contains(label) {
            expandedGroups.remove(label)
        } else {
            expandedGroups.insert(label)
        }
    }
}

private struct WeaponGroupSection: View {
    let label: String
    let weapons: [Weapon]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (Weapon) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(weapons.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(weapons) { weapon in
                        WeaponCompendiumRow(weapon: weapon, onSelect: { onSelect(weapon) })
                    }
                }
            }
        }
    }
}

private extension Weapon {
    /// "1d8/1d12" pra lista compacta do seletor (`WeaponPickerRow`, que
    /// continua de uma linha só — o Compendium é que virou tabela).
    var damageSummary: String {
        let small = damageSmall ?? "—"
        let large = damageLarge ?? "—"
        return "\(small)/\(large)"
    }
}

/// Linha de tabela — todas as colunas da tabela de armas do PHB visíveis
/// de cara (tocar ainda abre `WeaponDetailSheet`, mas não devia precisar
/// pra achar um valor: era exatamente a queixa que motivou trocar o
/// formato "nome + um resumo" por isto).
private struct WeaponCompendiumRow: View {
    let weapon: Weapon
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 0) {
                Text(weapon.name)
                    .font(Paper.hand(16))
                    .foregroundStyle(Paper.penInk)
                    .lineLimit(1)
                    .frame(width: WeaponCompendiumView.nameWidth, alignment: .leading)
                Text(weapon.size ?? "—")
                    .frame(width: WeaponCompendiumView.colWidth)
                Text(weapon.type ?? "—")
                    .frame(width: WeaponCompendiumView.colWidth)
                Text("\(weapon.speedFactor)")
                    .frame(width: WeaponCompendiumView.colWidth)
                Text(weapon.attacksPerRound)
                    .frame(width: WeaponCompendiumView.colWidth)
                Text(weapon.damageSmall ?? "—")
                    .frame(width: WeaponCompendiumView.colWidth + 12)
                Text(weapon.damageLarge ?? "—")
                    .frame(width: WeaponCompendiumView.colWidth + 12)
                Text(weapon.formattedRange ?? "—")
                    .frame(width: WeaponCompendiumView.rangeWidth, alignment: .leading)
            }
            .font(Paper.printed(13))
            .foregroundStyle(Paper.ink)
            .padding(.vertical, 6)
            .padding(.horizontal, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Descrição completa da arma

/// Janela de detalhe, aberta a partir do Compendium (só consulta) ou do
/// seletor de arma na ficha (`WeaponPickerSheet`, que soma um botão "choose"
/// — ver `onChoose`).
struct WeaponDetailSheet: View {
    let weapon: Weapon
    /// `nil` no Compendium (só consulta); preenchido quando aberto a partir
    /// do seletor da ficha, pra confirmar a escolha sem precisar voltar pra
    /// lista antes.
    var onChoose: (() -> Void)? = nil
    /// Só vem preenchido quando esta folha é aberta a partir da linha da
    /// FICHA (`WeaponFormRow`) — mesmo papel de `ProficiencyDetailSheet.
    /// onChangeProficiency`: fecha a descrição e reabre o
    /// `WeaponPickerSheet` pra escolher outra.
    var onChangeWeapon: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(weapon.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text(subtitle)
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    if let onChoose {
                        Button("choose") {
                            onChoose()
                            dismiss()
                        }
                        // Item 4 do pedido do usuário (2026-09-24):
                        // "choose"/"change" numa fonte bem menor que
                        // "close" — padronizados nos 16pt do "close" ao
                        // lado (mantendo o itálico do "change").
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                    }
                    if let onChangeWeapon {
                        Button("change", action: onChangeWeapon)
                            .font(Paper.printedItalic(16))
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
                            if let size = weapon.size {
                                WeaponDetailField(label: "Size", value: size)
                            }
                            if let type = weapon.type {
                                WeaponDetailField(label: "Type", value: type)
                            }
                            WeaponDetailField(label: "Speed Factor", value: "\(weapon.speedFactor)")
                            WeaponDetailField(label: "#AT", value: weapon.attacksPerRound)
                            if let damageSmall = weapon.damageSmall {
                                WeaponDetailField(label: "Dmg vs. S/M", value: damageSmall)
                            }
                            if let damageLarge = weapon.damageLarge {
                                WeaponDetailField(label: "Dmg vs. L", value: damageLarge)
                            }
                            if let range = weapon.formattedRange {
                                WeaponDetailField(label: "Range (S/M/L)", value: range)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var subtitle: String {
        var parts: [String] = ["\(weapon.source ?? "PHB") weapon"]
        if let type = weapon.type { parts.append(WeaponCompendiumView.groupLabel(forType: type)) }
        return parts.joined(separator: " · ")
    }
}

private extension WeaponCompendiumView {
    /// Reaproveita o mesmo texto amigável usado pro agrupamento
    /// ("Piercing"/"Slashing"/"Bludgeoning") no subtítulo do detalhe.
    static func groupLabel(forType type: String) -> String {
        label(forType: type)
    }
}

private struct WeaponDetailField: View {
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

// MARK: - Seletor de arma (usado na tabela de Weapon Combat da ficha)

/// Sheet aberta a partir de cada linha da Weapon Combat table
/// (`WeaponFormRow`, `CharacterSheetView.swift`) — escolher aqui preenche
/// nome, tamanho, tipo, speed factor, dano e alcance sozinho; THAC0 e o
/// ajuste de dano/acerto continuam sempre manuais (são do PERSONAGEM, não
/// da arma — a mesma arma tem THAC0 diferente pra cada jogador). Nada
/// impede editar os campos preenchidos na mão depois.
struct WeaponPickerSheet: View {
    @Binding var weapon: WeaponEntry
    @EnvironmentObject private var weaponDatabase: WeaponDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var detailWeapon: Weapon? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text("Choose a Weapon")
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField

                // Mesma saída de emergência do `ProficiencyPickerSheet` —
                // arma caseira ou variante de mesa que não está (e talvez
                // nunca esteja) na base de 69 armas do PHB.
                if !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   !filtered.contains(where: { Fuzzy.normalize($0.name) == Fuzzy.normalize(query) }) {
                    Button(action: useAsTyped) {
                        Text("Use \"\(query.trimmingCharacters(in: .whitespacesAndNewlines))\" as-is")
                            .font(Paper.printed(13).bold())
                            .foregroundStyle(Paper.sheet)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Paper.ink)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }

                if !weapon.name.isEmpty {
                    Button {
                        weapon = WeaponEntry()
                        dismiss()
                    } label: {
                        Text("Clear current weapon (\(weapon.name))")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }

                if let error = weaponDatabase.loadError {
                    Text(error)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.redInk)
                } else if filtered.isEmpty {
                    Text("No weapons match — try a different search.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered) { candidate in
                            WeaponPickerRow(
                                weapon: candidate,
                                isSelected: weapon.name == candidate.name,
                                onSelect: { choose(candidate) },
                                onInfo: { detailWeapon = candidate }
                            )
                        }
                    }
                }
            }
            .padding(24)
        }
        .sheet(item: $detailWeapon) { candidate in
            WeaponDetailSheet(weapon: candidate, onChoose: { choose(candidate) })
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "weapon name")
    }

    private var filtered: [Weapon] {
        let all = weaponDatabase.weapons
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return all }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return all }

        return all.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
    }

    /// Preenche o que a base sabe (nome, tamanho, tipo, speed, dano,
    /// alcance) e liga `matchedWeaponID` pra reabrir a descrição depois —
    /// THAC0/dmgAdj (do personagem, não da arma) ficam como já estavam.
    private func choose(_ candidate: Weapon) {
        weapon.name = candidate.name
        weapon.size = candidate.size
        weapon.weaponType = candidate.type
        weapon.speed = "\(candidate.speedFactor)"
        weapon.attacks = candidate.attacksPerRound
        weapon.damageSmall = candidate.damageSmall ?? ""
        weapon.damageLarge = candidate.damageLarge ?? ""
        if let range = candidate.formattedRange {
            weapon.range = range
        }
        weapon.matchedWeaponID = candidate.id
        dismiss()
    }

    /// Mesma saída de emergência do `ProficiencyPickerSheet.useAsTyped` —
    /// aceita o texto digitado como está, sem bater com nada da base.
    private func useAsTyped() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        var entry = WeaponEntry()
        entry.name = trimmed
        weapon = entry
        dismiss()
    }
}

private struct WeaponPickerRow: View {
    let weapon: Weapon
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
                    Text(weapon.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(weapon.damageSummary)
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
