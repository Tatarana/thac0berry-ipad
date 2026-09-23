import SwiftUI

/// Tela de consulta da base de proficiências não-de-arma — mesmo espírito
/// do `KitCompendiumView`/`SpellbookView`: folhear a base inteira (372,
/// PHB + suplementos), sem estar presa a nenhum personagem. Agrupada por
/// `primaryGroup` (General/Priest/Rogue/Warrior/Wizard/Psionicist/
/// "Racial / Special"), a mesma divisão que já vem pronta nos dados.
///
/// Aberta a partir do Compêndio geral — não filtra por cenário de
/// campanha (é uma referência, mostra tudo de propósito); o filtro por
/// cenário só entra no seletor da FICHA (`ProficiencyPickerSheet` abaixo),
/// que é o lugar que o usuário pediu pra "poluir menos as listas do
/// jogador" (TODO.md item 18).
struct ProficiencyCompendiumView: View {
    @EnvironmentObject private var proficiencyDatabase: ProficiencyDatabase

    @State private var query: String = ""
    /// Exceções ao padrão "recolhido" — usado quando NEM busca nem filtro
    /// estão ativos (`autoExpand == false`, browse normal). Ver
    /// `collapsedGroups` pro caso inverso.
    @State private var expandedGroups: Set<String> = []
    /// Exceções ao padrão "expandido" — usado quando busca OU filtro estão
    /// ativos (`autoExpand == true`). Sem isso, `isExpanded` não tinha
    /// como voltar `false` nunca com o filtro ligado (o bug relatado).
    @State private var collapsedGroups: Set<String> = []
    @State private var detailProficiency: Proficiency? = nil
    /// Filtro de cenário SÓ desta tela de consulta — vazio = mostra tudo.
    /// Independente de `Campaign.enabledSettings`: aqui é só um jeito
    /// rápido de folhear "o que existe pra Dark Sun", não muda nada da
    /// ficha nem precisa de campanha nenhuma pra usar. Usuário pediu
    /// ícones em vez de combo/Picker de formulário — ver `SettingFilterRow`
    /// abaixo (TODO.md item 18, rodada 2026-09-20).
    @State private var selectedSettings: Set<String> = []

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField
            SettingFilterRow(selected: $selectedSettings)

