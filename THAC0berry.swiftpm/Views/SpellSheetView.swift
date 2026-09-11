import SwiftUI
import UIKit

/// A folha de magias de um dia de jogo, no formato do registro oficial:
/// um quadro por círculo, com as bolinhas de slot no cabeçalho e a tabela
/// do que está memorizado, com iniciativa, alcance, duração, resistência e
/// componentes. Embaixo, o registro do dia escrito à caneta.
///
/// Ela é descartável de propósito: no repouso os slots zeram, e o dia
/// seguinte ganha uma folha nova.
struct SpellSheetView: View {
    @Binding var sheet: SpellSheet
    let character: PlayerCharacter
    @EnvironmentObject private var spellbook: SpellDatabase

    @State private var editingSlot: SpellSlot? = nil
    @State private var detailSlot: SpellSlot? = nil
    @State private var width: CGFloat = 0

    var body: some View {
        let minimum: CGFloat = width > 900 ? 420 : 320
        // Mesma conta de coluna que um GridItem(.adaptive(minimum:)) faria
        // — só que calculada à mão, porque agora quem decide em qual
        // coluna cada bloco cai somos nós, não o LazyVGrid.
        let columnCount = max(1, Int((width + 14) / (minimum + 14)))
        let columns = distributedColumns(into: columnCount)

        VStack(spacing: 12) {
            SpellSheetHeader(sheet: $sheet, character: character)

            // A largura é medida por trás: um GeometryReader em volta da
            // grade fixaria a altura dentro do ScrollView e cortaria os
            // círculos de baixo.
            //
            // Colunas montadas manualmente (em vez de LazyVGrid) pra poder
            // decidir onde o bloco de Turn Undead cai: ele vai pra coluna
            // que estiver mais curta no momento, em vez de sempre abrir uma
            // linha nova sozinho e deixar a outra coluna com um buraco.
            HStack(alignment: .top, spacing: 14) {
                ForEach(columns.indices, id: \.self) { columnIndex in
                    VStack(spacing: 12) {
                        ForEach(columns[columnIndex], id: \.self) { cell in
                            gridCell(cell)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .background(WidthReader(width: $width))

            ItemSpellBlock(sheet: $sheet)

            AdditionalSpellsBlock(sheet: $sheet)

            Text("A full rest returns all slots — start a new sheet. To change how many slots you have, edit Spell Slots on the character sheet.")
                .font(Paper.printedItalic(11))
                .foregroundStyle(Paper.inkSoft)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .sheet(item: $editingSlot) { slot in
            SlotEditorSheet(slot: slot, sheet: $sheet)
                .environmentObject(spellbook)
        }
        .sheet(item: $detailSlot) { slot in
            SpellDetailSheet(spell: slot.preparedSpellID.flatMap { spellbook.spell(id: $0) },
                              freeName: slot.preparedSpellName)
        }
    }

    /// Um bloco qualquer que pode cair numa coluna da grade: ou é um
    /// círculo de magia, ou é o marcador de Turn Undead.
    private enum SheetCell: Hashable {
        case circle(CasterLevel)
        case turnUndead
    }

    @ViewBuilder
    private func gridCell(_ cell: SheetCell) -> some View {
        switch cell {
        case .circle(let pair):
            CircleBlock(sheet: $sheet,
                        character: character,
                        caster: pair.caster,
                        level: pair.level,
                        onEdit: { slot in editingSlot = slot },
                        onShowDetail: { slot in detailSlot = slot })
        case .turnUndead:
            TurnUndeadBlock(sheet: $sheet)
        }
    }

    /// Peso aproximado de altura de um bloco — número de linhas de magia
    /// pra um círculo, um valor fixo pequeno pro Turn Undead (só cabeçalho
    /// + uma linha). Serve só pra decidir qual coluna está mais "cheia",
    /// não precisa ser exato.
    private func weight(_ cell: SheetCell) -> Int {
        switch cell {
        case .circle(let pair):
            return sheet.slotBoard.slots(level: pair.level, caster: pair.caster).count + 2
        case .turnUndead:
            return 2
        }
    }

    /// Distribui os círculos nas colunas na ordem de leitura de sempre
    /// (coluna 0, coluna 1, coluna 0, coluna 1..., como uma ficha em
    /// papel) e só decide de forma diferente pro Turn Undead: em vez de
    /// simplesmente continuar o rodízio (o que abriria uma linha nova
    /// sozinho, deixando a outra coluna com um buraco embaixo), ele cai na
    /// coluna que estiver mais curta no momento — encaixado como se fosse
    /// mais um círculo, sem sobrar espaço vazio do lado.
    private func distributedColumns(into columnCount: Int) -> [[SheetCell]] {
        var columns = Array(repeating: [SheetCell](), count: columnCount)
        var columnWeights = Array(repeating: 0, count: columnCount)

        for (index, pair) in casterLevels.enumerated() {
            let column = index % columnCount
            columns[column].append(.circle(pair))
            columnWeights[column] += weight(.circle(pair))
        }

        if sheet.slotBoard.casters().contains(.divine) {
            let lightest = columnWeights.indices.min { columnWeights[$0] < columnWeights[$1] } ?? 0
            columns[lightest].append(.turnUndead)
        }

        return columns
    }

    /// Todos os pares (conjurador, círculo) que existem nesta folha.
    private var casterLevels: [CasterLevel] {
        var result: [CasterLevel] = []
        for caster in sheet.slotBoard.casters() {
            for level in sheet.levels(for: caster) {
                result.append(CasterLevel(caster: caster, level: level))
            }
        }
        return result
    }
}

struct CasterLevel: Hashable {
    let caster: CasterType
    let level: Int
}

// MARK: - Cabeçalho da folha

private struct SpellSheetHeader: View {
    @Binding var sheet: SpellSheet
    let character: PlayerCharacter

    var body: some View {
        let who: String = "\(character.displayTitle) · \(character.characterClass.rawValue) \(character.level)"

        VStack(spacing: 6) {
            HStack(alignment: .bottom, spacing: 22) {
                VStack(alignment: .leading, spacing: 0) {
                    FieldLabel(text: "Priest Spell Sheet — Game Day")
                    EditableText(value: $sheet.title, placeholder: "untitled",
                                 size: 34, tilt: -0.7, underline: false)
                }
                // Cresce pra ocupar todo o espaço livre — empurra Character
                // e Wisdom, os dois de largura fixa, pra ponta direita.
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .trailing, spacing: 0) {
                    FieldLabel(text: "Character")
                    HandValue(text: who, size: 19, tilt: -0.3)
                    Rectangle().fill(Paper.hairline).frame(height: 1)
                }
                .fixedSize()

                VStack(alignment: .trailing, spacing: 0) {
                    FieldLabel(text: "Wisdom")
                    HandValue(text: "\(sheet.wisdomAtCreation)", size: 19, tilt: -0.3)
                    Rectangle().fill(Paper.hairline).frame(height: 1)
                }
                .frame(width: 55, alignment: .trailing)
            }

            Rectangle().fill(Paper.ink).frame(height: 2.2)
        }
    }
}

// MARK: - Um círculo: bolinhas + tabela de memorizadas

private struct CircleBlock: View {
    @Binding var sheet: SpellSheet
    let character: PlayerCharacter
    let caster: CasterType
    let level: Int
    let onEdit: (SpellSlot) -> Void
    let onShowDetail: (SpellSlot) -> Void

    @EnvironmentObject private var spellbook: SpellDatabase

    var body: some View {
        let slots: [SpellSlot] = sheet.slotBoard.slots(level: level, caster: caster)
        // Sacerdotes com Sabedoria alta ganham slots bônus por círculo — a
        // ficha oficial mostra "total (base+bônus)" ao lado do título.
        let bonus: Int = caster == .divine ? character.details.wisdomBonus(forCircle: level) : 0
        let base: Int = max(slots.count - bonus, 0)
        let title: String = bonus > 0
            ? "Level \(level) - \(slots.count) Slots (\(base)+\(bonus))"
            : "Level \(level) · \(slots.count) slots"

        let dots = FlowRow(spacing: 5, lineSpacing: 4) {
            ForEach(slots) { slot in
                Button { onEdit(slot) } label: {
                    SlotDot(isSpent: slot.isSpent)
                }
                .buttonStyle(.plain)
            }
        }

        VStack(alignment: .leading, spacing: 0) {
            // Com muitos slots as bolinhas ganham a própria linha, senão
            // espremem o título em coluna estreita.
            VStack(alignment: .leading, spacing: 4) {
                if slots.count > 5 {
                    Text(title.uppercased())
                        .font(Paper.printed(10))
                        .tracking(2)
                        .foregroundStyle(Paper.sheet)
                    dots
                } else {
                    HStack {
                        Text(title.uppercased())
                            .font(Paper.printed(10))
                            .tracking(2)
                            .foregroundStyle(Paper.sheet)
                        Spacer(minLength: 8)
                        dots
                    }
                }
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Paper.ink)

            VStack(spacing: 0) {
                TableHeader()
                ForEach(slots) { slot in
                    MemorizedRow(spell: spellFor(slot),
                                 freeName: slot.preparedSpellName,
                                 isSpent: slot.isSpent,
                                 casterLevel: character.level,
                                 onStrike: { toggle(slot) },
                                 onShowDetail: { onShowDetail(slot) })
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
        }
        .background(Color.white.opacity(0.12))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
    }

    private func spellFor(_ slot: SpellSlot) -> Spell? {
        guard let id = slot.preparedSpellID else { return nil }
        return spellbook.spell(id: id)
    }

    private func toggle(_ slot: SpellSlot) {
        guard let index = sheet.slotBoard.slots.firstIndex(where: { $0.id == slot.id })
        else { return }
        sheet.slotBoard.slots[index].isSpent.toggle()
    }
}

/// Bolinha de slot desenhada sobre a tarja escura do cabeçalho.
private struct SlotDot: View {
    let isSpent: Bool

    var body: some View {
        ZStack {
            Circle().stroke(Paper.sheet, lineWidth: 1.4)
            if isSpent {
                Text("✕")
                    .font(Paper.hand(16))
                    .foregroundStyle(Color(red: 0.886, green: 0.655, blue: 0.612))
                    .rotationEffect(.degrees(-8))
            }
        }
        .frame(width: 17, height: 17)
        .contentShape(Circle())
    }
}

private struct TableHeader: View {
    var body: some View {
        HStack(spacing: 4) {
            FieldLabel(text: "Memorized Spell")
                .frame(maxWidth: .infinity, alignment: .leading)
            FieldLabel(text: "Cast").frame(width: 42)
            FieldLabel(text: "Dmg/Heal").frame(width: 70)
        }
        .padding(.bottom, 2)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Paper.ink).frame(height: 1)
        }
    }
}

private struct MemorizedRow: View {
    let spell: Spell?
    let freeName: String?
    let isSpent: Bool
    /// Nível do personagem — usado para calcular o dano/cura que escala
    /// por nível ("10d6" em vez de "1d6 per level (max 10d6)").
    let casterLevel: Int
    /// Riscar a magia com o dedo/caneta, de ponta a ponta — só isso marca o
    /// slot como gasto (e riscar de novo desfaz).
    let onStrike: () -> Void
    /// Um toque simples, sem arrasto, abre a descrição sem mexer no slot.
    let onShowDetail: () -> Void

    @State private var strikeWidth: CGFloat = 0
    @State private var isStriking: Bool = false
    @State private var rowWidth: CGFloat = 0

    var body: some View {
        HStack(spacing: 4) {
            Text(name)
                .font(Paper.hand(20))
                .foregroundStyle(isSpent ? Paper.redInk.opacity(0.8) : Paper.penInk)
                .strikethrough(isSpent, color: Paper.redInk)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                // Mede só a coluna do nome, não a linha inteira — é sobre
                // ela que o traço de riscar é medido, então "metade do
                // campo" precisa ser metade dela, não da linha com as
                // colunas de Cast/Dmg incluídas.
                .background {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear { rowWidth = geo.size.width }
                            .onChange(of: geo.size.width) { _, newValue in rowWidth = newValue }
                    }
                }

            cell(castingTimeValue, width: 42)
            cell(dmgHealValue, width: 70)
        }
        .padding(.vertical, 2)
        .overlay(alignment: .bottom) { DottedRule() }
        .overlay(alignment: .leading) {
            if isStriking {
                Rectangle()
                    .fill(Paper.redInk)
                    .frame(width: strikeWidth, height: 2.4)
                    .rotationEffect(.degrees(-1), anchor: .leading)
            }
        }
        .contentShape(Rectangle())
        // Riscar com o dedo, sem querer, era confundido com o gesto de
        // virar a página — o DragGesture do SwiftUI não tem como saber qual
        // ferramenta fez o toque. `StrikeInteraction` é UIKit puro por
        // baixo: só a Apple Pencil risca; um arrasto de dedo falha na hora
        // e sobe livre pro UIPageViewController folhear. O toque simples
        // (abrir a descrição) continua funcionando com as duas.
        .overlay(
            StrikeInteraction(
                onTap: onShowDetail,
                onStrikeChanged: { dx, dy in
                    guard dx > 12, dx > dy else { return }
                    isStriking = true
                    strikeWidth = min(dx, rowWidth)
                },
                onStrikeEnded: { dx, dy in
                    let coveredEnough = rowWidth > 0 && dx > rowWidth * 0.3 && dy < 30
                    withAnimation(.easeOut(duration: 0.15)) {
                        isStriking = false
                        strikeWidth = 0
                    }
                    if coveredEnough { onStrike() }
                }
            )
        )
    }

    private var name: String {
        if let spell { return spell.name }
        if let freeName, !freeName.isEmpty { return freeName }
        return "—"
    }

    /// A coluna de Cast é estreita — "1 round" ou "5 rounds" não cabe e
    /// corta ("1 rou..."). Quando o tempo de conjuração é em turnos ou
    /// rounds, abrevia pro número + "t"/"r" ("1 t", "5 r"); tempos em
    /// segmentos de iniciativa (só um número) e "Special" ficam como estão.
    private var castingTimeValue: String? {
        guard let raw = spell?.castingTime else { return nil }
        let parts = raw.split(separator: " ", maxSplits: 1)
        guard parts.count == 2, let count = parts.first else { return raw }
        let unit = parts[1].lowercased()
        if unit.hasPrefix("turn") { return "\(count) t" }
        if unit.hasPrefix("round") { return "\(count) r" }
        return raw
    }

    /// Só o valor — "1d8", "10d6", "3d8 + 3" — sem dizer se é dano ou cura;
    /// a coluna já deixa isso implícito. Quando a magia tem uma versão
    /// estruturada (`damageDice`), o valor já sai calculado para o nível do
    /// personagem; senão cai para o texto livre, com "Heal"/"Heals" cortado.
    private var dmgHealValue: String? {
        guard let spell else { return nil }
        if let dice = spell.damageDice {
            return dice.text(casterLevel: casterLevel)
        }
        guard var value = spell.damage else { return nil }
        if value.hasPrefix("Heal") {
            value.removeFirst(4)
            if value.hasPrefix("s") { value.removeFirst() }
            value = value.trimmingCharacters(in: .whitespaces)
        }
        return value
    }

    private func cell(_ text: String?, width: CGFloat) -> some View {
        Text(text ?? "—")
            .font(Paper.hand(17))
            .foregroundStyle(Paper.penInk.opacity(0.9))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .frame(width: width)
    }
}

// MARK: - Turn Undead

/// Cobre uma linha de `MemorizedRow` com dois reconhecedores UIKit em vez
/// do `DragGesture` do SwiftUI, porque só o UIKit sabe dizer qual
/// ferramenta fez o toque:
/// - um toque simples (dedo OU caneta) abre a descrição da magia;
/// - um arrasto só é aceito da Apple Pencil e risca a magia — um arrasto de
///   dedo faz o reconhecedor falhar na hora, sem consumir o gesto, e sobe
///   livre pro `UIPageViewController` folhear a página por trás.
private struct StrikeInteraction: UIViewRepresentable {
    let onTap: () -> Void
    let onStrikeChanged: (_ dx: CGFloat, _ dy: CGFloat) -> Void
    let onStrikeEnded: (_ dx: CGFloat, _ dy: CGFloat) -> Void

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        let tap = UITapGestureRecognizer(target: context.coordinator,
                                          action: #selector(Coordinator.handleTap))
        view.addGestureRecognizer(tap)

        let pan = PencilOnlyPanGestureRecognizer(target: context.coordinator,
                                                  action: #selector(Coordinator.handlePan(_:)))
        pan.delegate = context.coordinator
        view.addGestureRecognizer(pan)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.onTap = onTap
        context.coordinator.onStrikeChanged = onStrikeChanged
        context.coordinator.onStrikeEnded = onStrikeEnded
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onTap: onTap, onStrikeChanged: onStrikeChanged, onStrikeEnded: onStrikeEnded)
    }

    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onTap: () -> Void
        var onStrikeChanged: (_ dx: CGFloat, _ dy: CGFloat) -> Void
        var onStrikeEnded: (_ dx: CGFloat, _ dy: CGFloat) -> Void

        init(onTap: @escaping () -> Void,
             onStrikeChanged: @escaping (_ dx: CGFloat, _ dy: CGFloat) -> Void,
             onStrikeEnded: @escaping (_ dx: CGFloat, _ dy: CGFloat) -> Void) {
            self.onTap = onTap
            self.onStrikeChanged = onStrikeChanged
            self.onStrikeEnded = onStrikeEnded
        }

        @objc func handleTap() {
            onTap()
        }

        @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
            let translation = recognizer.translation(in: recognizer.view)
            switch recognizer.state {
            case .changed:
                onStrikeChanged(translation.x, abs(translation.y))
            case .ended:
                onStrikeEnded(translation.x, abs(translation.y))
            case .cancelled, .failed:
                onStrikeEnded(0, 0)
            default:
                break
            }
        }

        // Permite que o gesto de risco conviva com o scroll da folha (e com
        // a virada de página) em vez de brigar por exclusividade — quem
        // decide se o risco "vale" é a lógica de dx/dy nos closures, não a
        // exclusividade do reconhecedor.
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                               shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            true
        }
    }
}

