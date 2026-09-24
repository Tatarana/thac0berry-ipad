import SwiftUI

/// Tela de consulta da base de Armaduras/Elmos/Escudos do PHB — mesmo
/// espírito de `WeaponCompendiumView`/`KitCompendiumView`: folhear a base
/// inteira, sem estar presa a nenhum personagem. Agrupada por
/// `ArmorPieceKind` (Armor/Helmets/Shields) — a mesma divisão em três
/// seções que a tabela do PHB já usa.
struct ArmorCompendiumView: View {
    @EnvironmentObject private var armorDatabase: ArmorDatabase

    @State private var query: String = ""
    @State private var expandedGroups: Set<String> = []
    @State private var detailPiece: ArmorPiece? = nil

    // Mesmo motivo/mesmo padrão de `WeaponCompendiumView` — formato de
    // tabela em vez de "nome + um resumo", pra ver AC/custo/peso sem
    // precisar abrir cada item. Não `private` porque `ArmorCompendiumRow`
    // usa os mesmos valores.
    static let nameWidth: CGFloat = 200
    static let colWidth: CGFloat = 70

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField

            if let error = armorDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedPieces.isEmpty {
                Text("No armor matches — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 10) {
                        tableHeader
                        ForEach(groupedPieces, id: \.label) { group in
                            ArmorGroupSection(
                                label: group.label,
                                pieces: group.pieces,
                                isExpanded: isExpanded(group.label),
                                onToggleExpand: { toggleExpand(group.label) },
                                onSelect: { detailPiece = $0 }
                            )
                        }
                    }
                }
            }
        }
        .sheet(item: $detailPiece) { piece in
            ArmorDetailSheet(piece: piece)
        }
    }

    private var tableHeader: some View {
        HStack(spacing: 0) {
            Text("Item").frame(width: Self.nameWidth, alignment: .leading)
            Text("AC").frame(width: Self.colWidth)
            Text("Cost").frame(width: Self.colWidth)
            Text("Weight").frame(width: Self.colWidth)
        }
        .font(Paper.printed(10.5))
        .foregroundStyle(Paper.ink)
        .padding(.vertical, 5)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1.2) }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Armor")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(armorDatabase.pieces.count) items")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "armor, helmet or shield name")
    }

    // MARK: - Dados derivados

    private var filtered: [ArmorPiece] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return armorDatabase.pieces }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return armorDatabase.pieces }

        return armorDatabase.pieces.filter {
            Fuzzy.normalize($0.name).contains(normalizedQuery)
        }
    }

    private struct KindGroup { let label: String; let pieces: [ArmorPiece] }

    private static let kindOrder: [ArmorPieceKind] = [.armor, .helmet, .shield]

    static func label(forKind kind: ArmorPieceKind) -> String {
        switch kind {
        case .armor: return "Armor"
        case .helmet: return "Helmets"
        case .shield: return "Shields"
        }
    }

    private var groupedPieces: [KindGroup] {
        let byKind = Dictionary(grouping: filtered, by: { $0.kind })
        return Self.kindOrder.compactMap { kind in
            guard let pieces = byKind[kind], !pieces.isEmpty else { return nil }
            return KindGroup(label: Self.label(forKind: kind), pieces: pieces.sorted { $0.name < $1.name })
        }
    }

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

private struct ArmorGroupSection: View {
    let label: String
    let pieces: [ArmorPiece]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (ArmorPiece) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(pieces.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(pieces) { piece in
                        ArmorCompendiumRow(piece: piece, onSelect: { onSelect(piece) })
                    }
                }
            }
        }
    }
}

