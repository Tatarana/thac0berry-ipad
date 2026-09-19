import SwiftUI
import UIKit

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
                                               maxPageIndex: character.characterClass.hasSpellSheet ? 2 : 1)
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
                            SpellbookView(character: $character)
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
            // A 3ª página da ficha (tabelas do Clérigo) só existe pra quem
            // tem ficha de magia — se a classe mudou pra outra, volta pra
            // página 1 caso estivesse lá.
            if recordSheetPageIndex > 1 { recordSheetPageIndex = 0 }
            switch page {
            case .spells, .campaignIndex, .spellbook: page = .record
            case .record, .notebook: break
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
        let showSessionBadge = hasSpellSheet && page != .campaignIndex && page != .spellbook

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
                        Label("Priest Spellbook", systemImage: "book.closed")
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
        var sheet = SpellSheet()
        sheet.sessionID = session.id
        sheet.title = "Day 1"
        sheet.wisdomAtCreation = character.abilities.wisdom
        sheet.slotBoard = character.freshSlotBoard()
        character.spellSheets.append(sheet)
        page = .spells(sheet.id)
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
                .foregroundStyle(isSelected ? Paper.chrome : Paper.sheet)
                .frame(width: 38, height: 30)
                .background(isSelected ? Paper.sheet : Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .shadow(color: isSelected ? Ember.glow.opacity(0.7) : .clear, radius: isSelected ? 6 : 0)
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
        if let session {
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
        let previous = daySheets.last
        var sheet: SpellSheet = previous?.nextDay(keepingPreparations: true) ?? SpellSheet()
        sheet.sessionID = session.id
        sheet.slotBoard = reconciled(sheet.slotBoard, with: character.computedSpellSlotAllotments)
        sheet.title = "Day \(daySheets.count + 1)"
        // Congela a Sabedoria de hoje na folha nova — é o valor que vale
        // pra esse dia, mesmo que o personagem mude depois.
        sheet.wisdomAtCreation = character.abilities.wisdom
        character.spellSheets.append(sheet)
        page = .spells(sheet.id)
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
            ProficienciesForm(character: $character)
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
    /// Equipment/Movement/Experience + Character Description).
    fileprivate var maxPageIndex: Int {
        character.characterClass.hasSpellSheet ? 3 : 2
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

            QuantityListBlock(title: "Magic Items", items: $character.page2MagicItems.orInit([]))
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
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
        // A aba Equipment sumiu — antes de morrer, ela guardava a lista de
        // itens e os "Magic Items" numa forma mais simples (só texto). Essa
        // migração roda uma vez só (checa se o destino novo ainda está
        // vazio) pra ninguém perder o que já tinha escrito lá.
        .onAppear { migrateFromOldEquipmentTab() }
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
                    .font(Paper.printedItalic(10))
                    .foregroundStyle(Paper.inkSoft)
                EditableNumber(value: $entry.quantity, size: 13, lower: 0, upper: 9999)
            }

            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

/// Igual ao `ListBlock` já usado na aba Equipment, mas com um contador de
/// quantidade por linha e botão de remover — pra "10 poções de cura" caber
/// numa linha só em vez de dez. Fica separado do `ListBlock` (que a aba
/// Equipment também usa) pra não mudar o comportamento dela.
private struct QuantityListBlock: View {
    let title: String
    @Binding var items: [QuantifiedItem]

    var body: some View {
        SheetBlock(title: title, trailing: "\(items.count)") {
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    QuantifiedItemRow(entry: $items[index], onDelete: {
                        items.remove(at: index)
                    })
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

    var body: some View {
        HStack(spacing: 0) {
            InlineTextField(value: $entry.item, placeholder: "…", fontSize: 13)
                .frame(maxWidth: .infinity, alignment: .leading)
            EditableText(value: $entry.location, placeholder: "—", size: 12, underline: false)
                .frame(width: 56)
            EditableText(value: $entry.weight, placeholder: "—", size: 12, underline: false)
                .frame(width: 36)
            RemoveRowButton(action: onDelete)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { DottedRule() }
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
            .font(Paper.printed(10))
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
                .font(Paper.printed(10))
                .foregroundStyle(Paper.ink)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
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
            FormSectionTitle(text: "Encumbrance")

            HStack(spacing: 4) {
                Text("").frame(width: 62)
                Text("Wt").font(Paper.printed(8.5)).frame(maxWidth: .infinity)
                Text("Move").font(Paper.printed(8.5)).frame(maxWidth: .infinity)
                Text("Atk").font(Paper.printed(8.5)).frame(maxWidth: .infinity)
                Text("AC").font(Paper.printed(8.5)).frame(maxWidth: .infinity)
            }
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
                .font(Paper.printed(9))
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
            }
            .padding(.bottom, 2)

            CombatLine(label: "Kit Modifier", value: $character.xpKitModifier.orDefault(""))
            CombatLine(label: "Ability Bonus", value: $character.xpAbilityBonus.orDefault(""))
            CombatLine(label: "Subrace Modifier", value: $character.xpSubraceModifier.orDefault(""))
            CombatLine(label: "Level Limit", value: $character.xpLevelLimit.orDefault(""))
        }
        .padding(10)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
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

    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(Paper.printed(10))
                .foregroundStyle(Paper.ink)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
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
                Text("By").font(Paper.printed(9)).frame(maxWidth: .infinity)
                Text("At Levels").font(Paper.printed(9)).frame(maxWidth: .infinity)
            }
            .foregroundStyle(Paper.inkSoft)

            LevelChangeRowView(title: "THAC0", row: table.thac0)
            LevelChangeRowView(title: "Saving Throws", row: table.savingThrows)
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

    var body: some View {
        Text(text.uppercased())
            .font(Paper.printed(14))
            .tracking(1.4)
            .foregroundStyle(Paper.ink)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 3)
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
                    .font(.system(size: 7.5, design: .serif))
                    .foregroundStyle(Paper.inkSoft)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.75)
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

    var body: some View {
        EditableNumber(value: $value, size: 22, lower: lower, upper: upper)
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

    var body: some View {
        VStack(spacing: 3) {
            Text("ARMOR").font(Paper.printed(10)).tracking(1.5)
            ZStack {
                ShieldShape().stroke(Paper.ink, lineWidth: 1.6)
                EditableNumber(value: $armorClass, size: 28, lower: -10, upper: 10)
                    .padding(.top, 6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
            }
            .frame(width: 76, height: 84)
            Text("CLASS").font(Paper.printed(10)).tracking(1.5)
        }
        .foregroundStyle(Paper.ink)
    }
}

// MARK: - Cabeçalho da ficha

private struct RecordHeaderForm: View {
    @Binding var character: PlayerCharacter
    var campaignBinding: Binding<Campaign>? = nil
    /// Fase 6 do plano: subir de nível ganha uma rajada de brasa em cima do
    /// campo — só quando o número SOBE (editar pra baixo, corrigindo um
    /// erro de digitação, não é level up).
    @State private var isLevelingUp = false

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
                            EditableText(value: $character.kit.orDefault(""), placeholder: "",
                                         size: 17, underline: false)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    HeaderLine(label: "Level") {
                        EditableNumber(value: $character.level, size: 17, lower: 0, upper: 30)
                    }
                    .frame(width: 80)
                    .emberBurst(trigger: isLevelingUp, particleCount: 18)
                }

                HStack(alignment: .bottom, spacing: 16) {
                    HeaderLine(label: "Race") {
                        EditableText(value: $character.race, placeholder: "", size: 17, underline: false)
                    }
                    .frame(maxWidth: .infinity)

                    HeaderLine(label: "Alignment") {
                        EditableText(value: $character.alignment, placeholder: "", size: 17, underline: false)
                    }
                    .frame(maxWidth: .infinity)
                }

                HStack(alignment: .bottom, spacing: 16) {
                    HeaderLine(label: "Patron Deity / Religion") {
                        InlineTextField(value: $character.deity, placeholder: "", fontSize: 15)
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
                if let recordBadge {
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
            guard newLevel > oldLevel else { return }
            isLevelingUp = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                isLevelingUp = false
            }
        }
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
        guard option.hasSpellSheet, character.spellSheets.isEmpty, let campaignBinding else { return }
        let session = campaignBinding.wrappedValue.activeSession()
        var sheet = SpellSheet()
        sheet.sessionID = session.id
        sheet.title = "First day"
        sheet.wisdomAtCreation = character.abilities.wisdom
        sheet.slotBoard = character.freshSlotBoard()
        character.spellSheets = [sheet]
    }
}

// MARK: - Atributos

private struct AbilityRowForm: View {
    let name: String
    @Binding var score: Int
    let cells: [(String, Binding<String>)]

    var body: some View {
        HStack(spacing: 0) {
            Text(name)
                .font(Paper.printed(16))
                .fontWeight(.bold)
                .foregroundStyle(Paper.ink)
                .frame(width: 46, alignment: .leading)
                .padding(.leading, 2)
            FormNumberCell(value: $score, lower: 1, upper: 25)
                .frame(width: 52)
            ForEach(cells.indices, id: \.self) { index in
                FormCell(label: cells[index].0, value: cells[index].1)
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
                AbilityRowForm(name: "STR", score: $character.abilities.strength, cells: [
                    ("Hit\nAdj", $character.details.strengthHit),
                    ("Dmg\nAdj", $character.details.strengthDamage),
                    ("Weight\nAllow", $character.details.strengthWeight),
                    ("Max\nPress", $character.details.strengthMaxPress),
                    ("Open\nDoors", $character.details.strengthDoors),
                    ("Bend\nBars", $character.details.strengthBars)
                ])
                AbilityRowForm(name: "DEX", score: $character.abilities.dexterity, cells: [
                    ("Surprise\nAdjustment", $character.details.dexterityReaction),
                    ("Missile Att\nAdjustment", $character.details.dexterityMissile),
                    ("Defensive\nAdjustment", $character.details.dexterityDefense)
                ])
                AbilityRowForm(name: "CON", score: $character.abilities.constitution, cells: [
                    ("HP\nAdj", $character.details.constitutionHP),
                    ("System\nShock", $character.details.constitutionShock),
                    ("Resurrect\nSurvival", $character.details.constitutionResurrection),
                    ("Poison\nSave", $character.details.constitutionPoison),
                    ("Regen", $character.details.constitutionRegen.orDefault(""))
                ])
                AbilityRowForm(name: "INT", score: $character.abilities.intelligence, cells: [
                    ("Languages", $character.details.intelligenceLanguages),
                    ("Spell\nLevel", $character.details.intelligenceMaxLevel),
                    ("Learn\nSpell", $character.details.intelligenceLearn),
                    ("Max/\nLevel", $character.details.intelligenceMaxPerLevel),
                    ("Spell\nImmun", $character.details.intelligenceSpellImmunity.orDefault(""))
                ])
                AbilityRowForm(name: "WIS", score: $character.abilities.wisdom, cells: [
                    ("Magical\nDef Adj", $character.details.wisdomDefense),
                    ("Bonus\nSpells", $character.details.wisdomBonusSpells),
                    ("Spell\nFailure", $character.details.wisdomFailure),
                    ("Spell\nImmun", $character.details.wisdomSpellImmunity.orDefault(""))
                ])
                AbilityRowForm(name: "CHA", score: $character.abilities.charisma, cells: [
                    ("Max # of\nHenchmen", $character.details.charismaHenchmen),
                    ("Loyalty\nBase", $character.details.charismaLoyalty),
                    ("Reaction\nAdjustment", $character.details.charismaReaction)
                ])
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
        }
    }
}

// MARK: - Jogadas de proteção
//
// Simplificação assumida: o PDF real tem colunas Start/Mod/Total pra cada
// jogada; o app guarda só um número (o alvo do d20, direto da tabela da
// classe) — mantido assim pra não abrir uma frente nova de mudança de
// modelo. A tabela aqui vira Jogada/Alvo/Modificador.
private struct SavingThrowsForm: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FormSectionTitle(text: "Saving Throws")
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("").frame(maxWidth: .infinity, alignment: .leading)
                    Text("Target").font(.system(size: 7.5, design: .serif)).frame(width: 40)
                    Text("Mod").font(.system(size: 7.5, design: .serif)).frame(width: 46)
                }
                .foregroundStyle(Paper.inkSoft)
                .padding(.vertical, 3)
                .padding(.horizontal, 4)

                ForEach(SavingThrows.labels) { entry in
                    SaveLineForm(saves: $character.saves, entry: entry)
                }
                SaveResistanceLine(saves: $character.saves)
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
        }
    }
}

private struct SaveLineForm: View {
    @Binding var saves: SavingThrows
    let entry: SavingThrows.SaveEntry

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
                size: 17, lower: 1, upper: 20
            )
            .frame(width: 40, height: 32)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
            EditableText(
                value: Binding(
                    get: { saves.modifier(for: entry.id) },
                    set: { saves.setModifier($0, for: entry.id) }
                ),
                placeholder: "—", size: 13, underline: false
            )
            .frame(width: 46, height: 32)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
        }
        .frame(minHeight: 32)
    }
}