/// Um `UIPanGestureRecognizer` que só reconhece a Apple Pencil — qualquer
/// toque de dedo faz o reconhecedor falhar imediatamente, sem consumir o
/// gesto, deixando-o livre pro gesto de virar página por trás.
private final class PencilOnlyPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.contains(where: { $0.type != .pencil }) {
            state = .failed
        }
    }
}

/// Todo padre expulsa mortos-vivos — sem teto de tentativas por dia (em 2e
/// só a rolagem decide se funciona, não uma carga que acaba), então é só
/// um traço a cada tentativa, no mesmo estilo dos outros contadores.
///
/// Desenhado como se fosse mais um bloco de círculo de magia — mesma casca,
/// mesmo tamanho de grade — pra economizar espaço encaixado ao lado deles.
/// A tarja de cabeçalho é vinho em vez de preta, com uma cruz antes do
/// título, só pra não ser confundido de relance com um círculo de magia.
private struct TurnUndeadBlock: View {
    @Binding var sheet: SpellSheet

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Text("✝")
                    .font(Paper.hand(13))
                    .foregroundStyle(Paper.sheet)
                Text("TURN UNDEAD")
                    .font(Paper.printed(10))
                    .tracking(2)
                    .foregroundStyle(Paper.sheet)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Paper.turnHeader)

            HStack(spacing: 8) {
                FieldLabel(text: "Attempts")
                TallyBoard(
                    count: sheet.turnUndeadUsed,
                    isExhausted: false,
                    onAdd: { sheet.turnUndeadUsed += 1 },
                    onRemove: {
                        guard sheet.turnUndeadUsed > 0 else { return }
                        sheet.turnUndeadUsed -= 1
                    }
                )
                Text("\(sheet.turnUndeadUsed)")
                    .font(Paper.hand(18))
                    .foregroundStyle(Paper.penInk)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 8)
        }
        .background(Color.white.opacity(0.12))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
    }
}

