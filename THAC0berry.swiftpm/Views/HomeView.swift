import SwiftUI
import UIKit

/// A Tela Principal — a nova raiz do app (Fase 4), substituindo a estante
/// de Campanhas nesse posto. Mesmo pano de fundo que a capa já usava (o
/// couro/brasa de `ObsidianBackground` + o brasão grande semi-transparente),
/// só que agora com três ícones grandes apontando pros três "departamentos"
/// do app — Campaigns, Characters, Compendium — e um quarto, menor, pra
/// Configurações (ver `SettingsView`). O `NavigationStack` com path
/// programático que antes morava em `CampaignListView` mudou pra cá: é o
/// que deixa o menu ☰ de dentro da ficha de um personagem voltar direto
/// pra esta tela com `popToRoot`, não importa a profundidade da pilha.
struct HomeView: View {
    @EnvironmentObject private var library: CharacterLibrary
    @EnvironmentObject private var spellbook: SpellDatabase
    @EnvironmentObject private var kits: KitDatabase
    @State private var path = NavigationPath()

    private var mascotBadge: Image? {
        guard let url = Bundle.main.url(forResource: "main_badge", withExtension: "png"),
              let uiImage = UIImage(contentsOfFile: url.path)
        else { return nil }
        return Image(uiImage: uiImage)
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ObsidianBackground()

                if let mascotBadge {
                    // Item 3 do feedback: quase apagado de tão sutil
                    // (0.1) — a pessoa nem percebia que tinha uma
                    // ilustração ali. Subiu bem sensivelmente (0.1 → 0.26),
                    // continua atrás de tudo (título, ícones, tarjas) sem
                    // brigar com a legibilidade deles.
                    mascotBadge
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 920)
                        .opacity(0.26)
                        .allowsHitTesting(false)
                }

                // Item novo do feedback: os três ícones ficavam logo abaixo
                // do título, no topo — num iPad na mão, isso é a parte mais
                // longe do polegar. Viraram uma "doca" ancorada embaixo da
                // tela: o título continua no topo (é onde a pessoa espera
                // achar o nome do app), e o `Spacer` entre os dois empurra
                // os ícones pro rodapé. Sem `ScrollView`: o conteúdo inteiro
                // sempre cabe numa tela só (3 ícones + título), e um
                // `ScrollView` não deixa o `Spacer` esticar direito (ele só
                // cresce dentro de uma altura já conhecida, que o
                // `ScrollView` não fornece sozinho).
                VStack(spacing: 20) {
                    header

                    Spacer(minLength: 12)

                    Rectangle().fill(Ember.brassDim).frame(height: 1.4)

                    // Sempre exatamente 3 ícones — colunas FIXAS em vez
                    // de `.adaptive`, que calcula quantas colunas cabem
                    // pela largura mínima e, em paisagem (bem mais
                    // larga que os ~240pt×3 que ele preenche), decidia
                    // que cabiam 4 ou 5 colunas e deixava a última(s)
                    // vazia(s) — os três ícones ficavam desalinhados à
                    // esquerda com um vão morto à direita. Com 3 colunas
                    // `.flexible`, elas sempre dividem a largura toda
                    // entre si, e o `frame(maxWidth:)` abaixo evita que
                    // cada uma fique gigante demais numa tela bem larga.
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 200), spacing: 20), count: 3),
                              spacing: 20) {
                        NavigationLink(value: AppRoute.campaigns) {
                            HomeIconTile(imageName: "icon_campaigns", systemImage: "map.fill",
                                         title: "Campaigns",
                                         subtitle: "\(library.campaigns.count) running",
                                         accent: Ember.amberAccent)
                        }
                        .buttonStyle(.plain)

                        NavigationLink(value: AppRoute.allCharacters) {
                            HomeIconTile(imageName: "icon_characters", systemImage: "person.2.fill",
                                         title: "Characters",
                                         subtitle: "\(library.characters.count) total",
                                         accent: Ember.crimson)
                        }
                        .buttonStyle(.plain)

                        NavigationLink(value: AppRoute.compendiumHub) {
                            HomeIconTile(imageName: "icon_compendium", systemImage: "books.vertical.fill",
                                         title: "Compendium",
                                         subtitle: "Grimoires & references",
                                         accent: Ember.teal)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: 760)

                    if let error = spellbook.loadError ?? kits.loadError ?? library.lastError {
                        Text(error)
                            .font(Paper.printedItalic(12))
                            .foregroundStyle(Ember.glowBright)
                    }
                }
                .padding(26)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .campaigns:
                    CampaignListView()
                case .allCharacters:
                    AllCharactersView()
                case .compendiumHub:
                    CompendiumHubView()
                case .campaign(let id):
                    if let binding = library.binding(forCampaignID: id) {
                        CampaignDetailView(campaign: binding)
                    }
                case .character(let id, let initialPage):
                    if let binding = library.binding(forCharacterID: id) {
                        CharacterSheetView(character: binding, initialPage: initialPage)
                    }
                }
            }
        }
        .environment(\.popToRoot) { path = NavigationPath() }
    }

    private var header: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Text("ADVANCED DUNGEONS & DRAGONS · 2ND EDITION")
                    .font(Paper.printed(9.5))
                    .tracking(2)
                    .foregroundStyle(Ember.brass)
                Text("THAC0berry")
                    .font(Paper.hand(44))
                    .foregroundStyle(Ember.onObsidian)
                    .rotationEffect(.degrees(-0.7))
            }
            Spacer()

            // Menor de propósito (item 3 do pedido) — hoje só um
            // placeholder (`SettingsView`), mas já reserva o canto onde as
            // futuras opções do app vão morar, sem competir com os três
            // ícones grandes de navegação principal.
            NavigationLink {
                SettingsView()
            } label: {
                Group {
                    if let gear = Image.bundled("icon_settings") {
                        gear
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 42, height: 42)
                            .shadow(color: Color.black.opacity(0.35), radius: 3, y: 1.5)
                    } else {
                        RoundIconBadge(systemImage: "gearshape.fill", style: .badge)
                    }
                }
                .actionTooltip("Settings")
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Settings")
        }
    }
}

