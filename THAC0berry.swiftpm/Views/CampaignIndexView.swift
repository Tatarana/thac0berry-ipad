import SwiftUI

/// Um picker de sessões, do ponto de vista de UM personagem: table sessions
/// (by the real-world date they happened) grouped by month, each with the
/// handful of day sheets THIS character has in it — jogadas de sessão em
/// si (criar, renomear, arquivar, apagar) mexem na campanha inteira, já que
/// a sessão agora é compartilhada por quem mais estiver jogando nela; a
/// visão completa do elenco/todas as sessões fica na tela da campanha
/// (`CampaignDetailView`), aberta pelo ☰ ou voltando com "Back".
struct CampaignIndexView: View {
    @Binding var character: PlayerCharacter
    @Binding var campaign: Campaign
    @Binding var page: CharacterSheetView.SheetPage
    @EnvironmentObject private var library: CharacterLibrary

    @State private var showNewSession = false
    @State private var showArchived = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header

            if activeSessions.isEmpty {
                Text("No sessions yet — start one below.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            ForEach(groupedActiveSessions, id: \.label) { group in
                VStack(alignment: .leading, spacing: 4) {
                    Text(group.label.uppercased())
                        .font(Paper.printed(10))
                        .tracking(2)
                        .foregroundStyle(Paper.inkSoft)

                    ForEach(group.sessions) { session in
                        SessionRow(character: $character,
                                   campaign: $campaign,
                                   session: session,
                                   color: campaign.sessionColor(session),
                                   dayCount: sheets(in: session).count,
                                   onOpen: { open(session) },
                                   onToggleArchive: { toggleArchive(session) },
                                   onDelete: { deleteSession(session) })
                    }
                }
            }

            if !archivedSessions.isEmpty {
                archivedDisclosure
            }
        }
        .sheet(isPresented: $showNewSession) {
            NewSessionSheet { date, title in
                createSession(date: date, title: title)
            }
        }
    }

    /// Every new session is born with this character's first Priest Spell
    /// Sheet already attached — a session with no day to open isn't much
    /// use at the table. Other characters in the same campaign pick up the
    /// session itself the moment they open this same picker.
    private func createSession(date: Date, title: String) {
        let session = Session(date: date, title: title)
        campaign.sessions.append(session)

        // The sheet is born on the same date as the session, not "now" —
        // otherwise a backdated session would fall out of order in the
        // chronological list of sheets. Herda o dia anterior (ver
        // `Store/SpellSheetRules.swift`).
        let sheetID = character.startSpellSheet(sessionID: session.id, title: "Day 1", date: date)

        page = .spells(sheetID)
    }

    private var header: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Sessions")
                    .font(Paper.hand(30))
                    .foregroundStyle(Paper.penInk)
                Text("\(campaign.sessions.count) sessions logged in \(campaign.displayTitle)")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            RoundIconButton(systemImage: "calendar.badge.plus", style: .paper, action: {
                showNewSession = true
            }, accessibilityLabel: "New session")
        }
    }

    private var archivedDisclosure: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button { showArchived.toggle() } label: {
                Text("\(showArchived ? "▾" : "▸") old sessions (\(archivedSessions.count))")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            .buttonStyle(.plain)

            if showArchived {
                ForEach(archivedSessions) { session in
                    SessionRow(character: $character,
                               campaign: $campaign,
                               session: session,
                               color: campaign.sessionColor(session),
                               dayCount: sheets(in: session).count,
                               onOpen: { open(session) },
                               onToggleArchive: { toggleArchive(session) },
                               onDelete: { deleteSession(session) })
                }
            }
        }
    }

    // MARK: - Derived data

    private var activeSessions: [Session] {
        campaign.sessions.filter { !$0.isArchived }.sorted { $0.date > $1.date }
    }

    private var archivedSessions: [Session] {
        campaign.sessions.filter { $0.isArchived }.sorted { $0.date > $1.date }
    }

    private struct SessionGroup { let label: String; let sessions: [Session] }

    private var groupedActiveSessions: [SessionGroup] {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        formatter.locale = Locale(identifier: "en_US")

        var bySessions: [String: [Session]] = [:]
        var order: [String] = []
        for session in activeSessions {
            let label = formatter.string(from: session.date)
            if bySessions[label] == nil { order.append(label) }
            bySessions[label, default: []].append(session)
        }
        return order.map { SessionGroup(label: $0, sessions: bySessions[$0] ?? []) }
    }

    private func sheets(in session: Session) -> [SpellSheet] {
        character.spellSheets.filter { $0.sessionID == session.id }
    }

    // MARK: - Actions

    /// Abre a folha mais recente deste personagem na sessão — ou, se ele
    /// ainda não tiver nenhuma ali (entrou na campanha depois, ou só ainda
    /// não jogou esse dia), cria a primeira folha dele nessa sessão.
    private func open(_ session: Session) {
        if let latest = sheets(in: session).max(by: { $0.date < $1.date }) {
            page = .spells(latest.id)
            return
        }
        let sheetID = character.startSpellSheet(sessionID: session.id, title: "Day 1")
        page = .spells(sheetID)
    }

    private func toggleArchive(_ session: Session) {
        guard let index = campaign.sessions.firstIndex(where: { $0.id == session.id }) else { return }
        campaign.sessions[index].isArchived.toggle()
    }

    /// Deletes this character's day sheets from the session. The session
    /// itself — shared with whoever else is playing this campaign — is
    /// only removed from the campaign if no OTHER character still has a
    /// sheet pointing at it; otherwise their history would dangle.
    private func deleteSession(_ session: Session) {
        let deletedIDs = Set(sheets(in: session).map(\.id))
        let wasShowingDeleted: Bool = {
            if case .spells(let id) = page { return deletedIDs.contains(id) }
            return false
        }()
        character.spellSheets.removeAll { deletedIDs.contains($0.id) }
        if wasShowingDeleted { page = .record }

        let stillUsed = library.characters(in: campaign.id).contains { other in
            other.id != character.id && other.spellSheets.contains { $0.sessionID == session.id }
        }
        if !stillUsed {
            campaign.sessions.removeAll { $0.id == session.id }
        }
    }
}