// MARK: - Itens mágicos

/// Anéis, cajados, bastões, armaduras encantadas — cada item pode conjurar
/// mais de uma magia, com cargas próprias por magia, fora da memorização
/// normal. Cada cartão guarda o nome do item, uma descrição pra consulta, e
/// a lista de magias que ele conjura.
private struct ItemSpellBlock: View {
    @Binding var sheet: SpellSheet

    var body: some View {
        SheetBlock(title: "Magic Item Spells", trailing: "rings, wands, staves, armor") {
            VStack(alignment: .leading, spacing: 14) {
                if sheet.magicItems.isEmpty {
                    Text("No magic items logged for today yet.")
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.inkSoft)
                }

                ForEach($sheet.magicItems) { $item in
                    let itemID = item.id
                    MagicItemCard(
                        item: $item,
                        onDeleteItem: {
                            DispatchQueue.main.async {
                                sheet.magicItems.removeAll { $0.id == itemID }
                            }
                        }
                    )
                }

                AddItemSpellButton(title: "add magic item") {
                    sheet.magicItems.append(MagicItem())
                }
            }
        }
    }
}

/// Um item mágico inteiro: nome, botão de descrição, botão de excluir, e a
/// lista de magias que ele conjura — cada uma com seu próprio traço de uso
/// e seu próprio "trocar magia".
private struct MagicItemCard: View {
    @Binding var item: MagicItem
    let onDeleteItem: () -> Void

