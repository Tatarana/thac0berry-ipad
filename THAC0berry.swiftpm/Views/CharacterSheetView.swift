import SwiftUI
import UIKit

/// Verde se algum Efeito Ativo estiver ajudando o campo `polarity`
/// representa, vermelho se estiver atrapalhando, ou `defaultColor` se
/// nenhum efeito mexe ali agora — pedido do usuário (2026-09-28): "todos
/// os ajustes temporários devem permanecer na cor verde se bons ou
/// vermelhos se ruins" (persistente, ao contrário do pisca-e-apaga do
/// `ChangeFlash`). `PlayerCharacter.activeEffectPolarity(for:)` decide
/// bom/ruim; isto só traduz pra cor.
private func polarityColor(_ polarity: PlayerCharacter.EffectPolarity?, default defaultColor: Color) -> Color {
    switch polarity {
    case .good?: return Paper.greenInk
    case .bad?: return Paper.redInk
    case nil: return defaultColor
    }
}

/// As folhas de um personagem: a ficha em si e uma folha de magias por dia
/// de jogo. As abas de papel no alto trocam de folha, como quem passa as
/// páginas de uma pasta.
struct CharacterSheetView: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var library: CharacterLibrary
    @State private var page: SheetPage
    /// Qual das duas páginas da aba Sheet está aberta — a ficha em si (0)
    /// ou a nova página de Equipment/Movement/Experience (1). Fica de fora
    /// do `SheetPage`, ao contrário do caderno: nada mais na tela precisa
    /// pular direto pra uma página específica daqui.
    @State private var recordSheetPageIndex: Int = 0

    /// Normalmente abre na Ficha — `initialPage` só existe pra quem chega
    /// de fora já sabendo pra onde ir (o botão de Caderno da campanha, por
    /// exemplo, que pula direto pro Caderno em vez da Ficha).
    init(character: Binding<PlayerCharacter>, initialPage: SheetPage = .record) {
        self._character = character
        self._page = State(initialValue: initialPage)
    }

    enum SheetPage: Hashable {
        case record
        case notebook(UUID?)
        case spells(UUID)
        case campaignIndex
        case spellbook
        /// "My Spellbook" (2026-09-30) — livro pessoal de quem lança magia
        /// arcana, mesmo espírito de `.spellbook` (o Grimório inteiro):
        /// folha própria, não janela modal. Só existe pra quem tem
        /// `characterClass.isArcaneCaster` (Mago e, desde 2026-09-30,
        /// Bardo) — ver `WizardSpellbookEditorSheet`.
        case mySpellbook
        /// Efeitos Ativos (2026-09-28) — magias/itens com duração finita
        /// (Regenerate, Stone Skin, Recitation, poções que sobrescrevem
        /// um atributo, PV temporário não-curável). Ver
        /// `Views/ActiveEffectsView.swift`. Disponível pra QUALQUER
        /// classe (ao contrário de `.spells`/`.spellbook`, que só
        /// existem pra quem tem ficha de magia) — efeitos temporários
        /// acontecem com guerreiro tanto quanto com clérigo.
        case effects
    }

    var body: some View {
        ZStack {
            // A capa de couro, por trás de tudo — o conteúdo (PaperBackground,
            // logo abaixo) cobre essa textura por completo; só a fileira de
            // abas no topo fica exposta a ela.
            ChromeBackground()

            VStack(spacing: 0) {
                SheetTabs(character: $character, campaignBinding: campaignBinding, page: $page)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(Paper.chromeDeep).frame(height: 1)
                    }

                ZStack {
                    PaperBackground()

                    switch page {
                    case .record:
                        // Mesmo padrão de navegação da Priest Spell Sheet —
                        // curl de página de verdade, não uma lista rolável —
                        // e agora também as mesmas bolinhas, pra folhear sem
                        // arrastar quando a página não é a de ao lado.
                        VStack(spacing: 0) {
                            RecordSheetBeadRow(currentIndex: $recordSheetPageIndex,
                                               maxPageIndex: character.characterClass.recordSheetPageCount - 1)
                            RecordSheetPagerView(character: $character,
                                                 campaignBinding: campaignBinding,
                                                 currentIndex: $recordSheetPageIndex)
                        }
                        .transition(.opacity)
                    case .notebook(let id):
                        if let campaignBinding {
                            // `id` chega `nil` tanto quando o caderno está
                            // mesmo vazio quanto quando quem abriu a tela só
                            // pediu "vai pro caderno" sem escolher página
                            // (o link da Campanha, por exemplo) — nos dois
                            // casos cai pra primeira folha em ordem, se
                            // existir alguma.
                            let resolvedID = id ?? campaignBinding.wrappedValue.notebookEntries
                                .sorted { $0.date < $1.date }.first?.id
                            if let resolvedID,
                               campaignBinding.wrappedValue.notebookEntries.contains(where: { $0.id == resolvedID }) {
                                VStack(spacing: 0) {
                                    NotebookBeadRow(campaign: campaignBinding, selection: notebookSelection, currentID: resolvedID)
                                    NotebookPagerView(campaign: campaignBinding, currentID: currentNotebookPageID)
                                }
                                .transition(.opacity)
                            } else {
                                ScrollView {
                                    NotebookEmptyState(campaign: campaignBinding, selection: notebookSelection)
                                        .padding(18)
                                }
                                .transition(.opacity)
                            }
                        } else {
                            ScrollView {
                                NoCampaignNotice()
                                    .padding(18)
                            }
                            .transition(.opacity)
                        }
                    case .spells(let sheetID):
                        // Sem .id(id) no pager aqui — ele precisa continuar
                        // sendo a MESMA instância de UIPageViewController
                        // quando o dia muda, pra ele mesmo desenhar o
                        // curl de verdade em vez da gente recriar a view
                        // (o que só daria um corte seco).
                        VStack(spacing: 0) {
                            SpellSheetBeadRow(character: $character, campaignBinding: campaignBinding,
                                              page: $page, currentSheetID: sheetID)
                            DayPagerView(character: $character, currentID: currentSpellSheetID)
                        }
                        .transition(.opacity)
                    case .campaignIndex:
                        ScrollView {
                            if let campaignBinding {
                                CampaignIndexView(character: $character, campaign: campaignBinding, page: $page)
                                    .padding(18)
                            } else {
                                NoCampaignNotice()
                                    .padding(18)
                            }
                        }
                        .transition(.opacity)
                    case .spellbook:
                        ScrollView {
                            SpellbookView(character: $character,
                                         caster: character.characterClass.isArcaneCaster ? .arcane : .divine)
                                .padding(18)
                        }
                        .transition(.opacity)
                    case .mySpellbook:
                        ScrollView {
                            WizardSpellbookEditorSheet(character: $character)
                                .padding(18)
                        }
                        .transition(.opacity)
                    case .effects:
                        ScrollView {
                            ActiveEffectsView(character: $character)
                                .padding(18)
                        }
                        .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: page)
            }
        }
        // Pedido do usuário (2026-09-29): o contador de "ataques
        // negados" (Stone Skin e afins) deveria aparecer na Ficha, não só
        // dentro da aba de Efeitos Ativos — uma janelinha flutuante fixa
        // no canto, visível em QUALQUER aba (`page`), pra riscar um
        // ataque anulado sem sair de onde se está.
        .overlay(alignment: .topTrailing) {
            AttackNegationFloatingBadge(character: $character)
                .padding(.top, 78)
                .padding(.trailing, 14)
                .allowsHitTesting(true)
        }
        // Se a classe mudou pra uma sem ficha de magia enquanto uma folha ou
        // o índice estavam abertos, volta pra Ficha — nenhuma das duas abas
        // existe mais. "My Spellbook" some sozinho quando deixa de ser Mago
        // mesmo virando Clérigo (que tem ficha de magia, mas não livro de
        // magias pessoal) — por isso essa checagem é separada da de
        // `hasSpellSheet` abaixo.
        .onChange(of: character.characterClass) { _, newClass in
            if page == .mySpellbook, !newClass.isArcaneCaster {
                page = .record
            }
            guard !newClass.hasSpellSheet else { return }
            // A 3ª página da ficha (tabelas do Clérigo) só existe pra quem
            // tem ficha de magia — se a classe mudou pra outra, volta pra
            // página 1 caso estivesse lá.
            if recordSheetPageIndex > 1 { recordSheetPageIndex = 0 }
            switch page {
            case .spells, .campaignIndex, .spellbook, .mySpellbook: page = .record
            // .effects fica disponível pra qualquer classe (ver comentário
            // em `SheetPage.effects`), então uma troca de classe nunca
            // precisa tirar ninguém de lá.
            case .record, .notebook, .effects: break
            }
        }
        // O UIPageViewController do folhear de dias tem o próprio gesto de
        // arrasto — que também mora bem na quina esquerda da tela, onde o
        // NavigationStack reserva o "puxar da borda pra voltar" do sistema.
        // Desligado pra sempre nesta tela (voltar agora é só pelo menu ☰).
        .background(
            InteractivePopGestureConfigurator()
                .frame(width: 0, height: 0)
        )
        // Sem barra de navegação nesta tela — o espaço que ela reservava só
        // pra caber o botão "back" agora é conteúdo de verdade; "voltar aos
        // personagens" mudou pra dentro do menu ☰.
        .toolbar(.hidden, for: .navigationBar)
    }

    /// Ponte entre `page` (que só carrega o UUID na case .notebook) e o
    /// `currentID: UUID` que o NotebookPagerView espera — mesma ideia da
    /// `currentSpellSheetID` logo abaixo, só que com um fallback pra
    /// primeira folha quando a página ainda não tinha um id definido.
    private var currentNotebookPageID: Binding<UUID> {
        Binding(
            get: {
                if case .notebook(let id) = page, let id { return id }
                return campaignBinding?.wrappedValue.notebookEntries.sorted { $0.date < $1.date }.first?.id ?? UUID()
            },
            set: { newID in page = .notebook(newID) }
        )
    }

    /// Ponte entre `page` e o `Binding<UUID?>` que `NotebookBeadRow`/
    /// `NotebookEmptyState` esperam agora (ver comentário em
    /// `NotebookBeadRow.selection`) — desacoplado do enum `SheetPage` pra
    /// esses dois também funcionarem fora de uma `CharacterSheetView`
    /// (`CampaignNotebookView`, aberta direto da Campanha).
    private var notebookSelection: Binding<UUID?> {
        Binding(
            get: { if case .notebook(let id) = page { return id }; return nil },
            set: { newID in page = .notebook(newID) }
        )
    }

    /// A campanha deste personagem — `nil` enquanto ele estiver no Sandbox,
    /// sem nenhuma campanha associada ainda.
    private var campaignBinding: Binding<Campaign>? {
        library.binding(forCampaignID: character.campaignID)
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

/// Aviso mostrado no lugar do Caderno/Índice/Grimório enquanto o personagem
/// ainda está no Sandbox — sem campanha, não há sessão nem caderno pra
/// abrir; some sozinho assim que ele for associado a uma campanha.
private struct NoCampaignNotice: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("No campaign yet")
                .font(Paper.hand(26))
                .foregroundStyle(Paper.penInk)
            Text("This character is in the Sandbox. Assign it to a campaign to start its notebook and session log.")
                .font(Paper.printedItalic(13))
                .foregroundStyle(Paper.inkSoft)
        }
    }
}

/// Janelinha flutuante fixa no canto superior direito da Ficha, visível em
/// QUALQUER aba (`page`) — replica o contador "X de Y" de cada
/// `.attackNegation` ativo (Stone Skin e afins) pra riscar um ataque
/// anulado sem precisar abrir a aba "✨ Efeitos Ativos" toda vez. Some
/// sozinha quando não há nenhum `.attackNegation` ativo. Pedido do
/// usuário (2026-09-29).
private struct AttackNegationFloatingBadge: View {
    @Binding var character: PlayerCharacter

    private var items: [PlayerCharacter.ActiveAttackNegation] { character.activeAttackNegations }

    var body: some View {
        if !items.isEmpty {
            VStack(alignment: .leading, spacing: 6) {
                ForEach(items) { item in
                    HStack(spacing: 6) {
                        Image(systemName: "shield.lefthalf.filled")
                            .font(.system(size: 11))
                            .foregroundStyle(item.component.isExhausted ? Paper.redInk : Paper.penInk)
                        Text(item.effectName.isEmpty ? "Effect" : item.effectName)
                            .font(Paper.printed(10.5))
                            .foregroundStyle(Paper.inkSoft)
                            .lineLimit(1)
                        TallyBoard(
                            count: item.component.usedCount,
                            isExhausted: item.component.isExhausted,
                            onAdd: {
                                character.adjustAttackNegation(effectID: item.effectID, componentID: item.component.id, by: 1)
                            },
                            onRemove: {
                                character.adjustAttackNegation(effectID: item.effectID, componentID: item.component.id, by: -1)
                            }
                        )
                        Text("\(item.component.usedCount)/\(item.component.maxUses)")
                            .font(Paper.hand(13))
                            .foregroundStyle(item.component.isExhausted ? Paper.redInk : Paper.penInk)
                    }
                }
            }
            .padding(8)
            .background(Paper.sheet.opacity(0.97))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink, lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
            .transition(.opacity)
        }
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
    let campaignBinding: Binding<Campaign>?
    @Binding var page: CharacterSheetView.SheetPage
    @State private var expandedSessionID: UUID? = nil
    @Environment(\.dismiss) private var dismiss
    @Environment(\.popToRoot) private var popToRoot

    var body: some View {
        // Só quem tem ficha de magia (Clérigo, por ora) ganha o distintivo
        // de sessão — as outras classes só veem Sheet/Notebook.
        let hasSpellSheet = character.characterClass.hasSpellSheet
        // O distintivo de sessão fica escondido quando o índice já está
        // aberto — mostrar a mesma sessão duas vezes (na fileira de abas e
        // no corpo do índice) não faz sentido nenhum.
        let showSessionBadge = hasSpellSheet && page != .campaignIndex && page != .spellbook && page != .mySpellbook

        HStack(alignment: .center, spacing: 10) {
            // Item 4 do feedback: cada tela tinha um jeito diferente de
            // voltar (aqui era só dentro do menu ☰, na Campanha era um
            // botão solto) — unificado, sempre visível, sem precisar abrir
            // menu. Mas o `RoundIconButton` normal (44×44, pensado pra
            // ficar sozinho num canto) inflava a altura desta fileira
            // inteira, que é compacta (as abas ao lado têm só 30pt) — daí
            // a reclamação de "tá ocupando todo o espaço". Este aqui usa o
            // mesmo desenho pequeno das abas (`PaperTabIcon`), só que sem
            // estado de seleção.
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Paper.sheet)
                    .frame(width: 30, height: 30)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Back")

            PaperTabIcon(systemImage: "person.text.rectangle.fill", isSelected: page == .record) {
                page = .record
            }
            .accessibilityLabel("Sheet")

            PaperTabIcon(systemImage: "note.text", isSelected: isNotebookSelected) {
                openNotebook()
            }
            .accessibilityLabel("Notebook")

            // Efeitos Ativos (2026-09-28) — pra qualquer classe, por isso
            // fica na fileira principal junto de Sheet/Notebook, e não
            // escondida no menu ☰ com Sessions/Spellbook (que só existem
            // pra quem tem ficha de magia).
            PaperTabIcon(systemImage: "sparkles", isSelected: page == .effects,
                        isGlowing: character.hasActiveEffects) {
                page = .effects
            }
            .accessibilityLabel("Active Effects")

            // Só a sessão ativa (a de hoje) fica na fileira — sessões
            // anteriores não somem, só passam a ficar a um toque de
            // distância dentro do menu ☰ (o índice já lista todas).
            if showSessionBadge, let campaignBinding, let active = activeSessionForStrip {
                SessionBadge(
                    session: active,
                    color: campaignBinding.wrappedValue.sessionColor(active),
                    // Só fica com a borda/tamanho de "selecionado" enquanto
                    // a folha de magias dessa sessão está realmente aberta
                    // — `expandedSessionID` sozinho só decide QUAL sessão
                    // aparece aqui (ver `activeSessionForStrip`), não deve
                    // deixar o distintivo "preso" marcado depois que a
                    // pessoa sai pra outra aba.
                    isSelected: isShowingSheet(in: active),
                    action: { selectSession(active) }
                )
                .accessibilityLabel(active.title.isEmpty ? "Current session" : active.title)
            }

            Spacer(minLength: 0)

            // Menu ☰: um botão simples, sem caixa — o padrão de "mais opções"
            // do próprio iOS. Reúne só o que não é consultado toda hora
            // (índice de sessões passadas, Grimório do Clérigo, ir pra
            // capa) — "voltar" saiu daqui e virou o botão fixo acima, que
            // é usado o tempo todo.
            Menu {
                Button {
                    popToRoot()
                } label: {
                    Label("Home", systemImage: "house")
                }

                if hasSpellSheet {
                    Divider()
                    Button {
                        page = .campaignIndex
                    } label: {
                        Label("Sessions", systemImage: "tray.full")
                    }
                    Button {
                        page = .spellbook
                    } label: {
                        Label(grimoireMenuLabel, systemImage: "book.closed")
                    }
                    // "My Spellbook" (2026-09-30) — livro PESSOAL de quem
                    // lança magia arcana, distinto do Grimório (base
                    // inteira) acima. Existe pra Mago e, desde 2026-09-30,
                    // pra Bardo também (mesmo livro reaproveitado — ver
                    // `CharacterClass.isArcaneCaster`); Clérigo não aprende
                    // magia, tem acesso direto pela esfera.
                    if character.characterClass.isArcaneCaster {
                        Button {
                            page = .mySpellbook
                        } label: {
                            Label("My Spellbook", systemImage: "text.book.closed")
                        }
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 21, weight: .regular))
                    .foregroundStyle(Paper.sheet)
                    .frame(width: 30, height: 30)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .onChange(of: page) { _, newPage in
            // O distintivo de sessão sempre acompanha a folha aberta, mesmo
            // quando ela foi aberta por outro caminho (índice, swipe).
            if case .spells(let id) = newPage,
               let sheet = character.spellSheets.first(where: { $0.id == id }),
               let sessionID = sheet.sessionID {
                expandedSessionID = sessionID
            }
        }
    }

    /// Rótulo do item "Grimoire" no menu ☰ — três classes, três nomes
    /// (2026-09-30: Bardo entrou ao lado de Mago/Clérigo, mesma base
    /// arcana — ver `CharacterClass.isArcaneCaster`).
    private var grimoireMenuLabel: String {
        switch character.characterClass {
        case .mage: return "Mage Grimoire"
        case .bard: return "Bard Grimoire"
        default: return "Priest Spellbook"
        }
    }

    /// A única sessão que aparece na fileira — a que está expandida (se o
    /// jogador tocou nela) ou, por padrão, a mais recente ainda aberta.
    /// Sessões antigas não desaparecem da campanha, só não ficam mais
    /// disputando espaço aqui — o Campaign Index (agora dentro do ☰) lista
    /// todas elas.
    private var activeSessionForStrip: Session? {
        let open = (campaignBinding?.wrappedValue.sessions ?? []).filter { !$0.isArchived }
        if let expandedSessionID, let match = open.first(where: { $0.id == expandedSessionID }) {
            return match
        }
        return open.max { $0.date < $1.date }
    }

    private var isNotebookSelected: Bool {
        if case .notebook = page { return true }
        return false
    }

    /// Toca a aba: se já estiver no caderno, não mexe em nada (mantém a
    /// folha aberta); senão pula pra folha mais recente, ou pro estado
    /// vazio se ainda não existir nenhuma.
    private func openNotebook() {
        if case .notebook = page { return }
        let firstID = campaignBinding?.wrappedValue.notebookEntries.sorted { $0.date < $1.date }.first?.id
        page = .notebook(firstID)
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

    /// Sempre navega num único toque — se este personagem ainda não tem
    /// nenhuma folha nesta sessão (uma sessão criada por outro personagem
    /// do elenco, por exemplo), cria a primeira folha dele na hora, em vez
    /// de só marcar a sessão como "expandida" sem sair do lugar (o que
    /// antes exigia ir pelo índice de sessões pra conseguir abrir).
    private func selectSession(_ session: Session) {
        expandedSessionID = session.id
        if let latest = daySheets(in: session).max(by: { $0.date < $1.date }) {
            page = .spells(latest.id)
            return
        }
        let sheetID = character.startSpellSheet(sessionID: session.id, title: "Day 1")
        page = .spells(sheetID)
    }
}

/// Um distintivo redondo pra sessão ativa — o ícone substitui o rótulo de
/// texto que a divisória tinha antes; a cor da sessão (a mesma usada em
/// todo canto do app) continua sendo o jeito principal de reconhecê-la.
private struct SessionBadge: View {
    let session: Session
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle().fill(color)
                Circle().stroke(Paper.sheet.opacity(0.85), lineWidth: isSelected ? 2 : 1)
                Image(systemName: "flag.fill")
                    .font(.system(size: isSelected ? 12 : 10, weight: .medium))
                    .foregroundStyle(Paper.ink.opacity(0.78))
            }
            .frame(width: isSelected ? 32 : 26, height: isSelected ? 32 : 26)
            .shadow(color: Color.black.opacity(isSelected ? 0.3 : 0), radius: 3, y: 1.5)
            // O círculo desenhado (26-32pt) é bem menor que os 44×44pt
            // recomendados pra alvo de toque — `clipShape`/o círculo em si
            // limitam a área que realmente responde ao toque à forma
            // desenhada, então um toque um pouco fora do centro (nas
            // "pontas" do círculo pequeno) simplesmente não registrava,
            // dando a impressão de precisar tocar várias vezes.
            .frame(minWidth: 44, minHeight: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.78), value: isSelected)
    }
}