private struct SessionRow: View {
    @Binding var character: PlayerCharacter
    @Binding var campaign: Campaign
    let session: Session
    let color: Color
    let dayCount: Int
    let onOpen: () -> Void
    let onToggleArchive: () -> Void
    let onDelete: () -> Void

    @State private var showReport = false
    @State private var isRenaming = false
    @State private var renameDraft = ""

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Rectangle()
                .fill(color)
                .frame(width: 5)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 0.6))

            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(shortDate)
                        .font(Paper.printed(11))
                        .foregroundStyle(Paper.inkSoft)

                    // Só exibe — não é mais um botão de edição: tocar em
                    // qualquer lugar da linha (inclusive aqui) abre a
                    // sessão. Renomear virou uma opção do menu ⋯.
                    HandValue(text: session.title.isEmpty ? "unnamed session" : session.title,
                              size: 16,
                              color: session.title.isEmpty ? Paper.inkSoft.opacity(0.6) : Paper.penInk,
                              tilt: -0.4)
                        .lineLimit(1)

                    Spacer(minLength: 4)

                    Text(dayCount == 1 ? "1 day" : "\(dayCount) days")
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)

                    Button { showReport = true } label: {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Session report")

                    Menu {
                        Button("Rename session") {
                            renameDraft = session.title
                            isRenaming = true
                        }
                        Button(session.isArchived ? "Reopen session" : "Close session",
                               action: onToggleArchive)
                        Button("Delete session", role: .destructive, action: onDelete)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 15))
                            .foregroundStyle(Paper.inkSoft)
                            .padding(.horizontal, 2)
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $isRenaming) {
                        HStack(spacing: 12) {
                            HandwritingField(text: $renameDraft, placeholder: "unnamed session",
                                             allowsSoftwareKeyboard: false) {
                                titleBinding.wrappedValue = renameDraft
                                isRenaming = false
                            }
                            .frame(width: 340, height: 64)
                            .overlay(alignment: .bottom) { DottedRule() }

                            Button {
                                titleBinding.wrappedValue = renameDraft
                                isRenaming = false
                            } label: {
                                Text("done")
                                    .font(Paper.printed(13))
                                    .foregroundStyle(Paper.ink)
                            }
                        }
                        .padding(14)
                        .background(Paper.sheet)
                        .presentationCompactAdaptation(.popover)
                    }
                }

                if !session.summary.isEmpty {
                    Text(session.summary)
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(2)
                }
            }
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
        .onTapGesture(perform: onOpen)
        .overlay(alignment: .bottom) { DottedRule() }
        .sheet(isPresented: $showReport) {
            SessionReportView(character: character, session: session)
        }
    }

    private var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: session.date)
    }

    private var titleBinding: Binding<String> {
        Binding(
            get: { campaign.sessions.first { $0.id == session.id }?.title ?? "" },
            set: { newValue in
                if let index = campaign.sessions.firstIndex(where: { $0.id == session.id }) {
                    campaign.sessions[index].title = newValue
                }
            }
        )
    }
}

/// Creates a new session: the date is the one field that really needs to be
/// picked — the deliberate exception to "write everything with the pencil",
/// because a calendar date is something you pick, not write.
private struct NewSessionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var date = Date()
    @State private var title = ""
    let onCreate: (Date, String) -> Void

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("New Session")
                        .font(Paper.hand(26))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                VStack(alignment: .leading, spacing: 4) {
                    FieldLabel(text: "Real-world table date")
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(Paper.ink)
                }

                VStack(alignment: .leading, spacing: 0) {
                    FieldLabel(text: "Title (optional)")
                    HandwritingField(text: $title, placeholder: "e.g. The Tower of Elturel",
                                     allowsSoftwareKeyboard: false, onCommit: {})
                        .frame(height: 54)
                        .overlay(alignment: .bottom) { DottedRule() }
                }

                Button {
                    onCreate(date, title)
                    dismiss()
                } label: {
                    Text("create session")
                        .font(Paper.printed(13))
                        .tracking(1)
                        .foregroundStyle(Paper.ink)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
                }
                .buttonStyle(.plain)
            }
            .padding(24)
            .frame(width: 380)
        }
    }
}