            if let error = proficiencyDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedProficiencies.isEmpty {
                Text("No proficiencies match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedProficiencies, id: \.group) { section in
                    ProficiencyGroupSection(
                        label: section.group,
                        proficiencies: section.proficiencies,
                        isExpanded: isExpanded(section.group),
                        onToggleExpand: { toggleExpand(section.group) },
                        onSelect: { detailProficiency = $0 }
                    )
                }
            }
        }
        .sheet(item: $detailProficiency) { proficiency in
            ProficiencyDetailSheet(proficiency: proficiency)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Proficiencies")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(proficiencyDatabase.proficiencies.count) proficiencies")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "proficiency name")
    }

    // MARK: - Dados derivados

    private var settingFiltered: [Proficiency] {
        guard !selectedSettings.isEmpty else { return proficiencyDatabase.proficiencies }
        return proficiencyDatabase.proficiencies.filter { matchesSelectedSettings($0) }
    }

    /// "Core"/"Generic" (ver `CampaignSettingCatalog.isGeneric`) nunca some
    /// da lista, esteja o filtro de ícones ligado ou não — mesma regra do
    /// filtro da ficha (`Campaign.allowsAnySetting`), só que sem depender
    /// de nenhuma campanha existir.
    private func matchesSelectedSettings(_ proficiency: Proficiency) -> Bool {
        if proficiency.campaignSettings.contains(where: { CampaignSettingCatalog.isGeneric($0) }) { return true }
        return !Set(proficiency.campaignSettings).isDisjoint(with: selectedSettings)
    }

    private var filtered: [Proficiency] {
        let base = settingFiltered
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return base }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return base }

        let substringMatches = base.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
        if !substringMatches.isEmpty { return substringMatches }

        // O fuzzy fallback (`matches(for:)`) busca na base inteira, sem
        // saber nada de cenário — filtra por cima antes de devolver, senão
        // uma digitação torta "furava" o filtro de ícones.
        let fuzzy = proficiencyDatabase.matches(for: trimmed, limit: 60)
        guard !selectedSettings.isEmpty else { return fuzzy }
        return fuzzy.filter { matchesSelectedSettings($0) }
    }

    private struct ProficiencyGroup { let group: String; let proficiencies: [Proficiency] }

    private var groupedProficiencies: [ProficiencyGroup] {
        let byGroup = Dictionary(grouping: filtered, by: { $0.primaryGroup })
        return ProficiencyDatabase.groupOrder.compactMap { group in
            guard let entries = byGroup[group], !entries.isEmpty else { return nil }
            return ProficiencyGroup(group: group, proficiencies: entries.sorted { $0.name < $1.name })
        }
    }

    /// Com busca por texto OU filtro de cenário ativo, todo grupo começa
    /// aberto sozinho (pra não esconder um resultado que a busca/filtro já
    /// restringiu) — mas isso não pode significar "sempre aberto,
    /// intocável": antes disso ERA o bug relatado (com filtro ligado, não
    /// dava pra recolher grupo nenhum, porque `isExpanded` sempre voltava
    /// `true` sem nunca checar um toque de fechar). Agora `expandedGroups`/
    /// `collapsedGroups` guardam só a EXCEÇÃO ao padrão do momento — qual
    /// dos dois conjuntos importa depende de `autoExpand` estar ligado ou
    /// não, então o toque de fechar/abrir sempre tem efeito nos dois
    /// modos.
    private var autoExpand: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !selectedSettings.isEmpty
    }

    private func isExpanded(_ group: String) -> Bool {
        autoExpand ? !collapsedGroups.contains(group) : expandedGroups.contains(group)
    }

    private func toggleExpand(_ group: String) {
        if autoExpand {
            if collapsedGroups.contains(group) {
                collapsedGroups.remove(group)
            } else {
                collapsedGroups.insert(group)
            }
        } else if expandedGroups.contains(group) {
            expandedGroups.remove(group)
        } else {
            expandedGroups.insert(group)
        }
    }
}

// MARK: - Filtro por cenário (ícones, não Picker)

/// Fileira de "selinhos" com ícone — não um `Picker`/formulário de menu.
/// "All" (sem nenhum marcado) mostra tudo; tocar um ou mais cenários
/// restringe a lista a eles (mais o que é Core/Generic, que nunca some —
/// ver `matchesSelectedSettings`). Toque-e-segure mostra o nome completo
/// do cenário (`actionTooltip`, mesmo tooltip do resto do app) — a legenda
/// embaixo do ícone já é curta o bastante pra caber sem precisar de texto
/// nenhum extra na maioria dos casos.
private struct SettingFilterRow: View {
    @Binding var selected: Set<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: "Setting")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    SettingFilterChip(
                        systemImage: "asterisk",
                        label: "All",
                        tooltip: "Show every setting",
                        isSelected: selected.isEmpty,
                        action: { selected.removeAll() }
                    )
                    ForEach(CampaignSettingCatalog.all, id: \.self) { setting in
                        SettingFilterChip(
                            systemImage: CampaignSettingCatalog.icon(for: setting),
                            imageName: CampaignSettingCatalog.logoImageName(for: setting),
                            label: CampaignSettingCatalog.shortLabel(for: setting),
                            tooltip: setting,
                            isSelected: selected.contains(setting),
                            action: { toggle(setting) }
                        )
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }

    private func toggle(_ setting: String) {
        if selected.contains(setting) {
            selected.remove(setting)
        } else {
            selected.insert(setting)
        }
    }
}