/// Os dias de uma sessão (ou as páginas do caderno) — contas de tinta
/// enfiadas numa linha de costura pontilhada, como as folhas de um caderno
/// costurado à mão (um "signature" de encadernação). Cada dia é um pingo
/// redondo com o número dentro; o aberto cresce, ganha tinta cheia e
/// sombra, os outros ficam pequenos e ocos, todos pendurados na mesma
/// linha. Por baixo, discretamente, agora aparece o nome da SESSÃO à qual
/// esses dias pertencem — não mais o título da própria folha do dia (esse
/// já aparece de novo, maior, junto do nome do personagem logo abaixo; dois
/// rótulos com a mesma informação eram redundância à toa). Mora dentro do
/// próprio escopo da Priest Spell Sheet (não mais na fileira de abas
/// global), com um pingo "+" no fim da linha pra criar o próximo dia.
struct DayThreadRow: View {
    let sheets: [SpellSheet]
    let currentID: UUID?
    let subtitle: String?
    let onSelect: (SpellSheet) -> Void
    let onDelete: (SpellSheet) -> Void
    let canDelete: Bool
    let onAdd: () -> Void

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

                Button(action: onAdd) {
                    AddBeadLabel()
                }
                .buttonStyle(.plain)
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

            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(Paper.printedItalic(10.5))
                    .foregroundStyle(Paper.inkSoft)
                    .padding(.leading, 3)
            }
        }
    }
}

/// A ficha (ou uma sessão inteira) apareceu antes nesta struct — mantida
/// pública pra ser reaproveitada pela linha de páginas do Notebook também.
struct InkDayBead: View {
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

/// O "pingo" de adicionar — mesmo tamanho/lugar dos números, mas tracejado
/// e com um "+" em vez de dígito, pra não ser confundido com um dia de
/// verdade. Só o desenho; quem decide o gesto (Button simples ou Menu, no
/// caso do caderno) é quem usa.
struct AddBeadLabel: View {
    var body: some View {
        ZStack {
            Circle().fill(Paper.sheet.opacity(0.35))
            Circle().stroke(Paper.inkSoft, style: StrokeStyle(lineWidth: 1.3, dash: [2.5, 3]))
            Text("+")
                .font(Paper.hand(15))
                .foregroundStyle(Paper.inkSoft)
        }
        .frame(width: 22, height: 22)
    }
}

/// Uma aba da fileira de chrome: só o ícone, sem moldura — quando
/// selecionada vira uma pequena "lasca" de pergaminho, ecoando a aba de
/// papel que existia antes, só que iconificada.
private struct PaperTabIcon: View {
    let systemImage: String
    let isSelected: Bool
    /// Brilho PERSISTENTE (não depende de estar selecionada) — pedido do
    /// usuário (2026-09-28): o ícone de Efeitos Ativos ("✨") deve
    /// continuar brilhando enquanto houver algum efeito ativo, pra nunca
    /// esquecer um ligado numa aba que não é a que está aberta agora.
    var isGlowing: Bool = false
    let action: () -> Void
    // Fase 4 do plano: a fileira de abas estava "morta" — trocava de cor
    // e só. Agora um toque dá um salto elástico curto no ícone tocado, e a
    // aba selecionada ganha um brilho de brasa sutil por baixo — reforça
    // qual folha está aberta sem precisar de texto nenhum a mais.
    @State private var bounce = false

    var body: some View {
        Button(action: {
            action()
            // Bug do v0.50: o retorno (bounce = false) tava agendado num
            // DispatchQueue com atraso FIXO (0.16s) que corria por cima da
            // animação de crescimento (~0.22s de resposta) antes dela
            // terminar — as duas ficavam competindo pelo mesmo valor ao
            // mesmo tempo e o resultado líquido era quase zero, por isso
            // "nada mudava visualmente". Troquei pelo `completion:` do
            // `withAnimation` (iOS 17+), que só dispara o encolhimento
            // depois que o crescimento realmente terminou — sem corrida.
            withAnimation(.spring(response: 0.2, dampingFraction: 0.45)) {
                bounce = true
            } completion: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    bounce = false
                }
            }
        }) {
            Image(systemName: systemImage)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? Paper.chrome : (isGlowing ? Ember.glow : Paper.sheet))
                .frame(width: 38, height: 30)
                .background(isSelected ? Paper.sheet : Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .shadow(color: (isSelected || isGlowing) ? Ember.glow.opacity(0.7) : .clear,
                        radius: (isSelected || isGlowing) ? 6 : 0)
                .scaleEffect(bounce ? 1.24 : 1.0)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.18), value: isSelected)
    }
}

/// A linha de dias da Priest Spell Sheet, agora vivendo dentro do próprio
/// escopo da folha (não mais na fileira global de abas) — junto com o "+"
/// que cria o próximo dia, que antes era um botão "+ day sheet" solto no
/// topo, visível mesmo em telas onde não fazia sentido nenhum.
private struct SpellSheetBeadRow: View {
    @Binding var character: PlayerCharacter
    let campaignBinding: Binding<Campaign>?
    @Binding var page: CharacterSheetView.SheetPage
    let currentSheetID: UUID

    var body: some View {
        if session != nil {
            DayThreadRow(
                sheets: daySheets,
                currentID: currentSheetID,
                subtitle: sessionLabel,
                onSelect: { sheet in page = .spells(sheet.id) },
                onDelete: deleteSheet,
                canDelete: character.spellSheets.count > 1,
                onAdd: newSheet
            )
            .padding(.horizontal, 18)
            .padding(.top, 12)
            .padding(.bottom, 2)
        }
    }

    private var session: Session? {
        guard let sheet = character.spellSheets.first(where: { $0.id == currentSheetID }) else { return nil }
        return campaignBinding?.wrappedValue.sessions.first { $0.id == sheet.sessionID }
    }

    private var daySheets: [SpellSheet] {
        guard let session else { return [] }
        return character.spellSheets
            .filter { $0.sessionID == session.id }
            .sorted { $0.date < $1.date }
    }

    /// O nome da SESSÃO (não mais o título da folha do dia, que já aparece
    /// de novo logo abaixo junto do nome do personagem) — quando a sessão
    /// não tem título próprio, cai pra data curta, igual ao distintivo da
    /// fileira de abas e ao Campaign Index.
    private var sessionLabel: String? {
        guard let session else { return nil }
        if !session.title.isEmpty { return session.title }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: session.date)
    }

    /// Nova folha herda o que estava preparado no dia anterior da mesma
    /// sessão, com os slots já zerados — que é o que o repouso faz na
    /// regra — mas a quantidade de slots em si vem de "Spell Slots" na
    /// ficha.
    private func newSheet() {
        guard let session else { return }
        // Regra única em `Store/SpellSheetRules.swift`; o "+" herda do
        // último dia DESTA sessão, como sempre fez.
        let sheetID = character.startSpellSheet(sessionID: session.id,
                                                title: "Day \(daySheets.count + 1)",
                                                continuingFrom: daySheets.last)
        page = .spells(sheetID)
    }

    /// Apaga uma folha (pelo menu de contexto de um pingo de dia). Sempre
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
}

/// As bolinhas da aba Sheet — mesma família visual da linha de dias da
/// Priest Spell Sheet e das páginas do Notebook, só que aqui marcando as 3
/// ou 4 páginas FIXAS da ficha (Ficha oficial, Equipment/Movement/XP,
/// Character Description e, pra quem tem magia, as tabelas de referência
/// do Clérigo). Sem pingo "+" — essas páginas não se criam nem se apagam.
private struct RecordSheetBeadRow: View {
    @Binding var currentIndex: Int
    let maxPageIndex: Int

