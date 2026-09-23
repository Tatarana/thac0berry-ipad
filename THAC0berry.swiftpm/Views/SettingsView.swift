import SwiftUI
import UniformTypeIdentifiers

/// Tela de Configurações — o ícone pequeno da Tela Principal. Por ora só
/// versão + Backup manual (Export/Import); o pedido original já avisa que
/// isto ganha funções aos poucos, então o resto nasce simples de
/// propósito, em vez de forçar opções que ainda não existem.
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var library: CharacterLibrary

    // MARK: - Export

    @State private var exportDocument: BackupDocument? = nil
    @State private var isExporterPresented = false
    @State private var exportErrorMessage: String? = nil

    // MARK: - Import

    @State private var isImporterPresented = false
    @State private var pendingImportData: Data? = nil
    @State private var pendingImportPreview: CharacterLibrary.ImportPreview? = nil
    @State private var showImportConfirm = false
    @State private var importErrorMessage: String? = nil

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
                    backupSection

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
        .fileExporter(isPresented: $isExporterPresented, document: exportDocument,
                      contentType: .json, defaultFilename: exportFilename) { result in
            if case .failure(let error) = result {
                exportErrorMessage = error.localizedDescription
            }
        }
        .fileImporter(isPresented: $isImporterPresented, allowedContentTypes: [.json]) { result in
            handleImportPick(result)
        }
        .alert("Couldn't export", isPresented: Binding(get: { exportErrorMessage != nil },
                                                        set: { if !$0 { exportErrorMessage = nil } })) {
            Button("OK", role: .cancel) { exportErrorMessage = nil }
        } message: {
            Text(exportErrorMessage ?? "")
        }
        .alert("Couldn't read that file", isPresented: Binding(get: { importErrorMessage != nil },
                                                                set: { if !$0 { importErrorMessage = nil } })) {
            Button("OK", role: .cancel) { importErrorMessage = nil }
        } message: {
            Text(importErrorMessage ?? "")
        }
        .alert("Replace everything on this device?", isPresented: $showImportConfirm) {
            Button("Cancel", role: .cancel) { clearPendingImport() }
            Button("Replace", role: .destructive) { applyPendingImport() }
        } message: {
            if let preview = pendingImportPreview {
                Text("This backup has \(preview.campaignCount) campaign(s) and \(preview.characterCount) character(s). It will REPLACE everything currently on this device — this can't be undone.")
            }
        }
    }

    /// Nome do arquivo sugerido no diálogo de exportação — data no formato
    /// `AAAA-MM-DD` pra dar pra distinguir backups feitos em dias
    /// diferentes sem abrir cada um.
    private var exportFilename: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return "THAC0berry-backup-\(formatter.string(from: Date()))"
    }

    /// Explica o PORQUÊ do backup existir — pedido do usuário (2026-09-20):
    /// "toda versão nova eu perco meus personagens". A causa raiz não é bug
    /// de leitura/escrita (o `library.json` em si já tolera campo novo/item
    /// corrompido — ver `LossyArray` em `CharacterLibrary.swift`); é que
    /// reimportar o `.zip` inteiro no Swift Playgrounds cria um projeto
    /// NOVO, com sua própria pasta Documents vazia, mesmo com o mesmo
    /// `bundleIdentifier` — nada atravessa essa reimportação sozinho. Este
    /// backup dá um jeito de levar os dados de uma cópia do projeto pra
    /// outra, manualmente, não importa a causa.
    private var backupSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Backup")
                .font(Paper.printed(13))
                .fontWeight(.bold)
                .foregroundStyle(Ember.onObsidian)
            Text("Campaigns and characters live in this app copy's own storage — reimporting a new version as a fresh Swift Playgrounds project starts that copy empty. Export a backup before reimporting, then Import it back afterward.")
                .font(Paper.printedItalic(12.5))
                .foregroundStyle(Ember.onObsidianSoft)

            HStack(spacing: 10) {
                Button(action: startExport) {
                    Label("Export Library", systemImage: "square.and.arrow.up")
                        .font(Paper.printed(12.5))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Ember.onObsidian)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                Button(action: { isImporterPresented = true }) {
                    Label("Import Library", systemImage: "square.and.arrow.down")
                        .font(Paper.printed(12.5))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Ember.onObsidian)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
        .padding(14)
        .emberCard(accent: Ember.brassDim)
    }

    private func startExport() {
        guard let data = library.exportSnapshot() else {
            exportErrorMessage = "Couldn't put together the backup file."
            return
        }
        exportDocument = BackupDocument(data: data)
        isExporterPresented = true
    }

    /// Lê o arquivo escolhido e só MOSTRA a prévia (quantas campanhas/
    /// personagens tem) — nada é aplicado até o jogador confirmar no
    /// alerta (`showImportConfirm`), porque importar substitui a
    /// biblioteca inteira, não faz merge com o que já está no aparelho.
    private func handleImportPick(_ result: Result<URL, Error>) {
        switch result {
        case .failure(let error):
            importErrorMessage = error.localizedDescription
        case .success(let url):
            let accessed = url.startAccessingSecurityScopedResource()
            defer { if accessed { url.stopAccessingSecurityScopedResource() } }
            do {
                let data = try Data(contentsOf: url)
                let preview = try library.previewImport(from: data)
                pendingImportData = data
                pendingImportPreview = preview
                showImportConfirm = true
            } catch {
                importErrorMessage = error.localizedDescription
            }
        }
    }

    private func applyPendingImport() {
        guard let data = pendingImportData else { return }
        do {
            try library.importSnapshot(from: data)
        } catch {
            importErrorMessage = error.localizedDescription
        }
        clearPendingImport()
    }

    private func clearPendingImport() {
        pendingImportData = nil
        pendingImportPreview = nil
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

/// Embrulho mínimo pra `.fileExporter` — o conteúdo já vem pronto
/// (`CharacterLibrary.exportSnapshot()` já devolve o JSON formatado), este
/// tipo só precisa satisfazer `FileDocument` pra abrir o diálogo nativo de
/// salvar. `init(configuration:)` nunca é chamado de verdade aqui (só
/// exportamos, não usamos este tipo pra ler de volta — a leitura do
/// Import usa `.fileImporter` + `Data(contentsOf:)` direto, mais simples
/// pra um botão que só precisa escolher um arquivo existente).
private struct BackupDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }

    var data: Data

    init(data: Data) {
        self.data = data
    }

    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}
