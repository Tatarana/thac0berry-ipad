import SwiftUI
import UIKit

/// As folhas de um personagem: a ficha em si e uma folha de magias por dia
/// de jogo. As abas de papel no alto trocam de folha, como quem passa as
/// páginas de uma pasta.
struct CharacterSheetView: View {
    @Binding var character: PlayerCharacter
    @State private var page: SheetPage = .record

    enum SheetPage: Hashable {
        case record
        case spells(UUID)
        case campaignIndex
    }

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(spacing: 0) {
                SheetTabs(character: $character, page: $page)
                    .padding(.horizontal, 18)
                    .padding(.top, 10)

                ZStack {
                    switch page {
                    case .record:
                        ScrollView { OfficialRecordSheet(character: $character).padding(18) }
                            .transition(.opacity)
                    case .spells:
                        // Sem .id(id) aqui — o pager precisa continuar
                        // sendo a MESMA instância de UIPageViewController
                        // quando o dia muda, pra ele mesmo desenhar o
                        // curl de verdade em vez da gente recriar a view
                        // (o que só daria um corte seco).
                        DayPagerView(character: $character, currentID: currentSpellSheetID)
                            .transition(.opacity)
                    case .campaignIndex:
                        ScrollView {
                            CampaignIndexView(character: $character, page: $page)
                                .padding(18)
                        }
                        .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: page)
            }
        }
        // Se a classe mudou pra uma sem ficha de magia enquanto uma folha ou
        // o índice estavam abertos, volta pra Ficha — nenhuma das duas abas
        // existe mais.
        .onChange(of: character.characterClass) { _, newClass in
            guard !newClass.hasSpellSheet else { return }
            switch page {
            case .spells, .campaignIndex: page = .record
            case .record: break
            }
        }
        // O UIPageViewController do folhear de dias tem o próprio gesto de
        // arrasto — que também mora bem na quina esquerda da tela, onde o
        // NavigationStack reserva o "puxar da borda pra voltar" do sistema.
        // Desligado pra sempre nesta tela (o botão de voltar da barra
        // continua funcionando normal).
        .background(
            InteractivePopGestureConfigurator()
                .frame(width: 0, height: 0)
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Paper.sheet, for: .navigationBar)
    }

    /// Ponte entre o `page` (que carrega o UUID só quando é a case
    /// .spells) e o `currentID: UUID` que o DayPagerView espera — ele só
    /// existe enquanto a case .spells está montada, então o valor de saída
    /// nunca é realmente usado fora dela.
    private var currentSpellSheetID: Binding<UUID> {
        Binding(
            get: {
                if case .spells(let id) = page { return id }
                return UUID()
            },
            set: { newID in page = .spells(newID) }
        )
    }
}

/// Um UIViewController "fantasma", sem conteúdo visível, só pra alcançar o
/// UINavigationController de dentro do SwiftUI e desligar o
/// `interactivePopGestureRecognizer` (o "puxar da borda esquerda pra
/// voltar" do sistema) nesta tela inteira. Fica desligado o tempo todo, não
/// só enquanto uma folha está aberta — ligar e desligar junto com a página
/// deixava uma janela de corrida bem na hora do gesto, e um arrasto um
/// pouco impreciso acabava puxando a tela inteira de volta pra lista de
/// personagens. O botão de voltar da barra de navegação continua ali pra
/// sair desta tela normalmente.
private struct InteractivePopGestureConfigurator: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        uiViewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

// MARK: - Abas de papel

private struct SheetTabs: View {
    @Binding var character: PlayerCharacter
    @Binding var page: CharacterSheetView.SheetPage
    @State private var expandedSessionID: UUID? = nil

    /// Quantas divisórias de sessão cabem na faixa antes de precisar abrir
    /// o índice inteiro — mesma ideia de antes com os dias.
    private let maxVisibleSessions = 4