private struct SettingFilterChip: View {
    let systemImage: String
    /// Nome do PNG (sem extensão) do logo de verdade do cenário —
    /// `nil` cai pro `systemImage` de sempre. Ver `CampaignSettingCatalog.
    /// logoImageName(for:)` (2026-09-21, logos entregues pelo usuário).
    var imageName: String? = nil
    let label: String
    let tooltip: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                settingIcon
                Text(label)
                    .font(Paper.printed(10))
                    .tracking(0.3)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
            .frame(width: 56, height: 46)
            .background(isSelected ? Paper.ink : Color.white.opacity(0.15))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink.opacity(0.5), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
        .actionTooltip(tooltip)
        .accessibilityLabel(tooltip)
    }

    /// Logo de verdade quando existe (`.renderingMode(.template)` faz o
    /// PNG preto puro herdar a mesma cor que o SF Symbol já usava, então
    /// selecionado/não-selecionado continuam se comportando exatamente
    /// igual); cai pro SF Symbol de sempre quando não há logo pro cenário
    /// (`imageName == nil`, ex. o chip "All") ou o PNG não carrega por
    /// algum motivo — mesmo padrão de fallback de `HomeIconTile`.
    @ViewBuilder
    private var settingIcon: some View {
        if let imageName, let art = Image.bundled(imageName) {
            art
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 17, height: 17)
        } else {
            Image(systemName: systemImage)
                .font(.system(size: 15, weight: .medium))
        }
    }
}

/// Fileira de chips de texto simples ("All", "General", "Warrior", ...) —
/// mais leve que `SettingFilterChip` (que carrega logo/ícone por cenário),
/// só um rótulo já basta pra um eixo categórico como este. Seleção única
/// (não múltipla como o filtro de cenário): um jogador está escolhendo
/// proficiência PRA uma classe de cada vez, então "General + Warrior ao
/// mesmo tempo" não é um caso de uso real aqui.
private struct ProficiencyGroupChipRow: View {
    let availableGroups: [String]
    @Binding var selected: String?
    /// Grupo da classe do personagem — só ganha uma estrelinha no rótulo
    /// do chip, pra sinalizar "este é o seu grupo" sem forçar o filtro
    /// (o esmaecimento das linhas já cuida do resto, ver `isDimmed`).
    var recommendedGroup: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: "Group")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    TextFilterChip(label: "All", isSelected: selected == nil, action: { selected = nil })
                    ForEach(availableGroups, id: \.self) { group in
                        TextFilterChip(
                            label: group == recommendedGroup ? "★ \(group)" : group,
                            isSelected: selected == group,
                            action: { selected = (selected == group) ? nil : group }
                        )
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

private struct TextFilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Paper.printed(11.5))
                .lineLimit(1)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
                .background(isSelected ? Paper.ink : Color.white.opacity(0.15))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink.opacity(0.5), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct ProficiencyGroupSection: View {
    let label: String
    let proficiencies: [Proficiency]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (Proficiency) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(proficiencies.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(proficiencies) { proficiency in
                        ProficiencyCompendiumRow(proficiency: proficiency, onSelect: { onSelect(proficiency) })
                    }
                }
            }
        }
    }
}

