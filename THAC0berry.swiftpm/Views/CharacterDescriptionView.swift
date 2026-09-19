import SwiftUI
import PhotosUI
import UIKit

/// A 4ª página da aba Sheet — "Character Description" do PDF de referência
/// (`MI_ADDCharSheet46.pdf`, página 4): a tabela de dados pessoais, a caixa
/// de retrato, Personality, Hit Points by Level e Background/History/
/// Noteworthy Events. Existe pra TODA classe (não só quem tem ficha de
/// magia) — mesmo `Grid`/`FormCell` "moldura de verdade" das outras páginas
/// oficiais, mas com peças próprias (`DescCell`) porque `FormCell` é
/// privada de `CharacterSheetView.swift` e não dá pra reaproveitar dali.
struct CharacterDescriptionPage: View {
    @Binding var character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Character Description")
                .font(Paper.printed(15))
                .tracking(1.6)
                .foregroundStyle(Paper.ink)
                .frame(maxWidth: .infinity, alignment: .center)

            VStack(spacing: 16) {
                descriptionTable

                HStack(alignment: .top, spacing: 16) {
                    personalityBlock
                        .frame(maxWidth: .infinity)
                    CharacterSketchBox(character: $character)
                        .frame(width: 220)
                }

                hitPointsByLevelField

                backgroundBlock
            }
            .padding(16)
            .background(Color.white.opacity(0.4))
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
        }
    }

    // MARK: - Tabela de dados pessoais

    /// Linhas 1-4 são simétricas (4 colunas iguais, ou 2 colunas de largura
    /// dupla na primeira linha) — igual ao PDF. Da 5ª linha em diante o PDF
    /// deixa de ser simétrico: "Racial Abilities" vira uma caixa alta à
    /// esquerda (mais espaço pra texto longo) enquanto a direita continua
    /// com linhas normais (Skin/Vision, Handedness/Class, Origin) — por
    /// isso essa parte final é um bloco à parte em vez de mais linhas da
    /// mesma grade.
    ///
    /// Pedido do usuário (2026-09-19): a coluna da esquerda precisava de
    /// mais espaço, "por volta de 20% a mais". A 1ª tentativa pesava cada
    /// LINHA de forma independente (uma `GeometryReader` por linha,
    /// normalizando os pesos daquela linha só) — matematicamente cada
    /// linha ficava certa, mas como a linha de 2 colunas e as linhas de 4
    /// colunas normalizavam separado, as bordas verticais não caíam no
    /// mesmo lugar de uma linha pra outra (ficou "desalinhado", captura de
    /// tela do usuário confirmou). Correção: uma ÚNICA `GeometryReader`
    /// pra tabela inteira, dividindo a largura em 4 "quartos" com pesos
    /// fixos (`q1` bem maior, `q2`/`q3`/`q4` iguais) — toda célula usa
    /// esses MESMOS quatro valores (ou a soma de dois quartos vizinhos,
    /// pras células que ocupam largura dupla, tipo Character Name ou
    /// Racial Abilities), garantindo que as bordas fiquem exatamente
    /// alinhadas em todas as linhas, como uma tabela de verdade.
    /// Feedback do usuário (2026-09-19): com q1 em 1.2x "fez muito pouca
    /// diferença" — subiu pra 1.8x (quase o dobro das outras colunas).
    private var descriptionTable: some View {
        GeometryReader { geo in
            let q1Weight: CGFloat = 1.8
            let totalWeight: CGFloat = q1Weight + 3 // q1 + q2 + q3 + q4
            let unit = geo.size.width / totalWeight
            let q1 = unit * q1Weight
            let q2 = unit
            let q3 = unit
            let q4 = unit

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    DescCell(label: "Character Name", value: $character.name)
                        .frame(width: q1 + q2)
                    DescCell(label: "Player Name", value: $character.playerName)
                        .frame(width: q3 + q4)
                }
                HStack(spacing: 0) {
                    DescCell(label: "Birth Date", value: $character.birthDate.orDefault(""))
                        .frame(width: q1)
                    DescCell(label: "Birth Rank", value: $character.birthRank.orDefault(""))
                        .frame(width: q2)
                    DescCell(label: "Age", value: $character.age)
                        .frame(width: q3)
                    DescCell(label: "Sex", value: $character.sex)
                        .frame(width: q4)
                }
                HStack(spacing: 0) {
                    DescCell(label: "Alignment", value: $character.alignment)
                        .frame(width: q1)
                    DescCell(label: "Deity", value: $character.deity)
                        .frame(width: q2)
                    DescCell(label: "Height", value: $character.height)
                        .frame(width: q3)
                    DescCell(label: "Weight", value: $character.weight)
                        .frame(width: q4)
                }
                HStack(spacing: 0) {
                    DescCell(label: "Race", value: $character.race)
                        .frame(width: q1)
                    DescCell(label: "Nationality", value: $character.nationality.orDefault(""))
                        .frame(width: q2)
                    DescCell(label: "Hair", value: $character.hair)
                        .frame(width: q3)
                    DescCell(label: "Eyes", value: $character.eyes)
                        .frame(width: q4)
                }
                HStack(alignment: .top, spacing: 0) {
                    DescCell(label: "Racial Abilities", value: $character.racialAbilities.orDefault(""),
                             minHeight: 126)
                        .frame(width: q1 + q2)
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            DescCell(label: "Skin", value: $character.skin.orDefault(""))
                                .frame(width: q3)
                            DescCell(label: "Vision", value: $character.vision.orDefault(""))
                                .frame(width: q4)
                        }
                        HStack(spacing: 0) {
                            DescCell(label: "Handedness", value: $character.handedness.orDefault(""))
                                .frame(width: q3)
                            DescCellStatic(label: "Class", value: character.characterClass.rawValue)
                                .frame(width: q4)
                        }
                        DescCell(label: "Origin", value: $character.placeOfOrigin.orDefault(""))
                            .frame(width: q3 + q4)
                    }
                    .frame(width: q3 + q4)
                }
            }
        }
        // Altura = soma fixa das 5 linhas (4 × 42 + 126) — a
        // `GeometryReader` da tabela inteira precisa de uma altura
        // explícita de fora, senão tenta ocupar todo o `ScrollView`.
        .frame(height: 42 * 4 + 126)
    }

    // MARK: - Personality

    private var personalityBlock: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Personality")
                .font(.system(size: 10, design: .serif))
                .foregroundStyle(Paper.inkSoft)
            PaperTextEditor(text: $character.personality.orDefault(""),
                            placeholder: "How they talk, what they want, what they're afraid of…")
                .frame(minHeight: 220)
        }
    }

    // MARK: - Hit Points by Level

    private var hitPointsByLevelField: some View {
        HStack(spacing: 8) {
            Text("Hit Points by Level:")
                .font(.system(size: 12, design: .serif))
                .foregroundStyle(Paper.ink)
            InlineTextField(value: $character.hitPointsByLevel.orDefault(""), placeholder: "—",
                            fontSize: 15, underline: true)
                .frame(maxWidth: 260)
        }
    }

    // MARK: - Background / History / Noteworthy Events

    private var backgroundBlock: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Background / History / Noteworthy Events")
                .font(Paper.printed(12))
                .tracking(1)
                .foregroundStyle(Paper.ink)
                .frame(maxWidth: .infinity, alignment: .center)
            PaperTextEditor(text: $character.backgroundHistory.orDefault(""),
                            placeholder: "Where they're from, what happened along the way, what everyone at the table should remember…")
                .frame(minHeight: 320)
        }
    }
}