    var body: some View {
        // Só quem tem ficha de magia (Clérigo, por ora) ganha as divisórias
        // de sessão — as outras classes só veem "Sheet".
        let hasSpellSheet = character.characterClass.hasSpellSheet
        // A fileira de sessões/dias fica escondida quando o índice já está
        // aberto — mostrar a mesma lista de sessões duas vezes (na fileira
        // de abas e no corpo do índice) não faz sentido nenhum.
        let showSessionStrip = hasSpellSheet && page != .campaignIndex

        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .bottom, spacing: 6) {
                PaperTab(title: "Sheet", isSelected: page == .record) {
                    page = .record
                }

                if showSessionStrip {
                    ForEach(recentSessions) { session in
                        SessionDivisory(
                            session: session,
                            color: character.sessionColor(session),
                            isSelected: expandedSessionID == session.id || isShowingSheet(in: session),
                            action: { selectSession(session) }
                        )
                    }
                }

                if hasSpellSheet {
                    PaperTab(title: "index", isSelected: page == .campaignIndex) {
                        page = .campaignIndex
                    }
                }

                Spacer(minLength: 0)

                if hasSpellSheet {
                    Button(action: newSheet) {
                        Text("+ day sheet")
                            .font(Paper.printed(12))
                            .tracking(1)
                            .foregroundStyle(Paper.ink)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
                    }
                    .buttonStyle(.plain)
                }
            }

            if showSessionStrip, let expanded = expandedSession {
                DayThreadRow(
                    sheets: daySheets(in: expanded),
                    currentID: currentSpellSheetID,
                    onSelect: { sheet in page = .spells(sheet.id) },
                    onDelete: deleteSheet,
                    canDelete: character.spellSheets.count > 1
                )
                .padding(.leading, 4)
            }
        }
        .onChange(of: page) { _, newPage in
            // A sub-fileira de dias sempre acompanha a folha aberta, mesmo
            // quando ela foi aberta por outro caminho (índice, swipe).
            if case .spells(let id) = newPage,
               let sheet = character.spellSheets.first(where: { $0.id == id }),
               let sessionID = sheet.sessionID {
                expandedSessionID = sessionID
            }
        }
    }

    private var recentSessions: [Session] {
        Array(character.sessions.filter { !$0.isArchived }
            .sorted { $0.date > $1.date }
            .prefix(maxVisibleSessions))
    }

    private var expandedSession: Session? {
        guard let id = expandedSessionID else { return nil }
        return character.sessions.first { $0.id == id }
    }

    private var currentSpellSheetID: UUID? {
        if case .spells(let id) = page { return id }
        return nil
    }

    private func daySheets(in session: Session) -> [SpellSheet] {
        character.spellSheets
            .filter { $0.sessionID == session.id }
            .sorted { $0.date < $1.date }
    }

    private func isShowingSheet(in session: Session) -> Bool {
        guard case .spells(let id) = page else { return false }
        return daySheets(in: session).contains { $0.id == id }
    }

    private func selectSession(_ session: Session) {
        expandedSessionID = session.id
        if let latest = daySheets(in: session).max(by: { $0.date < $1.date }) {
            page = .spells(latest.id)
        }
    }

    /// Nova folha herda o que estava preparado no dia anterior da mesma
    /// sessão, com os slots já zerados — que é o que o repouso faz na
    /// regra — mas a quantidade de slots em si vem de "Spell Slots" na
    /// ficha. Sem sessão ativa pra hoje, `activeSession()` cria uma sozinha.
    private func newSheet() {
        let session = character.activeSession()
        let previous = daySheets(in: session).last
        var sheet: SpellSheet = previous?.nextDay(keepingPreparations: true) ?? SpellSheet()
        sheet.sessionID = session.id
        sheet.slotBoard = reconciled(sheet.slotBoard, with: character.spellSlotAllotments)
        sheet.title = "Dia \(daySheets(in: session).count + 1)"
        // Congela a Sabedoria de hoje na folha nova — é o valor que vale
        // pra esse dia, mesmo que o personagem mude depois.
        sheet.wisdomAtCreation = character.abilities.wisdom
        character.spellSheets.append(sheet)
        expandedSessionID = session.id
        page = .spells(sheet.id)
    }

    /// Apaga uma folha (pelo menu de contexto de um chip de dia). Sempre
    /// sobra pelo menos uma no personagem inteiro — apagar sessões inteiras
    /// é feito pelo índice, que não tem essa trava.
    private func deleteSheet(_ sheet: SpellSheet) {
        guard character.spellSheets.count > 1 else { return }
        let wasShowing = page == .spells(sheet.id)
        character.spellSheets.removeAll { $0.id == sheet.id }
        if wasShowing {
            page = character.sortedSpellSheets.first.map { .spells($0.id) } ?? .record
        }
    }

    /// Ajusta uma grade herdada do dia anterior para bater com a tabela da
    /// ficha: aumenta ou diminui a contagem de cada círculo (`setCount`
    /// preserva o que estava preparado quando um nível encolhe) e zera
    /// círculos que saíram da tabela por completo.
    private func reconciled(_ board: SpellSlotBoard,
                            with allotments: [SpellSlotAllotment]) -> SpellSlotBoard {
        var result = board
        var covered = Set<CasterLevel>()

        for allotment in allotments {
            let key = CasterLevel(caster: allotment.caster, level: allotment.level)
            covered.insert(key)
            result.setCount(allotment.count, level: allotment.level, caster: allotment.caster)
        }

        let existing = Set(result.slots.map { CasterLevel(caster: $0.caster, level: $0.level) })
        for pair in existing where !covered.contains(pair) {
            result.setCount(0, level: pair.level, caster: pair.caster)
        }

        return result
    }
}

