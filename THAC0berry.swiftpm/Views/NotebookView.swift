import SwiftUI
import UIKit
import PencilKit

/// O caderno vira um livro de verdade: folheado com o mesmo curl de página
/// do UIPageViewController que a Ficha de Magias já usa (ver
/// `DayPagerView`), em vez de uma lista rolável de cartões. Desde o formato
/// 2 (2026-10-06) o caderno é do PERSONAGEM (`PlayerCharacter.notebookEntries`):
/// cada personagem de cada jogador tem o seu.
struct NotebookPagerView: UIViewControllerRepresentable {
    @Binding var entries: [NotebookEntry]
    @Binding var currentID: UUID

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pager = UIPageViewController(transitionStyle: .pageCurl,
                                         navigationOrientation: .horizontal,
                                         options: nil)
        pager.dataSource = context.coordinator
        pager.delegate = context.coordinator
        pager.view.backgroundColor = .clear
        if let first = context.coordinator.makePage(for: currentID) {
            pager.setViewControllers([first], direction: .forward, animated: false)
        }
        return pager
    }

    func updateUIViewController(_ pager: UIPageViewController, context: Context) {
        context.coordinator.parent = self

        // Mesma proteção que o DayPagerView usa: o UIPageViewController não
        // aguenta um segundo setViewControllers(animated:) enquanto o
        // primeiro curl ainda está andando.
        guard !context.coordinator.isTransitioning else { return }

        let visibleID = (pager.viewControllers?.first as? NotebookPageController)?.entryID

        if visibleID != currentID {
            guard let target = context.coordinator.makePage(for: currentID) else { return }
            let forward = isForward(from: visibleID, to: currentID)
            context.coordinator.isTransitioning = true
            pager.setViewControllers([target], direction: forward ? .forward : .reverse,
                                     animated: true) { _ in
                context.coordinator.isTransitioning = false
            }
        } else if let visible = pager.viewControllers?.first as? NotebookPageController {
            visible.rootView = pageContent(for: visible.entryID, readiness: visible.readiness)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    // MARK: - Conteúdo e vizinhança

    fileprivate func pageContent(for id: UUID, readiness: PageReadiness) -> AnyView {
        guard let index = entries.firstIndex(where: { $0.id == id }) else {
            return AnyView(
                Text("This page is no longer in the notebook.")
                    .font(Paper.printedItalic(14))
                    .foregroundStyle(Paper.inkSoft)
                    .padding(40)
            )
        }
        return AnyView(
            NotebookPageView(
                entry: Binding(
                    get: { entries[index] },
                    set: { newValue in
                        guard entries.indices.contains(index) else { return }
                        entries[index] = newValue
                    }
                ),
                pageNumber: index + 1,
                pageCount: entries.count,
                onDelete: { deleteEntry(id) },
                pageReadiness: readiness
            )
            .padding(18)
        )
    }

    /// Toda folha do caderno inteiro, em ordem — sem separar por sessão:
    /// o caderno é um único fio contínuo.
    private func orderedIDs() -> [UUID] {
        entries.sorted { $0.date < $1.date }.map(\.id)
    }

    fileprivate func neighborID(of id: UUID, forward: Bool) -> UUID? {
        let ordered = orderedIDs()
        guard let position = ordered.firstIndex(of: id) else { return nil }
        let nextIndex = forward ? position + 1 : position - 1
        guard ordered.indices.contains(nextIndex) else { return nil }
        return ordered[nextIndex]
    }

    private func isForward(from: UUID?, to: UUID) -> Bool {
        guard let from,
              let fromDate = entries.first(where: { $0.id == from })?.date,
              let toDate = entries.first(where: { $0.id == to })?.date
        else { return true }
        return toDate >= fromDate
    }

    /// Apaga a página; se era a que estava aberta, folheia pra uma vizinha
    /// em vez de deixar o livro parado num id que não existe mais.
    private func deleteEntry(_ id: UUID) {
        let fallback = neighborID(of: id, forward: false) ?? neighborID(of: id, forward: true)
        entries.removeAll { $0.id == id }
        if currentID == id, let fallback {
            currentID = fallback
        }
    }

    // MARK: - Coordinator

    final class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: NotebookPagerView
        var isTransitioning = false

        init(_ parent: NotebookPagerView) {
            self.parent = parent
        }

        fileprivate func makePage(for id: UUID) -> NotebookPageController? {
            // Cada folha ganha sua PRÓPRIA `PageReadiness` — ver o comentário
            // em `PageReadiness` e em `NotebookPageController.viewDidAppear`
            // pra causa raiz do crash que isso resolve.
            let readiness = PageReadiness()
            return NotebookPageController(entryID: id,
                                          rootView: parent.pageContent(for: id, readiness: readiness),
                                          readiness: readiness)
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let current = (viewController as? NotebookPageController)?.entryID,
                  let previousID = parent.neighborID(of: current, forward: false)
            else { return nil }
            return makePage(for: previousID)
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let current = (viewController as? NotebookPageController)?.entryID,
                  let nextID = parent.neighborID(of: current, forward: true)
            else { return nil }
            return makePage(for: nextID)
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
                  let visible = pageViewController.viewControllers?.first as? NotebookPageController
            else { return }
            parent.currentID = visible.entryID
            visible.rootView = parent.pageContent(for: visible.entryID, readiness: visible.readiness)
        }
    }
}