private struct SaveResistanceLine: View {
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
                    ArmorClassShield(armorClass: $character.armorClass)

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
                                Text("Hit Dice:").font(Paper.printed(10))
                                EditableText(value: combat.hitDiceType.orDefault(""), placeholder: "d",
                                             size: 13, underline: false)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .contentShape(Rectangle())
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
                                             allowsSoftwareKeyboard: true, onCommit: commit, fontSize: 20)
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
        character.hitPointsCurrent -= dmg
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
    private let cellWidth: CGFloat = 34

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Text("THAC0").font(Paper.printed(12)).tracking(1).foregroundStyle(Paper.ink)
                EditableNumber(value: $character.thac0, size: 17, lower: -10, upper: 25)
                    .frame(width: 40, height: 30)
                    .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
                Text("(base — the table below fills itself in)")
                    .font(Paper.printedItalic(10))
                    .foregroundStyle(Paper.inkSoft)
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
                            Text("\(ac)")
                                .font(Paper.printed(12))
                                .fontWeight(ac == 0 ? .bold : .regular)
                                .foregroundStyle(ac == 0 ? Paper.sheet : Paper.ink)
                                .frame(width: cellWidth, height: 28)
                                .background(ac == 0 ? Paper.ink : Color.clear)
                                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
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
                penalty.note = character.nonProficiencyPenalty ?? ""
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
    var onDelete: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            InlineTextField(value: $weapon.name, placeholder: "…", fontSize: 15)
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

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Weapon Combat")
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
                    .font(Paper.printed(10.5))
                    .foregroundStyle(Paper.ink)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 4)
                    .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1.2) }

                    ForEach($character.weapons) { $weapon in
                        WeaponFormRow(weapon: $weapon, onDelete: {
                            character.weapons.removeAll { $0.id == weapon.id }
                        })
                    }
                }
                .frame(minWidth: availableWidth, alignment: .leading)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
            }
            .background(WidthReader(width: $availableWidth))

            AddLineButton(title: "add weapon") {
                character.weapons.append(WeaponEntry())
            }
            .padding(.horizontal, 4)
        }
    }
}