/// Uma divisória de sessão — a metáfora de fichário: um retângulo colorido
/// com os cantos de cima arredondados, "saindo" da faixa de abas.
private struct SessionDivisory: View {
    let session: Session
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(shortLabel)
                .font(Paper.printed(11))
                .tracking(0.6)
                .lineLimit(1)
                .foregroundStyle(Paper.ink)
                .padding(.horizontal, 12)
                .padding(.vertical, isSelected ? 8 : 6)
                .frame(minWidth: 64)
                .background(color.opacity(isSelected ? 0.95 : 0.6))
                .clipShape(divisoryShape)
                .overlay(divisoryShape.stroke(Paper.ink, lineWidth: 1.2))
                .shadow(color: Paper.ink.opacity(isSelected ? 0.22 : 0), radius: 2.5, y: 1.5)
                .offset(y: isSelected ? -2 : 0)
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.78), value: isSelected)
    }

    private var divisoryShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(topLeadingRadius: 7, bottomLeadingRadius: 0,
                               bottomTrailingRadius: 0, topTrailingRadius: 7)
    }

    private var shortLabel: String {
        if !session.title.isEmpty { return session.title }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: session.date)
    }
}

/// Os dias de uma sessão — não mais uma fileira de caixinhas, e sim contas
/// de tinta enfiadas numa linha de costura pontilhada, como as folhas de um
/// caderno costurado à mão (um "signature" de encadernação). Cada dia é um
/// pingo redondo com o número dentro; o aberto cresce, ganha tinta cheia e
/// sombra, os outros ficam pequenos e ocos, todos pendurados na mesma
/// linha. O título de verdade do dia (pode ter sido renomeado) some
/// discretamente por baixo, junto do pingo aberto.
private struct DayThreadRow: View {
    let sheets: [SpellSheet]
    let currentID: UUID?
    let onSelect: (SpellSheet) -> Void
    let onDelete: (SpellSheet) -> Void
    let canDelete: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 13) {
                ForEach(Array(sheets.enumerated()), id: \.element.id) { index, sheet in
                    InkDayBead(number: index + 1, isSelected: sheet.id == currentID) {
                        onSelect(sheet)
                    }
                    .contextMenu {
                        if canDelete {
                            Button("Delete sheet", role: .destructive) { onDelete(sheet) }
                        }
                    }
                }
            }
            .padding(.vertical, 3)
            .background(alignment: .leading) {
                GeometryReader { geometry in
                    Path { path in
                        path.move(to: CGPoint(x: 9, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width - 9, y: geometry.size.height / 2))
                    }
                    .stroke(Paper.inkSoft.opacity(0.5),
                           style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [1, 5]))
                }
            }

            if let title = currentTitle {
                Text(title)
                    .font(Paper.printedItalic(10.5))
                    .foregroundStyle(Paper.inkSoft)
                    .padding(.leading, 3)
            }
        }
    }

    private var currentTitle: String? {
        sheets.first { $0.id == currentID }?.displayTitle
    }
}

private struct InkDayBead: View {
    let number: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle().fill(isSelected ? Paper.penInk : Paper.sheet)
                Circle().stroke(Paper.ink, lineWidth: isSelected ? 1.6 : 1)
                Text("\(number)")
                    .font(Paper.hand(isSelected ? 15 : 11))
                    .foregroundStyle(isSelected ? Paper.sheet : Paper.inkSoft)
            }
            .frame(width: isSelected ? 30 : 20, height: isSelected ? 30 : 20)
            .shadow(color: Paper.ink.opacity(isSelected ? 0.3 : 0), radius: 3, y: 1.5)
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.32, dampingFraction: 0.72), value: isSelected)
    }
}

private struct PaperTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            PaperTabLabel(title: title, isSelected: isSelected)
        }
        .buttonStyle(.plain)
    }
}