/// Sinaliza quando UMA folha específica do caderno terminou de "aparecer"
/// de verdade — ver `NotebookPageController.viewDidAppear` — pra quem
/// precisa saber que a animação de curl da página já passou, não só que a
/// view entrou numa janela. Um objeto por folha (criado em `Coordinator.
/// makePage`), guardado tanto no controller (que o completa) quanto na
/// própria `DrawingCanvas` (que espera por ele) — não é `ObservableObject`
/// de propósito: é só uma campainha de disparo único, sem precisar de
/// Combine/SwiftUI pra isso.
final class PageReadiness {
    private var pending: (() -> Void)?
    private(set) var isReady = false

    /// Chama `block` assim que a folha terminar de aparecer — na hora, se
    /// isso já tiver acontecido (ex.: reabrindo uma folha que já apareceu
    /// antes e só teve o conteúdo atualizado no lugar).
    func onReady(_ block: @escaping () -> Void) {
        if isReady {
            block()
        } else {
            pending = block
        }
    }

    func markReady() {
        guard !isReady else { return }
        isReady = true
        let block = pending
        pending = nil
        block?()
    }
}

/// Marca cada página do UIPageViewController com o id da folha do caderno
/// que ela representa — mesmo truque do `DayPageController`.
private final class NotebookPageController: UIHostingController<AnyView> {
    let entryID: UUID
    let readiness: PageReadiness

    init(entryID: UUID, rootView: AnyView, readiness: PageReadiness) {
        self.entryID = entryID
        self.readiness = readiness
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // AJUSTE (crash na criação de página "Freeform"): a tentativa anterior
    // (adiar o anexo do PKToolPicker com `DispatchQueue.main.async`) não
    // resolveu — o usuário confirmou "está exatamente igual". Um só ciclo
    // do run loop não é garantia nenhuma de que a animação de curl do
    // `UIPageViewController` já tenha terminado; a curl roda por várias
    // dezenas de ciclos. `viewDidAppear` é o sinal de verdade que o UIKit
    // já dá pra "esta página terminou de aparecer" — inclusive depois do
    // curl, tanto pra troca animada (`+` numa folha já existente) quanto
    // pra primeira folha (`animated: false`, onde ele dispara assim que o
    // pager entra na janela). `PageReadiness` carrega esse aviso até a
    // `DrawingCanvas` correspondente, que só aí liga o `PKToolPicker` e
    // pede o first responder — nunca mais no meio da transação de
    // animação que o UIPageViewController ainda está processando.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readiness.markReady()
    }
}

