import SwiftUI

/// As 9 combinações de alinhamento do PHB (Lei/Caos × Bem/Mal, com o Neutro
/// puro no meio) — pedido do usuário (2026-09-20): o campo "Alignment" era
/// `EditableText` livre (qualquer texto), e ele quer travado numa dessas 9,
/// mesmo escrevendo com a caneta. Conteúdo oficial e sem ambiguidade (igual
/// as 9 combinações do livro), então não precisa vir de nenhum corpus JSON
/// pra ser confiável — diferente de dado de regra "extraído", este é só a
/// enumeração do próprio eixo Lei/Caos-Bem/Mal que o PHB define.
enum AlignmentOption: String, CaseIterable, Identifiable {
    case lawfulGood = "Lawful Good"
    case neutralGood = "Neutral Good"
    case chaoticGood = "Chaotic Good"
    case lawfulNeutral = "Lawful Neutral"
    case trueNeutral = "True Neutral"
    case chaoticNeutral = "Chaotic Neutral"
    case lawfulEvil = "Lawful Evil"
    case neutralEvil = "Neutral Evil"
    case chaoticEvil = "Chaotic Evil"

    var id: String { rawValue }

    /// Abreviação de 2 letras clássica do PHB (LG, NG, CG... "True
    /// Neutral" vira "TN", não "N", pra não confundir com o eixo Lei/Caos
    /// que também usa N). Aparece no seletor pra quem já conhece de cor e
    /// prefere digitar/procurar pela sigla em vez do nome inteiro.
    var abbreviation: String {
        switch self {
        case .lawfulGood: return "LG"
        case .neutralGood: return "NG"
        case .chaoticGood: return "CG"
        case .lawfulNeutral: return "LN"
        case .trueNeutral: return "TN"
        case .chaoticNeutral: return "CN"
        case .lawfulEvil: return "LE"
        case .neutralEvil: return "NE"
        case .chaoticEvil: return "CE"
        }
    }

    /// Tenta casar um texto livre já salvo (fichas antigas, ou a sigla
    /// digitada) com uma das 9 opções — usado só pra destacar (★) a opção
    /// atual no seletor, nunca pra "corrigir" o valor sozinho.
    static func match(_ text: String) -> AlignmentOption? {
        let normalized = Fuzzy.normalize(text)
        guard !normalized.isEmpty else { return nil }
        return AlignmentOption.allCases.first {
            Fuzzy.normalize($0.rawValue) == normalized || Fuzzy.normalize($0.abbreviation) == normalized
        }
    }
}

/// Campo "Alignment" do cabeçalho da ficha — era `EditableText` livre,
/// virou botão que abre `AlignmentPickerSheet`, mesmo padrão do `KitField`
/// (`CharacterSheetView.swift`). `character.alignment` continua sendo o
/// mesmo `String` de sempre: escolher no seletor só grava o
/// `rawValue` (ex. "Lawful Good") ali — fichas antigas com texto livre
/// continuam aparecendo aqui até o jogador abrir o seletor e trocar.
struct AlignmentField: View {
    @Binding var alignment: String
    var size: CGFloat = 17
    @State private var isPickerPresented = false

    var body: some View {
        Button {
            isPickerPresented = true
        } label: {
            HandValue(text: alignment.isEmpty ? "—" : alignment, size: size)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isPickerPresented) {
            AlignmentPickerSheet(selection: $alignment)
        }
    }
}

/// Lista das 9 combinações, com busca — mesmo esqueleto do
/// `KitPickerSheet` (`Views/KitCompendiumView.swift`): `HandwritingField`
/// pra permitir escrever com a caneta (Scribble/soft keyboard), mas o
/// texto digitado só FILTRA a lista, nunca vira o valor gravado direto —
/// é assim que a trava pro PHB acontece mesmo aceitando escrita à mão.
struct AlignmentPickerSheet: View {
    @Binding var selection: String
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text("Choose Alignment")
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField

                if filtered.isEmpty {
                    Text("No alignment matches — try a different search.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered) { option in
                            AlignmentPickerRow(
                                option: option,
                                isSelected: currentMatch == option,
                                onSelect: {
                                    selection = option.rawValue
                                    dismiss()
                                }
                            )
                        }
                    }
                }
            }
            .padding(24)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "name or abbreviation (LG, TN, CE...)")
    }

    private var currentMatch: AlignmentOption? { AlignmentOption.match(selection) }

    private var filtered: [AlignmentOption] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return AlignmentOption.allCases }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return AlignmentOption.allCases }

        return AlignmentOption.allCases.filter {
            Fuzzy.normalize($0.rawValue).contains(normalizedQuery)
                || Fuzzy.normalize($0.abbreviation).contains(normalizedQuery)
        }
    }
}

private struct AlignmentPickerRow: View {
    let option: AlignmentOption
    let isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                Text(isSelected ? "★" : "")
                    .frame(width: 18)
                Text(option.rawValue)
                    .font(Paper.hand(18))
                    .foregroundStyle(Paper.penInk)
                Spacer()
                Text(option.abbreviation)
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}