// MARK: - Célula da tabela (label + valor editável, com moldura)

/// Mesma ideia de `FormCell` (label pequeno em cima, valor embaixo, moldura
/// fina de verdade) — reimplementada aqui porque `FormCell` é privada de
/// `CharacterSheetView.swift`. `multiline`/`minHeight` existem só pra
/// "Racial Abilities", a única célula desta página com texto longo o
/// bastante pra precisar de mais de uma linha.
private struct DescCell: View {
    let label: String
    @Binding var value: String
    var minHeight: CGFloat = 42

    // Escreve direto na página com `InlineTextField` (mesma UIKit
    // `HandwritingField` por baixo) — sem balão. A 1ª tentativa desta
    // célula usava um botão que abria um popover próprio; o usuário pediu
    // escrita direta (igual Racial Abilities/Personality/Background, que
    // já usavam esse caminho e sempre funcionaram) e, de quebra, o
    // popover também estava trocando o texto de campo (escrever em "Hit
    // Points by Level"/"Race"/"Nationality" ia parar em "Personality"/
    // "Racial Abilities") — o botão+popover saiu de vez, não só por
    // preferência de UX.
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(label)
                .font(.system(size: 8.5, design: .serif))
                .foregroundStyle(Paper.inkSoft)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            InlineTextField(value: $value, placeholder: "", fontSize: 13, underline: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .topLeading)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
    }
}

