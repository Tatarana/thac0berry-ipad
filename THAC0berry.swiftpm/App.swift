import SwiftUI

@main
struct THAC0berryApp: App {
    @StateObject private var library = CharacterLibrary()
    @StateObject private var spellbook = SpellDatabase()

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .top) {
                CharacterListView()
                    .environmentObject(library)
                    .environmentObject(spellbook)

                // Por cima de qualquer tela do app (lista, ficha, folha de
                // magia) — não faz parte de nenhuma delas, então continua
                // visível trocando de tela sem precisar ser adicionada em
                // cada uma.
                AppVersionBadge()
                    .allowsHitTesting(false)
            }
        }
    }
}

/// Numerozinho discreto da versão, sempre no topo da tela.
private struct AppVersionBadge: View {
    private var versionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return "v" + (version ?? "—")
    }

    var body: some View {
        Text(versionText)
            .font(Paper.printed(8))
            .tracking(0.6)
            .foregroundStyle(Paper.inkSoft.opacity(0.65))
            .padding(.top, 6)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
    }
}
