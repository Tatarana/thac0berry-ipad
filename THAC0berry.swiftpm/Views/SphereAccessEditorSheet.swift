import SwiftUI

/// Editor de "esferas de acesso" do personagem (TODO.md item 16) — o
/// jogador marca cada esfera como Major/Minor/nenhuma pro Clérigo atual.
/// Aberta a partir da FICHA DE PERSONAGEM (`CharacterSheetView.swift`,
/// botão "Spheres" ao lado de Class/Kit), não da Folha de Magias: esfera
/// de acesso é um traço do personagem, do mesmo jeito que Kit/Classe/Raça
/// — vive junto do registro permanente, não da folha descartável do dia.
/// A Folha de Magias (`SlotEditorSheet`/`MemorizedRow` em
/// `SpellSheetView.swift`) só LÊ o resultado pra SINALIZAR/ORDENAR
/// candidatos — nunca esconde nem bloqueia nada. Um personagem que nunca
/// abre esta folha (`sphereAccess == nil`) não muda em nada:
/// `PlayerCharacter.hasConfiguredSphereAccess` continua `false` e as
/// listas de magia aparecem exatamente como sempre apareceram.
///
/// "Suggest from kit" lê `KitSphereSuggestions` (extração de texto livre,
/// só 19 dos 91 kits cobertos — ver o comentário lá) e mostra o que o kit
/// atual nega/concede, mas só APLICA quando o jogador toca em "Apply
/// suggestion": kit sugere, jogador ajusta — nunca o contrário.
struct SphereAccessEditorSheet: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var kitDatabase: KitDatabase
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                header

                if let suggestion = kitSuggestion {
                    suggestionBanner(suggestion)
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(PriestSphereCatalog.groups) { group in
                            groupSection(group)
                        }
                    }
                    .padding(.bottom, 8)
                }

                Text("Signals and sorts spell candidates by sphere — it never hides a spell from the list.")
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
            }
            .padding(24)
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Spheres of Access")
                    .font(Paper.hand(28))
                    .foregroundStyle(Paper.penInk)
                Text("Major casts up to your top spell level in the sphere; minor caps at the 3rd circle.")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            Button("close") { dismiss() }
                .font(Paper.printed(16))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    // MARK: - Sugestão do kit

    /// Casa `character.kit` (texto livre — nome do kit, ver `KitField`)
    /// contra a base pra achar o `id` que `KitSphereSuggestions` usa.
    private var matchedKit: Kit? {
        guard let kitName = character.kit, !kitName.isEmpty else { return nil }
        return kitDatabase.kits.first { $0.name == kitName }
    }

    private var kitSuggestion: KitSphereSuggestions.Suggestion? {
        guard let id = matchedKit?.id else { return nil }
        return KitSphereSuggestions.byKitID[id]
    }

    @ViewBuilder
    private func suggestionBanner(_ suggestion: KitSphereSuggestions.Suggestion) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            FieldLabel(text: "Suggested from kit — \(matchedKit?.name ?? "")")
            if !suggestion.granted.isEmpty {
                let text = suggestion.granted
                    .map { "\($0.key) (\($0.value.label))" }
                    .sorted()
                    .joined(separator: ", ")
                Text("Grants: \(text)")
                    .font(Paper.printed(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            if !suggestion.denied.isEmpty {
                Text("Denies: \(suggestion.denied.sorted().joined(separator: ", "))")
                    .font(Paper.printed(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Button {
                apply(suggestion)
            } label: {
                Text("Apply suggestion")
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)
        }
        .padding(10)
        .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 1))
    }

    private func apply(_ suggestion: KitSphereSuggestions.Suggestion) {
        var access = character.sphereAccess ?? [:]
        for sphere in suggestion.denied { access.removeValue(forKey: sphere) }
        for (sphere, level) in suggestion.granted { access[sphere] = level }
        character.sphereAccess = access
    }

    // MARK: - Lista de esferas

    private func groupSection(_ group: PriestSphereGroup) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: group.title)
            ForEach(group.spheres, id: \.self) { sphere in
                sphereRow(sphere)
            }
        }
    }

    private func sphereRow(_ sphere: String) -> some View {
        HStack {
            Text(sphere)
                .font(Paper.hand(18))
                .foregroundStyle(Paper.penInk)
            Spacer(minLength: 8)
            HStack(spacing: 6) {
                levelButton(sphere: sphere, level: nil, label: "—")
                levelButton(sphere: sphere, level: .minor, label: "Minor")
                levelButton(sphere: sphere, level: .major, label: "Major")
            }
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
    }

    private func levelButton(sphere: String, level: SphereAccessLevel?, label: String) -> some View {
        let isSelected = character.sphereAccess?[sphere] == level
        return Button {
            var access = character.sphereAccess ?? [:]
            access[sphere] = level
            character.sphereAccess = access
        } label: {
            Text(label)
                .font(Paper.printed(11))
                .tracking(0.5)
                .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
                .padding(.horizontal, 7)
                .padding(.vertical, 3)
                .background(isSelected ? Paper.ink : Color.clear)
                .overlay(Rectangle().stroke(Paper.ink.opacity(0.5), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}