/// A linha de páginas do caderno — mesma metáfora de contas de tinta numa
/// linha de costura que a Priest Spell Sheet usa (`DayThreadRow`), agora
/// existindo também aqui: antes o caderno não tinha nenhum indicador de
/// posição, só o gesto de arrastar. O "+" no fim abre o mesmo menu de
/// escolha (transcrita ou desenho livre) que antes vivia solto na fileira
/// global de abas.
struct NotebookBeadRow: View {
    @Binding var entries: [NotebookEntry]
    // Item 3 do pedido do usuário (2026-09-24): folha nova nasce com o
    // estilo de papel padrão configurado em Settings.
    @EnvironmentObject private var library: CharacterLibrary
    /// Qual página está aberta — era um `Binding<CharacterSheetView.SheetPage>`
    /// direto, mas isso amarrava o caderno a sempre estar dentro de uma
    /// `CharacterSheetView`. Desacoplado pra `Binding<UUID?>` puro: dentro
    /// da ficha de personagem, `CharacterSheetView.notebookSelection` faz a
    /// ponte pra `page`.
    @Binding var selection: UUID?
    let currentID: UUID

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 13) {
                ForEach(Array(ordered.enumerated()), id: \.element.id) { index, entry in
                    InkDayBead(number: index + 1, isSelected: entry.id == currentID) {
                        selection = entry.id
                    }
                    .contextMenu {
                        if ordered.count > 1 {
                            Button("Delete page", role: .destructive) { delete(entry) }
                        }
                    }
                }

                Menu {
                    Button("Transcribed page") { addPage(.transcribed) }
                    Button("Freeform page (draw)") { addPage(.freeform) }
                } label: {
                    AddBeadLabel()
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

            if let title = currentTitle, !title.isEmpty {
                Text(title)
                    .font(Paper.printedItalic(10.5))
                    .foregroundStyle(Paper.inkSoft)
                    .padding(.leading, 3)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 2)
    }

    private var ordered: [NotebookEntry] {
        entries.sorted { $0.date < $1.date }
    }

    private var currentTitle: String? {
        ordered.first { $0.id == currentID }?.title
    }

    private func addPage(_ kind: NotebookPageKind) {
        selection = entries.addNotebookPage(kind: kind, paperStyle: library.defaultNotebookPaperStyle)
    }

    /// Apaga a página; se era a que estava aberta, pula pra uma vizinha.
    private func delete(_ entry: NotebookEntry) {
        guard ordered.count > 1 else { return }
        let ordered = self.ordered
        let fallback: UUID? = {
            guard let position = ordered.firstIndex(where: { $0.id == entry.id }) else { return nil }
            if ordered.indices.contains(position - 1) { return ordered[position - 1].id }
            if ordered.indices.contains(position + 1) { return ordered[position + 1].id }
            return nil
        }()
        entries.removeAll { $0.id == entry.id }
        if currentID == entry.id, let fallback {
            selection = fallback
        }
    }
}

// MARK: - Uma folha do caderno

/// Uma folha só: cabeçalho (data, título, tipo, apagar) e o conteúdo, que
/// muda conforme o tipo escolhido na criação — transcrita ou desenho livre.
private struct NotebookPageView: View {
    @Binding var entry: NotebookEntry
    let pageNumber: Int
    let pageCount: Int
    let onDelete: () -> Void
    let pageReadiness: PageReadiness

    private var kind: NotebookPageKind { entry.kind ?? .transcribed }

    // Item 2 do pedido do usuário (2026-09-24): "crie mais dois estilos de
    // folha: pautada e quadriculada, com a opção de trocar qual tipo de
    // folha" — folha SEM `paperStyle` salvo (criada antes deste pedido, ou
    // nunca trocada) cai pra `.plain`, que já era o único estilo que
    // existia.
    private var style: NotebookPaperStyle { entry.paperStyle ?? .plain }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            header
            content
        }
        .padding(14)
        // Mesmo verniz claro que as outras folhas da ficha usam por cima
        // do pergaminho (Official Record Sheet, tabelas do Clérigo, etc.)
        // — sem ele a área de escrita/desenho ficava puxando pro tom mais
        // escuro e "sujo" do grão do papel logo atrás dela.
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("page \(pageNumber) of \(pageCount)")
                .font(Paper.printed(10))
                .tracking(1.4)
                .foregroundStyle(Paper.inkSoft)

            DatePicker("", selection: $entry.date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .tint(Paper.ink)

            InlineTextField(value: $entry.title, placeholder: "untitled page", fontSize: 17)

            Spacer(minLength: 4)

            Text(kind == .freeform ? "✎ free draw" : "✒︎ transcribed")
                .font(Paper.printedItalic(11))
                .foregroundStyle(Paper.inkSoft)

            // Item 2: troca o estilo de papel DESTA folha — cada folha
            // guarda a própria escolha (ver `NotebookEntry.paperStyle`),
            // independente do padrão configurado em Settings (item 3), que
            // só vale pra folha nova.
            Menu {
                ForEach(NotebookPaperStyle.allCases, id: \.self) { option in
                    Button {
                        entry.paperStyle = option
                    } label: {
                        if option == style {
                            Label(option.label, systemImage: "checkmark")
                        } else {
                            Text(option.label)
                        }
                    }
                }
            } label: {
                Text(style.label)
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
                    .underline()
            }

            Button(action: onDelete) {
                Text("✕")
                    .font(Paper.printed(14))
                    .foregroundStyle(Paper.redInk)
                    .frame(width: 30, height: 30)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch kind {
        case .transcribed:
            // Escreve com a caneta ou o teclado — o Scribble do sistema
            // transcreve pra texto de verdade, editável e pesquisável.
            NotebookTextArea(text: $entry.text,
                              placeholder: "Write freely — NPCs met, clues, decisions made…")
                .frame(minHeight: 420)
                .background(NotebookPaperTexture(style: style))
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
        case .freeform:
            // Tela de desenho de verdade — sem transcrição nenhuma, pra
            // quem tem letra feia ou quer desenhar um mapa/rabisco.
            DrawingCanvas(drawingData: $entry.drawingData, readiness: pageReadiness)
                .frame(minHeight: 420)
                .background(NotebookPaperTexture(style: style))
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
        }
    }
}