private struct ProficiencyCompendiumRow: View {
    let proficiency: Proficiency
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(proficiency.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(proficiency.mechanics.abbreviatedMechanics)
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                Text(proficiency.description.briefSummary)
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

private extension ProficiencyMechanics {
    /// "Int -2 · 2 slots" — resumo compacto pra linha de lista.
    var abbreviatedMechanics: String {
        var parts: [String] = []
        if relevantAbility != "N/A" {
            let short = String(relevantAbility.prefix(3))
            parts.append(checkModifier == 0 ? short : "\(short) \(checkModifier >= 0 ? "+" : "")\(checkModifier)")
        }
        parts.append(slotsRequired == 1 ? "1 slot" : "\(slotsRequired) slots")
        return parts.joined(separator: " · ")
    }
}

// MARK: - Descrição completa da proficiência

/// Janela de detalhe, aberta a partir do Compendium (só consulta) ou do
/// seletor da ficha (`ProficiencyPickerSheet`, que soma um botão "Choose
/// this proficiency" — ver `onChoose`).
struct ProficiencyDetailSheet: View {
    let proficiency: Proficiency
    var onChoose: (() -> Void)? = nil
    /// Só vem preenchido quando esta folha é aberta a partir da linha da
    /// FICHA (`ProficiencyFormRow`) — mesmo papel de `SpellDetailSheet.
    /// onChangeSpell`: fecha a descrição e reabre o `ProficiencyPickerSheet`
    /// pra escolher outra, em vez de "aceitar a que já está sendo vista"
    /// (isso é o que `onChoose` faz, usado só ao navegar o Compêndio
    /// inteiro dentro do próprio seletor).
    var onChangeProficiency: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(proficiency.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text(proficiency.primaryGroup)
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    if let onChoose {
                        Button("choose") {
                            onChoose()
                            dismiss()
                        }
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.inkSoft)
                    }
                    if let onChangeProficiency {
                        Button("change", action: onChangeProficiency)
                            .font(Paper.printedItalic(13))
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
                            ProficiencyDetailField(label: "Ability", value: proficiency.mechanics.relevantAbility)
                            ProficiencyDetailField(label: "Check Modifier", value: signedModifier)
                            ProficiencyDetailField(label: "Slots Required", value: "\(proficiency.mechanics.slotsRequired)")
                            if !proficiency.campaignSettings.isEmpty {
                                ProficiencyDetailField(label: "Setting", value: proficiency.campaignSettings.joined(separator: ", "))
                            }
                            if !proficiency.mechanics.groups.isEmpty {
                                ProficiencyDetailField(label: "Learned by", value: proficiency.mechanics.groups.joined(separator: "; "))
                            }
                            if !proficiency.mechanics.prerequisites.isEmpty {
                                ProficiencyDetailField(label: "Prerequisites", value: proficiency.mechanics.prerequisites.joined(separator: ", "))
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            FieldLabel(text: "Description")
                            Text(proficiency.description.fullText)
                                .font(Paper.printed(14))
                                .foregroundStyle(Paper.ink)
                                .lineSpacing(4)
                        }

                        // Player's Option: Skills & Powers é um sistema
                        // alternativo que o app não implementa (ver
                        // comentário em `Proficiency.skillsAndPowers`) — só
                        // referência pra quem usa essa variante na mesa.
                        if let sap = proficiency.skillsAndPowers {
                            VStack(alignment: .leading, spacing: 4) {
                                FieldLabel(text: "Skills & Powers (optional rule)")
                                Text(skillsAndPowersText(sap))
                                    .font(Paper.printed(13))
                                    .foregroundStyle(Paper.inkSoft)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var signedModifier: String {
        let mod = proficiency.mechanics.checkModifier
        return mod == 0 ? "0" : (mod > 0 ? "+\(mod)" : "\(mod)")
    }

    private func skillsAndPowersText(_ sap: ProficiencySkillsAndPowers) -> String {
        var parts: [String] = []
        if let subAbility = sap.subAbility { parts.append("sub-ability \(subAbility)") }
        parts.append("base rating \(sap.baseRating)")
        if let cost = sap.characterPointCost { parts.append("\(cost) character points") }
        return parts.joined(separator: " · ")
    }
}

private struct ProficiencyDetailField: View {
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

// MARK: - Seletor de proficiência (usado na tabela de Proficiências da ficha)

/// Sheet aberta a partir de cada linha da tabela de Proficiências
/// (`ProficiencyFormRow`, `CharacterSheetView.swift`) — escolher aqui
/// preenche nome, slots e o alvo do teste ("Chk") sozinho, calculado a
/// partir do atributo relevante do personagem + o modificador da
/// proficiência (ex. Sabedoria 15 com Healing, Sab -2 → alvo 13). Nada
/// impede editar esses três campos na mão depois — é só um ponto de
/// partida, igual toda outra sugestão deste app.
///
/// Quando a campanha do personagem tem cenários de campanha ligados
/// (`Campaign.enabledSettings`, TODO.md item 18), a lista já vem filtrada
/// — proficiências de cenário desligado nem aparecem, pra não poluir a
/// escolha do jogador com opções que não valem pra mesa dele. Sem cenário
/// configurado (o padrão), mostra tudo, igual sempre foi.
struct ProficiencyPickerSheet: View {
    @Binding var entry: ProficiencyEntry
    var abilities: AbilityScores
    var campaign: Campaign?
    /// Grupo do personagem (`CharacterClass.proficiencyGroup`) — usado só
    /// pra destacar visualmente o chip da classe e ESMAECER (não esconder)
    /// as linhas de outros grupos quando nenhum filtro de grupo está
    /// escolhido a dedo. Pedido do usuário (2026-09-22, item 2 do lote):
    /// "deixe as classes diferentes da do personagem em blur ou algo do
    /// tipo, para que o player foque no General e no da sua classe" — o
    /// jogador continua vendo tudo (proficiência de outra classe ainda é
    /// uma opção válida, é só menos comum), só que General + a classe dele
    /// chamam mais atenção.
    var characterClass: CharacterClass
    @EnvironmentObject private var proficiencyDatabase: ProficiencyDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var detailProficiency: Proficiency? = nil
    /// Segundo filtro pedido pelo usuário (2026-09-22, item 2 do lote):
    /// além do filtro de cenário de campanha que já existia, agora também
    /// dá pra restringir por `primaryGroup` (General/Priest/Rogue/Warrior/
    /// Wizard/Psionicist/Racial-Special) — o único eixo "de classe" que o
    /// corpus guarda de forma limpa o bastante pra virar filtro (ver
    /// `ProficiencyMechanics.groups`, que é texto livre e por isso fica de
    /// fora). `nil` = qualquer grupo.
    @State private var selectedGroup: String? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text("Choose a Proficiency")
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                if let campaign, campaign.enabledSettings?.isEmpty == false {
                    Text("Filtered to \(campaign.displayTitle)'s settings — showing Core plus " +
                         (campaign.enabledSettings?.sorted().joined(separator: ", ") ?? ""))
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField
                ProficiencyGroupChipRow(availableGroups: availableGroups, selected: $selectedGroup,
                                         recommendedGroup: characterClass.proficiencyGroup)

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

                if !entry.name.isEmpty {
                    Button {
                        entry = ProficiencyEntry()
                        dismiss()
                    } label: {
                        Text("Clear current entry (\(entry.name))")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }

                if let error = proficiencyDatabase.loadError {
                    Text(error)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.redInk)
                } else if filtered.isEmpty {
                    Text("No proficiencies match — try a different search.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered) { proficiency in
                            ProficiencyPickerRow(
                                proficiency: proficiency,
                                isSelected: entry.name == proficiency.name,
                                isDimmed: isDimmed(proficiency),
                                onSelect: { choose(proficiency) },
                                onInfo: { detailProficiency = proficiency }
                            )
                        }
                    }
                }
            }
            .padding(24)
        }
        .sheet(item: $detailProficiency) { proficiency in
            ProficiencyDetailSheet(proficiency: proficiency, onChoose: { choose(proficiency) })
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "proficiency name")
    }

    private var settingFiltered: [Proficiency] {
        guard let campaign else { return proficiencyDatabase.proficiencies }
        return proficiencyDatabase.proficiencies.filter { campaign.allowsAnySetting($0.campaignSettings) }
    }

    /// Ordem fixa preferida (mesma dos 7 arquivos de origem, ver
    /// `Proficiency.primaryGroup`) — o resto (se algum valor inesperado
    /// aparecer) cai em ordem alfabética depois desses.
    private static let groupOrder = [
        "General", "Warrior", "Wizard", "Priest", "Rogue", "Psionicist", "Racial / Special",
    ]

    /// "General" e o grupo da classe do personagem vêm primeiro (à
    /// esquerda de tudo, antes até do resto da ordem fixa) — pedido do
    /// usuário: "ordene de forma que General e Priest (isso no caso de
    /// priest, mas varia por classe escolhida) sejam os primeiros filtros
    /// à esquerda". O resto continua na ordem fixa de sempre.
    private var availableGroups: [String] {
        let present = Set(proficiencyDatabase.proficiencies.map(\.primaryGroup))
        let recommended = ["General", characterClass.proficiencyGroup].filter { present.contains($0) }
        let rest = Self.groupOrder.filter { present.contains($0) && !recommended.contains($0) }
        let extra = present.subtracting(Self.groupOrder).sorted()
        return recommended + rest + extra
    }

    private var filtered: [Proficiency] {
        var base = settingFiltered
        if let selectedGroup {
            base = base.filter { $0.primaryGroup == selectedGroup }
        }
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return base }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return base }

        return base.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
    }

    /// Esmaecida quando não é "General" nem o grupo da classe do
    /// personagem — só enquanto nenhum filtro de grupo foi escolhido a
    /// dedo (aí o jogador já filtrou pra ver só aquele grupo de propósito,
    /// esmaecer tudo que sobrou não faria sentido).
    private func isDimmed(_ proficiency: Proficiency) -> Bool {
        guard selectedGroup == nil else { return false }
        return proficiency.primaryGroup != "General" && proficiency.primaryGroup != characterClass.proficiencyGroup
    }

    private func choose(_ proficiency: Proficiency) {
        entry.name = proficiency.name
        entry.slots = proficiency.mechanics.slotsRequired
        entry.target = suggestedTarget(for: proficiency)
        entry.matchedProficiencyID = proficiency.id
        dismiss()
    }

    /// Mesma saída de emergência do `SpellWritingSheet` (Folha de Magias):
    /// aceita o texto digitado como está, sem bater com nada da base — pra
    /// proficiência caseira ou variante de mesa que não está (e talvez
    /// nunca esteja) no corpus de 372. Sem `matchedProficiencyID`, então
    /// sem descrição pra consultar depois — só o nome mesmo, como sempre
    /// foi antes desta base existir.
    private func useAsTyped() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        entry = ProficiencyEntry(name: trimmed)
        dismiss()
    }