/// Linha de tabela — AC/custo/peso visíveis de cara, mesmo motivo de
/// `WeaponCompendiumRow`.
private struct ArmorCompendiumRow: View {
    let piece: ArmorPiece
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 0) {
                Text(piece.name)
                    .font(Paper.hand(16))
                    .foregroundStyle(Paper.penInk)
                    .lineLimit(1)
                    .frame(width: ArmorCompendiumView.nameWidth, alignment: .leading)
                Text(piece.baseAC.map(String.init) ?? "—")
                    .frame(width: ArmorCompendiumView.colWidth)
                Text(piece.cost ?? "—")
                    .frame(width: ArmorCompendiumView.colWidth)
                Text(piece.weight ?? "—")
                    .frame(width: ArmorCompendiumView.colWidth)
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

private extension ArmorPiece {
    /// "AC 4" pra armadura, "10 gp" pro que não tem AC (elmo/escudo) — mesmo
    /// espírito compacto de `Weapon.damageSummary`.
    var summary: String {
        if let baseAC { return "AC \(baseAC)" }
        return cost ?? "—"
    }
}

// MARK: - Descrição completa

/// Janela de detalhe, aberta a partir do Compendium (só consulta) ou do
/// seletor de Armor na ficha (`ArmorPickerSheet`).
struct ArmorDetailSheet: View {
    let piece: ArmorPiece
    var onChoose: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(piece.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text(ArmorCompendiumView.label(forKind: piece.kind))
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

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)],
                          alignment: .leading, spacing: 10) {
                    if let baseAC = piece.baseAC {
                        ArmorDetailField(label: "Base AC", value: "\(baseAC)")
                    }
                    if let cost = piece.cost {
                        ArmorDetailField(label: "Cost", value: cost)
                    }
                    if let weight = piece.weight {
                        ArmorDetailField(label: "Weight", value: weight)
                    }
                }

                if piece.baseAC == nil {
                    // Elmo/escudo não têm AC isolado na tabela de preços do
                    // PHB — não é lacuna de extração, é assim que o livro
                    // apresenta (ver comentário em `ArmorPiece`).
                    Text("This item has no separate AC value in the PHB price table.")
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.inkSoft)
                }

                Spacer(minLength: 0)
            }
            .padding(24)
        }
    }
}

private struct ArmorDetailField: View {
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

// MARK: - Seletor de Armor (usado no campo "Armor" do bloco de Armadura)

/// Sheet aberta a partir dos campos "Armor" e, a partir do item 7 do
/// pedido do usuário (2026-09-24: "Armor mostra só '1' no campo, AC base
/// não muda; estender pra Shield"), também "Shield" (`ArmorBlock`,
/// `CharacterSheetView.swift`) — `kind` escolhe qual seção da base
/// (`ArmorDatabase.pieces(kind:)`) listar, e `rating` é o campo de texto
/// (`armorRating` ou `shieldRating`) que recebe o valor escolhido. Mesmo
/// padrão de `WeaponPickerSheet`/`KitPickerSheet`, incluindo a saída "use
/// as typed" pra armadura/escudo caseiro fora da base.
///
/// Peça de armadura tem `baseAC` de verdade (AC final, ex. Plate Mail = 3)
/// — grava direto. Escudo NUNCA tem `baseAC` na base (a tabela de preços
/// do PHB não atribui um valor de AC isolado a eles, ver `ArmorPiece`) —
/// pra esses, `choose(_:)` grava o "-1" fixo que a regra central de 2e dá
/// a qualquer escudo, já com o sinal certo pra somar em
/// `ConsequenceEngine.recalculateArmorClass`.
struct ArmorPickerSheet: View {
    @Binding var rating: String
    var kind: ArmorPieceKind = .armor
    @EnvironmentObject private var armorDatabase: ArmorDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var detailPiece: ArmorPiece? = nil

    private var title: String {
        kind == .shield ? "Choose a Shield" : "Choose an Armor"
    }

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text(title)
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField

                if !rating.isEmpty {
                    Button {
                        rating = ""
                        dismiss()
                    } label: {
                        Text("Clear current value (\(rating))")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }

                if let error = armorDatabase.loadError {
                    Text(error)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.redInk)
                } else if filtered.isEmpty {
                    Text("No \(kind == .shield ? "shields" : "armor") match — try a different search.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered) { piece in
                            ArmorPickerRow(
                                piece: piece,
                                onSelect: { choose(piece) },
                                onInfo: { detailPiece = piece }
                            )
                        }
                    }
                }
            }
            .padding(24)
        }
        .sheet(item: $detailPiece) { piece in
            ArmorDetailSheet(piece: piece, onChoose: { choose(piece) })
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: kind == .shield ? "shield name" : "armor name")
    }

    private var filtered: [ArmorPiece] {
        let all = armorDatabase.pieces(kind: kind)
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return all }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return all }

        return all.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
    }

    private func choose(_ piece: ArmorPiece) {
        if let baseAC = piece.baseAC {
            rating = "\(baseAC)"
        } else if piece.kind == .shield {
            // Regra central de 2e: qualquer escudo dá -1 fixo de AC — sem
            // `baseAC` por item na tabela de preços do PHB (ver
            // `ArmorPiece`), então o valor não vem do dado, é a regra.
            rating = "-1"
        } else {
            return
        }
        dismiss()
    }
}

private struct ArmorPickerRow: View {
    let piece: ArmorPiece
    let onSelect: () -> Void
    let onInfo: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onSelect) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(piece.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(piece.summary)
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
