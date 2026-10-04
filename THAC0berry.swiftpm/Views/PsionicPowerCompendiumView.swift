import SwiftUI

/// Tela de consulta da base de powers psiônicos (257 powers, 6
/// disciplinas + "High-Level Enhancements" — ver `PsionicPowerDatabase`)
/// — mesmo espírito do `KitCompendiumView`/`SpellbookView`: folhear ou
/// buscar a base inteira, sem estar presa a nenhum personagem. Agrupada
/// por disciplina (ordem fixa do próprio livro, `PsionicPowerDatabase.
/// disciplineOrder` — não alfabética) e, dentro de cada uma, por tier
/// (Devotion antes de Science antes de Psionic Enhancement, a ordem de
/// "menor pra maior" que o CPsiH usa).
///
/// Rodada "fundação primeiro" dos Psiônicos (2026-10-01, ver TODO.md): só
/// consulta — nenhum personagem conhece power nenhum ainda (sem classe
/// Psionicist jogável), por isso não existe nenhum "choose"/`onChoose`
/// aqui, ao contrário de `KitDetailSheet`.
struct PsionicPowerCompendiumView: View {
    @EnvironmentObject private var psionicPowerDatabase: PsionicPowerDatabase

    @State private var query: String = ""
    @State private var tierFilter: String? = nil
    @State private var expandedGroups: Set<String> = []
    @State private var detailPower: PsionicPower? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField
            tierToggle

            if let error = psionicPowerDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedPowers.isEmpty {
                Text("No powers match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedPowers, id: \.discipline) { group in
                    PsionicDisciplineSection(
                        label: group.discipline,
                        powers: group.powers,
                        isExpanded: isExpanded(group.discipline),
                        onToggleExpand: { toggleExpand(group.discipline) },
                        onSelect: { detailPower = $0 }
                    )
                }
            }
        }
        .sheet(item: $detailPower) { power in
            PsionicPowerDetailSheet(power: power)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Psionic Powers")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(psionicPowerDatabase.powers.count) powers · Complete Psionics Handbook")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "power or discipline name")
    }

    private static let tierOrder = ["Devotion", "Science", "Psionic Enhancement"]

    private var tierToggle: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                TierFilterChip(label: "All", isSelected: tierFilter == nil, action: { tierFilter = nil })
                ForEach(Self.tierOrder, id: \.self) { tier in
                    TierFilterChip(label: tier, isSelected: tierFilter == tier, action: { tierFilter = tier })
                }
            }
        }
    }

    private var filtered: [PsionicPower] {
        var result = psionicPowerDatabase.powers
        if let tierFilter {
            result = result.filter { $0.powerTier == tierFilter }
        }
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return result }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return result }

        return result.filter { power in
            Fuzzy.normalize(power.title).contains(normalizedQuery)
                || Fuzzy.normalize(power.discipline).contains(normalizedQuery)
        }
    }

    private struct DisciplineGroup { let discipline: String; let powers: [PsionicPower] }

    private var groupedPowers: [DisciplineGroup] {
        let byDiscipline = Dictionary(grouping: filtered, by: { $0.discipline })
        return PsionicPowerDatabase.disciplineOrder.compactMap { discipline in
            guard let powers = byDiscipline[discipline], !powers.isEmpty else { return nil }
            let sorted = powers.sorted { lhs, rhs in
                let lhsTier = Self.tierOrder.firstIndex(of: lhs.powerTier) ?? Self.tierOrder.count
                let rhsTier = Self.tierOrder.firstIndex(of: rhs.powerTier) ?? Self.tierOrder.count
                if lhsTier != rhsTier { return lhsTier < rhsTier }
                return lhs.title < rhs.title
            }
            return DisciplineGroup(discipline: discipline, powers: sorted)
        }
    }

    /// Enquanto tem busca/filtro de tier ativo, todo grupo com resultado
    /// abre sozinho — mesmo comportamento do Grimório/Kit Compendium.
    private func isExpanded(_ discipline: String) -> Bool {
        if expandedGroups.contains(discipline) { return true }
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || tierFilter != nil
    }

    private func toggleExpand(_ discipline: String) {
        if expandedGroups.contains(discipline) {
            expandedGroups.remove(discipline)
        } else {
            expandedGroups.insert(discipline)
        }
    }
}

private struct TierFilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Paper.printed(11.5))
                .tracking(0.6)
                .foregroundStyle(isSelected ? Paper.sheet : Paper.inkSoft)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isSelected ? Paper.ink : Color.clear)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Paper.inkSoft.opacity(0.5), lineWidth: isSelected ? 0 : 1))
        }
        .buttonStyle(.plain)
    }
}

private struct PsionicDisciplineSection: View {
    let label: String
    let powers: [PsionicPower]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (PsionicPower) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(powers.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(powers) { power in
                        PsionicPowerRow(power: power, onSelect: { onSelect(power) })
                    }
                }
            }
        }
    }
}

private struct PsionicPowerRow: View {
    let power: PsionicPower
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(power.title)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text("\(power.powerTier) · \(power.pspCost.summary) PSP")
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                Text(power.description.briefSummary)
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

// MARK: - Descrição completa do power

struct PsionicPowerDetailSheet: View {
    let power: PsionicPower
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(power.title)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text("\(power.discipline) · \(power.powerTier)")
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)],
                                  alignment: .leading, spacing: 10) {
                            PsionicDetailField(label: "Power Score", value: power.powerScore.raw)
                            PsionicDetailField(label: "PSP Cost (initial/maint.)", value: power.pspCost.summary)
                            if let mac = power.tacticalCombat?.mac {
                                PsionicDetailField(label: "MAC", value: mac)
                            }
                            PsionicDetailField(label: "Range", value: power.parameters.range)
                            PsionicDetailField(label: "Preparation Time", value: power.parameters.preparationTime)
                            PsionicDetailField(label: "Area of Effect", value: power.parameters.areaOfEffect)
                            if !power.parameters.prerequisites.isEmpty {
                                PsionicDetailField(label: "Prerequisites", value: power.parameters.prerequisites.joined(separator: ", "))
                            }
                            PsionicDetailField(label: "Source", value: power.sources.map(\.book).joined(separator: ", "))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            FieldLabel(text: "Effect")
                            Text(power.description.sections.effect)
                                .font(Paper.printed(14))
                                .foregroundStyle(Paper.ink)
                                .lineSpacing(4)
                        }

                        if let rollResults = power.description.sections.powerScoreRollResults {
                            VStack(alignment: .leading, spacing: 10) {
                                VStack(alignment: .leading, spacing: 4) {
                                    FieldLabel(text: "Power Score (exceptional success)")
                                    Text(rollResults.powerScoreSuccess)
                                        .font(Paper.printed(14))
                                        .foregroundStyle(Paper.ink)
                                        .lineSpacing(4)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    FieldLabel(text: "Roll of 20 (critical failure)")
                                    Text(rollResults.criticalFailure20)
                                        .font(Paper.printed(14))
                                        .foregroundStyle(Paper.ink)
                                        .lineSpacing(4)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(20)
        }
    }
}

private struct PsionicDetailField: View {
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