    var body: some View {
        HStack(spacing: 13) {
            ForEach(0...maxPageIndex, id: \.self) { index in
                InkDayBead(number: index + 1, isSelected: index == currentIndex) {
                    currentIndex = index
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
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 2)
    }
}

// MARK: - Folha 1: a ficha oficial

/// A folha oficial de verdade — não painéis de app empilhados, e sim a
/// mesma grade de caixinhas com moldura fina que o PDF de referência usa
/// (`MI_ADDCharSheet46.pdf`, página 1). Cada seção abaixo desenha sua
/// própria tabela com `Rectangle().stroke(...)`, célula a célula, pra dar
/// a sensação de ficha impressa de verdade — não de app com cards.
struct OfficialRecordSheet: View {
    @Binding var character: PlayerCharacter
    var campaignBinding: Binding<Campaign>? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RecordHeaderForm(character: $character, campaignBinding: campaignBinding)

            // Sempre lado a lado, como no PDF — Jogadas de Proteção ficou
            // compacta (240pt) de propósito pra caber ao lado de Atributos
            // mesmo com a tela mais estreita, em vez de empilhar.
            HStack(alignment: .top, spacing: 14) {
                AbilityScoresForm(character: $character)
                    .frame(maxWidth: .infinity)
                SavingThrowsForm(character: $character)
                    .frame(width: 240)
            }

            CombatForm(character: $character)
            Thac0TargetForm(character: $character)
            CombatModifiersForm(character: $character)
            WeaponCombatForm(character: $character)
            ProficienciesForm(character: $character, campaignBinding: campaignBinding)
            if character.characterClass.hasThievingSkills {
                ThievingSkillsForm(character: $character)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
    }
}

// MARK: - Aba Sheet: pager de 2 páginas

/// Folheia as duas páginas da aba Sheet com o mesmo curl de página de
/// verdade da Priest Spell Sheet (`DayPagerView`) — só que aqui são sempre
/// exatamente duas páginas fixas (0 e 1), não uma lista dinâmica, então o
/// dataSource é indexado por Int em vez de UUID.
struct RecordSheetPagerView: UIViewControllerRepresentable {
    @Binding var character: PlayerCharacter
    var campaignBinding: Binding<Campaign>? = nil
    @Binding var currentIndex: Int

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pager = UIPageViewController(transitionStyle: .pageCurl,
                                         navigationOrientation: .horizontal,
                                         options: nil)
        pager.dataSource = context.coordinator
        pager.delegate = context.coordinator
        pager.view.backgroundColor = .clear
        if let first = context.coordinator.makePage(for: currentIndex) {
            pager.setViewControllers([first], direction: .forward, animated: false)
        }
        return pager
    }

    func updateUIViewController(_ pager: UIPageViewController, context: Context) {
        context.coordinator.parent = self
        guard !context.coordinator.isTransitioning else { return }

        let visibleIndex = (pager.viewControllers?.first as? RecordSheetPageController)?.index

        if visibleIndex != currentIndex {
            guard let target = context.coordinator.makePage(for: currentIndex) else { return }
            let forward = currentIndex > (visibleIndex ?? 0)
            context.coordinator.isTransitioning = true
            pager.setViewControllers([target], direction: forward ? .forward : .reverse,
                                     animated: true) { _ in
                context.coordinator.isTransitioning = false
            }
        } else if let visible = pager.viewControllers?.first as? RecordSheetPageController {
            visible.rootView = pageContent(for: visible.index)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    /// A 3ª página (Character Description) existe pra todo mundo. A 4ª
    /// (tabelas de referência do Clérigo) só existe pra quem tem ficha de
    /// magia — as outras classes ficam com as 3 páginas fixas (Ficha +
    /// Equipment/Movement/Experience + Character Description). Ver
    /// `CharacterClass.recordSheetPageCount` — mesma conta que
    /// `RecordSheetBeadRow` usa, pra não voltar a divergir.
    fileprivate var maxPageIndex: Int {
        character.characterClass.recordSheetPageCount - 1
    }

    fileprivate func pageContent(for index: Int) -> AnyView {
        switch index {
        case 0:
            return AnyView(ScrollView {
                OfficialRecordSheet(character: $character, campaignBinding: campaignBinding).padding(18)
            })
        case 1:
            return AnyView(ScrollView { RecordSheetPageTwo(character: $character).padding(18) })
        case 2:
            return AnyView(ScrollView { CharacterDescriptionPage(character: $character).padding(18) })
        default:
            // A 4ª página muda de conteúdo conforme a classe (2026-09-29,
            // estendido 2026-09-30 pros grupos Warrior e Rogue) — Mago
            // ganha as tabelas dele (`WizardReferencePage`), o grupo
            // Warrior (Fighter/Paladin/Ranger) ganha `WarriorReferencePage`,
            // o grupo Rogue (Thief/Bard/Ninja) ganha `RogueReferencePage`,
            // e o resto (Clérigo/Druida) fica com as do Clérigo.
            // `recordSheetPageCount`/`hasReferencePage` já garantem que só
            // quem tem alguma das quatro chega até aqui.
            if character.characterClass == .mage {
                return AnyView(ScrollView { WizardReferencePage(character: character).padding(18) })
            }
            if character.characterClass.proficiencyGroup == "Warrior" {
                return AnyView(ScrollView { WarriorReferencePage(character: character).padding(18) })
            }
            if character.characterClass.proficiencyGroup == "Rogue" {
                return AnyView(ScrollView { RogueReferencePage(character: character).padding(18) })
            }
            return AnyView(ScrollView { ClericReferencePage(character: character).padding(18) })
        }
    }

    final class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: RecordSheetPagerView
        var isTransitioning = false

        init(_ parent: RecordSheetPagerView) {
            self.parent = parent
        }

        fileprivate func makePage(for index: Int) -> RecordSheetPageController? {
            guard (0...parent.maxPageIndex).contains(index) else { return nil }
            return RecordSheetPageController(index: index, rootView: parent.pageContent(for: index))
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let current = (viewController as? RecordSheetPageController)?.index else { return nil }
            return makePage(for: current - 1)
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let current = (viewController as? RecordSheetPageController)?.index else { return nil }
            return makePage(for: current + 1)
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                willTransitionTo pendingViewControllers: [UIViewController]) {
            isTransitioning = true
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
            isTransitioning = false
            guard completed,
                  let visible = pageViewController.viewControllers?.first as? RecordSheetPageController
            else { return }
            parent.currentIndex = visible.index
            visible.rootView = parent.pageContent(for: visible.index)
        }
    }
}

private final class RecordSheetPageController: UIHostingController<AnyView> {
    let index: Int

    init(index: Int, rootView: AnyView) {
        self.index = index
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Aba Sheet, página 2 (Equipment / Movement / Experience do PDF)

/// A segunda folha da ficha oficial: a tabela de Equipment, Movement,
/// Encumbrance, Experience, Level Changes, Magic Items e Treasure/Other
/// Possessions — igual ao layout de duas colunas do PDF.
private struct RecordSheetPageTwo: View {
    @Binding var character: PlayerCharacter

    // Item 10 do pedido do usuário (2026-09-24): "Magic Items (armadura
    // mágica) não muda o AC" — precisa da base pra ler `defenseBonus.
    // acBonus` de um item recém-ligado na lista "Magic Items" logo abaixo.
    @EnvironmentObject private var magicItemDatabase: MagicItemDatabase

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ArmorBlock(character: $character)
            Page2EquipmentForm(character: $character)

            HStack(alignment: .top, spacing: 14) {
                VStack(alignment: .leading, spacing: 14) {
                    MovementForm(character: $character)
                    EncumbranceForm(character: $character)
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 14) {
                    ExperienceForm(character: $character)
                    LevelChangesForm(character: $character)
                }
                .frame(maxWidth: .infinity)
            }

            QuantityListBlock(title: "Magic Items", items: $character.page2MagicItems.orInit([]),
                               usesMagicItemDatabase: true)
            QuantityListBlock(title: "Treasure / Other Possessions",
                              items: $character.page2TreasureItems.orInit([]))

            HStack(alignment: .top, spacing: 14) {
                TreasureBlock(treasure: $character.treasure)
                    .frame(maxWidth: .infinity)
                ListBlock(title: "Languages", items: $character.languages)
                    .frame(maxWidth: .infinity)
                AlliesBlock(character: $character)
                    .frame(maxWidth: .infinity)
            }

            WildTalentBlock(character: $character)
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
        // A aba Equipment sumiu — antes de morrer, ela guardava a lista de
        // itens e os "Magic Items" numa forma mais simples (só texto). Essa
        // migração roda uma vez só (checa se o destino novo ainda está
        // vazio) pra ninguém perder o que já tinha escrito lá.
        .onAppear {
            migrateFromOldEquipmentTab()
        }
        // Item 10: um item de Magic Items sendo ligado/trocado/removido
        // (matchedItemID mudando) pode mudar o `acBonus` que entra na
        // conta do AC — ver `ConsequenceEngine.recalculateArmorClass`.
        // Dispara em QUALQUER mudança na lista (inclusive quantidade), mas
        // a função só escreve quando o total realmente muda.
        .onChange(of: character.page2MagicItems) { _, _ in
            ConsequenceEngine.recalculateArmorClass(for: &character, magicItemDatabase: magicItemDatabase)
        }
    }

    private func migrateFromOldEquipmentTab() {
        if character.page2Equipment?.isEmpty ?? true, !character.equipment.isEmpty {
            character.page2Equipment = character.equipment.enumerated().map { index, item in
                Page2EquipmentEntry(item: item.name, location: item.note, weight: "", column: index % 2)
            }
        }
        if character.page2MagicItems?.isEmpty ?? true, !character.magicItems.isEmpty {
            character.page2MagicItems = character.magicItems.map { QuantifiedItem(name: $0) }
        }
    }
}

private struct QuantifiedItemRow: View {
    @Binding var entry: QuantifiedItem
    var onDelete: () -> Void

    /// Mesmo padrão visual da Magic Item Spell na Priest Spell Sheet:
    /// pauzinhos primeiro, depois "usado de quantos" — em vez do chip "×N"
    /// separado de antes. `entry.quantity` faz o papel do "maxUses" de lá.
    private var usedCount: Binding<Int> { $entry.usedCount.orDefault(0) }
    private var isExhausted: Bool { entry.quantity > 0 && usedCount.wrappedValue >= entry.quantity }

    var body: some View {
        HStack(spacing: 8) {
            EditableText(value: $entry.name, placeholder: "…", size: 18, underline: false)
                .frame(maxWidth: .infinity, alignment: .leading)

            QuantityControls(quantity: $entry.quantity, usedCount: usedCount, isExhausted: isExhausted)
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

/// Pauzinhos + "usado de quantos" — compartilhado por `QuantifiedItemRow`
/// (Treasure/Other, texto livre) e `MagicItemQuantifiedRow` (Magic Items,
/// nome vira botão pro buscador) pra não duplicar esse pedaço.
private struct QuantityControls: View {
    @Binding var quantity: Int
    var usedCount: Binding<Int>
    var isExhausted: Bool

    var body: some View {
        HStack(spacing: 6) {
            TallyBoard(
                count: usedCount.wrappedValue,
                isExhausted: isExhausted,
                onAdd: { usedCount.wrappedValue += 1 },
                onRemove: {
                    guard usedCount.wrappedValue > 0 else { return }
                    usedCount.wrappedValue -= 1
                }
            )
            Text("\(usedCount.wrappedValue)")
                .font(Paper.hand(15))
                .foregroundStyle(isExhausted ? Paper.redInk : Paper.penInk)
            Text("of")
                .font(Paper.printedItalic(11))
                .foregroundStyle(Paper.inkSoft)
            EditableNumber(value: $quantity, size: 13, lower: 0, upper: 9999)
        }
    }
}

/// Mesma linha de `QuantifiedItemRow` (pauzinhos + "usado de quantos"), mas
/// só pra "Magic Items": o nome vira um botão, igual `Page2EquipmentRow`
/// faz pro Equipment mundano — linha já ligada a um item da base
/// (`matchedItemID`, ou nome batendo exato como fallback pra fichas
/// antigas) abre a descrição num toque, com "change" lá dentro pra trocar;
/// linha vazia ou não-ligada abre o buscador direto, onde também dá pra
/// digitar um nome à mão e usar "as-is" (item caseiro/criado pelo
/// jogador) — pedido do usuário: "buscar os itens da nossa lista recém
/// adicionada, ok? Mas mantendo a opção do jogador imputar o próprio
/// item". Só usada no bloco "Magic Items" — "Treasure / Other Possessions"
/// continua com `QuantifiedItemRow`/texto livre, sem nenhuma mudança.
private struct MagicItemQuantifiedRow: View {
    @Binding var entry: QuantifiedItem
    var onDelete: () -> Void

    @EnvironmentObject private var magicItemDatabase: MagicItemDatabase
    @State private var showDetail = false
    @State private var showPicker = false

    private var usedCount: Binding<Int> { $entry.usedCount.orDefault(0) }
    private var isExhausted: Bool { entry.quantity > 0 && usedCount.wrappedValue >= entry.quantity }

    private var matchedItem: CompendiumMagicItem? {
        if let id = entry.matchedItemID, let match = magicItemDatabase.item(id: id) {
            return match
        }
        guard !entry.name.isEmpty else { return nil }
        return magicItemDatabase.items.first { $0.name == entry.name }
    }

    var body: some View {
        HStack(spacing: 8) {
            Button {
                if matchedItem != nil {
                    showDetail = true
                } else {
                    showPicker = true
                }
            } label: {
                Text(entry.name.isEmpty ? "…" : entry.name)
                    .font(Paper.hand(18))
                    .foregroundStyle(entry.name.isEmpty ? Paper.inkSoft : Paper.penInk)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            QuantityControls(quantity: $entry.quantity, usedCount: usedCount, isExhausted: isExhausted)
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
        .sheet(isPresented: $showDetail) {
            if let matchedItem {
                MagicItemDetailSheet(item: matchedItem, onChangeItem: {
                    showDetail = false
                    DispatchQueue.main.async { showPicker = true }
                })
            }
        }
        .sheet(isPresented: $showPicker) {
            MagicItemPickerSheet(name: $entry.name, matchedItemID: $entry.matchedItemID)
        }
    }
}

/// Igual ao `ListBlock` já usado na aba Equipment, mas com um contador de
/// quantidade por linha e botão de remover — pra "10 poções de cura" caber
/// numa linha só em vez de dez. Fica separado do `ListBlock` (que a aba
/// Equipment também usa) pra não mudar o comportamento dela.
///
/// `usesMagicItemDatabase` troca a linha por `MagicItemQuantifiedRow`
/// (nome vira botão, busca em `MagicItemDatabase`) — só ligado no bloco
/// "Magic Items"; "Treasure / Other Possessions" continua com
/// `QuantifiedItemRow`/texto livre, sem nenhuma mudança de comportamento.
private struct QuantityListBlock: View {
    let title: String
    @Binding var items: [QuantifiedItem]
    var usesMagicItemDatabase: Bool = false

    var body: some View {
        SheetBlock(title: title, trailing: "\(items.count)") {
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    if usesMagicItemDatabase {
                        MagicItemQuantifiedRow(entry: $items[index], onDelete: {
                            items.remove(at: index)
                        })
                    } else {
                        QuantifiedItemRow(entry: $items[index], onDelete: {
                            items.remove(at: index)
                        })
                    }
                }
                AddLineButton(title: "add") {
                    items.append(QuantifiedItem())
                }
            }
        }
    }
}

private struct Page2EquipmentRow: View {
    @Binding var entry: Page2EquipmentEntry
    var onDelete: () -> Void

    // Mesmo padrão de "tocar no nome" de `ProficiencyFormRow`/
    // `WeaponFormRow`: linha já ligada a um item da base (`matchedItemID`,
    // ou nome batendo exato como último recurso pra fichas salvas antes
    // disso existir) abre a descrição (custo/peso) num toque, com "change"
    // lá dentro pra trocar; linha vazia ou não-ligada (item caseiro, texto
    // digitado à mão) abre o seletor direto.
    @EnvironmentObject private var itemDatabase: MundaneItemDatabase
    @State private var showDetail = false
    @State private var showPicker = false

    private var matchedItem: MundaneItem? {
        if let id = entry.matchedItemID, let match = itemDatabase.item(id: id) {
            return match
        }
        guard !entry.item.isEmpty else { return nil }
        return itemDatabase.items.first { $0.name == entry.item }
    }

    var body: some View {
        HStack(spacing: 0) {
            Button {
                if matchedItem != nil {
                    showDetail = true
                } else {
                    showPicker = true
                }
            } label: {
                Text(entry.item.isEmpty ? "…" : entry.item)
                    .font(Paper.printed(13))
                    .foregroundStyle(entry.item.isEmpty ? Paper.inkSoft : Paper.ink)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)
            EditableText(value: $entry.location, placeholder: "—", size: 12, underline: false)
                .frame(width: 56)
            EditableText(value: $entry.weight, placeholder: "—", size: 12, underline: false)
                .frame(width: 36)
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { DottedRule() }
        .sheet(isPresented: $showDetail) {
            if let matchedItem {
                MundaneItemDetailSheet(item: matchedItem, onChangeItem: {
                    showDetail = false
                    DispatchQueue.main.async { showPicker = true }
                })
            }
        }
        .sheet(isPresented: $showPicker) {
            MundaneItemPickerSheet(entry: $entry)
        }
    }
}

/// Cada linha guarda sua própria coluna (`Page2EquipmentEntry.column`) em
/// vez de um rodízio calculado pelo índice na lista — apagar uma linha só
/// reindexa o array inteiro, e um rodízio por índice fazia metade das
/// linhas trocarem de coluna a cada remoção. Filtrando pela coluna gravada,
/// apagar uma linha só desloca as linhas abaixo dela NA MESMA coluna, como
/// uma lista normal se comporta.
private struct Page2EquipmentColumn: View {
    let items: Binding<[Page2EquipmentEntry]>
    let column: Int

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Item").frame(maxWidth: .infinity, alignment: .leading)
                Text("Location").frame(width: 64)
                Text("Wt").frame(width: 40)
                Text("").frame(width: 24)
            }
            .font(Paper.printed(11))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .foregroundStyle(Paper.ink)
            .padding(4)
            .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1) }

            ForEach(indices, id: \.self) { index in
                Page2EquipmentRow(entry: items[index], onDelete: {
                    items.wrappedValue.remove(at: index)
                })
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.1))
    }

    private var indices: [Int] {
        items.wrappedValue.indices.filter { (items.wrappedValue[$0].column ?? 0) == column }
    }
}

private struct Page2EquipmentForm: View {
    @Binding var character: PlayerCharacter

    private var items: Binding<[Page2EquipmentEntry]> { $character.page2Equipment.orInit([]) }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Equipment")
            HStack(alignment: .top, spacing: 10) {
                Page2EquipmentColumn(items: items, column: 0)
                Page2EquipmentColumn(items: items, column: 1)
            }
            AddLineButton(title: "add item") {
                var entry = Page2EquipmentEntry()
                entry.column = leastFilledColumn()
                items.wrappedValue.append(entry)
            }
            .padding(.horizontal, 4)

            HStack(spacing: 18) {
                Page2FooterField(label: "Total Weight", value: $character.page2TotalWeight.orDefault(""))
                Page2FooterField(label: "Encumbrance",
                                 value: $character.page2EquipmentEncumbrance.orDefault(""))
                Page2FooterField(label: "Movement Rate", value: $character.page2MovementRate.orDefault(""))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 4)
        }
        // 10 linhas em branco (5 por coluna) na primeira vez que a página
        // abre — gravado de verdade, mesmo padrão do CombatModifiersForm/
        // ProficienciesForm. Fichas que já tinham linhas SEM coluna gravada
        // (versão anterior, com rodízio por índice) recebem a coluna uma
        // única vez aqui, preservando a distribuição que já apareciam.
        .onAppear {
            if character.page2Equipment?.isEmpty ?? true {
                character.page2Equipment = (0..<10).map { i in
                    var entry = Page2EquipmentEntry()
                    entry.column = i % 2
                    return entry
                }
            } else if character.page2Equipment?.contains(where: { $0.column != nil }) == false {
                for index in character.page2Equipment!.indices {
                    character.page2Equipment![index].column = index % 2
                }
            }
        }
    }

    private func leastFilledColumn() -> Int {
        let count0 = items.wrappedValue.filter { ($0.column ?? 0) == 0 }.count
        let count1 = items.wrappedValue.filter { ($0.column ?? 0) == 1 }.count
        return count0 <= count1 ? 0 : 1
    }
}

private struct Page2FooterField: View {
    let label: String
    @Binding var value: String

    var body: some View {
        HStack(spacing: 4) {
            FieldLabel(text: label)
            EditableText(value: $value, placeholder: "—", size: 14, underline: true)
                .frame(width: 64)
        }
    }
}

private struct MovementForm: View {
    @Binding var character: PlayerCharacter

    private var rates: Binding<MovementRates> { $character.page2Movement.orInit(MovementRates()) }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FormSectionTitle(text: "Movement")
            // Duas colunas, como no PDF — melhor aproveitamento do espaço
            // do que uma lista só de seis linhas.
            HStack(alignment: .top, spacing: 10) {
                VStack(spacing: 0) {
                    CombatLine(label: "Base", value: rates.base)
                        // Item 8 do pedido do usuário (2026-09-24):
                        // `RaceOption.apply(to:)` já preenche "Base"
                        // sozinho ao escolher a raça e já marca
                        // `markRecentAutoChange("page2MovementBase")` —
                        // só faltava este `.changeFlash` do lado da view
                        // pra consumir o aviso.
                        .changeFlash(character: $character, key: "page2MovementBase")
                    CombatLine(label: "Jog (x2)", value: rates.jog)
                    CombatLine(label: "Run (x3)", value: rates.runX3)
                    CombatLine(label: "Run (x4)", value: rates.runX4)
                }
                .frame(maxWidth: .infinity)

                VStack(spacing: 0) {
                    CombatLine(label: "Run (x5)", value: rates.runX5)
                    CombatLine(label: "Day", value: rates.day)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(10)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
    }
}

private struct EncumbranceRowView: View {
    let title: String
    @Binding var row: EncumbranceRow

    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(Paper.printed(11))
                .foregroundStyle(Paper.ink)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .frame(width: 62, alignment: .leading)
            FormCell(value: $row.weightCarried, size: 12)
            FormCell(value: $row.moveRate, size: 12)
            FormCell(value: $row.attackPenalty, size: 12)
            FormCell(value: $row.acPenalty, size: 12)
        }
    }
}

private struct EncumbranceForm: View {
    @Binding var character: PlayerCharacter

    private var table: Binding<EncumbranceTable> {
        $character.page2EncumbranceTable.orInit(EncumbranceTable())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FormSectionTitle(text: "Encumbrance", ruleID: "phb_ch06_encumbrance")

            HStack(spacing: 4) {
                Text("").frame(width: 62)
                Text("Wt").font(Paper.printed(11)).frame(maxWidth: .infinity)
                Text("Move").font(Paper.printed(11)).frame(maxWidth: .infinity)
                Text("Atk").font(Paper.printed(11)).frame(maxWidth: .infinity)
                Text("AC").font(Paper.printed(11)).frame(maxWidth: .infinity)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .foregroundStyle(Paper.inkSoft)

            EncumbranceRowView(title: "Light", row: table.light)
            EncumbranceRowView(title: "Moderate", row: table.moderate)
            EncumbranceRowView(title: "Heavy", row: table.heavy)
            EncumbranceRowView(title: "Severe", row: table.severe)
        }
        .padding(10)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
        // Os valores de penalidade já são regra fixa do livro — pré-
        // preenchidos uma vez, do mesmo jeito que o resto da ficha faz com
        // linhas em branco padrão, mas continuam editáveis (kit pode mudar).
        .onAppear {
            if character.page2EncumbranceTable == nil {
                var seeded = EncumbranceTable()
                seeded.light.attackPenalty = "–"
                seeded.light.acPenalty = "–"
                seeded.moderate.attackPenalty = "-1"
                seeded.moderate.acPenalty = "–"
                seeded.heavy.attackPenalty = "-2"
                seeded.heavy.acPenalty = "+1"
                seeded.severe.moveRate = "1"
                seeded.severe.attackPenalty = "-4"
                seeded.severe.acPenalty = "+3"
                character.page2EncumbranceTable = seeded
            }
        }
    }
}

/// Uma caixa grande, rótulo em cima e valor embaixo — como as duas caixas
/// de destaque do PDF (Total XPs / XPs Needed for Next Level). Os números
/// aqui chegam na casa das centenas de milhões, então precisam de bem mais
/// espaço que uma linha comum de `CombatLine`.
private struct ExperienceHeaderCell: View {
    let label: String
    @Binding var value: String

    var body: some View {
        VStack(spacing: 3) {
            Text(label.uppercased())
                .font(Paper.printed(10))
                .tracking(0.6)
                .foregroundStyle(Paper.inkSoft)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
            EditableText(value: $value, placeholder: "0", size: 21, underline: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, minHeight: 60)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
    }
}

private struct ExperienceForm: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Experience")