    @State private var showDescription = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // A régua fica fora do campo do nome e embaixo da linha
            // inteira: assim ela atravessa o cartão de ponta a ponta, sem o
            // pedaço faltando embaixo de "description" e do ✕ que aparecia
            // quando o sublinhado era do próprio campo, que só tem a
            // largura do texto.
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom, spacing: 10) {
                    VStack(alignment: .leading, spacing: 0) {
                        FieldLabel(text: "Item")
                        EditableText(value: $item.name, placeholder: "item name",
                                     size: 19, underline: false)
                    }

                    Spacer(minLength: 8)

                    Button { showDescription = true } label: {
                        Text("description")
                            .font(Paper.printedItalic(10))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .buttonStyle(.plain)

                    Button(action: onDeleteItem) {
                        Text("✕")
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }

                Rectangle().fill(Paper.hairline).frame(height: 1)
            }

            ForEach($item.spells) { $spell in
                let spellID = spell.id
                ItemSpellRow(
                    item: $spell,
                    onDelete: {
                        DispatchQueue.main.async {
                            item.spells.removeAll { $0.id == spellID }
                        }
                    }
                )
            }

            AddItemSpellButton(title: "add spell") {
                item.spells.append(ItemSpellUse())
            }
        }
        .padding(10)
        .background(Color.white.opacity(0.10))
        .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
        .sheet(isPresented: $showDescription) {
            ItemDescriptionSheet(item: $item)
        }
    }
}

private struct ItemSpellRow: View {
    @Binding var item: ItemSpellUse
    let onDelete: () -> Void

    @EnvironmentObject private var spellbook: SpellDatabase
    @State private var showDetail = false
    @State private var showPicker = false

    /// Todas as cargas foram riscadas — os traços viram vermelhos pra
    /// avisar que a magia está no fim da carga.
    private var isExhausted: Bool { item.usedCount >= item.maxUses }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // Linha padrão, sem o "change" embaixo do nome e sem o rótulo
            // "Dmg/Heal" — o botão de trocar a magia agora mora dentro da
            // própria janela de descrição, aberta ao tocar o nome.
            HStack(alignment: .center, spacing: 8) {
                Button { showDetail = true } label: {
                    Text(item.spellName.isEmpty ? "spell" : item.spellName)
                        .font(Paper.hand(20))
                        .foregroundStyle(item.spellName.isEmpty ? Paper.inkSoft : Paper.penInk)
                        .lineLimit(1)
                }
                .buttonStyle(.plain)
                .frame(minWidth: 60, alignment: .leading)

                Spacer(minLength: 4)

                HStack(spacing: 6) {
                    TallyBoard(count: item.usedCount, isExhausted: isExhausted,
                               onAdd: { item.addTally() }, onRemove: { item.removeLastTally() })
                    Text("\(item.usedCount)")
                        .font(Paper.hand(15))
                        .foregroundStyle(isExhausted ? Paper.redInk : Paper.penInk)
                    Text("of")
                        .font(Paper.printedItalic(10))
                        .foregroundStyle(Paper.inkSoft)
                    EditableNumber(value: $item.maxUses, size: 13, lower: 1, upper: 99)
                }

                EditableText(value: $item.damageNote, placeholder: "1d6+1",
                             size: 14, underline: true)
                    .frame(width: 66, alignment: .leading)

                Button(action: onDelete) {
                    Text("✕")
                        .font(Paper.printed(12))
                        .foregroundStyle(Paper.redInk)
                }
                .buttonStyle(.plain)
            }