    /// Alvo sugerido do teste ("Chk"): atributo relevante ajustado pelo
    /// modificador da proficiência — a mesma conta que o PHB descreve (Table
    /// 37 + Cap. 5: "add the modifier to the ability score, roll 1d20,
    /// equal or under succeeds"). `nil` quando a proficiência não usa teste
    /// de atributo nenhum ("N/A", ex. Blind-fighting) — o campo fica em
    /// branco pro jogador preencher se um dia isso mudar de regra na mesa.
    private func suggestedTarget(for proficiency: Proficiency) -> String? {
        guard let score = abilityScore(named: proficiency.mechanics.relevantAbility) else { return nil }
        return "\(score + proficiency.mechanics.checkModifier)"
    }

    private func abilityScore(named ability: String) -> Int? {
        switch ability {
        case "Strength": return abilities.strength
        case "Dexterity": return abilities.dexterity
        case "Constitution": return abilities.constitution
        case "Intelligence": return abilities.intelligence
        case "Wisdom": return abilities.wisdom
        case "Charisma": return abilities.charisma
        default: return nil
        }
    }
}

private struct ProficiencyPickerRow: View {
    let proficiency: Proficiency
    let isSelected: Bool
    /// `true` pra proficiência de um grupo que não é "General" nem o da
    /// classe do personagem — reduz a opacidade da linha inteira (mesma
    /// ideia de "blur" pedida pelo usuário; opacidade em vez de blur de
    /// verdade porque `Fuzzy`/texto continua legível se ele quiser ler
    /// mesmo assim, só menos chamativo). A linha continua tocável — nada
    /// foi escondido, só despriorizado visualmente.
    var isDimmed: Bool = false
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
                    Text(proficiency.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(proficiency.mechanics.abbreviatedMechanics)
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
        // Usuário relatou que 0.4 de opacidade sozinho "não funciona, tá
        // igual" — tinta escura sobre pergaminho claro ainda lê como texto
        // "normal" numa alfa só, mesmo a 40%. Reforçado: opacidade mais
        // baixa (0.28) JUNTO com dessaturação (`saturation(0)`, tira o
        // pouco de cor que a estrela/texto tinham) — a combinação dos dois
        // efeitos é o que de fato lê como "esmaecido" de relance, não só
        // um sozinho.
        .saturation(isDimmed ? 0 : 1)
        .opacity(isDimmed ? 0.28 : 1)
        .padding(.vertical, 4)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}