/// O desenho de fundo de uma folha — item 2 do pedido do usuário
/// (2026-09-24). `.plain` não desenha nada (folha lisa, comportamento
/// idêntico a antes deste pedido existir); `.lined` desenha linhas
/// horizontais tipo caderno pautado; `.grid` desenha uma malha quadriculada.
/// Fica só como FUNDO (`.background`) atrás do texto/traço — nunca captura
/// toque nem atrapalha o Scribble/PencilKit por cima.
private struct NotebookPaperTexture: View {
    let style: NotebookPaperStyle

    /// Mesmo tom (`Paper.inkSoft`) já usado pros rótulos secundários da
    /// ficha, bem apagado — o objetivo é sugerir "papel pautado/
    /// quadriculado de verdade", não competir visualmente com a tinta
    /// escrita por cima.
    private var lineColor: Color { Paper.inkSoft.opacity(0.28) }

    var body: some View {
        Canvas { context, size in
            switch style {
            case .plain:
                break
            case .lined:
                let spacing: CGFloat = 28
                var y = spacing
                while y < size.height {
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                    context.stroke(path, with: .color(lineColor), lineWidth: 1)
                    y += spacing
                }
            case .grid:
                let cell: CGFloat = 22
                var x = cell
                while x < size.width {
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                    context.stroke(path, with: .color(lineColor), lineWidth: 0.8)
                    x += cell
                }
                var y = cell
                while y < size.height {
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                    context.stroke(path, with: .color(lineColor), lineWidth: 0.8)
                    y += cell
                }
            }
        }
        .allowsHitTesting(false)
    }
}

/// Tela em branco quando o caderno ainda não tem nenhuma folha — pede pra
/// escolher o tipo antes mesmo da primeira página nascer.
struct NotebookEmptyState: View {
    @Binding var entries: [NotebookEntry]
    /// Ver o comentário em `NotebookBeadRow.selection` — mesma troca de
    /// `Binding<CharacterSheetView.SheetPage>` por `Binding<UUID?>` puro.
    @Binding var selection: UUID?
    // Item 3 do pedido do usuário (2026-09-24): mesmo motivo de
    // `NotebookBeadRow.library` — a primeira folha do caderno também nasce
    // com o padrão configurado em Settings.
    @EnvironmentObject private var library: CharacterLibrary

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Notebook")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("No pages yet — start this character's notebook below.")
                .font(Paper.printedItalic(13))
                .foregroundStyle(Paper.inkSoft)

            HStack(spacing: 20) {
                NewPageButton(systemImage: "square.and.pencil", caption: "transcribed page") {
                    addPage(.transcribed)
                }
                NewPageButton(systemImage: "scribble", caption: "freeform page (draw)") {
                    addPage(.freeform)
                }
            }
        }
    }

    private func addPage(_ kind: NotebookPageKind) {
        selection = entries.addNotebookPage(kind: kind, paperStyle: library.defaultNotebookPaperStyle)
    }
}

/// Um dos dois convites de "primeira página" do caderno vazio — o ícone
/// deixa claro de cara qual dos dois tipos é (letra vs. rabisco), a
/// legenda embaixo tira qualquer dúvida.
private struct NewPageButton: View {
    let systemImage: String
    let caption: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                RoundIconBadge(systemImage: systemImage, style: .paper)
                Text(caption)
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Canvas de desenho livre

/// A folha de "letra feia": tinta de verdade, com a Apple Pencil ou o dedo,
/// via PencilKit — sem nenhuma tentativa de transcrever pra texto. O
/// PKToolPicker do sistema (troca de cor/caneta/borracha) sobe sozinho
/// assim que a página vira primeira respondedora.
struct DrawingCanvas: UIViewRepresentable {
    @Binding var drawingData: Data?
    /// Ver `PageReadiness` — avisa quando esta folha terminou de aparecer
    /// de verdade (inclusive depois de qualquer animação de curl), pra só
    /// então ligar o `PKToolPicker`.
    let readiness: PageReadiness