            DottedRule()
        }
        .sheet(isPresented: $showDetail) {
            SpellDetailSheet(spell: item.matchedSpellID.flatMap { spellbook.spell(id: $0) },
                              freeName: item.spellName,
                              onChangeSpell: {
                                  showDetail = false
                                  DispatchQueue.main.async { showPicker = true }
                              })
        }
        .sheet(isPresented: $showPicker) {
            SpellWritingSheet(title: "Item spell", initialText: item.spellName) { name, spell in
                item.spellName = name
                item.matchedSpellID = spell?.id
            }
            .environmentObject(spellbook)
        }
    }
}

/// Descrição do item mágico em si — pra consultar o que ele faz sem
/// precisar procurar no livro. Texto livre, sem escrita à mão: é anotação,
/// não magia.
private struct ItemDescriptionSheet: View {
    @Binding var item: MagicItem
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.name.isEmpty ? "Unnamed item" : item.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text("Item description")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ZStack(alignment: .topLeading) {
                    if item.itemDescription.isEmpty {
                        Text("Write what this item does…")
                            .font(Paper.printedItalic(14))
                            .foregroundStyle(Paper.inkSoft.opacity(0.6))
                            .padding(.top, 9)
                            .padding(.leading, 6)
                            .allowsHitTesting(false)
                    }
                    TextEditor(text: $item.itemDescription)
                        .font(Paper.printed(15))
                        .foregroundStyle(Paper.ink)
                        .scrollContentBackground(.hidden)
                        .padding(2)
                }
                .background(Color.white.opacity(0.18))
                .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
            }
            .padding(24)
        }
    }
}

/// A área em branco onde a contagem é feita à mão: um arrasto curto
/// desenha um traço e soma um uso — a mesma cena do detento riscando a
/// parede da cela. Um toque simples (sem arrasto) apaga o último traço.
/// Nada vem pré-desenhado; os traços só existem depois de riscados.
private struct TallyBoard: View {
    let count: Int
    let isExhausted: Bool
    let onAdd: () -> Void
    let onRemove: () -> Void

    @State private var strokeLength: CGFloat = 0

    private let markHeight: CGFloat = 20

    var body: some View {
        HStack(spacing: 0) {
            TallyMarks(count: count, isExhausted: isExhausted)
            if strokeLength > 0 {
                Rectangle()
                    .fill(isExhausted ? Paper.redInk : Paper.ink)
                    .frame(width: 2.4, height: strokeLength)
                    .rotationEffect(.degrees(8))
                    .padding(.leading, 3)
            }
        }
        .frame(minWidth: 70, minHeight: markHeight, alignment: .leading)
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        // O traço é reconhecido em UIKit, e não por um gesto do SwiftUI,
        // porque a mesma view precisa dizer ao iPadOS que aqui a caneta
        // desenha em vez de escrever — senão o Scribble rouba o risco e o
        // transforma em texto no campo de escrita mais próximo.
        //
        // A margem negativa estica essa área de captura para além dos
        // traços desenhados: quem risca começa o movimento um pouco acima
        // da linha, e um começo fora da área é justamente o que escapava
        // para o Scribble. Sendo um overlay, isso não empurra nada no
        // layout da ficha — o tamanho visível do contador não muda.
        .overlay(
            TallyInput(
                onStrokeChange: { length in
                    withAnimation(.easeOut(duration: 0.12)) { strokeLength = length }
                },
                onAdd: onAdd,
                onRemove: onRemove,
                markHeight: markHeight
            )
            .padding(.vertical, -11)
            .padding(.horizontal, -8)
        )
    }
}

/// Os traços agrupados de cinco em cinco, com o quinto cruzando os outros
/// quatro — a marca de contagem clássica. Pretos enquanto sobra carga;
/// todos viram vermelhos quando o item chega ao fim dela.
private struct TallyMarks: View {
    let count: Int
    let isExhausted: Bool

    private let barWidth: CGFloat = 2
    private let barHeight: CGFloat = 18
    private let barSpacing: CGFloat = 3

    private var color: Color { isExhausted ? Paper.redInk : Paper.ink }

    var body: some View {
        FlowRow(spacing: 8, lineSpacing: 6) {
            ForEach(groups) { group in
                marks(in: group)
            }
        }
    }

    private struct Group: Identifiable {
        let start: Int
        let size: Int
        var id: Int { start }
    }

    /// Quebra a contagem em grupos de até 5 traços cada, guardando o índice
    /// inicial de cada um — é o que dá a cada traço uma "mão" própria e
    /// estável (sem reembaralhar a cada redesenho).
    private var groups: [Group] {
        var result: [Group] = []
        var remaining = count
        var start = 0
        while remaining > 0 {
            let size = min(5, remaining)
            result.append(Group(start: start, size: size))
            start += size
            remaining -= size
        }
        return result
    }

    private func marks(in group: Group) -> some View {
        let barsWidth: CGFloat = CGFloat(group.size) * barWidth
            + CGFloat(max(group.size - 1, 0)) * barSpacing

        return ZStack(alignment: .center) {
            HStack(spacing: barSpacing) {
                ForEach(0..<group.size, id: \.self) { offset in
                    let seed = group.start + offset
                    Rectangle()
                        .fill(color)
                        .frame(width: barWidth, height: barHeight * wobbleScale(seed))
                        .rotationEffect(.degrees(wobbleAngle(seed)))
                        .offset(x: wobbleOffset(seed, spread: 1.2), y: wobbleOffset(seed + 1, spread: 1.6))
                }
            }
            if group.size >= 5 {
                Rectangle()
                    .fill(color)
                    .frame(width: barsWidth + 5, height: 2)
                    .rotationEffect(.degrees(-30 + wobbleAngle(group.start + 90) * 0.5))
                    .offset(y: wobbleOffset(group.start + 91, spread: 2))
            }
        }
        .frame(width: barsWidth + 4, height: barHeight + 6)
    }

