import SwiftUI

/// A página de uma campanha: elenco de personagens (vivos em destaque,
/// mortos e arquivados guardados em seções recolhidas — mesmo padrão de
/// "sessões antigas" que o Índice de Sessões já usa), a linha do tempo de
/// sessões da campanha inteira, e o link pro Caderno compartilhado.
struct CampaignDetailView: View {
    @Binding var campaign: Campaign
    @EnvironmentObject private var library: CharacterLibrary
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeadSection = false
    @State private var showingArchivedSection = false
    /// Personagem esperando a folha `MarkDeadSheet` — `.sheet(item:)` em vez
    /// de matar na hora: item 4 do feedback pedia uma jornada de verdade
    /// pra "morrer", não um toque só que já grava data de hoje/nota em
    /// branco sem perguntar nada.
    @State private var characterPendingDeath: PlayerCharacter?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                backRow
                header
                Rectangle().fill(Ember.brassDim).frame(height: 1.4)
                castSection
                notebookLink
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

    // MARK: - Cabeçalho

    /// A barra de navegação do sistema fica escondida em toda tela do
    /// app — sem ela, o único jeito de voltar pra capa seria o gesto de
    /// arrastar da borda, fácil de não perceber; por isso este botão
    /// explícito. Compacto (30×30, sem o mínimo de toque de 44pt do
    /// `RoundIconButton`) — o mesmo padrão usado na fileira de abas da
    /// ficha do personagem, pra não repetir o botão grande/opaco demais
    /// que o feedback já reclamou aqui antes.
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
        .accessibilityLabel("Campaigns")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("CAMPAIGN")
                .font(Paper.printed(9.5))
                .tracking(2)
                .foregroundStyle(Ember.brass)
            InlineTextField(value: $campaign.name, placeholder: "unnamed campaign",
                            fontSize: 30, textColor: Ember.onObsidian)
            HStack(spacing: 10) {
                Text(campaign.startedDate, style: .date)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Ember.onObsidianSoft)
                RoundIconButton(
                    systemImage: campaign.isArchived ? "tray.and.arrow.up.fill" : "archivebox.fill",
                    style: .badge,
                    action: { campaign.isArchived.toggle() },
                    accessibilityLabel: campaign.isArchived ? "Unarchive campaign" : "Archive campaign",
                    tooltip: campaign.isArchived ? "Unarchive campaign" : "Archive campaign"
                )
                // Fase 6 do plano: arquivar/desarquivar ganhou um pulinho no
                // próprio ícone (a caixa "fecha" com uma leve batida) — antes
                // trocava de símbolo sem nenhum aviso de que algo aconteceu.
                .symbolEffect(.bounce, value: campaign.isArchived)
            }
        }
    }

    // MARK: - Elenco

    private var castSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("CAST")
                    .font(Paper.printed(9.5))
                    .tracking(2)
                    .foregroundStyle(Ember.onObsidianSoft)
                Spacer()
                // Item 6 do feedback: não existia jeito nenhum de trazer um
                // personagem que já estava no Sandbox pra dentro de uma
                // campanha a partir DAQUI — só dava pra criar um novo, ou ir
                // até o Sandbox e usar o menu de contexto lá. Agora o mesmo
                // botão de "+" oferece as duas opções.
                // Item 5 do feedback: `.paper` (ícone escuro sobre fundo
                // quase-branco) também estava apagado aqui, mesmo bug do
                // botão do Sandbox — trocado por `.badge`.
                Menu {
                    Button {
                        library.addCharacter(campaignID: campaign.id)
                    } label: {
                        Label("New character", systemImage: "person.badge.plus")
                    }
                    if !library.sandboxCharacters.isEmpty {
                        Menu {
                            ForEach(library.sandboxCharacters) { person in
                                Button(person.displayTitle) {
                                    library.assign(person, toCampaignID: campaign.id)
                                }
                            }
                        } label: {
                            Label("Add from Sandbox", systemImage: "tray.and.arrow.down")
                        }
                    }
                } label: {
                    RoundIconBadge(systemImage: "person.badge.plus", style: .badge)
                        .actionTooltip("Add character")
                }
                .accessibilityLabel("Add character")

                // Item 4 do feedback do v0.54: o cartão-link "Open sessions
                // index" não fazia sentido visualmente ali sozinho, largado
                // embaixo da lista de personagens. Virou este ícone
                // compacto, do lado do de adicionar personagem — mesma
                // linha, mesmo peso visual, sem seção própria.
                if !campaign.sessions.isEmpty, let first = aliveCast.first ?? cast.first {
                    NavigationLink(value: AppRoute.character(first.id, .campaignIndex)) {
                        RoundIconBadge(systemImage: "book.pages.fill", style: .badge)
                            .actionTooltip("Sessions (\(campaign.sessions.count))")
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Sessions (\(campaign.sessions.count))")
                }
            }

            ForEach(aliveCast) { person in
                castRow(person)
            }

            if !deadCast.isEmpty {
                DisclosureGroup(isExpanded: $showingDeadSection) {
                    VStack(spacing: 10) { ForEach(deadCast) { castRow($0) } }
                        .padding(.top, 8)
                } label: {
                    Text("Dead (\(deadCast.count))")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Ember.onObsidianSoft)
                }
                .tint(Ember.onObsidianSoft)
            }

            if !archivedCast.isEmpty {
                DisclosureGroup(isExpanded: $showingArchivedSection) {
                    VStack(spacing: 10) { ForEach(archivedCast) { castRow($0) } }
                        .padding(.top, 8)
                } label: {
                    Text("Archived (\(archivedCast.count))")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Ember.onObsidianSoft)
                }
                .tint(Ember.onObsidianSoft)
            }

            if aliveCast.isEmpty && deadCast.isEmpty && archivedCast.isEmpty {
                Text("No characters in this campaign yet.")
                    .font(Paper.printedItalic(14))
                    .foregroundStyle(Ember.onObsidianSoft)
            }
        }
    }

    private func castRow(_ person: PlayerCharacter) -> some View {
        NavigationLink(value: AppRoute.character(person.id, .record)) {
            CharacterCard(character: person)
                .contextMenu { castMenu(for: person) }
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func castMenu(for person: PlayerCharacter) -> some View {
        Button("Clone character") {
            library.cloneCharacter(person, into: campaign.id)
        }
        if person.status == .alive {
            Button("Mark as dead", role: .destructive) {
                characterPendingDeath = person
            }
            Button("Archive") {
                library.toggleArchived(person)
            }
        } else {
            Button("Bring back to active cast") {
                library.reviveToAlive(person)
            }
        }
        Button("Move to Sandbox") {
            library.assign(person, toCampaignID: nil)
        }
        Button("Delete character", role: .destructive) {
            library.deleteCharacter(person)
        }
    }

    private var cast: [PlayerCharacter] { library.characters(in: campaign.id) }
    private var aliveCast: [PlayerCharacter] { cast.filter { $0.status == .alive } }
    private var deadCast: [PlayerCharacter] { cast.filter { $0.status == .dead } }
    private var archivedCast: [PlayerCharacter] { cast.filter { $0.status == .archived } }

    // MARK: - Caderno

    private var notebookLink: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("NOTEBOOK")
                .font(Paper.printed(9.5))
                .tracking(2)
                .foregroundStyle(Ember.onObsidianSoft)
            // Abre direto pelo caderno da campanha (`CampaignNotebookView`)
            // — antes isso pegava emprestada a ficha do primeiro personagem
            // do elenco só pra chegar lá, o que também trazia a fileira de
            // abas da ficha (Sheet/Notebook, menu ☰) junto sem necessidade;
            // o caderno é da campanha, nunca precisou de personagem nenhum
            // pra existir.
            NavigationLink(value: AppRoute.campaignNotebook(campaign.id)) {
                HStack {
                    Text("Open campaign notebook")
                        .font(Paper.printed(13))
                        .foregroundStyle(Ember.onObsidian)
                    Spacer()
                    DiceIconBadge(kind: .d10, value: "\(campaign.notebookEntries.count)", diameter: 34)
                }
                .padding(12)
                .padding(.leading, 3)
                .emberCard(accent: Ember.teal)
            }
            .buttonStyle(.plain)
        }
    }
}