            HStack(spacing: 6) {
                ExperienceHeaderCell(label: "Total XPs", value: totalXPsBinding)
                ExperienceHeaderCell(label: "XPs Needed for Next Level",
                                     value: $character.xpNeededNextLevel.orDefault(""))
                    .changeFlash(character: $character, key: "xpNeededNextLevel")
            }
            .padding(.bottom, 2)

            if let note = ExperienceProgressionTable.note(for: character.characterClass, level: character.level) {
                Text(note)
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
                    .fixedSize(horizontal: false, vertical: true)
            }

            CombatLine(label: "Kit Modifier", value: $character.xpKitModifier.orDefault(""))
            CombatLine(label: "Ability Bonus", value: $character.xpAbilityBonus.orDefault(""))
            CombatLine(label: "Subrace Modifier", value: $character.xpSubraceModifier.orDefault(""))
            CombatLine(label: "Level Limit", value: $character.xpLevelLimit.orDefault(""))
        }
        .padding(10)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
        // Preenche sozinho a partir da tabela de progressão por classe
        // (`ExperienceProgressionTable`, cópia fiel das Tables 14/20/23/25
        // já no corpus de regras) — pedido do usuário: "em XP needed for
        // the next level, podemos preencher automaticamente, dado que
        // sabemos esta tabela por classe, certo?". Continua um campo de
        // texto normal (não travado): o jogador pode sobrescrever à mão se
        // a mesa usar uma variante de regra diferente.
        //
        // A conta de verdade agora mora em `PlayerCharacter.
        // refreshXPNeededNextLevel()` e é chamada direto de onde nível/
        // classe são editados de verdade (`RecordHeaderForm`, página 1) —
        // esta página (`ExperienceForm`, página 2) só recalcula de novo no
        // `onAppear` como uma segunda garantia (ex.: ficha antiga sem o
        // campo preenchido ainda), porque a página 2 vive dentro de um
        // `UIPageViewController` que só atualiza a página VISÍVEL — um
        // `onChange` aqui não disparava enquanto o jogador estava vendo a
        // página 1 (bug relatado pelo usuário: "ao subir ou descer de
        // nível este campo não é atualizado").
        .onAppear { character.refreshXPNeededNextLevel() }
    }

    /// A ficha já guarda o total de XP em `character.experience` (também
    /// editado na aba Equipment) — este campo só espelha o mesmo valor, sem
    /// criar um segundo contador que poderia divergir.
    private var totalXPsBinding: Binding<String> {
        Binding(
            get: { "\(character.experience)" },
            set: { newValue in character.experience = Int(newValue) ?? character.experience }
        )
    }
}

private struct LevelChangeRowView: View {
    let title: String
    @Binding var row: LevelChangeRow
    /// Item 9 do pedido do usuário (2026-09-24): botão "?" pra consultar
    /// a tabela cheia do livro (Table 53/60) sem sair da ficha — `nil`
    /// nas linhas de Proficiências, que não têm regra embutida pra
    /// apontar. Ver `ConsequenceEngine.levelChangeRuleIDs`.
    var ruleID: String? = nil

    var body: some View {
        HStack(spacing: 4) {
            HStack(spacing: 3) {
                Text(title)
                    .font(Paper.printed(11))
                    .foregroundStyle(Paper.ink)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                if let ruleID {
                    RuleLinkButton(ruleID: ruleID)
                }
            }
            .frame(width: 108, alignment: .leading)
            EditableText(value: $row.by, placeholder: "—", size: 13, underline: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .frame(height: 26)
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
            EditableText(value: $row.atLevels, placeholder: "—", size: 13, underline: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .frame(height: 26)
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
        }
    }
}

private struct LevelChangesForm: View {
    @Binding var character: PlayerCharacter

    private var table: Binding<LevelChangesTable> { $character.levelChanges.orInit(LevelChangesTable()) }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FormSectionTitle(text: "Level Changes")

            HStack(spacing: 4) {
                Text("").frame(width: 108)
                Text("By").font(Paper.printed(10)).frame(maxWidth: .infinity)
                Text("At Levels").font(Paper.printed(10)).frame(maxWidth: .infinity)
            }
            .foregroundStyle(Paper.inkSoft)

            // Item 9 do pedido do usuário (2026-09-24): estas duas linhas
            // são preenchidas sozinhas por `ConsequenceEngine.refreshLevelChanges`
            // (Tables 53/60 do PHB) — o `.changeFlash` avisa quando isso
            // acontece, e o "?" ao lado do título abre a tabela cheia do
            // livro pra consulta. Proficiências continuam manuais (ver
            // doc de `refreshLevelChanges` pro porquê), então não piscam
            // nem têm "?".
            LevelChangeRowView(title: "THAC0", row: table.thac0, ruleID: ConsequenceEngine.levelChangeRuleIDs["thac0"])
                .changeFlash(character: $character, key: "levelChanges")
            LevelChangeRowView(title: "Saving Throws", row: table.savingThrows, ruleID: ConsequenceEngine.levelChangeRuleIDs["savingThrows"])
                .changeFlash(character: $character, key: "levelChanges")
            LevelChangeRowView(title: "Weapon Proficiencies", row: table.weaponProficiencies)
            LevelChangeRowView(title: "Non-weapon Proficiencies", row: table.nonWeaponProficiencies)
        }
        .padding(10)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
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

// MARK: - Peças de formulário no estilo do PDF (não os cards do resto do app)
//
// A ficha oficial usa moldura fina e título simples, não a tarja escura dos
// blocos "de app" (`SheetBlock`) do resto da tela — é isso que dava a cara
// de planilha que o usuário reclamou. Estas poucas peças reaproveitam o
// papel/tinta do app (`Paper`, `EditableText`, `EditableNumber`), mas
// desenham a grade de caixinhas do PDF célula a célula.

/// Título de seção como no PDF — texto simples centralizado, sem tarja.
private struct FormSectionTitle: View {
    let text: String
    /// Quando presente, mostra o atalho "?" (`RuleLinkButton`) colado na
    /// borda direita do título — a regra correspondente da base embutida
    /// (ver `RulesDatabase`/`Store/EmbeddedRules_*.swift`). `nil` mantém o
    /// título como sempre foi, sem o botão (a maioria das seções não tem
    /// uma regra específica pra apontar).
    var ruleID: String? = nil

    var body: some View {
        Text(text.uppercased())
            .font(Paper.printed(14))
            .tracking(1.4)
            .foregroundStyle(Paper.ink)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 3)
            .overlay(alignment: .trailing) {
                if let ruleID {
                    RuleLinkButton(ruleID: ruleID)
                }
            }
    }
}

/// Uma célula com moldura de verdade — encostando uma na outra elas formam
/// a tabela sozinhas, como as caixinhas impressas do PDF.
private struct FormCell: View {
    var label: String? = nil
    @Binding var value: String
    var size: CGFloat = 14

    var body: some View {
        VStack(spacing: 1) {
            if let label {
                Text(label)
                    .font(.system(size: 9, design: .serif))
                    .foregroundStyle(Paper.inkSoft)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
            }
            Spacer(minLength: 0)
            // Sem frame aqui o botão só respondia ao toque bem em cima do
            // texto (ou de nada, quando a célula estava vazia) — a célula
            // inteira precisa ser tocável, não só onde o valor aparece.
            EditableText(value: $value, placeholder: "—", size: size, underline: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
        .padding(.horizontal, 3)
        .padding(.vertical, 3)
        .frame(maxWidth: .infinity, minHeight: 42)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
    }
}

/// A mesma célula, só que pra um número (a pontuação de um atributo).
private struct FormNumberCell: View {
    @Binding var value: Int
    var lower: Int = -99
    var upper: Int = 99
    /// Verde/vermelho persistente enquanto um Efeito Ativo mexer neste
    /// campo — ver `polarityColor`. `Paper.penInk` (o padrão do
    /// `EditableNumber`) quando não há nada ativo.
    var color: Color = Paper.penInk

    var body: some View {
        EditableNumber(value: $value, size: 22, color: color, lower: lower, upper: upper)
            .frame(minHeight: 42)
            .frame(maxWidth: .infinity)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
    }
}

/// O escudo da Classe de Armadura — o único desenho "de verdade" da ficha
/// oficial, não um ícone genérico de sistema.
private struct ShieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width, h = rect.height
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h * 0.5))
        path.addQuadCurve(to: CGPoint(x: w / 2, y: h), control: CGPoint(x: w, y: h * 0.92))
        path.addQuadCurve(to: CGPoint(x: 0, y: h * 0.5), control: CGPoint(x: 0, y: h * 0.92))
        path.closeSubpath()
        return path
    }
}

private struct ArmorClassShield: View {
    @Binding var armorClass: Int
    /// Verde/vermelho persistente enquanto um Efeito Ativo mexer na CA —
    /// ver `polarityColor`.
    var color: Color = Paper.penInk

    var body: some View {
        VStack(spacing: 3) {
            Text("ARMOR").font(Paper.printed(11)).tracking(1.5)
            ZStack {
                ShieldShape().stroke(Paper.ink, lineWidth: 1.6)
                EditableNumber(value: $armorClass, size: 28, color: color, lower: -10, upper: 10)
                    .padding(.top, 6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
            }
            .frame(width: 76, height: 84)
            Text("CLASS").font(Paper.printed(11)).tracking(1.5)
        }
        .foregroundStyle(Paper.ink)
    }
}

// MARK: - Cabeçalho da ficha

private struct RecordHeaderForm: View {
    @Binding var character: PlayerCharacter
    var campaignBinding: Binding<Campaign>? = nil
    /// Pro atalho "?" ao lado do campo "Patron Deity / Religion" — abre
    /// `DeityDetailSheet` quando o nome digitado bate (match exato, após
    /// `Fuzzy.normalize`) com uma das 79 divindades embutidas (ver
    /// `Store/EmbeddedDeities_Part*.swift`). Some sozinho quando não bate
    /// com nada — nunca mostra um link quebrado.
    @EnvironmentObject private var deityDatabase: DeityDatabase
    /// Item 9 do pedido do usuário (2026-09-24): "Level Changes ajustado
    /// automaticamente por classe/raça" — precisa do `RulesetRegistry`
    /// pra reaproveitar a mesma tabela (`ConsequenceEngine.refreshLevelChanges`)
    /// que já calcula THAC0/Saving Throws de verdade, em vez de duplicar
    /// os números.
    @EnvironmentObject private var ruleset: RulesetRegistry
    /// Item 5 do pedido do usuário (2026-09-24): "Kit que concede
    /// Proficiência deveria adicioná-la automaticamente na ficha" — ver
    /// `.onChange(of: character.kit)`/`addBonusProficiencies(forKit:)`
    /// mais abaixo.
    @EnvironmentObject private var kitDatabase: KitDatabase
    @EnvironmentObject private var proficiencyDatabase: ProficiencyDatabase
    /// Fase 6 do plano: subir de nível ganha uma rajada de brasa em cima do
    /// campo — só quando o número SOBE (editar pra baixo, corrigindo um
    /// erro de digitação, não é level up).
    @State private var isLevelingUp = false
    /// Abre `SphereAccessEditorSheet` — TODO.md item 16. Vive aqui (não na
    /// Folha de Magias) de propósito: esfera de acesso é um traço do
    /// PERSONAGEM, do mesmo jeito que Kit/Classe/Raça, não algo que faz
    /// sentido só existir enquanto o dia de jogo dura. `sphereAccess`
    /// mora em `PlayerCharacter` desde o início — só o botão pra editar
    /// estava no lugar errado.
    @State private var isSphereAccessPresented = false

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                HeaderLine(label: "Character") {
                    InlineTextField(value: $character.name, placeholder: "unnamed", fontSize: 22)
                }

                HStack(alignment: .bottom, spacing: 16) {
                    HeaderLine(label: "Class / Kit") {
                        HStack(spacing: 6) {
                            ClassPicker(character: $character, campaignBinding: campaignBinding)
                            Text("/").foregroundStyle(Paper.inkSoft)
                            KitField(kit: $character.kit, className: character.characterClass.rawValue)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    // Esferas de acesso só fazem sentido pro Clérigo — Mago
                    // usa escola/oposição de escola (TODO.md, fase ainda não
                    // implementada), não esfera. `hasSpellSheet` sozinho
                    // (que desde 2026-09-29 também é `true` pro Mago) já não
                    // basta mais aqui.
                    if character.characterClass == .cleric {
                        HeaderLine(label: "Spheres") {
                            Button {
                                isSphereAccessPresented = true
                            } label: {
                                Text("edit")
                                    .font(Paper.printedItalic(15))
                                    .foregroundStyle(Paper.penInk)
                            }
                            .buttonStyle(.plain)
                        }
                        .fixedSize()
                    }

                    // 2026-09-30: "My Spellbook" do Mago virou folha própria
                    // (menu ☰, `SheetPage.mySpellbook`), não mais um botão
                    // aqui no cabeçalho — mesmo lugar de onde já se chega no
                    // Grimório (Priest Spellbook/Mage Grimoire).

                    HeaderLine(label: "Level") {
                        EditableNumber(value: $character.level, size: 17, lower: 0, upper: 30)
                    }
                    .frame(width: 80)
                    .emberBurst(trigger: isLevelingUp, particleCount: 18)
                    // O sinal de consequência pendente não aparece mais
                    // aqui — usuário achou ruim ele pipocar em pontos
                    // diferentes da ficha (Level, ou uma das seis linhas
                    // de Ability Scores lá embaixo, dependendo de qual
                    // campo mudou por último). Agora é um lugar só: em
                    // cima do dragão no canto superior direito, ver
                    // `RecordHeaderForm.body` mais abaixo.
                }
                // Nenhum controle nesta linha é campo de escrita (Classe é
                // Menu, Kit abre uma sheet de escolha, Nível abre um
                // balão numérico) — mas os três ficam logo abaixo do
                // Character Name, que É um `HandwritingField` de verdade,
                // e o Scribble mira o campo de escrita mais próximo
                // INDEPENDENTE de quem está em foco (mesmo raciocínio do
                // `StrikeInteraction` em `SpellSheetView.swift`) — por
                // isso só `resignPencilFocus()` não bastava. `ScribbleGuard`
                // avisa o sistema pra não tentar escrita nesta área
                // nenhuma; o `simultaneousGesture` continua de reforço
                // pro caso de algum campo já estar em foco.
                .background(ScribbleGuard())
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0).onChanged { _ in resignPencilFocus() }
                )