private struct PaperTabLabel: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(Paper.printed(12))
            .tracking(1.4)
            .lineLimit(1)
            .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
            .padding(.horizontal, 14)
            .padding(.vertical, isSelected ? 8 : 6)
            .background(isSelected ? Paper.ink : Color.white.opacity(0.14))
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
    }
}

// MARK: - Folha 1: a ficha oficial

struct OfficialRecordSheet: View {
    @Binding var character: PlayerCharacter
    /// Medida por trás do conteúdo: um GeometryReader envolvendo a folha
    /// dentro de um ScrollView fixaria a altura e cortaria os blocos.
    @State private var width: CGFloat = 0

    var body: some View {
        let isWide: Bool = width > 900

        VStack(spacing: 12) {
            RecordHeader(character: $character)

            Group {
                if isWide {
                    HStack(alignment: .top, spacing: 12) {
                        VStack(spacing: 10) {
                            AbilityBlock(character: $character)
                            AlliesBlock(character: $character)
                            SavesBlock(saves: $character.saves)
                        }
                        .frame(width: 392)

                        VStack(spacing: 10) {
                            CombatRow(character: $character)
                            ArmorBlock(character: $character)
                            WeaponsBlock(character: $character)
                            EquipmentBlock(character: $character)
                            TreasureBlock(treasure: $character.treasure)
                        }
                        .frame(maxWidth: .infinity)

                        VStack(spacing: 10) {
                            ExperienceBlock(character: $character)
                            SpellSlotsBlock(character: $character)
                            ListBlock(title: "Proficiências em armas",
                                      items: $character.weaponProficiencies)
                            PairListBlock(title: "Perícias", trailing: "não-armas",
                                          items: $character.skills)
                            ListBlock(title: "Idiomas", items: $character.languages)
                            ListBlock(title: "Itens mágicos", items: $character.magicItems)
                        }
                        .frame(width: 330)
                    }
                } else {
                    // Dois Group: o ViewBuilder aceita no máximo 10 filhos
                    // diretos, e são treze blocos na coluna única.
                    VStack(spacing: 10) {
                        Group {
                            CombatRow(character: $character)
                            AbilityBlock(character: $character)
                            SavesBlock(saves: $character.saves)
                            ArmorBlock(character: $character)
                            WeaponsBlock(character: $character)
                            EquipmentBlock(character: $character)
                        }
                        Group {
                            TreasureBlock(treasure: $character.treasure)
                            ExperienceBlock(character: $character)
                            SpellSlotsBlock(character: $character)
                            ListBlock(title: "Proficiências em armas",
                                      items: $character.weaponProficiencies)
                            PairListBlock(title: "Perícias", trailing: "não-armas",
                                          items: $character.skills)
                            ListBlock(title: "Idiomas", items: $character.languages)
                            ListBlock(title: "Itens mágicos", items: $character.magicItems)
                            AlliesBlock(character: $character)
                        }
                    }
                }
            }
        }
        .background(WidthReader(width: $width))
    }
}

/// Mede a largura disponível sem interferir no tamanho do conteúdo.
///
/// Escreve por PreferenceKey em vez de mexer no @State direto de dentro do
/// GeometryReader: assim a atualização acontece depois do layout, e não
/// durante, que é o que gera o aviso "Modifying state during view update".
struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        let next = nextValue()
        if next > 0 { value = next }
    }
}

struct WidthReader: View {
    @Binding var width: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
        .onPreferenceChange(WidthPreferenceKey.self) { newValue in
            if abs(newValue - width) > 0.5 {
                width = newValue
            }
        }
    }
}

// MARK: - Cabeçalho da ficha

private struct RecordHeader: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        VStack(spacing: 6) {
            HStack(alignment: .bottom, spacing: 18) {
                VStack(alignment: .leading, spacing: 0) {
                    FieldLabel(text: "Personagem")
                    EditableText(value: $character.name, placeholder: "sem nome",
                                 size: 42, tilt: -0.8, underline: false)
                }
                .frame(width: 290, alignment: .leading)

                identityGrid
            }