/// Um dos três ícones grandes da Tela Principal — bem maiores que a
/// "moeda" de 42pt (`RoundIconBadge`) usada pra ações do resto do app,
/// porque aqui SÃO a navegação principal, não um atalho a mais.
///
/// `imageName` é a arte ilustrada entregue pela LLM de imagem (ver
/// `Docs/icon-button-spec.md`) — mapa/bússola, medalhão, pilha de
/// grimórios. Diferente do resto do app, essas artes NÃO entram dentro do
/// círculo escuro de moeda: elas já vêm com a própria moldura/recorte
/// (o medalhão já é redondo com borda própria; o mapa e os livros têm
/// contorno irregular de verdade) — encaixar isso num círculo cortaria a
/// ilustração ou deixaria sobra de fundo escuro nos cantos. Sem a imagem
/// (falha ao carregar o PNG), cai de volta pro SF Symbol na moeda de
/// sempre, pra nunca ficar com um buraco vazio no lugar do ícone.
private struct HomeIconTile: View {
    let imageName: String
    let systemImage: String
    let title: String
    let subtitle: String
    let accent: Color

    var body: some View {
        VStack(spacing: 12) {
            if let art = Image.bundled(imageName) {
                art
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 108, height: 108)
                    .shadow(color: Color.black.opacity(0.45), radius: 5, y: 3)
            } else {
                Image(systemName: systemImage)
                    .font(.system(size: 46, weight: .medium))
                    .foregroundStyle(Paper.sheet)
                    .frame(width: 96, height: 96)
                    .background(Paper.ink)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Paper.chromeDeep, lineWidth: 1.8))
                    .shadow(color: Color.black.opacity(0.35), radius: 6, y: 3)
            }

            VStack(spacing: 2) {
                Text(title)
                    .font(Paper.hand(26))
                    .foregroundStyle(Ember.onObsidian)
                Text(subtitle)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Ember.onObsidianSoft)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 190)
        .padding(.vertical, 22)
        .emberCard(accent: accent)
    }
}
