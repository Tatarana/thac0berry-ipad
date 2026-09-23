import SwiftUI

/// Editor de "campaign settings" habilitados pra uma campanha (TODO.md
/// item 18) — o mestre marca zero ou mais cenários (Dark Sun, Ravenloft,
/// Forgotten Realms etc.) e isso filtra o `ProficiencyPickerSheet` (e, no
/// futuro, outros seletores com `campaignSettings`/`setting`) pra não
/// poluir a lista do jogador com conteúdo de cenário que não está em uso
/// nesta mesa.
///
/// Mesmo padrão de sinal aditivo/nunca-quebra-nada de `sphereAccess`:
/// `Campaign.enabledSettings == nil` OU vazio = sem filtro nenhum, mostra
/// tudo — é o estado padrão de qualquer campanha nova ou já existente.
/// Só quando o mestre marca pelo menos um cenário aqui é que o filtro
/// passa a valer (ver `Campaign.allowsSetting`/`.allowsAnySetting` em
/// `Models/Character.swift`). "Core"/"Generic" (conteúdo sem cenário
/// específico) sempre aparece, esteja o filtro ligado ou não.
struct CampaignSettingsEditorSheet: View {
    @Binding var campaign: Campaign
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 16) {
                header

                Text("Pick zero or more settings to narrow proficiency (and future spell/kit) lists to what's actually in play at this table. Leave all unchecked to show everything — that's also what any campaign already has today.")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(CampaignSettingCatalog.all, id: \.self) { setting in
                            settingRow(setting)
                        }
                    }
                }

                if !(campaign.enabledSettings?.isEmpty ?? true) {
                    Button {
                        campaign.enabledSettings = nil
                    } label: {
                        Text("clear filter (show everything)")
                            .font(Paper.printed(12))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(24)
            .frame(width: 380)
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Campaign Settings")
                    .font(Paper.hand(26))
                    .foregroundStyle(Paper.penInk)
                Text("Which official settings are in play at this table?")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            Button("close") { dismiss() }
                .font(Paper.printed(16))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private func settingRow(_ setting: String) -> some View {
        let isSelected = campaign.enabledSettings?.contains(setting) ?? false
        return Button {
            toggle(setting)
        } label: {
            HStack(spacing: 8) {
                // Logo de verdade do cenário (2026-09-21, logos entregues
                // pelo usuário) — mesmo truque de template do selinho de
                // filtro (`SettingFilterChip`), só que aqui do tamanho de
                // uma letra maiúscula ao lado do nome, não um ícone
                // sozinho. Sem logo pro cenário, some sem deixar buraco.
                if let name = CampaignSettingCatalog.logoImageName(for: setting),
                   let art = Image.bundled(name) {
                    art
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Paper.inkSoft)
                }
                Text(setting)
                    .font(Paper.hand(18))
                    .foregroundStyle(Paper.penInk)
                Spacer()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundStyle(isSelected ? Paper.ink : Paper.inkSoft.opacity(0.6))
            }
            .padding(.vertical, 6)
            .contentShape(Rectangle())
            .overlay(alignment: .bottom) { DottedRule() }
        }
        .buttonStyle(.plain)
    }

    private func toggle(_ setting: String) {
        var current = campaign.enabledSettings ?? []
        if current.contains(setting) {
            current.remove(setting)
        } else {
            current.insert(setting)
        }
        campaign.enabledSettings = current
    }
}
