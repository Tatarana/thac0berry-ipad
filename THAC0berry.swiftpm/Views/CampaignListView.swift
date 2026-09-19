import SwiftUI
import UIKit

/// A estante de campanhas — um dos três destinos da Tela Principal
/// (`HomeView`, a raiz do app desde a Fase 4). Cada campanha dura meses ou
/// anos e pode ter vários personagens ativos ao mesmo tempo. O Sandbox
/// (personagens sem campanha) e o Grimório saíram daqui: agora moram em
/// `AllCharactersView` e `CompendiumHubView`, os outros dois ícones grandes
/// da Tela Principal — esta tela ficou só com a lista de campanhas em si.
struct CampaignListView: View {
    @EnvironmentObject private var library: CharacterLibrary
    @EnvironmentObject private var spellbook: SpellDatabase
    @Environment(\.dismiss) private var dismiss
    @State private var showingArchivedSection = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                backRow
                header

                Rectangle().fill(Ember.brassDim).frame(height: 1.4)

                campaignsSection

                if let error = spellbook.loadError ?? library.lastError {
                    Text(error)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Ember.glowBright)
                }
            }
            .padding(26)
        }
        .background(ObsidianBackground())
        .toolbar(.hidden, for: .navigationBar)
    }

    /// Mesmo padrão de "voltar" das outras telas empurradas a partir da
    /// Tela Principal (`CampaignDetailView.backRow`, a fileira de abas da
    /// ficha) — a barra de navegação do sistema fica sempre escondida.
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
                Text("Campaigns")
                    .font(Paper.hand(40))
                    .foregroundStyle(Ember.onObsidian)
                    .rotationEffect(.degrees(-0.7))
            }
            Spacer()

            RoundIconButton(systemImage: "plus", style: .badge, action: {
                library.addCampaign(name: "")
            }, accessibilityLabel: "New campaign", tooltip: "New campaign")
        }
    }

    // MARK: - Campanhas

    /// Ativas em cima, sempre visíveis; arquivadas numa seção recolhida no
    /// fim — mesmo padrão que o elenco de uma campanha já usa pra
    /// personagem morto/arquivado (`CampaignDetailView.castSection`).
    /// Antes disso, "Archived" não tinha efeito nenhum na listagem: a
    /// campanha continuava exatamente onde estava, só com uma palavra a
    /// mais no subtítulo do cartão.
    private var activeCampaigns: [Campaign] { library.campaigns.filter { !$0.isArchived } }
    private var archivedCampaigns: [Campaign] { library.campaigns.filter { $0.isArchived } }

    private var campaignsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("CAMPAIGNS")
                .font(Paper.printed(9.5))
                .tracking(2)
                .foregroundStyle(Ember.onObsidianSoft)

            ForEach(activeCampaigns) { campaign in
                campaignRow(campaign)
            }

            if !archivedCampaigns.isEmpty {
                DisclosureGroup(isExpanded: $showingArchivedSection) {
                    VStack(spacing: 10) { ForEach(archivedCampaigns) { campaignRow($0) } }
                        .padding(.top, 8)
                } label: {
                    Text("Archived (\(archivedCampaigns.count))")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Ember.onObsidianSoft)
                }
                .tint(Ember.onObsidianSoft)
            }

            if library.campaigns.isEmpty {
                Text("No campaigns yet — start one above.")
                    .font(Paper.printedItalic(14))
                    .foregroundStyle(Ember.onObsidianSoft)
                    .padding(.top, 6)
            }
        }
    }

    private func campaignRow(_ campaign: Campaign) -> some View {
        NavigationLink(value: AppRoute.campaign(campaign.id)) {
            CampaignRow(campaign: campaign,
                       characterCount: library.characters(in: campaign.id).count)
        }
        .buttonStyle(.plain)
        // Mesmo padrão da listagem de personagens (`CharacterCard` em
        // `AllCharactersView`): excluir/arquivar por toque longo, sem
        // precisar entrar na campanha pra achar o botão (que já existe lá
        // dentro, no cabeçalho — este aqui é só um atalho a mais, direto
        // da lista).
        .contextMenu {
            Button(campaign.isArchived ? "Unarchive" : "Archive") {
                var updated = campaign
                updated.isArchived.toggle()
                library.updateCampaign(updated)
            }
            Button("Delete campaign", role: .destructive) {
                library.deleteCampaign(campaign)
            }
        }
    }
}

/// Uma linha da lista de campanhas: nome, quantidade de sessões e de
/// personagens no elenco.
private struct CampaignRow: View {
    let campaign: Campaign
    let characterCount: Int

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(campaign.displayTitle)
                    .font(Paper.hand(28))
                    .foregroundStyle(Ember.onObsidian)
                    .rotationEffect(.degrees(-0.4))
                Text(campaign.isArchived
                     ? "Archived · \(characterCount) character\(characterCount == 1 ? "" : "s")"
                     : "\(characterCount) character\(characterCount == 1 ? "" : "s")")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Ember.onObsidianSoft)
            }

            Spacer(minLength: 0)

            DiceIconBadge(kind: .d10, value: "\(campaign.sessions.count)", diameter: 40)
        }
        .padding(16)
        .padding(.leading, 3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .emberCard(accent: Ember.amberAccent)
    }
}