    /// Item 1 do pedido do usuário (2026-09-24): "a cor padrão da caneta é
    /// branca, e isso é horrível pq mal dá pra ver. Troca pelo preto."
    ///
    /// AJUSTE (2026-09-24, terceira tentativa — v1.62 e v1.63 reafirmavam
    /// `.black` de várias formas e o usuário reportou "Nada mudou" nas
    /// duas): a teoria de corrida assíncrona com o `PKToolPicker` estava
    /// errada — reafirmar a MESMA cor não muda nada se o problema nunca foi
    /// timing. O PencilKit trata `UIColor.black`/`.white` como cores
    /// ADAPTATIVAS: ele inverte automaticamente entre preto e branco de
    /// acordo com o `userInterfaceStyle` (claro/escuro) do canvas, pra
    /// tinta continuar visível em qualquer fundo — é um comportamento
    /// documentado da Apple, não um bug de sincronização. Como o papel
    /// deste app é sempre claro mas o SISTEMA podia estar em Modo Escuro,
    /// o preto literal virava branco por baixo dos panos, e reatribuir
    /// `.black` de novo (mesmo três vezes) não tinha efeito nenhum, porque
    /// a própria COR continuava sendo a adaptativa. Duas mudanças juntas
    /// resolvem a causa raiz: (a) trocar o preto puro por um RGB explícito
    /// bem próximo do preto — deixa de ser a cor especial que o PencilKit
    /// reconhece e inverte; (b) forçar o canvas a ficar sempre em modo
    /// claro (`overrideUserInterfaceStyle`), removendo de vez o gatilho
    /// que causava a inversão, não importa o tema do sistema.
    static let defaultInkColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.backgroundColor = .clear
        canvas.overrideUserInterfaceStyle = .light
        canvas.drawingPolicy = .anyInput
        canvas.tool = PKInkingTool(.pen, color: Self.defaultInkColor, width: 3)
        canvas.delegate = context.coordinator
        if let data = drawingData, let drawing = try? PKDrawing(data: data) {
            canvas.drawing = drawing
        }
        // Ver o comentário em `Coordinator.lastSyncedData`: registra aqui o
        // valor que o canvas JÁ nasceu mostrando, pra `updateUIView` não
        // achar que esse mesmo valor "mudou por fora" na primeira passada.
        context.coordinator.lastSyncedData = drawingData
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        context.coordinator.parent = self

        // Liga o PKToolPicker assim que a view já está numa janela de
        // verdade — na primeira passada de makeUIView ela ainda não está.
        // `PKToolPicker.shared(for:)` (um picker por JANELA) foi
        // depreciado no iOS 14 — a Apple pede uma instância própria por
        // canvas agora (`PKToolPicker()`), guardada no Coordinator pra não
        // recriar uma a cada `updateUIView` (senão o picker "esquece" a
        // ferramenta escolhida a cada toque na tela).
        // Reforça o modo claro aqui também — `overrideUserInterfaceStyle`
        // de vez em quando é reavaliado quando a view entra numa hierarquia
        // nova (ex.: folheando pra esta página de novo); garantir de novo
        // a cada `updateUIView` não custa nada e fecha essa brecha.
        if uiView.overrideUserInterfaceStyle != .light {
            uiView.overrideUserInterfaceStyle = .light
        }