                HStack(alignment: .bottom, spacing: 16) {
                    HeaderLine(label: "Race") {
                        // Era `EditableText` livre — este era o campo que
                        // o jogador via primeiro e realmente tocava; o
                        // seletor (TODO.md item 35) tinha sido ligado só
                        // no espelho da aba "Character Description" por
                        // engano. Corrigido no item 36/37 — ver
                        // `Views/RacePickerSheet.swift` → `RaceField`.
                        RaceField(character: $character, size: 17)
                    }
                    .frame(maxWidth: .infinity)

                    HeaderLine(label: "Alignment") {
                        // Era `EditableText` livre — pedido do usuário
                        // (2026-09-20): tem que ser uma das 9 combinações
                        // do PHB, mesmo escrevendo com a caneta. Ver
                        // `Views/AlignmentPicker.swift`.
                        AlignmentField(alignment: $character.alignment, size: 17)
                    }
                    .frame(maxWidth: .infinity)
                }
                // Mesmo motivo da linha Classe/Kit/Nível acima: Raça e
                // Alinhamento também abrem balão (`EditableText`) e ficam
                // perto o bastante do Character Name pra sofrer o mesmo
                // problema — o Scribble mirando o campo mais próximo em
                // vez de abrir o balão certo.
                .background(ScribbleGuard())
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0).onChanged { _ in resignPencilFocus() }
                )

                HStack(alignment: .bottom, spacing: 16) {
                    HeaderLine(label: "Patron Deity / Religion") {
                        HStack(spacing: 4) {
                            InlineTextField(value: $character.deity, placeholder: "", fontSize: 15)
                            DeityLinkButton(deityName: character.deity)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    HeaderLine(label: "Place of Origin") {
                        InlineTextField(value: $character.placeOfOrigin.orDefault(""), placeholder: "",
                                        fontSize: 15)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .trailing, spacing: 2) {
                Text("Advanced Dungeons & Dragons")
                    .font(Paper.printed(15))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                Text("2nd Edition")
                    .font(Paper.printedItalic(12))
                Rectangle().fill(Paper.ink).frame(height: 2).padding(.top, 4)
                Text("Player Character Record")
                    .font(Paper.printed(11))
                    .tracking(1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.top, 2)

                // O distintivo do grupo, no vão vazio abaixo do título —
                // pedido do usuário, com o fundo já tratado pra ficar
                // transparente (a imagem original vinha num quadrado branco).
                // Centralizado na coluna do cabeçalho (em vez de grudado à
                // direita) e com saturação/contraste reduzidos — as cores
                // originais eram vivas demais perto do pergaminho pastel do
                // resto da ficha.
                //
                // Quando há consequência pendente (nível ou algum atributo
                // mudou desde a última revisão — `hasPendingConsequences`),
                // o dragão dá lugar ao `ConsequenceSignalBadge`, no mesmo
                // tamanho (92pt) e no mesmo lugar — era pra aparecer em
                // pontos diferentes da ficha (perto do Level, ou de uma das
                // seis linhas de Ability Scores), usuário achou ruim e
                // pediu um ponto único, fixo, "como se substituindo" o
                // dragão. Único sinal da ficha inteira agora.
                if character.hasPendingConsequences {
                    ConsequenceSignalBadge(character: $character, isActive: true, diameter: 92)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                } else if let recordBadge {
                    recordBadge
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 92, height: 92)
                        .saturation(0.45)
                        .brightness(0.05)
                        .contrast(0.92)
                        .opacity(0.9)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                }
            }
            .foregroundStyle(Paper.ink)
            .frame(width: 170, alignment: .trailing)
        }
        .onChange(of: character.level) { oldLevel, newLevel in
            guard oldLevel != newLevel else { return }
            // Marca o Level como o campo editado por último — decide onde
            // o único sinal de consequência da ficha aparece (ver
            // `effectiveChangedField`). Mesmo quando o nível desce (não é
            // "level up"), ainda foi ele que mudou por último.
            character.lastChangedField = "level"
            // Recalcula "XP needed for next level" AQUI (não só dentro de
            // `ExperienceForm`, página 2) — ver o comentário de
            // `PlayerCharacter.refreshXPNeededNextLevel()` pro porquê.
            character.refreshXPNeededNextLevel()
            // Item 9 do pedido do usuário (2026-09-24): "Level Changes
            // ajustado automaticamente por classe/raça" — só preenche
            // linha vazia (ver doc de `refreshLevelChanges`), então é
            // seguro chamar em toda edição de nível, sem risco de
            // sobrescrever algo que o jogador tenha digitado à mão.
            ConsequenceEngine.refreshLevelChanges(for: &character, registry: ruleset)
            guard newLevel > oldLevel else { return }
            isLevelingUp = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                isLevelingUp = false
            }
        }
        .onChange(of: character.kit) { _, newKit in
            // Item 5 do pedido do usuário (2026-09-24): "Kit que concede
            // Proficiência deveria adicioná-la automaticamente na
            // ficha" — dispara ao escolher/trocar o Kit no cabeçalho
            // (`KitField`) ou ao digitar um nome que bata com um kit da
            // base.
            addBonusProficiencies(forKit: newKit)
        }
        .onAppear {
            // Só preenche o snapshot de consequências na primeira vez —
            // ver `PlayerCharacter.ensureConsequenceSnapshotInitialized()`.
            // Seguro chamar toda vez que a ficha aparece: depois da
            // primeira vez, não faz nada.
            character.ensureConsequenceSnapshotInitialized()
            // Rede de segurança pra fichas que já existiam com classe/
            // nível escolhidos e "Level Changes" vazio — mesma ideia do
            // `refreshHitDiceType()` acima: só preenche o que estiver
            // vazio, nunca sobrescreve.
            ConsequenceEngine.refreshLevelChanges(for: &character, registry: ruleset)
        }
        .sheet(isPresented: $isSphereAccessPresented) {
            SphereAccessEditorSheet(character: $character)
        }
    }

    /// Item 5 do pedido do usuário (2026-09-24): "Kit que concede
    /// Proficiência deveria adicioná-la automaticamente na ficha" — só
    /// cobre `kit.mechanics.proficiencies.bonus` (`KitProficiencyRules.bonus`,
    /// `Models/Kit.swift`), a lista de proficiências não-de-arma que o
    /// kit CONCEDE de graça — distinta de `recommended` (só sugestão, o
    /// jogador ainda escolhe essas à mão no seletor). `kitName` vem de
    /// `character.kit`, texto livre; `KitDatabase.kit(named:)` casa por
    /// nome (`Fuzzy.normalize`) — kit não encontrado (texto digitado à
    /// mão, ou vazio) simplesmente não adiciona nada. Nunca REMOVE
    /// proficiência nenhuma ao trocar de kit, e nunca duplica: confere
    /// por `matchedProficiencyID` (ou nome normalizado, pra entradas
    /// antigas sem esse campo) antes de adicionar.
    ///
    /// Pedido do usuário (2026-09-24): a ficha já nasce com 6 linhas em
    /// branco pro jogador preencher (`ProficienciesForm.onAppear`) —
    /// sem esse cuidado, escolher um Kit que concede proficiência criava
    /// uma linha NOVA além das 6 em branco, em vez de ocupar uma delas.
    /// Por isso reaproveita a primeira linha vazia (sem nome e sem
    /// proficiência já casada) que encontrar, e só cria uma linha nova
    /// quando não sobra nenhuma vazia.
    private func addBonusProficiencies(forKit kitName: String?) {
        guard let kitName, let kit = kitDatabase.kit(named: kitName) else { return }
        let bonusNames = kit.mechanics.proficiencies.bonus
        guard !bonusNames.isEmpty else { return }

        var entries = character.proficiencies ?? []
        var existingKeys: Set<String> = Set(entries.compactMap { entry -> String? in
            if let id = entry.matchedProficiencyID { return id }
            let normalized = Fuzzy.normalize(entry.name)
            return normalized.isEmpty ? nil : normalized
        })

        var added = false
        for bonusName in bonusNames {
            let matched = proficiencyDatabase.proficiencies.first {
                Fuzzy.normalize($0.name) == Fuzzy.normalize(bonusName)
            }
            let key = matched?.id ?? Fuzzy.normalize(bonusName)
            guard !key.isEmpty, !existingKeys.contains(key) else { continue }

            let newEntry = ProficiencyEntry(name: matched?.name ?? bonusName, slots: 1, matchedProficiencyID: matched?.id)
            // Pedido do usuário (2026-09-24): a ficha já nasce com 6
            // linhas em branco pro jogador preencher (`ProficienciesForm.onAppear`)
            // — em vez de criar uma linha NOVA e deixar as 6 em branco
            // sobrando do lado, primeiro procura uma linha vazia (sem
            // nome nem proficiência já casada) e reaproveita ela.
            if let blankIndex = entries.firstIndex(where: { $0.name.trimmingCharacters(in: .whitespaces).isEmpty && $0.matchedProficiencyID == nil }) {
                // Preserva `id`/`checked`/`target` da linha em branco
                // (jogador pode ter anotado um alvo de rolagem numa
                // linha ainda sem nome) — só o nome/slots/id casado vêm
                // da proficiência bônus do kit.
                entries[blankIndex].name = newEntry.name
                entries[blankIndex].slots = newEntry.slots
                entries[blankIndex].matchedProficiencyID = newEntry.matchedProficiencyID
            } else {
                entries.append(newEntry)
            }
            existingKeys.insert(key)
            added = true
        }

        guard added else { return }
        character.proficiencies = entries
        character.markRecentAutoChange("proficiencies")
    }

    /// Carregado do bundle igual ao `main_badge` da tela de personagens —
    /// arquivo solto em `Resources` não vira entrada de asset catalog
    /// acessível por `Image("nome")`.
    private var recordBadge: Image? {
        guard let url = Bundle.main.url(forResource: "record_badge", withExtension: "png"),
              let uiImage = UIImage(contentsOfFile: url.path)
        else { return nil }
        return Image(uiImage: uiImage)
    }
}

/// Rótulo em cima, valor sublinhado embaixo — como as linhas em branco do
/// PDF, não a caixinha com moldura das tabelas (o cabeçalho do PDF real
/// usa sublinhado, as tabelas usam caixa).
private struct HeaderLine<Content: View>: View {
    let label: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(Paper.printed(11))
                .foregroundStyle(Paper.inkSoft)
            content
            Rectangle().fill(Paper.ink).frame(height: 1)
        }
    }
}

/// Só o menu de troca de classe, sem rótulo próprio — o rótulo "Class/Kit"
/// já vem do `HeaderLine` que o envolve.
private struct ClassPicker: View {
    @Binding var character: PlayerCharacter
    var campaignBinding: Binding<Campaign>? = nil
    /// Item 9 do pedido do usuário (2026-09-24): trocar de classe também
    /// resincroniza "Level Changes" — ver `select(_:)` abaixo.
    @EnvironmentObject private var ruleset: RulesetRegistry
    /// 2026-09-29: vira Mago pela primeira vez já começa com "Read Magic"
    /// no livro de magias — ver `PlayerCharacter.seedWizardSpellbookIfNeeded(in:)`
    /// e o comentário grande em `wizardSpellbook`.
    @EnvironmentObject private var spellbook: SpellDatabase

    var body: some View {
        Menu {
            ForEach(CharacterClass.allCases) { option in
                Button(option.rawValue) { select(option) }
            }
        } label: {
            HandValue(text: character.characterClass.rawValue, size: 17)
        }
        .buttonStyle(.plain)
    }

    /// Sem campanha (personagem ainda no Sandbox), não há onde criar a
    /// primeira folha — fica pendente até ele ser associado a uma.
    private func select(_ option: CharacterClass) {
        character.characterClass = option
        // Trocar de classe também muda THAC0/Saves/etc. — liga o sinal de
        // consequência no campo de nível (ver `hasPendingLevelChange`).
        character.lastChangedField = "level"
        // Cada classe usa uma coluna diferente da tabela de progressão —
        // ver `PlayerCharacter.refreshXPNeededNextLevel()`.
        character.refreshXPNeededNextLevel()
        // Preenche "Hit Dice" sozinho, sempre resincronizando com a
        // classe atual (força mesmo se já tiver algo escrito) — ver
        // `PlayerCharacter.refreshHitDiceType()`.
        character.refreshHitDiceType(force: true)
        // Item 9 do pedido do usuário (2026-09-24): "Level Changes"
        // resincroniza com `force: true` — a tabela THAC0/Saves da
        // classe anterior não serve mais pra classe nova.
        ConsequenceEngine.refreshLevelChanges(for: &character, registry: ruleset, force: true)
        // Só entra em ação a primeira vez que o personagem vira Mago (o
        // guard dentro do método garante isso: `wizardSpellbook.isEmpty`)
        // — nunca sobrescreve um livro já editado pelo jogador.
        character.seedWizardSpellbookIfNeeded(in: spellbook)
        // Folhas que já existem NUNCA mudam ao trocar de classe (decisão do
        // usuário, 2026-10-05): só as novas nascem no padrão da classe nova
        // — `startSpellSheet` ajusta a grade herdada à tabela atual.
        guard option.hasSpellSheet, character.spellSheets.isEmpty, let campaignBinding else { return }
        let session = campaignBinding.wrappedValue.activeSession()
        character.startSpellSheet(sessionID: session.id, title: "First day")
    }
}

/// Campo "Kit" do cabeçalho — era `EditableText` livre, virou botão que
/// abre `KitPickerSheet` (ver TODO.md item 9 e `Views/KitCompendiumView.swift`).
/// `character.kit` continua sendo o mesmo `String?` de sempre: escolher um
/// kit na base só grava `kit.name` ali, sem mudar o modelo nem quebrar
/// fichas antigas que já tinham texto livre digitado nesse campo (esse
/// texto continua aparecendo aqui normalmente, só não bate com nenhuma
/// linha destacada — ★ — no seletor).
private struct KitField: View {
    @Binding var kit: String?
    /// `character.characterClass.rawValue` — repassado pro `KitPickerSheet`
    /// pra só listar kits elegíveis pra essa classe (ver
    /// `KitDatabase.kits(allowedFor:)`). Antes esse filtro nunca era
    /// aplicado aqui e o seletor sempre mostrava os 97 kits inteiros,
    /// não importa a classe escolhida na ficha.
    let className: String
    @State private var isPickerPresented = false

    // Usuário relatou que este campo é difícil de abrir — sendo um valor
    // fixo (não dá pra escrever/digitar direto nele, ao contrário de um
    // campo de texto normal), o toque precisa de um alvo maior do que só o
    // texto do kit escolhido. Primeira tentativa acrescentou um ícone de
    // seta do lado do valor — usuário achou feio visualmente e sugeriu
    // algo mais simples: mostrar "None" (em vez de "—") quando não há kit
    // escolhido, deixando claro que é um campo esperando preenchimento, e
    // tirar o ícone. O `contentShape`/padding continuam alargando a área
    // tocável por baixo dos panos, sem nenhum elemento visual extra.
    var body: some View {
        Button {
            isPickerPresented = true
        } label: {
            HandValue(text: kit?.isEmpty == false ? kit! : "None", size: 17)
                .padding(.vertical, 4)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isPickerPresented) {
            KitPickerSheet(selection: $kit, className: className)
        }
    }
}

// MARK: - Atributos

private struct AbilityRowForm: View {
    let name: String
    @Binding var character: PlayerCharacter
    @Binding var score: Int
    /// Terceiro elemento (opcional): chave em
    /// `PlayerCharacter.recentAutoChanges` pra ESTA célula específica (ex.
    /// "strengthHit", "constitutionHP", ...) — ver `flashKey` abaixo pro
    /// mesmo esquema aplicado ao score em si.
    let cells: [(String, Binding<String>, String?)]
    /// Chave em `PlayerCharacter.recentAutoChanges` pra este atributo
    /// ("strength", "dexterity", ...) — usada pelo `ChangeFlash` quando o
    /// seletor de Raça (ou outra automação futura) muda este valor
    /// sozinho. `nil` em qualquer chamador antigo que não passe isso
    /// simplesmente nunca pisca, sem quebrar nada.
    var flashKey: String? = nil

    var body: some View {
        HStack(spacing: 0) {
            Text(name)
                .font(Paper.printed(16))
                .fontWeight(.bold)
                .foregroundStyle(Paper.ink)
                .frame(width: 46, alignment: .leading)
                .padding(.leading, 2)
            FormNumberCell(value: $score, lower: 1, upper: 25,
                           color: polarityColor(flashKey.flatMap { character.activeEffectPolarity(for: $0) }, default: Paper.penInk))
                .frame(width: 52)
                .modifier(OptionalChangeFlash(character: $character, key: flashKey))
                // O sinal de consequência pendente não aparece mais aqui —
                // virou um lugar só na ficha inteira, em cima do dragão no
                // cabeçalho (ver `RecordHeaderForm.body`).
            ForEach(cells.indices, id: \.self) { index in
                FormCell(label: cells[index].0, value: cells[index].1)
                    // Item 2 do pedido do usuário (2026-09-24): "aumentar
                    // atributos que impactam os ability scores não fazem
                    // eles piscarem em verde, apesar de corretamente
                    // ajustá-los" — subir um atributo e aplicar as
                    // consequências automáticas (`ConsequencePreviewSheet`,
                    // "Apply automatic changes") já escrevia certinho nestas
                    // células (Hit Adj, Dmg Adj, HP Adj etc. — ver
                    // `ConsequenceEngine.trackedRules`), mas nada marcava
                    // `recentAutoChange` pra elas, então nunca piscavam.
                    .modifier(OptionalChangeFlash(character: $character, key: cells[index].2))
            }
        }
    }
}

private struct AbilityScoresForm: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FormSectionTitle(text: "Ability Scores")
            VStack(spacing: 0) {
                AbilityRowForm(name: "STR", character: $character, score: $character.abilities.strength, cells: [
                    ("Hit\nAdj", $character.details.strengthHit, "strengthHit"),
                    ("Dmg\nAdj", $character.details.strengthDamage, "strengthDamage"),
                    ("Weight\nAllow", $character.details.strengthWeight, "strengthWeight"),
                    ("Max\nPress", $character.details.strengthMaxPress, "strengthMaxPress"),
                    ("Open\nDoors", $character.details.strengthDoors, "strengthDoors"),
                    ("Bend\nBars", $character.details.strengthBars, "strengthBars")
                ], flashKey: "strength")
                AbilityRowForm(name: "DEX", character: $character, score: $character.abilities.dexterity, cells: [
                    ("Surprise\nAdjustment", $character.details.dexterityReaction, "dexterityReaction"),
                    ("Missile Att\nAdjustment", $character.details.dexterityMissile, "dexterityMissile"),
                    ("Defensive\nAdjustment", $character.details.dexterityDefense, "dexterityDefense")
                ], flashKey: "dexterity")
                AbilityRowForm(name: "CON", character: $character, score: $character.abilities.constitution, cells: [
                    ("HP\nAdj", $character.details.constitutionHP, "constitutionHP"),
                    ("System\nShock", $character.details.constitutionShock, "constitutionShock"),
                    ("Resurrect\nSurvival", $character.details.constitutionResurrection, "constitutionResurrection"),
                    ("Poison\nSave", $character.details.constitutionPoison, "constitutionPoison"),
                    ("Regen", $character.details.constitutionRegen.orDefault(""), nil)
                ], flashKey: "constitution")
                AbilityRowForm(name: "INT", character: $character, score: $character.abilities.intelligence, cells: [
                    ("Languages", $character.details.intelligenceLanguages, "intelligenceLanguages"),
                    ("Spell\nLevel", $character.details.intelligenceMaxLevel, "intelligenceMaxLevel"),
                    ("Learn\nSpell", $character.details.intelligenceLearn, "intelligenceLearn"),
                    ("Max/\nLevel", $character.details.intelligenceMaxPerLevel, "intelligenceMaxPerLevel"),
                    ("Spell\nImmun", $character.details.intelligenceSpellImmunity.orDefault(""), nil)
                ], flashKey: "intelligence")
                AbilityRowForm(name: "WIS", character: $character, score: $character.abilities.wisdom, cells: [
                    ("Magical\nDef Adj", $character.details.wisdomDefense, "wisdomDefense"),
                    ("Bonus\nSpells", $character.details.wisdomBonusSpells, "wisdomBonusSpells"),
                    ("Spell\nFailure", $character.details.wisdomFailure, "wisdomFailure"),
                    ("Spell\nImmun", $character.details.wisdomSpellImmunity.orDefault(""), nil)
                ], flashKey: "wisdom")
                AbilityRowForm(name: "CHA", character: $character, score: $character.abilities.charisma, cells: [
                    ("Max # of\nHenchmen", $character.details.charismaHenchmen, "charismaHenchmen"),
                    ("Loyalty\nBase", $character.details.charismaLoyalty, "charismaLoyalty"),
                    ("Reaction\nAdjustment", $character.details.charismaReaction, "charismaReaction")
                ], flashKey: "charisma")
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
        }
        // Marca qual atributo foi editado por último — decide onde o
        // único sinal de consequência da ficha aparece (ver
        // `effectiveChangedField` em `Models/Character.swift`; mesmo
        // esquema do `.onChange(of: character.level)` em
        // `RecordHeaderForm`). Confere um por um porque `AbilityScores`
        // muda inteira de uma vez só (é um struct) — o `EditableNumber`
        // de cada linha só mexe em UM campo por edição, então no máximo
        // uma dessas comparações bate a cada chamada.
        .onChange(of: character.abilities) { old, new in
            if old.strength != new.strength { character.lastChangedField = "strength" }
            else if old.dexterity != new.dexterity { character.lastChangedField = "dexterity" }
            else if old.constitution != new.constitution { character.lastChangedField = "constitution" }
            else if old.intelligence != new.intelligence { character.lastChangedField = "intelligence" }
            else if old.wisdom != new.wisdom { character.lastChangedField = "wisdom" }
            else if old.charisma != new.charisma { character.lastChangedField = "charisma" }
        }
    }
}

