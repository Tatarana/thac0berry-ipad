import SwiftUI

/// O terceiro destino da Tela Principal — antes o ícone do Grimório na
/// estante de Campanhas ia direto pro `SpellbookView` do Clérigo; agora
/// existe esta tela intermediária, pensada desde já pra quando o Grimório
/// do Mago existir do lado do de Clérigo (mesma ideia dos dois ícones de
/// classe que já conviviam ali, só que como tela própria em vez de um
/// atalho solto no cabeçalho).
struct CompendiumHubView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                backRow
                header

                Rectangle().fill(Ember.brassDim).frame(height: 1.4)

                VStack(spacing: 14) {
                    NavigationLink {
                        SpellbookScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_priest_grimoire",
                            systemImage: "book.closed.fill",
                            badgeImage: "flame.fill",
                            badgeColor: Ember.glow,
                            title: "Priest Grimoire",
                            subtitle: "1,795 spells · search, favorites, spheres",
                            accent: Ember.crimson,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        KitCompendiumScreen(classGroup: "Priest")
                    } label: {
                        CompendiumTile(
                            imageName: "icon_priest_kits",
                            systemImage: "shield.lefthalf.filled",
                            badgeImage: "star.fill",
                            badgeColor: Ember.brass,
                            title: "Priest Kits",
                            subtitle: "91 kits · origins & specialty priests",
                            accent: Ember.brass,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        KitCompendiumScreen(classGroup: "Wizard")
                    } label: {
                        CompendiumTile(
                            imageName: "icon_wizard_kits",
                            systemImage: "wand.and.stars",
                            badgeImage: "star.fill",
                            badgeColor: Ember.teal,
                            title: "Wizard Kits",
                            subtitle: "41 kits · Complete Wizard's Handbook & Tome of Magic",
                            accent: Ember.teal,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        KitCompendiumScreen(classGroup: "Warrior")
                    } label: {
                        CompendiumTile(
                            imageName: "icon_warrior_kits",
                            systemImage: "shield.fill",
                            badgeImage: "bolt.fill",
                            badgeColor: Ember.crimson,
                            title: "Warrior Kits",
                            subtitle: "114 kits · Fighter, Paladin, Ranger & Barbarian",
                            accent: Ember.crimson,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        KitCompendiumScreen(classGroup: "Rogue")
                    } label: {
                        CompendiumTile(
                            imageName: "icon_rogue_kits",
                            systemImage: "eye.slash.fill",
                            badgeImage: "star.fill",
                            badgeColor: Ember.mintDeep,
                            title: "Rogue Kits",
                            subtitle: "73 kits · Thief, Bard & Ninja",
                            accent: Ember.mintDeep,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        DeityCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_deities",
                            systemImage: "crown.fill",
                            badgeImage: "sparkle",
                            badgeColor: Ember.brass,
                            title: "Deities",
                            subtitle: "79 deities · Faiths & Avatars, Powers & Pantheons",
                            accent: Ember.glow,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        RulesCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_rules_reference",
                            systemImage: "text.book.closed.fill",
                            badgeImage: "questionmark",
                            badgeColor: Ember.teal,
                            title: "Rules Reference",
                            subtitle: "888 rules · PHB, DMG, 8 Complete Handbooks & Psionics (CPsiH, DSC, DK, WatW)",
                            accent: Ember.teal,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        ProficiencyCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_proficiencies",
                            systemImage: "checklist",
                            badgeImage: "checkmark.seal.fill",
                            badgeColor: Ember.crimson,
                            title: "Proficiencies",
                            subtitle: "372 proficiencies · general, class & racial",
                            accent: Ember.brass,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        WeaponCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_weapons",
                            systemImage: "shield.righthalf.filled",
                            badgeImage: "target",
                            badgeColor: Ember.wine,
                            title: "Weapons",
                            subtitle: "75 weapons · PHB & CPrH",
                            accent: Ember.wine,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        ArmorCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_armor",
                            systemImage: "shield.checkerboard",
                            badgeImage: "checkmark.shield.fill",
                            badgeColor: Ember.amberAccent,
                            title: "Armor",
                            subtitle: "20 items · armor, helmets & shields",
                            accent: Ember.amberAccent,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        MundaneItemCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_equipment",
                            systemImage: "bag.fill",
                            badgeImage: "shippingbox.fill",
                            badgeColor: Ember.teal,
                            title: "Equipment",
                            subtitle: "183 items · gear, clothing, food & more",
                            accent: Ember.teal,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        MagicItemCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_magic_items",
                            systemImage: "wand.and.stars",
                            badgeImage: "sparkles",
                            badgeColor: Ember.wine,
                            title: "Magic Items",
                            subtitle: "5,669 items · full corpus, filter by source",
                            accent: Ember.wine,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        MageGrimoireScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_mage_grimoire",
                            systemImage: "wand.and.stars",
                            badgeImage: "sparkles",
                            badgeColor: Ember.teal,
                            title: "Mage Grimoire",
                            subtitle: "2,608 spells · search, favorites, schools",
                            accent: Ember.teal,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        PsionicPowerCompendiumScreen()
                    } label: {
                        CompendiumTile(
                            imageName: "icon_psionic_powers",
                            systemImage: "brain.head.profile",
                            badgeImage: "sparkle",
                            badgeColor: Ember.mintDeep,
                            title: "Psionic Powers",
                            subtitle: "257 powers · 6 disciplines, Complete Psionics Handbook",
                            accent: Ember.mintDeep,
                            isEnabled: true
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(26)
        }
        .background(ObsidianBackground())
        .toolbar(.hidden, for: .navigationBar)
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
        VStack(alignment: .leading, spacing: 0) {
            Text("ADVANCED DUNGEONS & DRAGONS · 2ND EDITION")
                .font(Paper.printed(9.5))
                .tracking(2)
                .foregroundStyle(Ember.brass)
            Text("Compendium")
                .font(Paper.hand(40))
                .foregroundStyle(Ember.onObsidian)
                .rotationEffect(.degrees(-0.7))
        }
    }
}

/// Um cartão grande por grimório — o mesmo desenho de cartão de couro do
/// resto do app (`emberCard`), só que alto o bastante pra caber um ícone
/// central de verdade em vez de só texto numa linha.
///
/// `imageName` é a arte ilustrada (ver `Docs/icon-button-spec.md`) — cada
/// grimório já vem com seu próprio selo desenhado na capa (vela acesa pro
/// Clérigo, estrela azul arcana pro Mago), então o selinho `badgeImage`
/// sobreposto em código só entra no fallback, quando a imagem não carrega.
private struct CompendiumTile: View {
    let imageName: String
    let systemImage: String
    let badgeImage: String
    let badgeColor: Color
    let title: String
    let subtitle: String
    let accent: Color
    var isEnabled: Bool = true

    var body: some View {
        HStack(spacing: 18) {
            if let art = Image.bundled(imageName) {
                art
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 78, height: 62)
                    .shadow(color: Color.black.opacity(0.4), radius: 3, y: 2)
            } else {
                Image(systemName: systemImage)
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(Paper.sheet)
                    .frame(width: 60, height: 60)
                    .background(Paper.ink)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Paper.chromeDeep, lineWidth: 1.5))
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: badgeImage)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(badgeColor)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Ember.obsidianDeep, lineWidth: 1.5))
                    }
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(Paper.hand(26))
                    .foregroundStyle(Ember.onObsidian)
                    .rotationEffect(.degrees(-0.4))
                Text(subtitle)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Ember.onObsidianSoft)
            }

            Spacer(minLength: 0)

            if isEnabled {
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Ember.onObsidianSoft)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .emberCard(accent: accent)
        .opacity(isEnabled ? 1 : 0.5)
        .allowsHitTesting(isEnabled)
    }
}

