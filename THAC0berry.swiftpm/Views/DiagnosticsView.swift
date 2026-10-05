import SwiftUI
import AuthenticationServices

/// Tela escondida de diagnóstico do backend (Etapa 3, 2026-10-05), aberta por
/// Settings. Três testes: conexão sem login, login com Google e leitura já
/// logado. A sessão fica só na memória desta tela; nada é gravado no
/// aparelho e as fichas não são tocadas. Ver `Store/Network/`.
struct DiagnosticsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession

    @State private var lines: [BackendDiagnostics.Line] = []
    @State private var session: BackendDiagnostics.Session? = nil
    @State private var isBusy = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                closeRow
                header
                Rectangle().fill(Ember.brassDim).frame(height: 1.4)
                actions
                results
            }
            .padding(26)
        }
        .background(ObsidianBackground())
    }

    // MARK: - Partes da tela

    private var closeRow: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "xmark")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Ember.onObsidian)
                .frame(width: 30, height: 30)
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Close")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Diagnostics")
                .font(Paper.hand(36))
                .foregroundStyle(Ember.onObsidian)
            Text("Checks the connection to the THAC0berry server. Nothing is saved and your characters are not touched.")
                .font(Paper.printedItalic(12.5))
                .foregroundStyle(Ember.onObsidianSoft)
        }
    }

    private var actions: some View {
        VStack(alignment: .leading, spacing: 10) {
            DiagnosticsButton(title: "Test connection", systemImage: "network", isDisabled: isBusy) {
                Task { await runConnectionTest() }
            }
            DiagnosticsButton(title: "Sign in with Google", systemImage: "person.crop.circle", isDisabled: isBusy) {
                Task { await runGoogleSignIn() }
            }
            DiagnosticsButton(title: "Test signed-in read", systemImage: "tray.and.arrow.down",
                              isDisabled: isBusy || session == nil) {
                Task { await runSignedInRead() }
            }
            Text(sessionText)
                .font(Paper.printed(12))
                .foregroundStyle(Ember.onObsidianSoft)
        }
        .padding(14)
        .emberCard(accent: Ember.brassDim)
    }

    private var results: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(lines) { line in
                DiagnosticsLineRow(line: line)
            }
        }
    }

    private var sessionText: String {
        guard let session else { return "Not signed in." }
        return "Signed in as \(session.email) (this screen only)."
    }

    // MARK: - Ações

    private func runConnectionTest() async {
        isBusy = true
        let result = await BackendDiagnostics.testConnection()
        lines.append(contentsOf: result)
        isBusy = false
    }

    private func runGoogleSignIn() async {
        isBusy = true
        let pkce = BackendDiagnostics.makePKCE()
        guard let url = BackendDiagnostics.signInURL(provider: "google", pkce: pkce) else {
            lines.append(BackendDiagnostics.Line(ok: false, text: "Sign-in: invalid URL"))
            isBusy = false
            return
        }
        do {
            let callback = try await webAuthenticationSession.authenticate(
                using: url,
                callbackURLScheme: BackendConfig.callbackScheme,
                preferredBrowserSession: .ephemeral
            )
            let newSession = try await BackendDiagnostics.exchange(callback: callback, pkce: pkce)
            session = newSession
            lines.append(BackendDiagnostics.Line(ok: true, text: "Signed in with Google: \(newSession.email)"))
        } catch {
            lines.append(BackendDiagnostics.Line(ok: false, text: "Sign-in failed: \(error.localizedDescription)"))
        }
        isBusy = false
    }

    private func runSignedInRead() async {
        guard let session else { return }
        isBusy = true
        let line = await BackendDiagnostics.signedInRead(session: session)
        lines.append(line)
        isBusy = false
    }
}

private struct DiagnosticsButton: View {
    let title: String
    let systemImage: String
    let isDisabled: Bool
    let action: () -> Void

    private var opacity: Double { isDisabled ? 0.4 : 1 }

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .font(Paper.printed(13))
        }
        .buttonStyle(.plain)
        .foregroundStyle(Ember.onObsidian)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .opacity(opacity)
        .disabled(isDisabled)
    }
}

private struct DiagnosticsLineRow: View {
    let line: BackendDiagnostics.Line

    private var symbol: String { line.ok ? "checkmark.circle.fill" : "xmark.octagon.fill" }
    private var tint: Color { line.ok ? Ember.mintGlow : Ember.crimson }

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: symbol)
                .foregroundStyle(tint)
            Text(line.text)
                .font(Paper.printed(12.5))
                .foregroundStyle(Ember.onObsidian)
                .textSelection(.enabled)
        }
    }
}