        if !context.coordinator.didAttachToolPicker {
            context.coordinator.didAttachToolPicker = true

            // AJUSTE (crash na criação de página "Freeform" — tentativa 2):
            // a primeira tentativa adiava o anexo do `PKToolPicker` com
            // `DispatchQueue.main.async`, e o usuário confirmou que não
            // mudou nada. Fazia sentido: um único ciclo do run loop não é
            // garantia nenhuma de que a animação de curl do
            // `UIPageViewController` (que dura vários ciclos) já tenha
            // terminado — o anexo continuava caindo NO MEIO da transação de
            // animação, só um instante mais tarde. `readiness.onReady`
            // (ver `PageReadiness`/`NotebookPageController.viewDidAppear`)
            // é o sinal de verdade do próprio UIKit de que a folha terminou
            // de aparecer, curl incluso — não uma estimativa de tempo.
            readiness.onReady { [weak uiView] in
                guard let uiView, uiView.window != nil else { return }

                let toolPicker = PKToolPicker()
                // AJUSTE (2026-09-24, mesmo dia — usuário reportou que a tinta
                // já saía preta, mas o SELETOR DE COR do próprio PKToolPicker
                // continuava mostrando branco como a cor atual): o
                // `PKToolPicker` é um popover do SISTEMA, fora da hierarquia de
                // views do app — ele tem sua PRÓPRIA `overrideUserInterfaceStyle`,
                // independente da que já força o `PKCanvasView` pro modo claro
                // acima. Sem travar o picker também, ele seguia o tema do
                // sistema e desenhava seus próprios swatches (inclusive o que
                // mostra a cor "atual") de forma adaptativa, mesmo já não
                // afetando mais o traço em si.
                toolPicker.overrideUserInterfaceStyle = .light
                context.coordinator.toolPicker = toolPicker
                toolPicker.setVisible(true, forFirstResponder: uiView)
                toolPicker.addObserver(uiView)
                uiView.becomeFirstResponder()

                // A causa raiz era a cor adaptativa preto/branco do PencilKit
                // (ver comentário em `defaultInkColor`), não uma corrida com o
                // `PKToolPicker` — mas como o picker pode mesmo trocar a
                // ferramenta ativa ao anexar, reafirma a cor (já não-adaptativa
                // agora) logo em seguida, só nesse anexo inicial, sem brigar
                // com uma escolha do jogador depois.
                uiView.tool = PKInkingTool(.pen, color: Self.defaultInkColor, width: 3)
            }
        }

        // AJUSTE (mesmo crash): esta comparação era o segundo problema, e
        // provavelmente o de verdade — o `DispatchQueue.main.async` da
        // tentativa 1 não tocava nela, o que bate com o usuário ter visto
        // "exatamente igual" mesmo depois daquele ajuste. Antes comparava
        // `uiView.drawing.dataRepresentation()` (o traço ATUAL do canvas,
        // reserializado) contra `drawingData ?? Data()` — mas um
        // `PKDrawing` vazio de verdade NÃO serializa como `Data()` vazio de
        // verdade (o formato tem cabeçalho próprio mesmo sem traço nenhum).
        // Numa folha nova (`drawingData == nil`), essa comparação batia
        // "diferente" em TODA passada de `updateUIView`, e o `else if
        // drawingData == nil` reatribuía `uiView.drawing = PKDrawing()` de
        // novo — reatribuição que o `PKCanvasViewDelegate` pode enxergar
        // como mudança e devolver pro binding (`canvasViewDrawingDidChange`),
        // que por sua vez dispara outra passada de `updateUIView` ENQUANTO
        // a primeira ainda podia estar em curso (e essa, ainda por cima,
        // rodando no meio da animação de curl da criação da página) — o
        // tipo de laço de atualização de estado que trava o app. A troca:
        // comparar contra o último valor que o PRÓPRIO coordinator colocou
        // ali (`lastSyncedData`), não contra uma reserialização do canvas
        // nem contra `Data()` — sem esse mal-entendido, a folha só recarrega
        // o traço quando o valor de fora muda de verdade (folheou pra outra
        // página), nunca só por render de novo.
        guard context.coordinator.lastSyncedData != drawingData else { return }
        context.coordinator.lastSyncedData = drawingData
        if let data = drawingData, let drawing = try? PKDrawing(data: data) {
            uiView.drawing = drawing
        } else if drawingData == nil {
            uiView.drawing = PKDrawing()
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: DrawingCanvas
        var didAttachToolPicker = false
        /// Guardado aqui (não só passado adiante) pra manter viva a
        /// instância própria do picker (ver `updateUIView`) — sem essa
        /// referência forte, `PKToolPicker()` seria liberado assim que
        /// `updateUIView` termina e o picker sumiria da tela.
        var toolPicker: PKToolPicker?
        /// Último valor de `drawingData` que ESTE coordinator já colocou no
        /// canvas ou já leu de volta dele — ver o comentário grande em
        /// `updateUIView` pra causa raiz que essa comparação evita.
        var lastSyncedData: Data?

        init(_ parent: DrawingCanvas) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            let data = canvasView.drawing.dataRepresentation()
            lastSyncedData = data
            parent.drawingData = data
        }
    }
}

// MARK: - Caderno aberto direto da Campanha
