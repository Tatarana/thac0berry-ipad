import SwiftUI
import UIKit

/// O cartão de personagem — uma folha dobrada com nome, HP e magias prontas.
/// Reaproveitado tanto pela seção Sandbox da tela de Campanhas quanto pelo
/// Elenco de uma `CampaignDetailView` — não é mais uma lista própria (isso
/// virou `CampaignListView`, a nova raiz do app).
struct CharacterCard: View {
    let character: PlayerCharacter
    /// Personagem no Sandbox ainda não tem campanha — mostrar HP dele é
    /// informação sem uso nenhum ali (ele nem entrou em combate ainda).
    /// Some só o badge; o resto do cartão continua igual.
    var showHP: Bool = true

    /// Magias memorizadas e ainda não gastas na folha do dia em andamento.
    static func readySpells(in character: PlayerCharacter) -> Int {
        guard let sheet = character.sortedSpellSheets.first else { return 0 }
        var total = 0
        for slot in sheet.slotBoard.slots where !slot.isSpent && !slot.isEmpty {
            total += 1
        }
        return total
    }

    /// A linha que substitui "X spells ready" quando o personagem morreu.
    /// `diedOn`/`deathNote` já existiam no modelo mas nunca eram exibidos —
    /// e o botão "Mark as dead" mais antigo (`CampaignDetailView.castMenu`)
    /// gravava data/nota em branco, então muito personagem morto por aqui
    /// ainda não tem nada registrado. Sem data: só "Fallen". Com nota: data
    /// + nota. Nunca deixa a linha em branco.
    private var deathLine: String {
        guard let diedOn = character.diedOn else {
            return "Fallen"
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateText = "Died \(formatter.string(from: diedOn))"
        if let note = character.deathNote, !note.isEmpty {
            return "\(dateText) — \(note)"
        }
        return dateText
    }

    var body: some View {
        let subtitle: String = character.displaySubtitle
        // O que interessa na capa é a folha do dia em andamento.
        let ready: Int = CharacterCard.readySpells(in: character)
        let sheetCount: Int = character.spellSheets.count

        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(character.displayTitle)
                        .font(Paper.hand(34))
                        .foregroundStyle(Ember.onObsidian)
                        .rotationEffect(.degrees(-0.5))
                    if character.status != .alive {
                        // Selo de cera de verdade (ver Docs/icon-button-spec.md)
                        // em vez do emoji que ficava aqui antes — caveira
                        // gravada pro morto, cadeado rúnico pro arquivado.
                        // Sem a imagem, cai pro emoji antigo, nunca some.
                        StatusSeal(status: character.status)
                    }
                }
                Text(subtitle)
                    .font(Paper.printed(13))
                    .foregroundStyle(Ember.onObsidianSoft)
                if character.status == .dead {
                    // "Prontas pra conjurar hoje" não diz nada sobre quem já
                    // morreu — mostra como e quando, se tiver sido registrado.
                    Text(deathLine)
                        .font(Paper.printedItalic(11.5))
                        .foregroundStyle(Ember.onObsidianSoft.opacity(0.85))
                } else {
                    Text("\(ready) spells ready · \(sheetCount) sheet\(sheetCount == 1 ? "" : "s")")
                        .font(Paper.printedItalic(11.5))
                        .foregroundStyle(Ember.onObsidianSoft.opacity(0.85))
                }
            }

            Spacer(minLength: 0)

            if showHP {
                DiceIconBadge(kind: .d8, value: "\(character.hitPointsCurrent)/\(character.hitPointsMax)", diameter: 44)
            }
        }
        .padding(16)
        .padding(.leading, 3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(alignment: .trailing) {
            // Fallen Heroes: o brasão do cavaleiro-esqueleto (já usado como
            // cabeçalho da seção) reaparece bem de leve dentro de cada
            // caixa individual, encostado na direita — onde o cartão só
            // tem o d8 de HP (que aqui nem aparece, `showHP: false`) ou
            // espaço vazio. Opacidade baixa de propósito: é textura atrás
            // do texto, não outra ilustração competindo com ele.
            if character.status == .dead, let art = Image.bundled("banner_fallen_heroes") {
                art
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 108)
                    .opacity(0.4)
                    .allowsHitTesting(false)
            }
        }
        .clipped()
        .emberCard(accent: Ember.crimson)
        // O selo do dragão (Fase 3) saiu daqui — tentar disparar a
        // animação num `simultaneousGesture` bem na hora do toque estava
        // competindo com o gesto do `NavigationLink` ao redor do cartão
        // (mudar a view — inserir o selo condicionalmente — no meio do
        // toque cancelava a navegação: por isso a ficha travava sem abrir
        // e o selo nem chegava a aparecer direito). Agora ele mora na
        // `CharacterSheetView`, disparado só quando a ficha já apareceu na
        // tela (`onAppear`) — sem gesto nenhum aqui, sem risco de atrapalhar
        // o toque que abre o personagem.
    }
}

/// O selinho de status ao lado do nome — caveira em cera vermelha pro
/// personagem morto, cadeado rúnico dourado pro arquivado. Pequeno de
/// propósito (16pt): é só um marcador ao lado do nome escrito à mão, não
/// o protagonista do cartão.
private struct StatusSeal: View {
    let status: CharacterStatus

    private var imageName: String {
        status == .dead ? "seal_dead" : "seal_archived"
    }

    var body: some View {
        if let art = Image.bundled(imageName) {
            art
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
        } else {
            Text(status == .dead ? "🩸" : "🔒")
                .font(.system(size: 13))
        }
    }
}