// MARK: - Proficiências

private struct ProficiencyFormRow: View {
    @Binding var entry: ProficiencyEntry
    var onDelete: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            InlineTextField(value: $entry.name, placeholder: "…", fontSize: 13)
                .frame(maxWidth: .infinity, alignment: .leading)
            EditableText(value: $entry.slots, placeholder: "—", size: 12, underline: false)
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
    }
}

/// Distribui uma lista só em três colunas em rodízio (0,3,6… / 1,4,7… /
/// 2,5,8…), pra parecer com as três tabelas lado a lado do PDF sem
/// precisar manter três listas separadas no modelo.
private struct ProficiencyColumn: View {
    let items: Binding<[ProficiencyEntry]>
    let column: Int

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Proficiency").frame(maxWidth: .infinity, alignment: .leading)
                Text("Slots").frame(width: 40)
                Text("Chk").frame(width: 28)
                Text("").frame(width: 24)
            }
            .font(Paper.printed(10))
            .foregroundStyle(Paper.ink)
            .padding(4)
            .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1) }

            ForEach(indices, id: \.self) { index in
                ProficiencyFormRow(entry: items[index], onDelete: {
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

    private var items: Binding<[ProficiencyEntry]> { $character.proficiencies.orInit([]) }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            FormSectionTitle(text: "Proficiencies")
            HStack(alignment: .top, spacing: 10) {
                ProficiencyColumn(items: items, column: 0)
                ProficiencyColumn(items: items, column: 1)
                ProficiencyColumn(items: items, column: 2)
            }
            AddLineButton(title: "add proficiency") {
                items.wrappedValue.append(ProficiencyEntry())
            }
            .padding(.horizontal, 4)
        }
        // Se a ficha já tinha proficiências de arma/perícias da extinta aba
        // Equipment, herda delas em vez de nascer em branco — só na
        // primeira vez (checa se a lista nova ainda está vazia). Sem
        // nenhuma das duas, começa com 6 linhas em branco (2 por coluna, no
        // rodízio de 3 colunas), gravadas de verdade, mesmo motivo do
        // CombatModifiersForm acima.
        .onAppear {
            guard character.proficiencies?.isEmpty ?? true else { return }
            let inherited = character.weaponProficiencies.map { ProficiencyEntry(name: $0, slots: "weapon") }
                + character.skills.map { ProficiencyEntry(name: $0.name, slots: $0.note) }
            character.proficiencies = inherited.isEmpty
                ? (0..<6).map { _ in ProficiencyEntry() }
                : inherited
        }
    }
}

// MARK: - Armadura (fora da página 1 do PDF — agora mora na página 2)

private struct ArmorBlock: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        SheetBlock(title: "Armor", trailing: "base AC 10") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 12)],
                      alignment: .leading, spacing: 2) {
                ArmorField(label: "Armor", value: $character.armorRating)
                ArmorField(label: "Shield", value: $character.shieldRating)
                ArmorField(label: "Dexterity", value: $character.details.dexterityDefense)
                HStack(spacing: 4) {
                    FieldLabel(text: "Movement")
                    Spacer(minLength: 2)
                    EditableNumber(value: $character.movement, size: 17, lower: 0, upper: 30)
                }
                .overlay(alignment: .bottom) { DottedRule() }
            }
        }
    }
}

private struct ArmorField: View {
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
