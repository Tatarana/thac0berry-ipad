import SwiftUI

@main
struct THAC0berryApp: App {
    @StateObject private var library = CharacterLibrary()
    @StateObject private var spellbook = SpellDatabase()

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .top) {
                HomeView()
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
///
/// Achava que tinha sumido: na verdade só ficou ilegível. `Paper.inkSoft` é
/// tinta escura pensada pra ler sobre pergaminho claro — desde que a
/// estante e a tela de campanha viraram couro escuro (Fase 1), o texto
/// continuava lá, só que marrom-escuro sobre quase-preto. Por isso agora
/// tem seu próprio chip com fundo, em vez de confiar na cor do que estiver
/// por baixo — funciona igual em cima do pergaminho claro (Ficha, Grimório)
/// e do couro escuro (estante, Campanha).
private struct AppVersionBadge: View {
    private var versionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return "v" + (version ?? "—")
    }

    var body: some View {
        Text(versionText)
            .font(Paper.printed(9))
            .tracking(0.6)
            .foregroundStyle(.white.opacity(0.85))
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(Color.black.opacity(0.45))
            .clipShape(Capsule())
            .padding(.top, 6)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
    }
}