    /// Pseudo-aleatório determinístico (mesma semente → mesmo traço, sempre)
    /// — nada de tremer a cada recomposição da view. Só serve pra fugir da
    /// régua: cada risco fica um pouco torto, um pouco mais curto ou mais
    /// alto, como se tivesse sido feito à mão mesmo.
    private func noise(_ seed: Int) -> Double {
        // Hash inteiro determinístico — sem trigonometria, então não precisa
        // de import além do SwiftUI. Mesma semente sempre dá o mesmo traço.
        var x = UInt64(bitPattern: Int64(seed))
        x = x &* 2654435761 &+ 0x9E3779B97F4A7C15
        x ^= (x >> 33)
        x = x &* 0xff51afd7ed558ccd
        x ^= (x >> 33)
        return Double(x % 10_000) / 10_000.0 // fração entre 0 e 1
    }

    private func wobbleAngle(_ seed: Int) -> Double {
        (noise(seed) - 0.5) * 14 // -7° a +7°
    }

    private func wobbleScale(_ seed: Int) -> CGFloat {
        CGFloat(0.85 + noise(seed * 7 + 3) * 0.3) // 0.85x a 1.15x
    }

    private func wobbleOffset(_ seed: Int, spread: CGFloat) -> CGFloat {
        CGFloat(noise(seed * 13 + 5) - 0.5) * 2 * spread
    }
}

private struct AddItemSpellButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("+ " + title)
                .font(Paper.printedItalic(11.5))
                .foregroundStyle(Paper.inkSoft)
        }
        .buttonStyle(.plain)
    }
}

/// Escrever o nome de uma magia com a caneta e escolher entre os
/// casamentos por aproximação da base. Serve tanto pra dizer que magia um
/// item conjura quanto pra registrar (ou corrigir) uma magia lançada fora
/// da grade de círculos — é sempre a mesma pergunta, "qual magia é essa?".
///
/// Fica numa folha à parte de propósito, e não numa linha solta no meio da
/// ficha: o campo de escrita do iPadOS captura traços de caneta feitos
/// perto dele, então ele não pode dividir espaço com os contadores de
/// traço — o risco de um contador acabaria virando texto no campo.
private struct SpellWritingSheet: View {
    let title: String
    var initialText: String = ""
    /// Recebe o nome final e a magia da base, quando o casamento foi
    /// escolhido — `nil` quando o nome foi aceito como escrito.
    let onPick: (String, Spell?) -> Void

    @EnvironmentObject private var spellbook: SpellDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var handwritten: String = ""

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text(title)
                        .font(Paper.printed(14))
                        .tracking(1.4)
                        .foregroundStyle(Paper.ink)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                VStack(alignment: .leading, spacing: 2) {
                    FieldLabel(text: "Spell name")
                    HandwritingField(text: $handwritten,
                                     placeholder: "write the spell",
                                     onCommit: confirmBest)
                        .frame(height: 46)
                    DottedRule()
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        if !handwritten.isEmpty {
                            ForEach(candidates) { match in
                                SpellPaperRow(spell: match.spell, hint: match.confidenceLabel) {
                                    pick(name: match.spell.name, spell: match.spell)
                                }
                            }

                            Button {
                                pick(name: handwritten, spell: nil)
                            } label: {
                                let label: String = "use \"" + handwritten + "\" as-is"
                                Text(label)
                                    .font(Paper.printedItalic(13))
                                    .foregroundStyle(Paper.inkSoft)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(24)
        }
        .onAppear { handwritten = initialText }
    }

    private var candidates: [SpellMatch] {
        spellbook.matches(for: handwritten, limit: 8)
    }

    /// Terminar de escrever já resolve, quando o casamento é forte o
    /// bastante — sem precisar tocar na sugestão depois.
    private func confirmBest() {
        guard let best = candidates.first, best.isStrong else { return }
        pick(name: best.spell.name, spell: best.spell)
    }

    private func pick(name: String, spell: Spell?) {
        onPick(name, spell)
        dismiss()
    }
}

// MARK: - Magias adicionais

/// Pro caso clássico de "passar rápido" vários dias sem escolher slot por
/// slot: 3 dias hospedado em segurança curando o grupo, uma Regeneration
/// de duração longa, qualquer magia lançada fora da grade de círculos.
/// Não risca nenhum slot memorizado — é só um registro à parte, pra não
/// se perder o que foi conjurado nesse meio tempo.
private struct AdditionalSpellsBlock: View {
    @Binding var sheet: SpellSheet
    @EnvironmentObject private var spellbook: SpellDatabase

    @State private var expandedID: UUID? = nil
    @State private var handwritten: String = ""