/// Moldura do Grimório do Clérigo: o conteúdo (`SpellbookView`) ainda é
/// todo tinta escura sobre pergaminho claro, então só a volta ganha o selo
/// escuro — igual antes, quando este mesmo destino era aberto direto da
/// estante de Campanhas.
private struct SpellbookScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                SpellbookView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Grimório do Mago (2026-09-29) — igual `SpellbookScreen`
/// acima, só passando `caster: .arcane` pro mesmo `SpellbookView` (ver
/// comentário lá: a tela inteira foi generalizada pra servir os dois
/// grimórios em vez de duplicar a implementação).
private struct MageGrimoireScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                SpellbookView(caster: .arcane)
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Psionic Powers — mesmo tratamento do
/// `MageGrimoireScreen` acima. Rodada "fundação primeiro" dos Psiônicos
/// (2026-10-01): só consulta, nenhum personagem conhece power nenhum
/// ainda (ver `PsionicPowerCompendiumView`).
private struct PsionicPowerCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                PsionicPowerCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Kits — mesmo tratamento do `SpellbookScreen`
/// acima (conteúdo em tinta sobre pergaminho, só a volta com o selo
/// escuro da estante). Generalizada (2026-09-29) com `classGroup`, mesma
/// ideia de `MageGrimoireScreen`/`SpellbookScreen` acima — um único
/// `KitCompendiumScreen` serve as duas telas do hub ("Priest Kits" e
/// "Wizard Kits"), só repassando o parâmetro pro `KitCompendiumView` já
/// generalizado (ver comentário lá).
private struct KitCompendiumScreen: View {
    var classGroup: String = "Priest"
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                KitCompendiumView(classGroup: classGroup)
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura da Referência de Regras — mesmo tratamento dos dois acima.
private struct DeityCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                DeityCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct RulesCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                RulesCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Proficiências (TODO.md item 18) — mesmo
/// tratamento dos três acima. Aqui é só consulta/referência, por isso
/// SEM filtro de campaign setting (ver comentário em
/// `ProficiencyCompendiumView`) — o filtro só entra no seletor aberto a
/// partir da ficha de personagem.
private struct ProficiencyCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                ProficiencyCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Armas ("Manda bala!" — ver TODO.md item 25) —
/// mesmo tratamento dos quatro acima.
private struct WeaponCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                WeaponCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Armaduras/Elmos/Escudos (TODO.md item 26) —
/// mesmo tratamento dos cinco acima.
private struct ArmorCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                ArmorCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Equipamento geral (TODO.md item 26) — mesmo
/// tratamento dos seis acima.
private struct MundaneItemCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                MundaneItemCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}

/// Moldura do Compendium de Itens Mágicos (TODO.md item 30 — escopo full,
/// 5.669 itens) — mesmo tratamento dos sete acima.
private struct MagicItemCompendiumScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                RoundIconButton(systemImage: "chevron.left", style: .badge, action: {
                    dismiss()
                }, accessibilityLabel: "Compendium")

                MagicItemCompendiumView()
            }
            .padding(18)
        }
        .background(PaperBackground())
        .toolbar(.hidden, for: .navigationBar)
    }
}
