import SwiftUI
import UIKit
import PencilKit

/// O caderno de campanha vira um livro de verdade: folheado com o mesmo
/// curl de página do UIPageViewController que a Ficha de Magias já usa
/// (ver `DayPagerView`), em vez de uma lista rolável de cartões. As
/// páginas não são agrupadas por sessão — é um único caderno contínuo da
/// CAMPANHA, compartilhado por todo mundo que joga nela, do jeito que a
/// mesa carregaria um caderno físico só pra sessão inteira (não mais um
/// caderno por personagem).
struct NotebookPagerView: UIViewControllerRepresentable {
    @Binding var campaign: Campaign
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
            visible.rootView = pageContent(for: visible.entryID)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    // MARK: - Conteúdo e vizinhança

    fileprivate func pageContent(for id: UUID) -> AnyView {
        guard let index = campaign.notebookEntries.firstIndex(where: { $0.id == id }) else {
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
                    get: { campaign.notebookEntries[index] },
                    set: { newValue in
                        guard campaign.notebookEntries.indices.contains(index) else { return }
                        campaign.notebookEntries[index] = newValue
                    }
                ),
                pageNumber: index + 1,
                pageCount: campaign.notebookEntries.count,
                onDelete: { deleteEntry(id) }
            )
            .padding(18)
        )
    }

    /// Toda folha do caderno inteiro, em ordem — sem separar por sessão:
    /// o caderno é um único fio contínuo da campanha.
    private func orderedIDs() -> [UUID] {
        campaign.notebookEntries.sorted { $0.date < $1.date }.map(\.id)
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
              let fromDate = campaign.notebookEntries.first(where: { $0.id == from })?.date,
              let toDate = campaign.notebookEntries.first(where: { $0.id == to })?.date
        else { return true }
        return toDate >= fromDate
    }

    /// Apaga a página; se era a que estava aberta, folheia pra uma vizinha
    /// em vez de deixar o livro parado num id que não existe mais.
    private func deleteEntry(_ id: UUID) {
        let fallback = neighborID(of: id, forward: false) ?? neighborID(of: id, forward: true)
        campaign.notebookEntries.removeAll { $0.id == id }
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
            NotebookPageController(entryID: id, rootView: parent.pageContent(for: id))
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
            visible.rootView = parent.pageContent(for: visible.entryID)
        }
    }
}

/// Marca cada página do UIPageViewController com o id da folha do caderno
/// que ela representa — mesmo truque do `DayPageController`.
private final class NotebookPageController: UIHostingController<AnyView> {
    let entryID: UUID