    var body: some View {
        SheetBlock(title: "Additional Spells", trailing: "write the spell with the pencil") {
            VStack(alignment: .leading, spacing: 0) {
                ForEach($sheet.entries) { $entry in
                    let entryID = entry.id
                    AdditionalSpellRow(
                        entry: $entry,
                        isExpanded: expandedID == entryID,
                        onToggle: { expandedID = (expandedID == entryID) ? nil : entryID },
                        onDelete: {
                            DispatchQueue.main.async {
                                sheet.entries.removeAll { $0.id == entryID }
                            }
                        }
                    )
                }

                // A próxima linha em branco da folha é onde se escreve: é
                // só encostar a caneta nela e escrever o nome da magia.
                writingLine

                if !handwritten.isEmpty {
                    suggestions
                }

                ForEach(0..<blankLines, id: \.self) { _ in
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 28)
                        DottedRule()
                    }
                }
            }
        }
    }

    private var writingLine: some View {
        VStack(spacing: 0) {
            HandwritingField(text: $handwritten,
                             placeholder: "cast…",
                             onCommit: confirmBest)
                .frame(height: 34)
            Rectangle().fill(Paper.hairline).frame(height: 1)
        }
    }

    @ViewBuilder
    private var suggestions: some View {
        let matches: [SpellMatch] = spellbook.matches(for: handwritten)

        VStack(alignment: .leading, spacing: 5) {
            if matches.isEmpty {
                Button {
                    logCast(name: handwritten, spell: nil)
                } label: {
                    let title: String = "log \"" + handwritten + "\" as-is"
                    Text(title)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.inkSoft)
                }
                .buttonStyle(.plain)
            } else {
                ForEach(matches) { match in
                    SuggestionLine(match: match) {
                        logCast(name: match.spell.name, spell: match.spell)
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }

    /// Terminar de escrever já registra, quando o casamento é forte o
    /// bastante — sem precisar tocar na sugestão depois.
    private func confirmBest() {
        guard !handwritten.isEmpty else { return }
        let matches: [SpellMatch] = spellbook.matches(for: handwritten)
        guard let best = matches.first, best.isStrong else { return }
        logCast(name: best.spell.name, spell: best.spell)
    }

    private var blankLines: Int {
        let used: Int = sheet.entries.count
        return used >= 6 ? 1 : 6 - used
    }

    /// Lançar de novo uma magia que já está na folha não vira uma linha
    /// nova: é a mesma magia conjurada mais uma vez, então soma no contador
    /// da linha que já existe. Casa primeiro pela magia da base
    /// reconhecida e, sem isso, pelo nome escrito.
    private func logCast(name: String, spell: Spell?) {
        // Larga o foco junto com o registro: um campo em foco captura
        // traços de caneta feitos longe dele, inclusive os riscos dos
        // contadores das linhas de cima. Escrever a próxima magia é
        // encostar a caneta na linha em branco de novo.
        defer {
            handwritten = ""
            resignPencilFocus()
        }

        if let index = indexOfExisting(name: name, spell: spell) {
            sheet.entries[index].castCount += 1
            return
        }

        var entry = SpellLogEntry()
        entry.rawText = handwritten
        entry.displayName = name
        entry.matchedSpellID = spell?.id
        entry.spellLevel = spell?.level
        sheet.entries.append(entry)
    }

    private func indexOfExisting(name: String, spell: Spell?) -> Int? {
        if let spellID = spell?.id {
            return sheet.entries.firstIndex { $0.matchedSpellID == spellID }
        }
        return sheet.entries.firstIndex {
            $0.matchedSpellID == nil
                && $0.displayName.caseInsensitiveCompare(name) == .orderedSame
        }
    }
}

/// Uma magia da base sugerida enquanto se escreve, com o quanto o
/// casamento é confiável e um "log" pra registrar.
private struct SuggestionLine: View {
    let match: SpellMatch
    let onAdd: () -> Void

    var body: some View {
        let caption: String = "lvl. \(match.spell.level) · \(match.confidenceLabel)"

        Button(action: onAdd) {
            HStack(spacing: 8) {
                Text(match.spell.name)
                    .font(Paper.hand(21))
                    .foregroundStyle(Paper.penInk)
                Text(caption)
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
                Spacer(minLength: 0)
                Text("log")
                    .font(Paper.printed(11))
                    .tracking(1)
                    .foregroundStyle(Paper.ink)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .overlay(Rectangle().stroke(Paper.ink.opacity(0.7), lineWidth: 1))
            }
        }
        .buttonStyle(.plain)
    }
}

private struct AdditionalSpellRow: View {
    @Binding var entry: SpellLogEntry
    let isExpanded: Bool
    let onToggle: () -> Void
    let onDelete: () -> Void

    @EnvironmentObject private var spellbook: SpellDatabase
    @State private var showingNamePicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                Button(action: onToggle) {
                    Text(entry.displayName)
                        .font(Paper.hand(22))
                        .foregroundStyle(Paper.penInk)
                        .rotationEffect(.degrees(-0.3))
                }
                .buttonStyle(.plain)

                Spacer(minLength: 8)

                // Mesmo contador de traço do Turn Undead: arrasta pra
                // marcar mais uma conjuração da mesma magia, toca parado
                // pra apagar a última.
                FieldLabel(text: "Casts")
                TallyBoard(
                    count: entry.castCount,
                    isExhausted: false,
                    onAdd: { entry.castCount += 1 },
                    onRemove: {
                        guard entry.castCount > 1 else { return }
                        entry.castCount -= 1
                    }
                )
                Text("\(entry.castCount)")
                    .font(Paper.hand(16))
                    .foregroundStyle(Paper.penInk)

                // Sempre visível, não só quando a linha está expandida —
                // apagar uma linha não devia depender de achar o "delete
                // line" escondido primeiro.
                Button(action: onDelete) {
                    Text("✕")
                        .font(Paper.printed(12))
                        .foregroundStyle(Paper.redInk)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 5)

            Rectangle().fill(Paper.hairline).frame(height: 1)

            if isExpanded {
                HStack(spacing: 10) {
                    Button { showingNamePicker = true } label: {
                        Text("change name")
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .buttonStyle(.plain)
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 7)
            }
        }
        .sheet(isPresented: $showingNamePicker) {
            SpellWritingSheet(title: "Spell name", initialText: entry.displayName) { name, spell in
                entry.rawText = name
                entry.displayName = name
                entry.matchedSpellID = spell?.id
                entry.spellLevel = spell?.level
            }
            .environmentObject(spellbook)
        }
    }
}

// MARK: - Trocar a magia memorizada em um slot

private struct SlotEditorSheet: View {
    let slot: SpellSlot
    @Binding var sheet: SpellSheet
    @EnvironmentObject private var spellbook: SpellDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var handwritten: String = ""

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text("Level \(slot.level) · \(slot.caster.label)")
                        .font(Paper.printed(14))
                        .tracking(1.4)
                        .foregroundStyle(Paper.ink)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                VStack(alignment: .leading, spacing: 2) {
                    FieldLabel(text: "Memorize")
                    HandwritingField(text: $handwritten, placeholder: "write the spell")
                        .frame(height: 46)
                    DottedRule()
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        if !handwritten.isEmpty && candidates.isEmpty {
                            Button {
                                assign(name: handwritten, id: nil)
                            } label: {
                                let title: String = "use \"" + handwritten + "\" as-is"
                                HandValue(text: title, size: 21)
                            }
                            .buttonStyle(.plain)
                        }

                        ForEach(candidates) { match in
                            SpellPaperRow(spell: match.spell, hint: match.confidenceLabel) {
                                assign(name: match.spell.name, id: match.spell.id)
                            }
                        }

                        if handwritten.isEmpty {
                            ForEach(levelList) { spell in
                                SpellPaperRow(spell: spell, hint: nil) {
                                    assign(name: spell.name, id: spell.id)
                                }
                            }
                            if levelList.isEmpty {
                                Text("The built-in spell list doesn't cover this level — write the name by hand.")
                                    .font(Paper.printedItalic(12))
                                    .foregroundStyle(Paper.inkSoft)
                            }
                        }
                    }
                }

                HStack {
                    Button {
                        update { $0.clear() }
                        dismiss()
                    } label: {
                        Text("clear slot")
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button {
                        update { $0.isSpent.toggle() }
                        dismiss()
                    } label: {
                        Text(slot.isSpent ? "unmark as used" : "mark as used")
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.ink)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(24)
        }
    }

    private var candidates: [SpellMatch] {
        let all: [SpellMatch] = spellbook.matches(for: handwritten, limit: 8)
        let level: Int = slot.level
        let caster: CasterType = slot.caster
        return all.filter { (match: SpellMatch) -> Bool in
            match.spell.level == level && match.spell.caster == caster
        }
    }

    private var levelList: [Spell] {
        spellbook.spells(caster: slot.caster, level: slot.level)
    }

    private func assign(name: String, id: String?) {
        update { slot in
            slot.preparedSpellID = id
            slot.preparedSpellName = id == nil ? name : nil
            slot.isSpent = false
        }
        dismiss()
    }

    private func update(_ change: (inout SpellSlot) -> Void) {
        guard let index = sheet.slotBoard.slots.firstIndex(where: { $0.id == slot.id })
        else { return }
        change(&sheet.slotBoard.slots[index])
    }
}