// MARK: - Jogadas de proteção
//
// Três colunas, como no PDF real (TODO.md item 4, retomado a pedido do
// usuário — "é muito importante ter o MOD, pois podemos aplicar
// manualmente um ajuste temporário"): "Start" é o alvo da tabela de
// classe/nível (o `ConsequenceEngine` escreve sozinho numa subida de
// nível, mas continua editável na mão), "Mod" é um ajuste numérico
// temporário que o jogador liga/desliga (anel, poção, armadilha, bônus de
// magia — qualquer coisa que a tabela sozinha não cobre) e "Total" é só
// exibido, nunca editável nem guardado — sempre Start − Mod na hora de
// desenhar a tela (ver `SavingThrows.total(for:)`), então nunca fica
// dessincronizado dos outros dois.
private struct SavingThrowsForm: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var ruleset: RulesetRegistry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Pedido do usuário (2026-09-22, TODO.md item 38): Saving
            // Throws muda por nível/classe, mas o sinal de "algo mudou,
            // vem conferir" só aparecia perto do campo Level/atributo em
            // si, nunca aqui — onde o jogador de fato precisa ir conferir
            // a tabela e atualizar os números. Era um `ConsequenceSignalBadge`
            // (ícone circular) — trocado (TODO.md item 41, usuário: "os
            // campos alterados [deveriam ficar] em verde... o ícone
            // pequeno... tá errado") por `PendingConsequenceHighlight`,
            // que tinge o próprio título de verde em vez de um ícone do
            // lado.
            //
            // Item 1 do pedido do usuário (2026-09-24): usava
            // `character.hasPendingConsequences` (o sinal GLOBAL — liga com
            // QUALQUER atributo pendente de revisão) em vez de checar se
            // Saving Throws especificamente mudaria — subir WIS, que não
            // entra na tabela de resistência, ainda assim acendia este
            // realce. Troca pra `hasPendingConsequence(forKeys:)`, escopada
            // só na regra "savingThrows" (ver `ConsequenceEngine.trackedRules`).
            FormSectionTitle(text: "Saving Throws", ruleID: "phb_ch09_the_saving_throw")
                .pendingConsequenceHighlight(isActive: character.hasPendingConsequence(forKeys: ["savingThrows"], registry: ruleset))
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("").frame(maxWidth: .infinity, alignment: .leading)
                    Text("Start").font(.system(size: 9, design: .serif)).frame(width: 34)
                    Text("Mod").font(.system(size: 9, design: .serif)).frame(width: 34)
                    Text("Total").font(.system(size: 9, design: .serif)).frame(width: 34)
                }
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundStyle(Paper.inkSoft)
                .padding(.vertical, 3)
                .padding(.horizontal, 4)

                ForEach(SavingThrows.labels) { entry in
                    SaveLineForm(saves: $character.saves, entry: entry,
                                color: polarityColor(character.activeEffectPolarity(for: "savingThrows"), default: Paper.ink))
                }
                SaveResistanceLine(character: $character, saves: $character.saves)
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
        }
    }
}

private struct SaveLineForm: View {
    @Binding var saves: SavingThrows
    let entry: SavingThrows.SaveEntry
    /// Verde/vermelho persistente enquanto um Efeito Ativo mexer nos
    /// Saving Throws (`allSaves`) — tinge o "Total", que é o número que
    /// realmente vale na mesa (`Paper.ink`, o padrão de sempre, quando
    /// não há nada ativo).
    var color: Color = Paper.ink

    var body: some View {
        HStack(spacing: 0) {
            Text(entry.label)
                .font(Paper.printed(11))
                .foregroundStyle(Paper.ink)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
            EditableNumber(
                value: Binding(
                    get: { saves[keyPath: entry.keyPath] },
                    set: { saves[keyPath: entry.keyPath] = $0 }
                ),
                size: 15, lower: 1, upper: 20
            )
            .frame(width: 34, height: 32)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
            EditableNumber(
                value: Binding(
                    get: { saves.modifier(for: entry.id) },
                    set: { saves.setModifier($0, for: entry.id) }
                ),
                size: 15, lower: -20, upper: 20
            )
            .frame(width: 34, height: 32)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
            // Total nunca é editável nem guardado — só exibe Start − Mod
            // (ver comentário da `SavingThrowsForm`). Destaque em negrito
            // pra deixar claro que é o número que vale na mesa.
            Text("\(saves.total(for: entry))")
                .font(Paper.printed(15).bold())
                .foregroundStyle(color)
                .frame(width: 34, height: 32)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
        }
        .frame(minHeight: 32)
    }
}

private struct SaveResistanceLine: View {
    @Binding var character: PlayerCharacter
    @Binding var saves: SavingThrows

    var body: some View {
        HStack(spacing: 0) {
            Text("Spell Resistance")
                .font(Paper.printed(11))
                .foregroundStyle(Paper.ink)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
            EditableText(value: $saves.spellResistance.orDefault(""), placeholder: "—",
                         size: 13, underline: false)
                .frame(width: 86, height: 32)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
                // Preenchido sozinho pelo seletor de Raça (Elf/Half-elf
                // ganham "X% vs sleep/charm" automático) — mesmo sinal
                // de "mudou sozinho" dos atributos.
                .changeFlash(character: $character, key: "spellResistance")
        }
        .frame(minHeight: 32)
    }
}

// MARK: - Combate

private struct CombatLine: View {
    let label: String
    @Binding var value: String

    var body: some View {
        HStack(spacing: 3) {
            Text(label)
                .font(Paper.printed(10.5))
                .foregroundStyle(Paper.ink)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
            Spacer(minLength: 2)
            EditableText(value: $value, placeholder: "—", size: 14, underline: false)
                .frame(width: 38, height: 24)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
        }
        .padding(.vertical, 3)
    }
}

/// Reorganizado pra seguir a mesma ordem de colunas do PDF oficial (Armor/
/// Class, AC por situação, Checks, Hit Points, contagem de mortes, Wounds,
/// todos numa fileira só) em vez de uma grade genérica que reflui — como já
/// fazíamos com a tabela de armas e o "Target's AC", rola na horizontal
/// quando a tela não tem espaço pra tudo, e estica pra preencher quando tem.
private struct CombatForm: View {
    @Binding var character: PlayerCharacter
    // Fase 6 do plano: dano sacode a caixa de HP, cura ganha um brilho de
    // poção — contadores em vez de Bool porque golpes/curas em sequência
    // (várias trocas de turno) precisam disparar de novo mesmo sem o
    // valor "descansar" em `false` no meio.
    @State private var damageTick = 0
    @State private var healTick = 0

    private var combat: Binding<CombatDetails> { $character.combat.orInit(CombatDetails()) }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            FormSectionTitle(text: "Combat")

            // Sem scroll horizontal: com as colunas mais compactas, tudo
            // já cabe na largura da tela.
            HStack(alignment: .top, spacing: 6) {
                    ArmorClassShield(armorClass: $character.armorClass,
                                     color: polarityColor(character.activeEffectPolarity(for: "armorClass"), default: Paper.penInk))
                        // Itens 7/10: pisca quando o AC muda sozinho por
                        // causa de Armor/Shield/Magic Items — mesmo
                        // vocabulário de `markRecentAutoChange("armorClass")`
                        // em `ConsequenceEngine.recalculateArmorClass`.
                        .changeFlash(character: $character, key: "armorClass")

                    VStack(spacing: 0) {
                        CombatLine(label: "Surprised AC", value: combat.surprisedAC.orDefault(""))
                        CombatLine(label: "Shieldless AC", value: combat.shieldlessAC.orDefault(""))
                        CombatLine(label: "Rear AC", value: combat.rearAC.orDefault(""))
                        CombatLine(label: "Type Worn", value: combat.typeWorn.orDefault(""))
                    }
                    .frame(width: 132)

                    VStack(spacing: 0) {
                        CombatLine(label: "Dex Checks", value: combat.dexChecks.orDefault(""))
                        CombatLine(label: "Vision Checks", value: combat.visionChecks.orDefault(""))
                        CombatLine(label: "Hearing Checks", value: combat.hearingChecks.orDefault(""))
                    }
                    .frame(width: 132)

                    VStack(spacing: 6) {
                        HStack(spacing: 4) {
                            Text("Hit Points").font(Paper.printed(11)).tracking(1)
                            // Reset rápido pra "full" — volta o atual pro
                            // máximo, pra não ter que rolar/apagar à mão
                            // depois de um descanso longo.
                            Button {
                                character.hitPointsCurrent = character.hitPointsMax
                            } label: {
                                Image(systemName: "arrow.counterclockwise.circle")
                                    .font(.system(size: 13))
                                    .foregroundStyle(Paper.inkSoft)
                            }
                            .buttonStyle(.plain)
                        }

                        VStack(spacing: 2) {
                            HStack(alignment: .lastTextBaseline, spacing: 2) {
                                EditableNumber(value: $character.hitPointsCurrent, size: 28,
                                               color: Paper.redInk, lower: -30, upper: 999)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                Text("/").foregroundStyle(Paper.inkSoft)
                                EditableNumber(value: $character.hitPointsMax, size: 17, lower: 1, upper: 999)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .contentShape(Rectangle())
                            }
                            .frame(width: 100, height: 52)
                            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.4))
                            .shakeOnce(trigger: damageTick)
                            .flashOnce(trigger: healTick, color: Ember.teal)
                            .onChange(of: character.hitPointsCurrent) { old, new in
                                if new < old { damageTick += 1 }
                                else if new > old { healTick += 1 }
                            }

                            HStack(spacing: 3) {
                                Text("Hit Dice:").font(Paper.printed(11))
                                EditableText(value: combat.hitDiceType.orDefault(""), placeholder: "d",
                                             size: 13, underline: false)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    // Item 3 do pedido do usuário (2026-09-24):
                                    // trocar de classe já ajustava o Hit Dice
                                    // certinho (`PlayerCharacter.refreshHitDiceType`
                                    // já chama `markRecentAutoChange("hitDiceType")`),
                                    // só faltava este `.changeFlash` pra consumir o
                                    // aviso e realmente piscar em verde.
                                    .changeFlash(character: $character, key: "hitDiceType")
                            }
                            // Mesma largura da caixa de Hit Points logo
                            // acima, alinhado com ela, e bem colado —
                            // espaçamento de 2pt em vez de 6, pra ficar
                            // próximo da caixa em vez de solto no meio da
                            // coluna.
                            .frame(width: 100)
                        }
                    }
                    .foregroundStyle(Paper.ink)
                    .frame(width: 104)

                    VStack(spacing: 0) {
                        CombatLine(label: "Numbed #", value: combat.numbedNumber.orDefault(""))
                        CombatLine(label: "Useless #", value: combat.uselessNumber.orDefault(""))
                        CombatLine(label: "Max Deaths", value: combat.maxDeaths.orDefault(""))
                        CombatLine(label: "Deaths to Date", value: combat.deathsToDate.orDefault(""))
                    }
                    .frame(width: 132)

                    // Um respiro a mais antes do Wounds — as outras
                    // colunas ficam coladas entre si, mas esta é visualmente
                    // separada (é um bloco próprio, não outra lista de
                    // linhas AC/checks).
                    Spacer().frame(width: 10)

                    WoundsBlock(character: $character)
            }
            // Sem scroll, o HStack passou a ter só a largura da soma das
            // colunas — sobrando um vão à direita dentro da caixa inteira.
            // Centralizando em vez de deixar grudado à esquerda.
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 8)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
        // Rede de segurança pra fichas que já existiam com uma classe
        // escolhida e o campo "Hit Dice" vazio — `ClassPicker.select`
        // cobre a troca de classe, isso aqui cobre abrir uma ficha antiga
        // (ver `PlayerCharacter.refreshHitDiceType()`, só preenche se
        // estiver vazio, nunca sobrescreve).
        .onAppear { character.refreshHitDiceType() }
    }
}

/// Cada ferimento registrado empilha como uma linha nova em vez de
/// substituir a anterior — um extrato, não uma caixa que só guarda o
/// último número. Cada entrada nova soma ao histórico visível e desconta
/// na hora dos Hit Points atuais.
private struct WoundsBlock: View {
    @Binding var character: PlayerCharacter

    @State private var isAdding = false
    @State private var draft = ""

    private var entries: [String] {
        (character.combat?.wounds ?? "")
            .split(separator: "\n", omittingEmptySubsequences: true)
            .map(String.init)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Wounds").font(Paper.printed(11)).tracking(1)

            // Os ícones ficavam soltos, boiando no fim de uma fileira
            // larga que só existia pra empurrá-los — agora moram coladinhos
            // do lado da caixa, uma coluna estreita própria, em vez de
            // flutuando longe dela.
            HStack(alignment: .top, spacing: 4) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 2) {
                        if entries.isEmpty {
                            Text("—")
                                .font(Paper.printed(13))
                                .foregroundStyle(Paper.inkSoft.opacity(0.6))
                        } else {
                            ForEach(Array(entries.enumerated()), id: \.offset) { _, entry in
                                Text("− \(entry)")
                                    .font(Paper.printed(12.5))
                                    .foregroundStyle(Paper.penInk)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(4)
                }
                .frame(width: 50, height: 96)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))

                VStack(spacing: 8) {
                    // "+" pra lançar um novo dano.
                    Button {
                        draft = ""
                        isAdding = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .buttonStyle(.plain)
                    .frame(width: 20, height: 20)
                    .contentShape(Rectangle())
                    .popover(isPresented: $isAdding) {
                        HStack(spacing: 12) {
                            HandwritingField(text: $draft, placeholder: "dmg",
                                             allowsSoftwareKeyboard: false, onCommit: commit, fontSize: 20)
                                .frame(width: 100, height: 44)
                                .overlay(alignment: .bottom) { DottedRule() }
                            Button(action: commit) {
                                Text("add").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                            }
                        }
                        .padding(14)
                        .background(Paper.sheet)
                        .presentationCompactAdaptation(.popover)
                    }

                    if !entries.isEmpty {
                        Button(action: clearAll) {
                            Image(systemName: "trash")
                                .font(.system(size: 11))
                                .foregroundStyle(Paper.inkSoft)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 20, height: 20)
                        .contentShape(Rectangle())
                    }
                }
                .padding(.top, 2)
            }
        }
        .foregroundStyle(Paper.ink)
    }

    private func commit() {
        defer { draft = ""; isAdding = false }
        guard let dmg = Int(draft.trimmingCharacters(in: .whitespaces)), dmg != 0 else { return }
        // `applyDamage` (não mais `hitPointsCurrent -=` direto) — ponto
        // único de dano, pra descontar primeiro de qualquer PV temporário
        // não-curável ativo e disparar um Regenerate pendente (pedido do
        // usuário, 2026-09-28: "Efeitos Ativos" — ver `Models/ActiveEffect.swift`).
        character.applyDamage(dmg)
        var updated = character.combat ?? CombatDetails()
        let existing = updated.wounds ?? ""
        updated.wounds = existing.isEmpty ? "\(dmg)" : existing + "\n\(dmg)"
        character.combat = updated
    }

    private func clearAll() {
        character.combat?.wounds = ""
    }
}

// MARK: - Tabela "Target's AC / To Hit #"

/// A tabela clássica de acerto por CA-alvo, calculada sozinha a partir do
/// THAC0 (`character.thac0 − CA`) — mas cada célula continua editável: um
/// bônus situacional escrito por cima vira um ajuste manual só daquela CA,
/// que "cicatriza" de volta ao valor automático se apagado ou se bater com
/// a conta (ver `PlayerCharacter.setThac0Override`). É larga demais pra
/// coluna estreita do iPad em retrato, então rola na horizontal — como
/// alguém correndo o dedo pela linha impressa.
private struct Thac0TargetForm: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var ruleset: RulesetRegistry
    private let cellWidth: CGFloat = 34

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Text("THAC0").font(Paper.printed(12)).tracking(1).foregroundStyle(Paper.ink)
                // Mesmo motivo do `Saving Throws` acima (TODO.md item 38):
                // THAC0 também muda por nível/classe. Era um
                // `ConsequenceSignalBadge` (ícone do lado) — trocado
                // (TODO.md item 41, usuário: "os campos alterados
                // [deveriam ficar] em verde") por um realce direto no
                // próprio campo do THAC0 base.
                //
                // Item 1 do pedido do usuário (2026-09-24): mudar WIS (ou
                // qualquer atributo, mesmo os que não afetam THAC0) acendia
                // este realce, porque usava `hasPendingConsequences` global.
                // Escopado pra regra "thac0" — só acende quando o THAC0
                // resolvido de verdade mudaria (ver `ConsequenceEngine`).
                EditableNumber(value: $character.thac0, size: 17,
                               color: polarityColor(character.activeEffectPolarity(for: "thac0"), default: Paper.penInk),
                               lower: -10, upper: 25)
                    .frame(width: 40, height: 30)
                    .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
                    .pendingConsequenceHighlight(isActive: character.hasPendingConsequence(forKeys: ["thac0"], registry: ruleset))
                    // Efeitos Ativos (2026-09-28) podem substituir o THAC0
                    // sozinhos (`.statOverride`) — reaproveita o mesmo
                    // `ChangeFlash` da Força/CA/etc, em vez de inventar
                    // outro sinal só pra isso.
                    .changeFlash(character: $character, key: "thac0")
                Text("(base — the table below fills itself in)")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
                Spacer(minLength: 4)
                RuleLinkButton(ruleID: "phb_ch09_calculating_thac0")
            }

            ScrollView(.horizontal, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Target's AC")
                            .font(Paper.printed(11)).bold()
                            .foregroundStyle(Paper.ink)
                            .frame(width: 92, alignment: .leading)
                            .padding(.leading, 4)
                        ForEach(PlayerCharacter.thac0TargetACs, id: \.self) { ac in
                            // CA 0 é a coluna de referência (sem bônus nem
                            // penalidade) — destacada com fundo escuro/letra
                            // clara pra achar rápido na tira inteira.
                            Thac0TargetACHeaderCell(ac: ac)
                                .frame(width: cellWidth, height: 28)
                        }
                    }
                    HStack(spacing: 0) {
                        Text("To Hit #")
                            .font(Paper.printed(11)).bold()
                            .foregroundStyle(Paper.ink)
                            .frame(width: 92, alignment: .leading)
                            .padding(.leading, 4)
                        ForEach(PlayerCharacter.thac0TargetACs, id: \.self) { ac in
                            Thac0TargetCell(character: $character, ac: ac)
                                .frame(width: cellWidth, height: 32)
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
            }
        }
    }
}