    init(entryID: UUID, rootView: AnyView) {
        self.entryID = entryID
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// A linha de páginas do caderno — mesma metáfora de contas de tinta numa
/// linha de costura que a Priest Spell Sheet usa (`DayThreadRow`), agora
/// existindo também aqui: antes o caderno não tinha nenhum indicador de
/// posição, só o gesto de arrastar. O "+" no fim abre o mesmo menu de
/// escolha (transcrita ou desenho livre) que antes vivia solto na fileira
/// global de abas.
struct NotebookBeadRow: View {
    @Binding var campaign: Campaign
    /// Qual página está aberta — era um `Binding<CharacterSheetView.SheetPage>`
    /// direto, mas isso amarrava o caderno a sempre estar dentro de uma
    /// `CharacterSheetView`. Desacoplado pra `Binding<UUID?>` puro: dentro
    /// da ficha de personagem, `CharacterSheetView.notebookSelection` faz a
    /// ponte pra `page`; fora dela (`CampaignNotebookView`, aberta direto
    /// da Campanha, sem passar por nenhum personagem), é só um `@State`
    /// local.
    @Binding var selection: UUID?
    let currentID: UUID

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 13) {
                ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                    InkDayBead(number: index + 1, isSelected: entry.id == currentID) {
                        selection = entry.id
                    }
                    .contextMenu {
                        if entries.count > 1 {
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

    private var entries: [NotebookEntry] {
        campaign.notebookEntries.sorted { $0.date < $1.date }
    }

    private var currentTitle: String? {
        entries.first { $0.id == currentID }?.title
    }

    private func addPage(_ kind: NotebookPageKind) {
        selection = campaign.addNotebookPage(kind: kind)
    }

    /// Apaga a página; se era a que estava aberta, pula pra uma vizinha.
    private func delete(_ entry: NotebookEntry) {
        guard entries.count > 1 else { return }
        let ordered = entries
        let fallback: UUID? = {
            guard let position = ordered.firstIndex(where: { $0.id == entry.id }) else { return nil }
            if ordered.indices.contains(position - 1) { return ordered[position - 1].id }
            if ordered.indices.contains(position + 1) { return ordered[position + 1].id }
            return nil
        }()
        campaign.notebookEntries.removeAll { $0.id == entry.id }
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

    private var kind: NotebookPageKind { entry.kind ?? .transcribed }

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
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
        case .freeform:
            // Tela de desenho de verdade — sem transcrição nenhuma, pra
            // quem tem letra feia ou quer desenhar um mapa/rabisco.
            DrawingCanvas(drawingData: $entry.drawingData)
                .frame(minHeight: 420)
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
        }
    }
}

/// Tela em branco quando o caderno ainda não tem nenhuma folha — pede pra
/// escolher o tipo antes mesmo da primeira página nascer.
struct NotebookEmptyState: View {
    @Binding var campaign: Campaign
    /// Ver o comentário em `NotebookBeadRow.selection` — mesma troca de
    /// `Binding<CharacterSheetView.SheetPage>` por `Binding<UUID?>` puro.
    @Binding var selection: UUID?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Notebook")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("No pages yet — start your campaign notebook below.")
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
        selection = campaign.addNotebookPage(kind: kind)
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

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        canvas.tool = PKInkingTool(.pen, color: UIColor(red: 0.118, green: 0.208, blue: 0.341, alpha: 1),
                                   width: 3)
        canvas.delegate = context.coordinator
        if let data = drawingData, let drawing = try? PKDrawing(data: data) {
            canvas.drawing = drawing
        }
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        context.coordinator.parent = self

        // Liga o PKToolPicker assim que a view já está numa janela de
        // verdade — na primeira passada de makeUIView ela ainda não está.
        if !context.coordinator.didAttachToolPicker, let window = uiView.window {
            context.coordinator.didAttachToolPicker = true
            if let toolPicker = PKToolPicker.shared(for: window) {
                toolPicker.setVisible(true, forFirstResponder: uiView)
                toolPicker.addObserver(uiView)
                uiView.becomeFirstResponder()
            }
        }

        // Só recarrega o traço se o dado mudou por fora (folheou pra outra
        // página) — comparar a cada toque evitaria perder o traço em curso.
        let currentData = uiView.drawing.dataRepresentation()
        guard currentData != (drawingData ?? Data()) else { return }
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

        init(_ parent: DrawingCanvas) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawingData = canvasView.drawing.dataRepresentation()
        }
    }
}

// MARK: - Caderno aberto direto da Campanha

/// O caderno da campanha, sozinho — sem passar por nenhum personagem. Até
/// aqui o único jeito de abrir o caderno era pela ficha de um personagem
/// (`CharacterSheetView`'s aba Notebook), o que trazia junto a fileira de
/// abas inteira (Sheet/Notebook, distintivo de sessão, menu ☰) mesmo
/// quando a pessoa só queria ler o caderno partindo da própria Campanha.
/// Essa fileira continua existindo — nada muda pra quem já está dentro da
/// ficha de um personagem durante a sessão — mas agora o link "Open
/// campaign notebook" de `CampaignDetailView` chega direto aqui, com só um
/// botão simples de voltar, igual às outras telas empurradas a partir da
/// Tela Principal.
struct CampaignNotebookView: View {
    @Binding var campaign: Campaign
    @Environment(\.dismiss) private var dismiss
    @State private var selectedID: UUID? = nil

    var body: some View {
        ZStack {
            ChromeBackground()

            VStack(spacing: 0) {
                backRow
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(Paper.chromeDeep).frame(height: 1)
                    }

                ZStack {
                    PaperBackground()

                    if let resolvedID,
                       campaign.notebookEntries.contains(where: { $0.id == resolvedID }) {
                        VStack(spacing: 0) {
                            NotebookBeadRow(campaign: $campaign, selection: $selectedID, currentID: resolvedID)
                            NotebookPagerView(campaign: $campaign, currentID: currentPageID)
                        }
                    } else {
                        ScrollView {
                            NotebookEmptyState(campaign: $campaign, selection: $selectedID)
                                .padding(18)
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var backRow: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Paper.sheet)
                .frame(width: 30, height: 30)
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Campaign")
    }

    /// `selectedID` chega `nil` tanto quando o caderno está mesmo vazio
    /// quanto quando a tela acabou de abrir sem escolha nenhuma — nos dois
    /// casos cai pra primeira folha em ordem, se existir alguma. Mesma
    /// ideia de `CharacterSheetView`'s `resolvedID`/`currentNotebookPageID`.
    private var resolvedID: UUID? {
        selectedID ?? campaign.notebookEntries.sorted { $0.date < $1.date }.first?.id
    }

    private var currentPageID: Binding<UUID> {
        Binding(
            get: { resolvedID ?? UUID() },
            set: { selectedID = $0 }
        )
    }
}