            Rectangle().fill(Paper.ink).frame(height: 2.2)
        }
    }

    /// Os campos de identidade em uma lista: doze filhos soltos estouram o
    /// limite de dez do ViewBuilder e o tempo de inferência do compilador.
    struct IdentityField: Identifiable {
        let id: String
        let keyPath: WritableKeyPath<PlayerCharacter, String>
    }

    private static let identityFields: [IdentityField] = [
        IdentityField(id: "Jogador", keyPath: \.playerName),
        IdentityField(id: "Raça", keyPath: \.race),
        IdentityField(id: "Tendência", keyPath: \.alignment),
        IdentityField(id: "Divindade", keyPath: \.deity),
        IdentityField(id: "Sexo", keyPath: \.sex),
        IdentityField(id: "Idade", keyPath: \.age),
        IdentityField(id: "Altura", keyPath: \.height),
        IdentityField(id: "Peso", keyPath: \.weight),
        IdentityField(id: "Cabelos", keyPath: \.hair),
        IdentityField(id: "Olhos", keyPath: \.eyes)
    ]

    private var identityGrid: some View {
        let columns = [GridItem(.adaptive(minimum: 128), spacing: 14)]

        return LazyVGrid(columns: columns, alignment: .leading, spacing: 3) {
            SmallNumberField(label: "Nível", value: $character.level, upper: 30)
            ClassField(character: $character)
            ForEach(RecordHeader.identityFields) { field in
                SmallField(label: field.id, value: Binding(
                    get: { character[keyPath: field.keyPath] },
                    set: { character[keyPath: field.keyPath] = $0 }
                ))
            }
        }
    }
}

/// Classe agora é uma lista fechada, não texto livre — é ela que decide se
/// a pasta ganha a aba de folha de magia (só o Clérigo, por ora). Trocar a
/// classe pra Clérigo já cria a primeira folha, se ainda não existir uma.
struct ClassField: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FieldLabel(text: "Classe")
            Menu {
                ForEach(CharacterClass.allCases) { option in
                    Button(option.rawValue) { select(option) }
                }
            } label: {
                VStack(alignment: .leading, spacing: 1) {
                    HandValue(text: character.characterClass.rawValue, size: 19)
                    Rectangle().fill(Paper.hairline).frame(height: 1)
                }
            }
            .buttonStyle(.plain)
        }
    }

    private func select(_ option: CharacterClass) {
        character.characterClass = option
        guard option.hasSpellSheet, character.spellSheets.isEmpty else { return }
        let session = character.activeSession()
        var sheet = SpellSheet()
        sheet.sessionID = session.id
        sheet.title = "Primeiro dia"
        sheet.wisdomAtCreation = character.abilities.wisdom
        sheet.slotBoard = character.freshSlotBoard()
        character.spellSheets = [sheet]
    }
}

struct SmallField: View {
    let label: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FieldLabel(text: label)
            EditableText(value: $value, placeholder: "", size: 19)
        }
    }
}

struct SmallNumberField: View {
    let label: String
    @Binding var value: Int
    var upper: Int = 9999

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FieldLabel(text: label)
            HStack {
                EditableNumber(value: $value, size: 19, lower: 0, upper: upper)
                Spacer(minLength: 0)
            }
            Rectangle().fill(Paper.hairline).frame(height: 1)
        }
    }
}

// MARK: - Atributos com os ajustes derivados

private struct AbilityBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Atributos", trailing: "ajustes") {
            VStack(spacing: 0) {
                strengthRow
                dexterityRow
                constitutionRow
                intelligenceRow
                wisdomRow
                charismaRow
            }
        }
    }

    // Uma propriedade por linha: as seis juntas formam uma árvore genérica
    // grande demais para o type-checker do Playgrounds resolver de uma vez.

    private var strengthRow: some View {
        AbilityRow(name: "Força", score: $character.abilities.strength) {
            SubField(label: "Acerto", value: $character.details.strengthHit)
            SubField(label: "Dano", value: $character.details.strengthDamage)
            SubField(label: "Peso perm.", value: $character.details.strengthWeight)
            SubField(label: "Carga máx.", value: $character.details.strengthMaxPress)
            SubField(label: "Portas", value: $character.details.strengthDoors)
            SubField(label: "Barras", value: $character.details.strengthBars)
        }
    }

    private var dexterityRow: some View {
        AbilityRow(name: "Destreza", score: $character.abilities.dexterity) {
            SubField(label: "Reação", value: $character.details.dexterityReaction)
            SubField(label: "Projétil", value: $character.details.dexterityMissile)
            SubField(label: "Defesa (CA)", value: $character.details.dexterityDefense)
        }
    }

    private var constitutionRow: some View {
        AbilityRow(name: "Constituição", score: $character.abilities.constitution) {
            SubField(label: "Ajuste PV", value: $character.details.constitutionHP)
            SubField(label: "Choque", value: $character.details.constitutionShock)
            SubField(label: "Ressurreição", value: $character.details.constitutionResurrection)
            SubField(label: "Veneno", value: $character.details.constitutionPoison)
        }
    }

    private var intelligenceRow: some View {
        AbilityRow(name: "Inteligência", score: $character.abilities.intelligence) {
            SubField(label: "Idiomas", value: $character.details.intelligenceLanguages)
            SubField(label: "Nível máx.", value: $character.details.intelligenceMaxLevel)
            SubField(label: "Aprender", value: $character.details.intelligenceLearn)
            SubField(label: "Máx./nível", value: $character.details.intelligenceMaxPerLevel)
        }
    }

    private var wisdomRow: some View {
        AbilityRow(name: "Sabedoria", score: $character.abilities.wisdom) {
            SubField(label: "Defesa mág.", value: $character.details.wisdomDefense)
            SubField(label: "Falha", value: $character.details.wisdomFailure)
            SubField(label: "Magias bônus", value: $character.details.wisdomBonusSpells)
        }
    }

    private var charismaRow: some View {
        AbilityRow(name: "Carisma", score: $character.abilities.charisma, isLast: true) {
            SubField(label: "Seguidores", value: $character.details.charismaHenchmen)
            SubField(label: "Lealdade", value: $character.details.charismaLoyalty)
            SubField(label: "Reação", value: $character.details.charismaReaction)
        }
    }
}

