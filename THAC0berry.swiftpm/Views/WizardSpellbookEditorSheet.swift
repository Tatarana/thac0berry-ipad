import SwiftUI

/// O livro de magias pessoal do Mago (2026-09-29, ver o comentário grande
/// em `PlayerCharacter.wizardSpellbook`) — aberto como uma folha PRÓPRIA
/// na ficha do personagem ("My Spellbook", só pra Mago), pelo menu ☰ ao
/// lado de "Sessions"/"Mage Grimoire" (`SheetTabs`, `CharacterSheetView.swift`).
/// Vivia como uma sheet modal na v1.89 — o usuário pediu (2026-09-30) pra
/// virar folha de verdade, mesmo espírito do Grimório (`SpellbookView`,
/// que já é uma página, não uma janela): um traço PERMANENTE do
/// personagem, então faz mais sentido ser um lugar fixo na ficha do que
/// algo que se abre e fecha por cima.
///
/// Diferente de Sphere Access (que nunca bloqueia, só sinaliza), aqui a
/// lista É a restrição de verdade: só quem está neste livro aparece pra
/// memorizar num slot da Wizard Spell Sheet (`SlotEditorSheet`/
/// `MemorizedRow` em `SpellSheetView.swift`) — regra real do AD&D 2e, o
/// mago precisa aprender a magia antes de poder prepará-la, ao contrário
/// do clérigo (que só precisa ter acesso à esfera). Sem simular a rolagem
/// de "chance to learn" da Tabela 4 — mesma filosofia de nunca rolar dado
/// sozinho que o app já segue pra Hit Points: é uma lista editável simples,
/// o jogador decide o que entra.
///
/// A busca abaixo só oferece círculos que o personagem já consegue
/// LANÇAR agora (`PlayerCharacter.wizardMaxKnowableCircle`, pedido do
/// usuário 2026-09-30) — aprender um círculo fora de alcance ainda não
/// faz sentido. O mesmo Grimório (`SpellbookView`) também ganhou seu
/// próprio botão de adicionar direto de lá, com a mesma restrição — esta
/// tela e o Grimório escrevem no mesmo `character.wizardSpellbook`.
///
/// A seção "Specialization" (2026-09-30, PHB Table 22) deixa escolher uma
/// das oito escolas — opcional, `nil` continua sendo o generalista de
/// sempre, sem bônus e sem restrição nenhuma. Especializar bloqueia de
/// verdade as escolas opostas (`PlayerCharacter.isSpellOpposedBySchool`),
/// e trocar de escola já REMOVE do livro qualquer magia batida com a base
/// que ficou oposta pela troca — ver `setSchool(_:)`. Entradas livres
/// (nome digitado à mão, sem escola conhecida) nunca são removidas por
/// esta checagem. Só aparece pro Mago — o PHB é explícito que "in no case
/// can a bard choose to specialize in a school of magic", então a seção
/// inteira fica fora pra quem não é `.mage` (`specializationSection`).
///
/// REAPROVEITADO PRO BARDO (2026-09-30, "Grimório manual, igual o do
/// Mago" — escolha do usuário): esta mesma tela, o mesmo
/// `character.wizardSpellbook`, servem o Bardo também — ver o comentário
/// grande em `CharacterClass.isArcaneCaster`. A única diferença de
/// comportamento é a especialização (acima) e o texto do rodapé, que
/// troca "Mage Grimoire" por "Bard Grimoire" quando for o caso.
struct WizardSpellbookEditorSheet: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var spellbook: SpellDatabase

    @State private var query: String = ""
    @State private var freeNameLevel: Int = 1

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            if character.characterClass == .mage {
                specializationSection
            }
            searchField

            if !trimmedQuery.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    if searchResults.isEmpty && (beyondCircleCount > 0 || opposedCount > 0) {
                        Text(blockedResultsNote)
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    ForEach(searchResults) { spell in
                        searchResultRow(spell)
                    }
                    addFreeNameRow
                }

                Rectangle().fill(Paper.hairline).frame(height: 1)
            }

            VStack(alignment: .leading, spacing: 16) {
                ForEach(groupedBook, id: \.level) { group in
                    circleSection(group)
                }
                if character.wizardSpellbook.isEmpty {
                    Text("Your spellbook is empty — search above to add spells from the Grimoire.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }
            }

            Text("Only spells in your spellbook can be memorized on the Spell Sheet — unlike a priest's spheres, you have to actually learn a spell first. You can also add spells straight from the \(grimoireLabel) (menu ☰).")
                .font(Paper.printedItalic(11))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    /// "Mage Grimoire" pro Mago, "Bard Grimoire" pro Bardo — mesmo rótulo
    /// usado no menu ☰ (`SheetTabs`, `CharacterSheetView.swift`) e no
    /// cabeçalho do Grimório (`SpellbookView.header`).
    private var grimoireLabel: String { character.characterClass == .bard ? "Bard Grimoire" : "Mage Grimoire" }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("My Spellbook")
                    .font(Paper.hand(28))
                    .foregroundStyle(Paper.penInk)
                Text("\(character.wizardSpellbook.count) spell(s) known — can cast up to circle \(character.wizardMaxKnowableCircle)")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "search the Grimoire to add a spell")
    }

    // MARK: - Especialização de escola (PHB Table 22, 2026-09-30)

    private var specializationSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                FieldLabel(text: "Specialization")
                Spacer()
                Menu {
                    Button("Generalist (no school)") { setSchool(nil) }
                    Divider()
                    ForEach(WizardSchool.allCases) { school in
                        Button("\(school.rawValue) (\(school.specialistTitle))") { setSchool(school) }
                    }
                } label: {
                    Text("\(character.wizardSchool?.rawValue ?? "Generalist") ▾")
                        .font(Paper.printed(13))
                        .tracking(0.3)
                        .foregroundStyle(Paper.ink)
                }
            }
            if let wizardSchool = character.wizardSchool {
                Text("+1 slot per circle you already have, best filled with a \(wizardSchool.rawValue) spell. Opposition schools (blocked): \(wizardSchool.oppositionSchools.map(\.rawValue).joined(separator: ", ")).")
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
            } else {
                Text("Generalist — no bonus, no restriction. Specializing is optional.")
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
            }
        }
        .padding(.bottom, 4)
    }

    /// Trocar de escola já remove do livro qualquer magia batida com a
    /// base que fica oposta pela nova escolha — bloqueio de verdade vale
    /// pra trás também, não só pra adição nova. Entradas livres (sem
    /// `matchedSpellID`, escola desconhecida) nunca são removidas aqui.
    private func setSchool(_ school: WizardSchool?) {
        character.wizardSchool = school
        character.wizardSpellbook.removeAll { entry in
            guard let id = entry.matchedSpellID, let spell = spellbook.spell(id: id) else { return false }
            return character.isSpellOpposedBySchool(spell)
        }
    }

    // MARK: - Busca (adicionar)

    private var trimmedQuery: String { query.trimmingCharacters(in: .whitespacesAndNewlines) }

    /// Mesmo padrão de duas etapas do `SpellbookView.filtered` — substring
    /// primeiro (busca digitada, sem ruído de aproximação fraca), fuzzy só
    /// se a substring não achar nada. Só oferece círculos que o
    /// personagem já consegue lançar (`wizardMaxKnowableCircle`) e escolas
    /// que não estão opostas à especialização atual — ver o comentário
    /// grande no topo do arquivo.
    private var searchResults: [Spell] {
        allSearchMatches.filter { $0.level <= character.wizardMaxKnowableCircle && !character.isSpellOpposedBySchool($0) }
    }

    /// Igual a `searchResults`, mas sem restrição nenhuma — só pra calcular
    /// `beyondCircleCount`/`opposedCount` (avisar quando existe resultado,
    /// só que bloqueado, em vez de parecer que a busca não achou nada).
    private var allSearchMatches: [Spell] {
        guard !trimmedQuery.isEmpty else { return [] }
        let normalized = Fuzzy.normalize(trimmedQuery)
        guard !normalized.isEmpty else { return [] }

        let arcaneSpells = spellbook.spells.filter { $0.caster == .arcane }
        let substringMatches = arcaneSpells.filter { $0.normalizedName.contains(normalized) }
        let base = substringMatches.isEmpty
            ? spellbook.matches(for: trimmedQuery, limit: 30, minimumScore: 0.5, caster: .arcane).map(\.spell)
            : substringMatches
        return base.sorted { lhs, rhs in
            lhs.level == rhs.level ? lhs.name < rhs.name : lhs.level < rhs.level
        }
    }

    private var beyondCircleCount: Int {
        allSearchMatches.filter { $0.level > character.wizardMaxKnowableCircle }.count
    }

    private var opposedCount: Int {
        allSearchMatches.filter { $0.level <= character.wizardMaxKnowableCircle && character.isSpellOpposedBySchool($0) }.count
    }

    private var blockedResultsNote: String {
        var parts: [String] = []
        if beyondCircleCount > 0 {
            parts.append("\(beyondCircleCount) beyond circle \(character.wizardMaxKnowableCircle)")
        }
        if opposedCount > 0 {
            parts.append("\(opposedCount) from an opposition school")
        }
        return "No usable match — \(parts.joined(separator: ", ")) found, but blocked."
    }

    private func searchResultRow(_ spell: Spell) -> some View {
        let known = character.wizardKnows(spellID: spell.id)
        return HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text(spell.name)
                    .font(Paper.hand(18))
                    .foregroundStyle(Paper.penInk)
                Text(circleLabel(spell.level))
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer(minLength: 8)
            Button {
                toggle(spell)
            } label: {
                Text(known ? "in book ✓" : "add")
                    .font(Paper.printed(12))
                    .tracking(0.5)
                    .foregroundStyle(known ? Paper.inkSoft : Paper.ink)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
        .overlay(alignment: .bottom) { DottedRule() }
    }

    /// Não bateu com nada da base (dentro do alcance) — ainda pode entrar
    /// no livro como entrada de nome livre (magia homebrew, achada num
    /// pergaminho em jogo) — mesma ideia já usada em Magic Item Spells/
    /// Additional Spells. O seletor de círculo também não passa do teto
    /// (`wizardMaxKnowableCircle`) — mesma restrição da busca.
    @ViewBuilder
    private var addFreeNameRow: some View {
        if searchResults.isEmpty && beyondCircleCount == 0 && opposedCount == 0 {
            let maxCircle = max(character.wizardMaxKnowableCircle, 1)
            VStack(alignment: .leading, spacing: 6) {
                Text("Not in the Grimoire — add as a free entry (homebrew, or found in play):")
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
                HStack {
                    Text("Circle")
                        .font(Paper.printed(12))
                        .foregroundStyle(Paper.ink)
                    Picker("Circle", selection: $freeNameLevel) {
                        ForEach(1...maxCircle, id: \.self) { level in
                            Text("\(level)").tag(level)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    Spacer()
                    Button {
                        character.wizardSpellbook.append(
                            WizardSpellbookEntry(name: trimmedQuery, matchedSpellID: nil, level: freeNameLevel))
                        query = ""
                    } label: {
                        Text("add \u{201C}\(trimmedQuery)\u{201D}")
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.ink)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 6)
            .onAppear { freeNameLevel = min(freeNameLevel, maxCircle) }
        }
    }

    private func toggle(_ spell: Spell) {
        if character.wizardKnows(spellID: spell.id) {
            character.wizardSpellbook.removeAll { $0.matchedSpellID == spell.id }
        } else {
            character.wizardSpellbook.append(
                WizardSpellbookEntry(name: spell.name, matchedSpellID: spell.id, level: nil))
        }
    }

    // MARK: - Livro atual (remover)

    private struct CircleGroup { let level: Int; let entries: [WizardSpellbookEntry] }

    private var groupedBook: [CircleGroup] {
        let byLevel = Dictionary(grouping: character.wizardSpellbook) { entry -> Int in
            if let id = entry.matchedSpellID, let spell = spellbook.spell(id: id) { return spell.level }
            return entry.level ?? 0
        }
        return byLevel.keys.sorted().map { level in
            CircleGroup(level: level,
                       entries: byLevel[level, default: []].sorted { displayName($0) < displayName($1) })
        }
    }

    private func circleSection(_ group: CircleGroup) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: circleLabel(group.level))
            ForEach(group.entries) { entry in
                bookRow(entry)
            }
        }
    }

    private func bookRow(_ entry: WizardSpellbookEntry) -> some View {
        HStack {
            Text(displayName(entry))
                .font(Paper.hand(18))
                .foregroundStyle(Paper.penInk)
            if entry.matchedSpellID == nil {
                Text("(free entry)")
                    .font(Paper.printedItalic(10))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer(minLength: 8)
            Button {
                character.wizardSpellbook.removeAll { $0.id == entry.id }
            } label: {
                Text("remove")
                    .font(Paper.printed(11))
                    .foregroundStyle(Paper.redInk)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
    }

    private func displayName(_ entry: WizardSpellbookEntry) -> String {
        if let id = entry.matchedSpellID, let spell = spellbook.spell(id: id) { return spell.name }
        return entry.name
    }

    private func circleLabel(_ level: Int) -> String {
        level == 0 ? "Cantrip" : "Circle \(level)"
    }
}