/// Cabeçalho "Target's AC" de uma coluna (CA 0 destacada). Separado do
/// `Thac0TargetForm` pelos ternários de cor/peso, que inline deixavam o
/// `body` dele lento de compilar (~0,15–0,24 s).
private struct Thac0TargetACHeaderCell: View {
    let ac: Int

    private var isZero: Bool { ac == 0 }
    private var weight: Font.Weight { isZero ? .bold : .regular }
    private var textColor: Color { isZero ? Paper.sheet : Paper.ink }
    private var fill: Color { isZero ? Paper.ink : Color.clear }

    var body: some View {
        Text("\(ac)")
            .font(Paper.printed(12))
            .fontWeight(weight)
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(fill)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
    }
}

private struct Thac0TargetCell: View {
    @Binding var character: PlayerCharacter
    let ac: Int

    var body: some View {
        EditableText(
            value: Binding(
                get: { character.thac0TargetDisplay(ac: ac) },
                set: { character.setThac0Override(ac: ac, text: $0) }
            ),
            placeholder: "—", size: 14, underline: false
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        // Bordas transparentes por pedido — as células ainda se separam
        // pela grade por trás (a moldura da tabela inteira + as verticais
        // da fileira "Target's AC" acima continuam visíveis).
        .overlay(Rectangle().stroke(Color.clear, lineWidth: 1))
    }
}

// MARK: - Modificadores de combate

/// Botão pequeno de remover linha — usado nas tabelas de Modifiers, Weapon
/// Combat e Proficiencies, que agora deixam apagar uma entrada.
private struct RemoveRowButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "minus.circle")
                .font(.system(size: 15))
                .foregroundStyle(Paper.redInk.opacity(0.75))
        }
        .buttonStyle(.plain)
        .frame(width: 24, height: 24)
        .contentShape(Rectangle())
    }
}

private struct ModifierLine: View {
    @Binding var item: EquipmentItem
    var onDelete: () -> Void

    var body: some View {
        HStack {
            InlineTextField(value: $item.name, placeholder: "…", fontSize: 14)
                .frame(maxWidth: .infinity, alignment: .leading)
            EditableText(value: $item.note, placeholder: "—", size: 14, underline: false)
                .frame(width: 40, height: 26)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

private struct ModifierTable: View {
    let title: String
    @Binding var items: [EquipmentItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title).font(Paper.printed(12)).foregroundStyle(Paper.ink)
                Spacer()
                Text("+/-").font(.system(size: 9, design: .serif)).foregroundStyle(Paper.inkSoft)
            }
            .padding(6)
            .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1) }

            ForEach($items) { $item in
                ModifierLine(item: $item, onDelete: {
                    items.removeAll { $0.id == item.id }
                })
            }

            AddLineButton(title: "add") {
                items.append(EquipmentItem())
            }
            .padding(.horizontal, 4)
        }
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
    }
}

private struct CombatModifiersForm: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ModifierTable(title: "To Hit Modifiers", items: $character.toHitModifiers.orInit([]))
            ModifierTable(title: "Damage Modifiers", items: $character.damageModifiers.orInit([]))
            ModifierTable(title: "AC Modifiers", items: $character.acModifiers.orInit([]))
        }
        // Semeia linhas na primeira vez que a ficha abre, pra tela não
        // nascer vazia — gravado de verdade (não via orInit's default, que
        // recriaria itens novos com IDs aleatórios a cada redesenho e
        // bagunçaria o foco dos campos).
        .onAppear {
            // "Non-proficiency penalty" não é mais uma linha fixa separada
            // — virou só a primeira linha da lista, editável e removível
            // como as outras, mas pré-preenchida (migrando o que já
            // estivesse salvo no antigo campo dedicado, pra ninguém perder
            // dado ao abrir a ficha nesta versão).
            var toHit = character.toHitModifiers ?? []
            if !toHit.contains(where: { $0.name == "Non-proficiency penalty" }) {
                var penalty = EquipmentItem()
                penalty.name = "Non-proficiency penalty"
                // Antes ficava sempre vazio até o jogador digitar o valor à
                // mão — mas dá pra saber a penalidade só pela classe
                // (Tabela 34 do PHB, ver `ProficiencySlotsTable`), então
                // semeia com ela quando não houver nada migrado do campo
                // antigo. Continua editável depois — não é recalculado se
                // a classe mudar, mesma lógica de "semear uma vez só" já
                // usada nesta função pras outras tabelas.
                penalty.note = character.nonProficiencyPenalty
                    ?? ProficiencySlotsTable.nonProficiencyPenalty(for: character.characterClass)
                toHit.insert(penalty, at: 0)
            }
            if toHit.count < 3 {
                toHit.append(contentsOf: (0..<(3 - toHit.count)).map { _ in EquipmentItem() })
            }
            character.toHitModifiers = toHit

            if character.damageModifiers?.isEmpty ?? true {
                character.damageModifiers = [EquipmentItem(), EquipmentItem(), EquipmentItem()]
            }
            if character.acModifiers?.isEmpty ?? true {
                character.acModifiers = [EquipmentItem(), EquipmentItem(), EquipmentItem()]
            }
        }
    }
}

// MARK: - Armas

private struct WeaponFormRow: View {
    @Binding var weapon: WeaponEntry
    var characterClass: CharacterClass
    var onDelete: () -> Void

    // Mesmo padrão de "tocar no nome" de `ProficiencyFormRow`: linha já
    // ligada a uma arma da base (`matchedWeaponID`, ou nome batendo exato
    // como último recurso pra fichas salvas antes disso existir) abre a
    // descrição num toque, com "change" lá dentro pra trocar; linha vazia
    // ou não-ligada (homebrew, texto digitado à mão) abre o seletor direto.
    @EnvironmentObject private var weaponDatabase: WeaponDatabase
    @State private var showDetail = false
    @State private var showPicker = false

    private var matchedWeapon: Weapon? {
        if let id = weapon.matchedWeaponID, let match = weaponDatabase.weapon(id: id) {
            return match
        }
        guard !weapon.name.isEmpty else { return nil }
        return weaponDatabase.weapons.first { $0.name == weapon.name }
    }

    /// Weapon Specialization (PHB, conferido contra o Complete Fighter's
    /// Handbook cap. 4) é exclusividade do Fighter — nunca aparece pra
    /// Paladin/Ranger/outras classes, mesmo sendo do grupo Warrior.
    private var isFighter: Bool { characterClass == .fighter }
    private var isSpecialized: Bool { weapon.isSpecialized ?? false }

    /// Arco/besta especializa diferente de arma corpo-a-corpo (ver
    /// `toggleSpecialization`): detectado por substring no nome, já que
    /// não há campo estruturado de "categoria de arma" em `WeaponEntry`.
    private var isRangedWeapon: Bool {
        let name = (matchedWeapon?.name ?? weapon.name).lowercased()
        return name.contains("bow") || name.contains("crossbow")
    }

    /// Liga/desliga a especialização e, só ao ligar, semeia os campos de
    /// "Hit/Dmg Adj" — nunca sobrescrevendo o que o jogador já tiver
    /// escrito (mesma regra documentada no doc-comment de
    /// `WeaponEntry.isSpecialized`, Models/Character.swift). Corpo-a-corpo:
    /// +1 pra acertar / +2 de dano. Arco/besta: sem bônus de dano, e o
    /// +2 pra acertar só vale dentro do alcance "point-blank" — daí o
    /// "+2*" com o asterisco explicado no rodapé da seção.
    private func toggleSpecialization() {
        weapon.isSpecialized = !isSpecialized
        guard weapon.isSpecialized == true else { return }
        if isRangedWeapon {
            if weapon.thac0.isEmpty { weapon.thac0 = "+2*" }
        } else {
            if weapon.thac0.isEmpty { weapon.thac0 = "+1" }
            if (weapon.dmgAdj ?? "").isEmpty { weapon.dmgAdj = "+2" }
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 4) {
                Button {
                    if matchedWeapon != nil {
                        showDetail = true
                    } else {
                        showPicker = true
                    }
                } label: {
                    Text(weapon.name.isEmpty ? "…" : weapon.name)
                        .font(Paper.printed(15))
                        .foregroundStyle(weapon.name.isEmpty ? Paper.inkSoft : Paper.ink)
                        .lineLimit(1)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .leading)

                if isFighter {
                    Button(action: toggleSpecialization) {
                        Text(isSpecialized ? "★ spec" : "☆ spec")
                            .font(Paper.printed(9))
                            .foregroundStyle(isSpecialized ? Paper.ink : Paper.inkSoft)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(width: 220, alignment: .leading)
            EditableText(value: $weapon.attacks, placeholder: "1", size: 14, underline: false)
                .frame(width: 40)
            EditableText(value: $weapon.size.orDefault(""), placeholder: "—", size: 14, underline: false)
                .frame(width: 48)
            EditableText(value: $weapon.weaponType.orDefault(""), placeholder: "—", size: 14, underline: false)
                .frame(width: 54)
            EditableText(value: $weapon.speed.orDefault(""), placeholder: "—", size: 14, underline: false)
                .frame(width: 48)
            HStack(spacing: 2) {
                EditableText(value: $weapon.thac0, placeholder: "—", size: 13, underline: false)
                Text("/").foregroundStyle(Paper.inkSoft)
                EditableText(value: $weapon.dmgAdj.orDefault(""), placeholder: "—", size: 13, underline: false)
            }
            .frame(width: 88)
            HStack(spacing: 2) {
                EditableText(value: $weapon.damageSmall, placeholder: "—", size: 13, underline: false)
                Text("/").foregroundStyle(Paper.inkSoft)
                EditableText(value: $weapon.damageLarge, placeholder: "—", size: 13, underline: false)
            }
            .frame(width: 88)
            EditableText(value: $weapon.range, placeholder: "—", size: 14, underline: false)
                .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { DottedRule() }
        .sheet(isPresented: $showDetail) {
            if let matchedWeapon {
                WeaponDetailSheet(weapon: matchedWeapon, onChangeWeapon: {
                    showDetail = false
                    DispatchQueue.main.async { showPicker = true }
                })
            }
        }
        .sheet(isPresented: $showPicker) {
            WeaponPickerSheet(weapon: $weapon)
        }
    }
}

private struct WeaponCombatForm: View {
    @Binding var character: PlayerCharacter

    // A tabela em si tem ~686pt de largura fixa (soma das colunas); numa
    // tela mais larga que isso ela sobrava espaço vazio à direita porque o
    // ScrollView só media o próprio conteúdo. Medindo a largura disponível
    // e aplicando como minWidth no conteúdo, a tabela estica pra preencher
    // a seção quando há espaço, e continua rolando na horizontal quando
    // não há (retrato no iPad).
    @State private var availableWidth: CGFloat = 0

    /// Soma das larguras fixas das colunas (220+40+48+54+48+88+88+24) mais
    /// os 100pt mínimos de "Range/Special" — abaixo disso a tabela some
    /// conteúdo e PRECISA rolar; a partir daqui ela já coube inteira sem
    /// cortar nada.
    private static let minTableWidth: CGFloat = 710

    // Pedido do usuário (2026-09-20): "a caixa Weapon Combat se move junto
    // com meu dedo quando me apoio nela pra trocar de página". Causa: esta
    // tabela mora dentro do `UIPageViewController` de `RecordSheetPagerView`
    // (folhear as páginas da aba Sheet é um gesto horizontal), e um
    // `ScrollView(.horizontal)` aqui dentro instala seu PRÓPRIO gesto de
    // arraste horizontal — os dois competem sempre que o toque começa
    // sobre esta tabela, e o `ScrollView` interno costuma ganhar, "roubando"
    // o folhear de página. Na tela cheia do iPad (paisagem) a tabela cabe
    // inteira e a rolagem nem faz falta — só existe pra retrato, quando as
    // colunas realmente não cabem. `.scrollDisabled` tira o gesto do meio
    // exatamente quando ele não tem função nenhuma (retrato continua
    // rolando normalmente, porque aí a rolagem é o comportamento certo).
    private var needsHorizontalScroll: Bool { availableWidth < Self.minTableWidth }

    // MARK: - Weapon Proficiency Slots (2026-09-30)
    //
    // Contra-proposta do usuário no lugar da P2 original (um contador
    // solto, digitado à parte): em vez disso, o próprio ato de listar uma
    // arma aqui (1 slot, regra já em vigor desde o item 4 do feedback
    // v1.93) e de marcar a ★ de especialização (`WeaponFormRow.
    // toggleSpecialization`) já É o gasto de slot — o contador abaixo só
    // LÊ essas duas coisas e soma contra o total que `ProficiencySlotsTable`
    // calcula pro nível atual (Tabela 34 + bônus de Inteligência, CFH cap.
    // 4). Nunca trava nada (mesma filosofia do resto da ficha) — só avisa
    // em vermelho se o jogador especializar/adicionar arma além do que
    // tem slot pra pagar.

    /// `true` só quando o nome do texto (arma matched ou digitada à mão)
    /// é um ARCO que não seja besta — a única categoria que custa 2 slots
    /// extras pra especializar (besta e corpo-a-corpo custam só 1, ver
    /// `cfh_ch04_weapon_proficiency_slots`: "any sort of melee weapon or
    /// crossbow... two slots... any bow (other than a crossbow)...
    /// three"). Mesma checagem por substring que `WeaponFormRow.
    /// isRangedWeapon` já usa pro bônus de "point-blank" (lá bow+crossbow
    /// andam juntos porque os dois ganham o mesmo bônus de acerto; aqui
    /// eles têm custo DIFERENTE, por isso a checagem é separada).
    private func isTrueBow(_ name: String) -> Bool {
        let normalized = name.lowercased()
        return normalized.contains("bow") && !normalized.contains("crossbow")
    }

    /// Quantos slots esta linha consome: 1 pela proficiência básica (toda
    /// arma listada JÁ É uma proficiência, regra de sempre desta tabela) —
    /// linha vazia não conta nada ainda, não virou proficiência de
    /// verdade — mais 1 (corpo-a-corpo/besta) ou 2 (arco) se especializada.
    private func slotCost(_ weapon: WeaponEntry) -> Int {
        guard !weapon.name.trimmingCharacters(in: .whitespaces).isEmpty else { return 0 }
        var cost = 1
        if weapon.isSpecialized == true {
            cost += isTrueBow(weapon.name) ? 2 : 1
        }
        return cost
    }

    private var spentWeaponSlots: Int {
        character.weapons.reduce(0) { $0 + slotCost($1) }
    }

    /// Teto informativo (ver doc de `ProficiencySlotsTable.
    /// totalWeaponSlots`) — assume que TODO o bônus de Inteligência foi
    /// pra proficiência de arma, quando na regra do CFH isso é uma escolha
    /// do jogador que pode ter ido parte pra não-arma.
    private var totalWeaponSlots: Int {
        ProficiencySlotsTable.totalWeaponSlots(for: character.characterClass, level: character.level,
                                                intelligence: character.abilities.intelligence)
    }

    private var isOverspent: Bool { spentWeaponSlots > totalWeaponSlots }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Weapon Combat", ruleID: "phb_ch05_weapon_proficiencies")

            // Item 4 do feedback do usuário (2026-09-30): "onde eu
            // adiciono as Weapon Proficiencies?" — resposta é AQUI: cada
            // arma listada abaixo já É a proficiência (o app nunca teve
            // uma lista separada de "slots de proficiência de arma" — só
            // a seção "Proficiencies", mais abaixo, que é só de
            // NÃO-armas). Uma linha curta deixa isso explícito, porque a
            // tabela sozinha não deixava óbvio.
            Text("Weapons listed here ARE your Weapon Proficiencies — add one per weapon you know. Untrained weapon? Leave it off this table, or use the Non-proficiency penalty below.")
                .font(Paper.printedItalic(10))
                .foregroundStyle(Paper.inkSoft)
                .padding(.horizontal, 4)

            ScrollView(.horizontal, showsIndicators: true) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Weapon").frame(width: 220, alignment: .leading)
                        Text("#AT").frame(width: 40)
                        Text("Size").frame(width: 48)
                        Text("Type").frame(width: 54)
                        Text("Speed").frame(width: 48)
                        Text("Hit/Dmg Adj").frame(width: 88)
                        Text("Damage").frame(width: 88)
                        Text("Range/Special").frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                        Text("").frame(width: 24)
                    }
                    .font(Paper.printed(11))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .foregroundStyle(Paper.ink)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 4)
                    .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1.2) }

                    ForEach($character.weapons) { $weapon in
                        WeaponFormRow(weapon: $weapon, characterClass: character.characterClass, onDelete: {
                            character.weapons.removeAll { $0.id == weapon.id }
                        })
                    }
                }
                .frame(minWidth: availableWidth, alignment: .leading)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
            }
            .scrollDisabled(!needsHorizontalScroll)
            .background(WidthReader(width: $availableWidth))

            AddLineButton(title: "add weapon") {
                character.weapons.append(WeaponEntry())
            }
            .padding(.horizontal, 4)

            // Contador de Weapon Proficiency Slots (2026-09-30) — pra
            // QUALQUER classe (toda classe tem Tabela 34, não só Fighter):
            // soma quantos slots as armas listadas acima + as ★ marcadas já
            // consomem, contra o total que o nível/Inteligência do
            // personagem já garantem. Fica vermelho se passar do total —
            // nunca trava nada, só avisa (mesma filosofia do resto da
            // ficha: a régua existe, ninguém é impedido de escrever o que
            // quiser nela).
            HStack(spacing: 4) {
                Text("Weapon Proficiency Slots: \(spentWeaponSlots)/\(totalWeaponSlots) used")
                    .font(Paper.printed(10))
                    .foregroundStyle(isOverspent ? Paper.redInk : Paper.inkSoft)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                RuleLinkButton(ruleID: "phb_ch05_proficiencies")
            }
            .padding(.horizontal, 4)
            .padding(.top, 2)

            // Nota de Weapon Specialization (2026-09-30) — só aparece pro
            // Fighter, já que Paladin/Ranger nunca podem especializar (regra
            // conferida no Complete Fighter's Handbook cap. 4, "Single-Weapon
            // Proficiency, Weapon Specialization", enviado pelo usuário).
            //
            // Era um parágrafo inteiro em fonte 10 — usuário reclamou que
            // ficava ilegível (item 2 do feedback, 2026-09-30). Virou uma
            // linha curta com o essencial, mais o botão "?" de sempre
            // (`RuleLinkButton`) abrindo o texto completo do CFH em
            // `RuleDetailSheet` — que já usa fonte de leitura normal, não a
            // miniatura de rodapé. O custo em slots (1 extra corpo-a-corpo/
            // besta, 2 extra arco) já está refletido no contador acima —
            // esta linha só explica O QUE a ★ faz mecanicamente (acerto/dano).
            if character.characterClass == .fighter {
                HStack(spacing: 4) {
                    Text("★ spec: melee/crossbow +1/+2 dmg (1 slot extra) · bow point-blank +2 (2 slots extra)")
                        .font(Paper.printed(10))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                    RuleLinkButton(ruleID: "cfh_ch04_weapon_proficiency_slots")
                }
                .padding(.horizontal, 4)
                .padding(.top, 2)
            }
        }
    }
}

