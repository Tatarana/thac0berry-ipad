import SwiftUI

/// Todo destino navegável a partir da Tela Principal, num único
/// NavigationStack com path programático — é o que deixa qualquer tela do
/// fundo da pilha (a ficha de um personagem, por exemplo) voltar direto pra
/// capa sem precisar "descer" nível a nível. A pilha e o `navigationDestination`
/// moram em `HomeView` (a nova raiz do app); `CampaignListView`,
/// `AllCharactersView` e `CompendiumHubView` só empurram valores nela.
enum AppRoute: Hashable {
    /// Os três ícones grandes da Tela Principal.
    case campaigns
    case allCharacters
    case compendiumHub

    case campaign(UUID)
    case character(UUID, CharacterSheetView.SheetPage)
    /// O caderno da campanha aberto direto, sem passar por nenhum
    /// personagem — ver `CampaignNotebookView`. Antes, o link "Open
    /// campaign notebook" de `CampaignDetailView` empurrava
    /// `.character(primeiroDoElenco, .notebook(nil))`, o que trazia junto
    /// toda a fileira de abas da ficha (Sheet/Notebook, distintivo de
    /// sessão, menu ☰) — amarrando sem querer "ver o caderno" a "estar
    /// dentro da ficha de um personagem específico".
    case campaignNotebook(UUID)
}

private struct PopToRootKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    /// Volta pra capa (a lista de Campanhas) de qualquer profundidade da
    /// pilha — usado pelo item "Home" do menu ☰ dentro da ficha de um
    /// personagem.
    var popToRoot: () -> Void {
        get { self[PopToRootKey.self] }
        set { self[PopToRootKey.self] = newValue }
    }
}