/// A mesma célula, só que pra um valor que não é dessa página (a Classe já
/// se edita na página 1, pelo `ClassPicker`) — mostrado aqui só pra
/// completar a tabela como no PDF, sem abrir um segundo jeito de editar a
/// mesma coisa.
private struct DescCellStatic: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(label)
                .font(.system(size: 8.5, design: .serif))
                .foregroundStyle(Paper.inkSoft)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            Text(value.isEmpty ? "—" : value)
                .font(Paper.hand(17))
                .foregroundStyle(Paper.penInk)
                .lineLimit(1)
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, minHeight: 42, alignment: .topLeading)
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
    }
}

// MARK: - Texto livre com régua de papel

/// `TextEditor` com o mesmo tratamento visual já usado na descrição de um
/// item mágico (`SlotEditorSheet` em `SpellSheetView.swift`): fundo claro,
/// placeholder por cima quando vazio, moldura fina.
private struct PaperTextEditor: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft.opacity(0.6))
                    .padding(.top, 9)
                    .padding(.leading, 6)
                    .allowsHitTesting(false)
            }
            TextEditor(text: $text)
                .font(Paper.printed(14))
                .foregroundStyle(Paper.ink)
                .scrollContentBackground(.hidden)
                .padding(2)
        }
        .background(Color.white.opacity(0.18))
        .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
    }
}

// MARK: - Retrato / Character Sketch

/// O quadrado "Character Sketch" do PDF, funcional: toque abre o seletor
/// de fotos do sistema (`PhotosPicker`, sem pedir permissão de biblioteca
/// inteira — o picker roda fora do processo do app) e a imagem escolhida
/// vira o retrato do personagem. Moldura dupla como no PDF (duas linhas
/// com um pequeno vão entre elas).
struct CharacterSketchBox: View {
    @Binding var character: PlayerCharacter
    @State private var pickerItem: PhotosPickerItem? = nil
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 6) {
            Text("Character Sketch")
                .font(.system(size: 11, design: .serif))
                .foregroundStyle(Paper.ink)

            PhotosPicker(selection: $pickerItem, matching: .images) {
                // `GeometryReader` mede o espaço disponível de verdade e o
                // retrato usa exatamente essa medida (`geo.size`) no seu
                // próprio `.frame`, antes do `.clipped()` — o corte deixa de
                // depender de nenhuma propagação de frame vinda de fora
                // (nem do `PhotosPicker`, nem do `ZStack` ao redor). Antes,
                // com a altura fixada só no `ZStack`, o primeiro retrato
                // cabia certinho mas TROCAR de foto (uma nova imagem, com
                // proporção diferente da anterior) estourava a moldura na
                // horizontal — o `Image(uiImage:)` antigo não tinha uma
                // largura própria pra se ancorar, só herdava do ZStack.
                GeometryReader { geo in
                    ZStack {
                        Color.white.opacity(0.5)

                        if let data = character.portraitImageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                        } else if isLoading {
                            ProgressView()
                        } else {
                            VStack(spacing: 8) {
                                Image(systemName: "person.crop.square.badge.plus")
                                    .font(.system(size: 30))
                                    .foregroundStyle(Paper.inkSoft)
                                Text("Tap to add a portrait")
                                    .font(Paper.printedItalic(11))
                                    .foregroundStyle(Paper.inkSoft)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 240)
                .clipped()
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .padding(4)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
            .padding(2)
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))

            if character.portraitImageData != nil {
                Button(role: .destructive) {
                    character.portraitImageData = nil
                    pickerItem = nil
                } label: {
                    Text("Remove photo")
                        .font(Paper.printed(11))
                        .foregroundStyle(Paper.redInk)
                }
                .buttonStyle(.plain)
            }
        }
        .onChange(of: pickerItem) { _, newItem in
            guard let newItem else { return }
            isLoading = true
            Task {
                let jpeg = try? await newItem.loadTransferable(type: Data.self)
                    .flatMap { UIImage(data: $0) }
                    .flatMap { $0.resizedForSketch() }
                    .flatMap { $0.jpegData(compressionQuality: 0.82) }
                await MainActor.run {
                    if let jpeg { character.portraitImageData = jpeg }
                    isLoading = false
                }
            }
        }
    }
}

private extension UIImage {
    /// Reduz a imagem escolhida pra um retrato — não precisa de resolução
    /// de câmera pra caber num quadrado de tela; isso só engordaria o JSON
    /// que `CharacterLibrary` salva (o personagem inteiro, retrato
    /// incluso) sem ganho nenhum de nitidez visível. Mesma faixa de
    /// tamanho usada pros ícones ilustrados do app (700-900px).
    func resizedForSketch(maxDimension: CGFloat = 800) -> UIImage? {
        let scale = min(1, maxDimension / max(size.width, size.height))
        guard scale < 1 else { return self }
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in draw(in: CGRect(origin: .zero, size: newSize)) }
    }
}
