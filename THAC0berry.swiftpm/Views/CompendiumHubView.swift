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

                    CompendiumTile(
                        imageName: "icon_mage_grimoire",
                        systemImage: "wand.and.stars",
                        badgeImage: "sparkles",
                        badgeColor: Ember.teal,
                        title: "Mage Grimoire",
                        subtitle: "Coming soon",
                        accent: Ember.teal,
                        isEnabled: false
                    )
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