// MARK: - Descrição completa da magia

/// Aberta com um toque simples na linha memorizada. Não mexe no slot — só
/// mostra a descrição. Quando a magia não está na base (nome livre), mostra
/// um texto de placeholder no lugar da descrição real.
private struct SpellDetailSheet: View {
    let spell: Spell?
    let freeName: String?
    /// Só vem preenchido pra magias de item mágico — o círculo de magia
    /// tem sua própria janela de troca, aberta pela grade, e não passa
    /// esse retorno.
    var onChangeSpell: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(Paper.hand(30))
                            .foregroundStyle(Paper.penInk)
                        Text(subtitle)
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    if let onChangeSpell {
                        Button("change", action: onChangeSpell)
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Button("close") { dismiss() }
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)],
                                  alignment: .leading, spacing: 10) {
                            DetailField(label: "Casting Time", value: spell?.castingTime)
                            DetailField(label: "Range", value: spell?.range)
                            DetailField(label: "Duration", value: spell?.duration)
                            DetailField(label: "Area of Effect", value: spell?.areaOfEffect)
                            DetailField(label: "Saving Throw", value: spell?.savingThrow)
                            DetailField(label: "Components", value: spell?.components)
                            if let damage = spell?.damage {
                                DetailField(label: "Damage", value: damage)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            FieldLabel(text: "Description")
                            Text(description)
                                .font(Paper.printed(14))
                                .foregroundStyle(Paper.ink)
                                .lineSpacing(4)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var title: String {
        if let spell { return spell.name }
        if let freeName, !freeName.isEmpty { return freeName }
        return "Unnamed spell"
    }

    private var subtitle: String {
        guard let spell else { return "Not in the built-in spellbook yet" }
        return "Level \(spell.level) \(spell.caster.label.lowercased()) spell · \(spell.school)"
    }

    /// Enquanto a magia não está na base, mostra um texto de exemplo — dá
    /// pra ver a janela funcionando antes de completar o spells.json.
    private var description: String {
        if let spell { return spell.summary }
        return """
        This spell hasn't been added to the built-in spellbook yet, so \
        there's no real description to show — this is placeholder text \
        standing in for it. Once the entry exists in spells.json, its \
        actual casting time, range, duration, and description will show \
        up here automatically.
        """
    }
}

private struct DetailField: View {
    let label: String
    let value: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            FieldLabel(text: label)
            Text(value ?? "—")
                .font(Paper.hand(18))
                .foregroundStyle(Paper.penInk)
        }
    }
}

struct SpellPaperRow: View {
    let spell: Spell
    let hint: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 8) {
                    Text(spell.name)
                        .font(Paper.hand(23))
                        .foregroundStyle(Paper.penInk)
                    if let hint {
                        Text(hint)
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer(minLength: 0)
                    Text(spell.castingTime)
                        .font(Paper.printed(12))
                        .foregroundStyle(Paper.inkSoft)
                }
                Text(spell.summary)
                    .font(Paper.printed(12))
                    .foregroundStyle(Paper.inkSoft)
                    .multilineTextAlignment(.leading)
                DottedRule()
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Layout que quebra linha sozinho

/// SwiftUI não traz um "flow layout"; sem ele, as bolinhas de slot não
/// quebram em várias linhas quando o círculo tem muitos slots.
struct FlowRow: Layout {
    var spacing: CGFloat = 6
    var lineSpacing: CGFloat = 4

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth: CGFloat = max(proposal.width ?? .infinity, 1)
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lineHeight: CGFloat = 0
        var widest: CGFloat = 0

        for subview in subviews {
            let size: CGSize = subview.sizeThatFits(.unspecified)
            if x > 0 && x + size.width > maxWidth {
                y += lineHeight + lineSpacing
                x = 0
                lineHeight = 0
            }
            widest = max(widest, x + size.width)
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
        return CGSize(width: min(widest, maxWidth), height: y + lineHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ()) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size: CGSize = subview.sizeThatFits(.unspecified)
            if x > bounds.minX && x + size.width > bounds.maxX {
                y += lineHeight + lineSpacing
                x = bounds.minX
                lineHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), anchor: .topLeading,
                          proposal: ProposedViewSize(size))
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
}
