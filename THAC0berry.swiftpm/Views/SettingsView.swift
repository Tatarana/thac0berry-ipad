import SwiftUI

/// Tela de Configurações — o ícone pequeno da Tela Principal. Por ora só um
/// placeholder (número da versão + nota do que vem por aqui no futuro); o
/// pedido original já avisa que isto ganha funções aos poucos, então a tela
/// nasce simples de propósito, em vez de forçar opções que ainda não
/// existem.
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    private var versionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        return "v\(version ?? "—") (\(build ?? "—"))"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                backRow
                header

                Rectangle().fill(Ember.brassDim).frame(height: 1.4)

                VStack(alignment: .leading, spacing: 10) {
                    Text("More settings — theme, backup, house rules — land here as they're built.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Ember.onObsidianSoft)

                    HStack {
                        Text("THAC0berry")
                            .font(Paper.printed(12))
                            .foregroundStyle(Ember.onObsidian)
                        Spacer()
                        Text(versionText)
                            .font(Paper.printed(12))
                            .foregroundStyle(Ember.onObsidianSoft)
                    }
                    .padding(14)
                    .emberCard(accent: Ember.brassDim)
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
            Text("Settings")
                .font(Paper.hand(40))
                .foregroundStyle(Ember.onObsidian)
                .rotationEffect(.degrees(-0.7))
        }
    }
}