private struct AbilityRow<Subs: View>: View {
    let name: String
    @Binding var score: Int
    var isLast: Bool = false
    @ViewBuilder var subs: Subs

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 8) {
                Text(name.uppercased())
                    .font(Paper.printed(11))
                    .tracking(1)
                    .foregroundStyle(Paper.ink)
                    .frame(width: 92, alignment: .leading)
                    .padding(.top, 8)

                EditableNumber(value: $score, size: 27, lower: 1, upper: 25)
                    .frame(width: 46, height: 38)
                    .background(Color.white.opacity(0.35))
                    .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 92), spacing: 10)],
                          alignment: .leading, spacing: 1) {
                    subs
                }
            }
            .padding(.vertical, 5)

            if !isLast { DottedRule() }
        }
    }
}

private struct SubField: View {
    let label: String
    @Binding var value: String

    var body: some View {
        HStack(spacing: 4) {
            FieldLabel(text: label)
            Spacer(minLength: 2)
            EditableText(value: $value, placeholder: "—", size: 17, underline: false)
                .fixedSize()
        }
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Combate

private struct CombatRow: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        HStack(spacing: 10) {
            BigStat(label: "Classe de armadura") {
                EditableNumber(value: $character.armorClass, size: 34, lower: -10, upper: 10)
            }
            BigStat(label: "THAC0") {
                EditableNumber(value: $character.thac0, size: 34, lower: -10, upper: 25)
            }
            BigStat(label: "Pontos de vida") {
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    EditableNumber(value: $character.hitPointsCurrent, size: 34,
                                   color: Paper.redInk, lower: -30, upper: 999)
                    Text("/")
                        .font(Paper.printed(18))
                        .foregroundStyle(Paper.inkSoft)
                    EditableNumber(value: $character.hitPointsMax, size: 20, lower: 1, upper: 999)
                }
            }
        }
    }
}

private struct BigStat<Content: View>: View {
    let label: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 2) {
            Text(label.uppercased())
                .font(.system(size: 9, weight: .regular, design: .serif))
                .tracking(1.6)
                .foregroundStyle(Paper.inkSoft)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 7)
        .background(Color.white.opacity(0.25))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
    }
}

private struct ArmorBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Armadura", trailing: "CA base 10") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 12)],
                      alignment: .leading, spacing: 2) {
                SubField(label: "Armadura", value: $character.armorRating)
                SubField(label: "Escudo", value: $character.shieldRating)
                SubField(label: "Destreza", value: $character.details.dexterityDefense)
                HStack(spacing: 4) {
                    FieldLabel(text: "Movimento")
                    Spacer(minLength: 2)
                    EditableNumber(value: $character.movement, size: 17, lower: 0, upper: 30)
                }
                .overlay(alignment: .bottom) { DottedRule() }
            }
        }
    }
}

// MARK: - Jogadas de proteção

private struct SavesBlock: View {
    @Binding var saves: SavingThrows

    var body: some View {
        SheetBlock(title: "Jogadas de proteção", trailing: "d20") {
            VStack(spacing: 0) {
                ForEach(SavingThrows.labels) { entry in
                    SaveLine(saves: $saves, entry: entry)
                }
            }
        }
    }
}

