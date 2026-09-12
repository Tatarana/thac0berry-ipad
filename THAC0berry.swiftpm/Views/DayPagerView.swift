import SwiftUI
import UIKit

/// Folheia os dias de magia com o curl de página de verdade do sistema —
/// o mesmo `UIPageViewController` que a Apple usa em livros/revistas — em
/// vez da rotação em 3D artesanal de antes. O gesto de arrasto (a largura
/// inteira da tela, não só a borda) também é o do próprio sistema, então
/// não precisamos mais da faixa fina de borda nem do `DragGesture` cascão
/// que a gente tinha construído à mão.
///
/// A ordem dos dias é sempre cronológica entre TODAS as folhas do
/// personagem (`character.spellSheets`), cruzando de uma sessão pra outra
/// sozinha quando chega na ponta — mesma regra de antes, só que agora
/// resolvida pelo `dataSource` do UIKit em vez de um `navigateDay` na mão.
struct DayPagerView: UIViewControllerRepresentable {
    @Binding var character: PlayerCharacter
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

        // O SwiftUI chama isso de novo a cada mudança em QUALQUER lugar do
        // personagem, não só quando o dia muda — e o UIPageViewController
        // não aguenta receber um segundo `setViewControllers(animated:)`
        // enquanto o primeiro curl ainda está em andamento (trava com
        // "Unbalanced calls to begin/end appearance transitions", que é
        // exatamente o crash depois de folhear algumas vezes rápido).
        // Enquanto uma virada está rolando, simplesmente ignora esta
        // atualização — a próxima, depois que a transição terminar, resolve
        // o que ficou pendente.
        guard !context.coordinator.isTransitioning else { return }

        let visibleID = (pager.viewControllers?.first as? DayPageController)?.sheetID

        if visibleID != currentID {
            // Mudou de fora (chip de dia, divisória de sessão, índice da
            // campanha) — pula direto pra lá, com o curl na direção certa.
            guard let target = context.coordinator.makePage(for: currentID) else { return }
            let forward = isForward(from: visibleID, to: currentID)
            context.coordinator.isTransitioning = true
            pager.setViewControllers([target], direction: forward ? .forward : .reverse,
                                     animated: true) { _ in
                context.coordinator.isTransitioning = false
            }
        } else if let visible = pager.viewControllers?.first as? DayPageController {
            // Mesmo dia, mas os dados podem ter mudado por outro caminho
            // (ex: Spell Slots editado na Ficha) — atualiza o conteúdo sem
            // trocar de página.
            visible.rootView = pageContent(for: visible.sheetID)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Conteúdo e vizinhança

    fileprivate func pageContent(for id: UUID) -> AnyView {
        guard let index = character.spellSheets.firstIndex(where: { $0.id == id }) else {
            return AnyView(
                Text("This sheet is no longer in the folder.")
                    .font(Paper.printedItalic(14))
                    .foregroundStyle(Paper.inkSoft)
                    .padding(40)
            )
        }
        return AnyView(
            ScrollView {
                SpellSheetView(sheet: $character.spellSheets[index], character: $character)
                    .padding(18)
            }
        )
    }

    /// Só os dias da MESMA sessão, em ordem — cruzar de sessão pra sessão
    /// só acontece escolhendo explicitamente (chip de dia, divisória,
    /// índice da campanha), nunca só de folhear. Fica mais claro na mesa:
    /// bater no fim de uma sessão trava a página em vez de pular sem avisar
    /// pra outra data.
    private func chronologicalIDs(in sessionID: UUID?) -> [UUID] {
        character.spellSheets
            .filter { $0.sessionID == sessionID }
            .sorted { $0.date < $1.date }
            .map(\.id)
    }

    fileprivate func neighborID(of id: UUID, forward: Bool) -> UUID? {
        guard let current = character.spellSheets.first(where: { $0.id == id }) else { return nil }
        let ordered = chronologicalIDs(in: current.sessionID)
        guard let position = ordered.firstIndex(of: id) else { return nil }
        let nextIndex = forward ? position + 1 : position - 1
        guard ordered.indices.contains(nextIndex) else { return nil }
        return ordered[nextIndex]
    }

    private func isForward(from: UUID?, to: UUID) -> Bool {
        guard let from,
              let fromDate = character.spellSheets.first(where: { $0.id == from })?.date,
              let toDate = character.spellSheets.first(where: { $0.id == to })?.date
        else { return true }
        return toDate >= fromDate
    }

    // MARK: - Coordinator

    final class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: DayPagerView
        /// Verdadeiro enquanto um curl (por gesto do usuário OU disparado
        /// por código) está em andamento — ver o comentário em
        /// `updateUIViewController`.
        var isTransitioning = false

        init(_ parent: DayPagerView) {
            self.parent = parent
        }

        fileprivate func makePage(for id: UUID) -> DayPageController? {
            let controller = DayPageController(sheetID: id, rootView: parent.pageContent(for: id))
            // Uma folha criada agora mesmo (botão "+ day sheet") às vezes
            // ainda não está em `character.spellSheets` no exato instante em
            // que este método roda — o SwiftUI publica a mudança de `page`
            // (local) e a de `character` (um binding, às vezes com mais
            // saltos até o dado de verdade) em momentos ligeiramente
            // diferentes. Resultado: a página nascia com o aviso "not in the
            // folder" e só se corrigia quando o jogador folheava pra outro
            // dia e voltava. Em vez de tentar acertar a ordem exata (frágil
            // e difícil de reproduzir), se a folha não for encontrada agora,
            // tenta de novo daqui a pouquíssimo tempo — na próxima volta do
            // runloop os dados já com certeza chegaram.
            if parent.character.spellSheets.first(where: { $0.id == id }) == nil {
                DispatchQueue.main.async { [weak self, weak controller] in
                    guard let self, let controller else { return }
                    controller.rootView = self.parent.pageContent(for: id)
                }
            }
            return controller
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let current = (viewController as? DayPageController)?.sheetID,
                  let previousID = parent.neighborID(of: current, forward: false)
            else { return nil }
            return makePage(for: previousID)
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let current = (viewController as? DayPageController)?.sheetID,
                  let nextID = parent.neighborID(of: current, forward: true)
            else { return nil }
            return makePage(for: nextID)
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                willTransitionTo pendingViewControllers: [UIViewController]) {
            // O dedo do usuário começou a folhear — trava as atualizações
            // vindas de fora até o gesto terminar (ver `updateUIViewController`).
            isTransitioning = true
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
            isTransitioning = false
            // Este delegate só dispara pra transição arrastada pelo dedo do
            // usuário — uma chamada por código a `setViewControllers` (o
            // caminho usado por "+ day sheet") NÃO passa por aqui, só pelo
            // completion handler dela mesma. O reforço real pra folha nova
            // ficando em branco está em `makePage`, acima.
            guard completed,
                  let visible = pageViewController.viewControllers?.first as? DayPageController
            else { return }
            parent.currentID = visible.sheetID
            // Reconstrói mesmo assim com os dados mais recentes de `parent`
            // — não custa nada e cobre qualquer outro caso parecido (também
            // disparava este mesmo delegate). Agora ele sempre recarrega.
            visible.rootView = parent.pageContent(for: visible.sheetID)
        }
    }
}

/// Um UIHostingController marcado com o id do dia que ele representa — o
/// UIPageViewController só enxerga UIViewController genérico, então
/// precisamos de um jeito de "ler de volta" qual dia cada página é.
private final class DayPageController: UIHostingController<AnyView> {
    let sheetID: UUID

    init(sheetID: UUID, rootView: AnyView) {
        self.sheetID = sheetID
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
