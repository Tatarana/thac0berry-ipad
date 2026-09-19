import SwiftUI

/// Um dos três destinos da Tela Principal: todo personagem do jogador,
/// numa lista só — de campanha ou de Sandbox, misturados por seção. Antes
/// da Fase 4 o Sandbox vivia dentro da estante de Campanhas e o elenco de
/// cada campanha só aparecia dentro dela própria; esta tela junta as duas
/// fontes (`library.characters` inteiro) pra responder "onde estão TODOS
/// os meus personagens" sem precisar entrar campanha por campanha.
struct AllCharactersView: View {
    @EnvironmentObject private var library: CharacterLibrary
    @Environment(\.dismiss) private var dismiss
    /// Mesmo padrão de `CampaignDetailView`: a folha de captura de data/nota
    /// abre sob demanda em vez de matar o personagem na hora do toque.
    @State private var characterPendingDeath: PlayerCharacter?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                backRow
                header

                Rectangle().fill(Ember.brassDim).frame(height: 1.4)

                ForEach(library.campaigns) { campaign in
                    // Mortos saem daqui — moram só na seção Fallen Heroes lá
                    // embaixo, pra não aparecer duplicado (uma vez no elenco
                    // da campanha, outra vez no memorial). Arquivado
                    // continua aqui — só inativo, não morto.
                    let cast = library.characters(in: campaign.id).filter { $0.status != .dead }
                    if !cast.isEmpty {
                        section(title: campaign.displayTitle.uppercased(), characters: cast)
                    }
                }

                let livingSandbox = library.sandboxCharacters.filter { $0.status != .dead }
                if !livingSandbox.isEmpty {
                    section(title: "SANDBOX — NO CAMPAIGN YET", characters: livingSandbox)
                }

                if library.characters.isEmpty {
                    Text("No characters yet — start one from a campaign, or add one to the Sandbox below.")
                        .font(Paper.printedItalic(14))
                        .foregroundStyle(Ember.onObsidianSoft)
                        .padding(.top, 6)

                    addSandboxButton
                }

                fallenHeroesSection
            }
            .padding(26)
        }
        .background(ObsidianBackground())
        .toolbar(.hidden, for: .navigationBar)
        .sheet(item: $characterPendingDeath) { person in
            MarkDeadSheet(character: person) { date, note in
                library.markDead(person, on: date, note: note)
            }
        }
    }

    private var backRow: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Ember.onObsidian)
                .frame(width: 30, height: 30)
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Home")
    }

    private var header: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Text("ADVANCED DUNGEONS & DRAGONS · 2ND EDITION")
                    .font(Paper.printed(9.5))
                    .tracking(2)
                    .foregroundStyle(Ember.brass)
                Text("Characters")
                    .font(Paper.hand(40))
                    .foregroundStyle(Ember.onObsidian)
                    .rotationEffect(.degrees(-0.7))
            }
            Spacer()
            addSandboxButton
        }
    }

    /// Criar sem campanha continua possível daqui — o mesmo "+" que antes
    /// morava na seção Sandbox da estante de Campanhas.
    private var addSandboxButton: some View {
        RoundIconButton(systemImage: "person.badge.plus", style: .badge, action: {
            library.addCharacter(campaignID: nil)
        }, accessibilityLabel: "New character", tooltip: "New character")
    }

    private func section(title: String, characters: [PlayerCharacter]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(Paper.printed(9.5))
                .tracking(2)
                .foregroundStyle(Ember.onObsidianSoft)
                .padding(.top, 10)

            ForEach(characters) { person in
                NavigationLink(value: AppRoute.character(person.id, .record)) {
                    CharacterCard(character: person, showHP: person.campaignID != nil)
                        .contextMenu {
                            Menu("Assign to campaign") {
                                if person.campaignID != nil {
                                    Button("Move to Sandbox") {
                                        library.assign(person, toCampaignID: nil)
                                    }
                                }
                                ForEach(library.campaigns) { campaign in
                                    if campaign.id != person.campaignID {
                                        Button(campaign.displayTitle) {
                                            library.assign(person, toCampaignID: campaign.id)
                                        }
                                    }
                                }
                            }
                            // Item 4 do feedback: a jornada de "morrer" não
                            // existia aqui — só dentro do elenco de uma
                            // campanha (`CampaignDetailView`). Personagem de
                            // Sandbox também morre em sessão.
                            Button("Mark as dead", role: .destructive) {
                                characterPendingDeath = person
                            }
                            Button("Delete character", role: .destructive) {
                                library.deleteCharacter(person)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Fallen Heroes

    /// Memorial dos personagens mortos, de todas as campanhas juntas — a
    /// seção dedicada pedida à parte do elenco vivo de cada campanha (ver
    /// filtro `status != .dead` acima). Usa o brasão do cavaleiro-esqueleto
    /// (`Docs/icon-button-spec.md`) como cabeçalho em vez do rótulo de
    /// texto simples das outras seções — pensado pra ser visto, não
    /// escondido atrás de um "mostrar mais".
    @ViewBuilder
    private var fallenHeroesSection: some View {
        let fallen = library.characters
            .filter { $0.status == .dead }
            .sorted { $0.name < $1.name }

        if !fallen.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    if let art = Image.bundled("banner_fallen_heroes") {
                        art
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 54)
                            .shadow(color: Color.black.opacity(0.45), radius: 4, y: 2)
                    }
                    Text("FALLEN HEROES")
                        .font(Paper.printed(9.5))
                        .tracking(2)
                        .foregroundStyle(Ember.onObsidianSoft)
                }
                .padding(.top, 18)

                ForEach(fallen) { person in
                    NavigationLink(value: AppRoute.character(person.id, .record)) {
                        CharacterCard(character: person, showHP: false)
                            .contextMenu {
                                Button("Bring back to active cast") {
                                    library.reviveToAlive(person)
                                }
                                Button("Delete character", role: .destructive) {
                                    library.deleteCharacter(person)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