// MARK: - Proficiências

private struct ProficiencyFormRow: View {
    @Binding var entry: ProficiencyEntry
    /// Repassado pro `ProficiencyPickerSheet` — sugere o alvo de "Chk" a
    /// partir do atributo relevante da proficiência escolhida.
    var abilities: AbilityScores
    /// Campanha vinculada ao personagem (via `character.campaignID`), se
    /// houver — filtra o seletor por `campaignSettings` quando a campanha
    /// tiver `enabledSettings` configurado (ver `Campaign.
    /// allowsAnySetting`). `nil` = sem filtro (personagem avulso).
    var campaign: Campaign?
    /// Repassado só pro `ProficiencyPickerSheet` destacar o grupo da
    /// classe do personagem (item 2 do lote 2026-09-22) — a linha em si
    /// não usa isso em mais nada.
    var characterClass: CharacterClass
    var onDelete: () -> Void

    // Mesmo padrão de toque no nome de `ItemSpellRow` (Magic Item Spells,
    // `SpellSheetView.swift`): tocar o nome abre a DESCRIÇÃO (quando a
    // linha já está ligada a uma proficiência da base), com "change" lá
    // dentro pra trocar; linha vazia ou não-ligada (texto digitado à mão,
    // fichas antigas) abre o seletor direto — não tem descrição nenhuma
    // pra mostrar ainda.
    @EnvironmentObject private var proficiencyDatabase: ProficiencyDatabase
    @State private var showDetail = false
    @State private var showPicker = false

    private var matchedProficiency: Proficiency? {
        if let id = entry.matchedProficiencyID, let match = proficiencyDatabase.proficiency(id: id) {
            return match
        }
        guard !entry.name.isEmpty else { return nil }
        return proficiencyDatabase.proficiencies.first { $0.name == entry.name }
    }

    var body: some View {
        HStack(spacing: 0) {
            Button {
                if matchedProficiency != nil {
                    showDetail = true
                } else {
                    showPicker = true
                }
            } label: {
                Text(entry.name.isEmpty ? "…" : entry.name)
                    .font(Paper.printed(13))
                    .foregroundStyle(entry.name.isEmpty ? Paper.inkSoft : Paper.ink)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)
            EditableNumber(value: $entry.slots, size: 13, lower: 0, upper: 9)
                .frame(width: 40)
            // "Chk" não é uma caixinha de visto — é o número-alvo pra rolar
            // no dado e ter sucesso na checagem da proficiência.
            EditableText(value: $entry.target.orDefault(""), placeholder: "—", size: 12, underline: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .frame(width: 28, height: 24)
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { DottedRule() }
        .sheet(isPresented: $showDetail) {
            if let matchedProficiency {
                ProficiencyDetailSheet(proficiency: matchedProficiency, onChangeProficiency: {
                    showDetail = false
                    DispatchQueue.main.async { showPicker = true }
                })
            }
        }
        .sheet(isPresented: $showPicker) {
            ProficiencyPickerSheet(entry: $entry, abilities: abilities, campaign: campaign,
                                    characterClass: characterClass)
        }
    }
}

/// Distribui uma lista só em três colunas em rodízio (0,3,6… / 1,4,7… /
/// 2,5,8…), pra parecer com as três tabelas lado a lado do PDF sem
/// precisar manter três listas separadas no modelo.
private struct ProficiencyColumn: View {
    let items: Binding<[ProficiencyEntry]>
    let column: Int
    var abilities: AbilityScores
    var campaign: Campaign?
    var characterClass: CharacterClass

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Proficiency").frame(maxWidth: .infinity, alignment: .leading)
                Text("Slots").frame(width: 40)
                Text("Chk").frame(width: 28)
                Text("").frame(width: 24)
            }
            .font(Paper.printed(11))
            .lineLimit(1)
            .minimumScaleFactor(0.65)
            .foregroundStyle(Paper.ink)
            .padding(4)
            .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1) }

            ForEach(indices, id: \.self) { index in
                ProficiencyFormRow(entry: items[index], abilities: abilities, campaign: campaign,
                                    characterClass: characterClass, onDelete: {
                    items.wrappedValue.remove(at: index)
                })
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.1))
    }

    private var indices: [Int] {
        Array(stride(from: column, to: items.wrappedValue.count, by: 3))
    }
}

private struct ProficienciesForm: View {
    @Binding var character: PlayerCharacter
    /// Mesmo `campaignBinding` que já percorre `OfficialRecordSheet` inteira
    /// (sessões, notebook etc.) — repassado aqui só pra ler `enabledSettings`
    /// e filtrar o seletor de proficiência por campaign setting. `nil`
    /// quando o personagem está avulso (sem campanha vinculada).
    var campaignBinding: Binding<Campaign>? = nil

    private var items: Binding<[ProficiencyEntry]> { $character.proficiencies.orInit([]) }
    private var campaign: Campaign? { campaignBinding?.wrappedValue }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Proficiencies", ruleID: "phb_ch05_proficiencies")
            // Item 4 do feedback (2026-09-30): reforça, do lado de fora da
            // tabela, que esta lista é só de Nonweapon Proficiencies — as
            // de arma vivem na tabela "Weapon Combat" logo acima (ver nota
            // lá). Sem essa linha o título sozinho ("Proficiencies") não
            // deixava claro que era só metade da história.
            Text("Nonweapon only — Weapon Proficiencies are the weapons listed above, in Weapon Combat.")
                .font(Paper.printedItalic(10))
                .foregroundStyle(Paper.inkSoft)
                .padding(.horizontal, 4)
            HStack(alignment: .top, spacing: 10) {
                ProficiencyColumn(items: items, column: 0, abilities: character.abilities, campaign: campaign,
                                   characterClass: character.characterClass)
                ProficiencyColumn(items: items, column: 1, abilities: character.abilities, campaign: campaign,
                                   characterClass: character.characterClass)
                ProficiencyColumn(items: items, column: 2, abilities: character.abilities, campaign: campaign,
                                   characterClass: character.characterClass)
            }
            // Item 5 do pedido do usuário (2026-09-24): avisa quando
            // `RecordHeaderForm.addBonusProficiencies(forKit:)` acrescenta
            // uma proficiência sozinho ao escolher/trocar de Kit.
            .changeFlash(character: $character, key: "proficiencies")
            AddLineButton(title: "add proficiency") {
                items.wrappedValue.append(ProficiencyEntry())
            }
            .padding(.horizontal, 4)
        }
        // Começa com 6 linhas em branco (2 por coluna, no rodízio de 3
        // colunas), gravadas de verdade, mesmo motivo do
        // CombatModifiersForm acima — só na primeira vez (checa se a lista
        // ainda está vazia).
        .onAppear {
            guard character.proficiencies?.isEmpty ?? true else { return }
            character.proficiencies = (0..<6).map { _ in ProficiencyEntry() }
        }
    }
}

// MARK: - Thieving Skills (grupo Rogue: Thief/Bard/Ninja)

/// Seção nova (2026-09-30) só pra quem tem `hasThievingSkills` — uma
/// habilidade por linha, nome fixo (não editável, vem de
/// `ThievingSkillsTable.skills(for:)`), um único campo de % livre.
/// Semeada uma vez com Base+Raça+Destreza (`ThievingSkillsTable.seedTotal`)
/// quando a lista nasce ou quando a classe muda pra uma do grupo Rogue
/// (ver `onChange` abaixo) — nunca recalculada depois disso, mesmo padrão
/// de "semear sem atropelar" do resto do app. O ajuste de armadura (Table
/// 29/Table 5) fica de fora do cálculo — o app não sabe o TIPO de armadura
/// vestida, só o valor de AC (ver doc de `ThievingSkillsTable`) — e vem
/// como tabela de consulta na 4ª página (`RogueReferencePage`).
private struct ThievingSkillsForm: View {
    @Binding var character: PlayerCharacter

    private var items: Binding<[ThievingSkillEntry]> { $character.thievingSkills.orInit([]) }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Thieving Skills", ruleID: "phb_ch03_thief_skill_explanations")
            Text("Base + race + Dexterity, seeded once — add your per-level discretionary points and any armor adjustment (see the Rogue Reference page) by hand.")
                .font(Paper.printedItalic(10))
                .foregroundStyle(Paper.inkSoft)
                .padding(.horizontal, 4)

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Skill").frame(maxWidth: .infinity, alignment: .leading)
                    Text("%").frame(width: 56)
                }
                .font(Paper.printed(11))
                .lineLimit(1)
                .foregroundStyle(Paper.ink)
                .padding(4)
                .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1) }

                ForEach(items) { $entry in
                    HStack(spacing: 0) {
                        Text(entry.skill)
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.ink)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        EditableText(value: $entry.value, placeholder: "—", size: 13, underline: false)
                            .frame(width: 56)
                    }
                    .padding(.vertical, 3)
                    .padding(.horizontal, 4)
                    .overlay(alignment: .bottom) { DottedRule() }
                }
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.1))

            if character.characterClass == .thief || character.characterClass == .ninja {
                HStack(spacing: 4) {
                    Text("Backstab at level \(character.level): \(ThievingSkillsTable.backstabMultiplier(level: character.level)) damage")
                        .font(Paper.printed(10))
                        .foregroundStyle(Paper.inkSoft)
                    RuleLinkButton(ruleID: "phb_ch03_rogue_tables")
                }
                .padding(.horizontal, 4)
            }
        }
        // Semeia quando a lista de skills esperada pra classe atual ainda
        // não bate com o que está salvo — cobre tanto "ficha nova" quanto
        // "acabou de trocar pra uma classe do grupo Rogue" (ex. virou
        // Bard), sem nunca reescrever uma linha que já existe com o mesmo
        // nome (o jogador pode ter editado `value` à mão).
        .onAppear { seedIfNeeded() }
        .onChange(of: character.characterClass) { _, _ in seedIfNeeded() }
    }

    private func seedIfNeeded() {
        let expected = ThievingSkillsTable.skills(for: character.characterClass)
        guard !expected.isEmpty else { return }
        var current = character.thievingSkills ?? []
        let existingNames = Set(current.map(\.skill))
        guard existingNames != Set(expected) else { return }
        // Troca de classe dentro do grupo Rogue (ex. Thief → Bard): tira
        // as linhas que não pertencem mais à nova classe e acrescenta as
        // que faltam, preservando o valor de quem já existia e continua
        // valendo (ex. "Pick Pockets" existe pras três classes).
        current.removeAll { !expected.contains($0.skill) }
        for skill in expected where !current.contains(where: { $0.skill == skill }) {
            let seeded = ThievingSkillsTable.seedTotal(skill: skill, characterClass: character.characterClass,
                                                        race: character.race, dexterity: character.abilities.dexterity)
            current.append(ThievingSkillEntry(skill: skill, value: seeded))
        }
        // Mantém a ordem canônica de `expected` em vez da ordem de
        // inserção (que ficaria com as linhas novas todas no fim).
        current.sort { (expected.firstIndex(of: $0.skill) ?? 0) < (expected.firstIndex(of: $1.skill) ?? 0) }
        character.thievingSkills = current
    }
}

// MARK: - Armadura (fora da página 1 do PDF — agora mora na página 2)

private struct ArmorBlock: View {
    @Binding var character: PlayerCharacter
    @State private var showArmorPicker = false
    // Item 7 do pedido do usuário (2026-09-24): o seletor de armadura
    // ("Armor") já existia, mas "Shield" ficava só como texto livre — sem
    // seletor nenhum, e sem AC pra sugerir (ver `ArmorPickerSheet`).
    @State private var showShieldPicker = false

    // Precisa da base de Magic Items aqui (não só em `RecordSheetPageTwo`)
    // porque tanto mudar a Armor/Shield escolhida QUANTO mudar a lista de
    // Magic Items pode afetar o AC final — ver
    // `ConsequenceEngine.recalculateArmorClass`.
    @EnvironmentObject private var magicItemDatabase: MagicItemDatabase

    var body: some View {
        SheetBlock(title: "Armor", trailing: "base AC 10") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 12)],
                      alignment: .leading, spacing: 2) {
                ArmorField(label: "Armor", value: $character.armorRating, onPick: { showArmorPicker = true })
                ArmorField(label: "Shield", value: $character.shieldRating, onPick: { showShieldPicker = true })
                ArmorField(label: "Dexterity", value: $character.details.dexterityDefense)
                HStack(spacing: 4) {
                    FieldLabel(text: "Movement")
                    Spacer(minLength: 2)
                    EditableNumber(value: $character.movement, size: 17, lower: 0, upper: 30)
                }
                .overlay(alignment: .bottom) { DottedRule() }
            }
        }
        .sheet(isPresented: $showArmorPicker) {
            ArmorPickerSheet(rating: $character.armorRating, kind: .armor)
        }
        .sheet(isPresented: $showShieldPicker) {
            ArmorPickerSheet(rating: $character.shieldRating, kind: .shield)
        }
        // Item 7: escolher (ou editar a mão) Armor/Shield agora recalcula
        // o AC final da página 1 sozinho — ver
        // `ConsequenceEngine.recalculateArmorClass` pro porquê de não
        // rodar em `onAppear`.
        .onChange(of: character.armorRating) { _, _ in
            ConsequenceEngine.recalculateArmorClass(for: &character, magicItemDatabase: magicItemDatabase)
        }
        .onChange(of: character.shieldRating) { _, _ in
            ConsequenceEngine.recalculateArmorClass(for: &character, magicItemDatabase: magicItemDatabase)
        }
    }
}

private struct ArmorField: View {
    let label: String
    @Binding var value: String
    /// Presente só no campo "Armor" — toca no rótulo (não no número, que
    /// continua editável na hora) pra abrir o Armor Compendium e sugerir o
    /// `baseAC` da armadura escolhida.
    var onPick: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 4) {
            if let onPick {
                Button(action: onPick) {
                    HStack(spacing: 3) {
                        FieldLabel(text: label)
                        Text("ⓘ")
                            .font(Paper.printed(10))
                            .foregroundStyle(Paper.inkSoft)
                    }
                }
                .buttonStyle(.plain)
            } else {
                FieldLabel(text: label)
            }
            Spacer(minLength: 2)
            EditableText(value: $value, placeholder: "—", size: 17, underline: false)
                .fixedSize()
        }
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Listas da ficha

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
                AddLineButton(title: "add") {
                    items.append("")
                }
            }
        }
    }
}

private struct AlliesBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        ListBlock(title: "Allies & Henchmen", items: $character.allies)
    }
}

/// Wild Talent (CPsiH cap. 1 — ver `Models/Character.swift`/`WildTalent`)
/// — rodada "fundação primeiro" dos Psiônicos (2026-10-01). Disponível pra
/// QUALQUER classe (ao contrário de Kit/Spheres, que dependem de
/// `characterClass`), por isso vive aqui na Page 2 em vez de no cabeçalho
/// da ficha, perto de Allies/Languages — mesma ideia de "traço do
/// personagem, não do dia de jogo" que já vale pro resto desta página.
/// `$character.wildTalent.orInit(WildTalent())` materializa o struct na
/// primeira escrita (mesmo padrão de `combat`/`page2MagicItems` — ver
/// `Binding.orInit`), então o bloco já aparece pronto pra preencher, sem
/// precisar de um botão "+ add" separado.
private struct WildTalentBlock: View {
    @Binding var character: PlayerCharacter

    private var wildTalent: Binding<WildTalent> { $character.wildTalent.orInit(WildTalent()) }
    private var powers: Binding<[String]> { wildTalent.powers }
    private var psp: Binding<Int> { wildTalent.psionicStrengthPoints }

    var body: some View {
        SheetBlock(title: "Wild Talent", trailing: "\(powers.wrappedValue.count)") {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text("Any character can test for latent psionic potential, regardless of class.")
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)
                    RuleLinkButton(ruleID: "cpsih_ch01_wild_talents")
                }

                VStack(spacing: 0) {
                    ForEach(powers.wrappedValue.indices, id: \.self) { index in
                        HStack {
                            EditableText(value: powers[index], placeholder: "power name…",
                                         size: 18, underline: false)
                            Spacer(minLength: 0)
                        }
                        .padding(.vertical, 3)
                        .overlay(alignment: .bottom) { DottedRule() }
                    }
                    AddLineButton(title: "power") {
                        powers.wrappedValue.append("")
                    }
                }

                HStack(spacing: 8) {
                    FieldLabel(text: "PSP")
                    EditableNumber(value: psp, size: 15, lower: 0, upper: 999)
                    Spacer(minLength: 0)
                }
            }
        }
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
        SheetBlock(title: "Treasure", trailing: "coins") {
            HStack(spacing: 10) {
                CoinField(label: "PP", value: $treasure.platinum)
                CoinField(label: "GP", value: $treasure.gold)
                CoinField(label: "EP", value: $treasure.electrum)
                CoinField(label: "SP", value: $treasure.silver)
                CoinField(label: "CP", value: $treasure.copper)
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

// Spell Slots (a tabela manual "quantos slots por círculo") e a Experience
// da antiga aba Equipment saíram daqui: a primeira virou automática (ver
// `PlayerCharacter.computedSpellSlotAllotments`, pela Priest Spell
// Progression), e a segunda já vivia espelhada em `ExperienceForm`, na
// página 2 — nenhuma das duas precisava de um lugar novo.