private struct SaveLine: View {
    @Binding var saves: SavingThrows
    let entry: SavingThrows.SaveEntry

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(entry.label)
                    .font(Paper.printed(12.5))
                    .foregroundStyle(Paper.ink)
                Spacer(minLength: 8)
                EditableNumber(
                    value: Binding(
                        get: { saves[keyPath: entry.keyPath] },
                        set: { saves[keyPath: entry.keyPath] = $0 }
                    ),
                    size: 24, lower: 1, upper: 20
                )
            }
            .padding(.vertical, 4)
            DottedRule()
        }
    }
}

// MARK: - Armas

private struct WeaponsBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Armas", trailing: "ataques por rodada") {
            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    FieldLabel(text: "Arma")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FieldLabel(text: "Atq").frame(width: 34)
                    FieldLabel(text: "THAC0").frame(width: 44)
                    FieldLabel(text: "Dano P/M").frame(width: 64)
                    FieldLabel(text: "Dano G").frame(width: 60)
                    FieldLabel(text: "Alcance").frame(width: 62)
                }
                .padding(.bottom, 2)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Paper.ink).frame(height: 1)
                }

                ForEach($character.weapons) { $weapon in
                    WeaponRow(weapon: $weapon)
                }

                AddLineButton(title: "acrescentar arma") {
                    character.weapons.append(WeaponEntry())
                }
            }
        }
    }
}

private struct WeaponRow: View {
    @Binding var weapon: WeaponEntry

    var body: some View {
        HStack(spacing: 6) {
            EditableText(value: $weapon.name, placeholder: "…", size: 19, underline: false)
                .frame(maxWidth: .infinity, alignment: .leading)
            EditableText(value: $weapon.attacks, placeholder: "1", size: 18, underline: false)
                .frame(width: 34)
            EditableText(value: $weapon.thac0, placeholder: "—", size: 18, underline: false)
                .frame(width: 44)
            EditableText(value: $weapon.damageSmall, placeholder: "—", size: 18, underline: false)
                .frame(width: 64)
            EditableText(value: $weapon.damageLarge, placeholder: "—", size: 18, underline: false)
                .frame(width: 60)
            EditableText(value: $weapon.range, placeholder: "—", size: 18, underline: false)
                .frame(width: 62)
        }
        .padding(.vertical, 2)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Listas da ficha

private struct EquipmentBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Equipamento", trailing: "peso") {
            VStack(spacing: 0) {
                ForEach($character.equipment) { $item in
                    PairLine(item: $item)
                }
                AddLineButton(title: "acrescentar linha") {
                    character.equipment.append(EquipmentItem())
                }
            }
        }
    }
}

private struct PairListBlock: View {
    let title: String
    var trailing: String? = nil
    @Binding var items: [EquipmentItem]

    var body: some View {
        SheetBlock(title: title, trailing: trailing) {
            VStack(spacing: 0) {
                ForEach($items) { $item in
                    PairLine(item: $item)
                }
                AddLineButton(title: "acrescentar") {
                    items.append(EquipmentItem())
                }
            }
        }
    }
}

private struct PairLine: View {
    @Binding var item: EquipmentItem

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 8) {
            EditableText(value: $item.name, placeholder: "…", size: 19, underline: false)
            Spacer(minLength: 4)
            EditableText(value: $item.note, placeholder: "", size: 13, underline: false)
                .frame(width: 72, alignment: .trailing)
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

private struct ListBlock: View {
    let title: String
    @Binding var items: [String]

    var body: some View {
        SheetBlock(title: title, trailing: "\(items.count)") {
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        EditableText(value: $items[index], placeholder: "…",
                                     size: 19, underline: false)
                        Spacer(minLength: 0)
                    }
                    .padding(.vertical, 3)
                    .overlay(alignment: .bottom) { DottedRule() }
                }
                AddLineButton(title: "acrescentar") {
                    items.append("")
                }
            }
        }
    }
}

private struct AlliesBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        ListBlock(title: "Aliados e seguidores", items: $character.allies)
    }
}

private struct AddLineButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("+ " + title)
                .font(Paper.printedItalic(11.5))
                .foregroundStyle(Paper.inkSoft)
                .padding(.top, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Tesouro e experiência

private struct TreasureBlock: View {
    @Binding var treasure: Treasure

    var body: some View {
        SheetBlock(title: "Tesouro", trailing: "moedas") {
            HStack(spacing: 10) {
                CoinField(label: "PL", value: $treasure.platinum)
                CoinField(label: "PO", value: $treasure.gold)
                CoinField(label: "PE", value: $treasure.electrum)
                CoinField(label: "PP", value: $treasure.silver)
                CoinField(label: "PC", value: $treasure.copper)
            }
        }
    }
}

private struct CoinField: View {
    let label: String
    @Binding var value: Int

    var body: some View {
        VStack(spacing: 1) {
            EditableNumber(value: $value, size: 21, lower: 0, upper: 999_999)
            Rectangle().fill(Paper.hairline).frame(height: 1)
            FieldLabel(text: label)
        }
        .frame(maxWidth: .infinity)
    }
}

/// Quantos slots de cada círculo o personagem tem por descanso — a tabela
/// de memorização da classe, do livro. Preenchida uma vez aqui; toda folha
/// de magia nova nasce a partir dela, em vez de deixar cada dia divergir
/// sobre quantos slots o personagem tem.
private struct SpellSlotsBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Spell Slots", trailing: "per rest") {
            VStack(alignment: .leading, spacing: 6) {
                if character.spellSlotAllotments.isEmpty {
                    Text("No slots set yet — add one below.")
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.inkSoft)
                }

                ForEach(sortedAllotments) { allotment in
                    HStack(spacing: 8) {
                        Text(allotment.caster.label)
                            .font(Paper.printed(11))
                            .foregroundStyle(Paper.inkSoft)
                            .frame(width: 54, alignment: .leading)
                        Text("Lvl \(allotment.level)")
                            .font(Paper.printed(11))
                            .foregroundStyle(Paper.inkSoft)
                            .frame(width: 42, alignment: .leading)
                        EditableNumber(value: binding(for: allotment), size: 16,
                                       lower: 0, upper: 20)
                        Spacer(minLength: 0)
                        Button {
                            setCount(0, level: allotment.level, caster: allotment.caster)
                        } label: {
                            Text("✕")
                                .font(Paper.printed(12))
                                .foregroundStyle(Paper.redInk)
                        }
                        .buttonStyle(.plain)
                    }
                }

                AddSlotLevelMenu { level, caster in
                    let current = character.spellSlotAllotments
                        .first { $0.level == level && $0.caster == caster }?.count ?? 0
                    setCount(current + 1, level: level, caster: caster)
                }
                .padding(.top, character.spellSlotAllotments.isEmpty ? 0 : 4)
            }
        }
    }

    private var sortedAllotments: [SpellSlotAllotment] {
        character.spellSlotAllotments.sorted { lhs, rhs in
            if lhs.caster != rhs.caster { return lhs.caster.rawValue < rhs.caster.rawValue }
            return lhs.level < rhs.level
        }
    }

    private func binding(for allotment: SpellSlotAllotment) -> Binding<Int> {
        Binding(
            get: {
                character.spellSlotAllotments.first { $0.id == allotment.id }?.count ?? 0
            },
            set: { newValue in
                setCount(newValue, level: allotment.level, caster: allotment.caster)
            }
        )
    }

    private func setCount(_ count: Int, level: Int, caster: CasterType) {
        if let index = character.spellSlotAllotments.firstIndex(where: {
            $0.level == level && $0.caster == caster
        }) {
            if count <= 0 {
                character.spellSlotAllotments.remove(at: index)
            } else {
                character.spellSlotAllotments[index].count = count
            }
        } else if count > 0 {
            character.spellSlotAllotments.append(
                SpellSlotAllotment(caster: caster, level: level, count: count))
        }
    }
}

/// O mesmo menu de "+ slot" de antes, só que agora escreve na ficha do
/// personagem em vez de na folha do dia.
private struct AddSlotLevelMenu: View {
    let onAdd: (Int, CasterType) -> Void

    var body: some View {
        Menu {
            ForEach(CasterType.allCases) { caster in
                Menu(caster.label) {
                    ForEach(1...9, id: \.self) { level in
                        Button("Level \(level): add a slot") {
                            onAdd(level, caster)
                        }
                    }
                }
            }
        } label: {
            Text("+ slot")
                .font(Paper.printed(12))
                .tracking(1)
                .foregroundStyle(Paper.ink)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
        }
    }
}

private struct ExperienceBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Experiência") {
            VStack(spacing: 0) {
                HStack {
                    Text("Total")
                        .font(Paper.printed(12.5))
                        .foregroundStyle(Paper.ink)
                    Spacer()
                    EditableNumber(value: $character.experience, size: 24,
                                   lower: 0, upper: 9_999_999)
                }
                .padding(.vertical, 4)
                DottedRule()
            }
        }
    }
}
