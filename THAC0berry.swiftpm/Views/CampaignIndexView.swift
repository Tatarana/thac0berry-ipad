import SwiftUI

/// The campaign summary: table sessions (by the real-world date they
/// happened) grouped by month, each with the handful of day sheets it
/// contains. This is where a new session gets created, closed (archived,
/// not deleted) or deleted for good.
struct CampaignIndexView: View {
    @Binding var character: PlayerCharacter
    @Binding var page: CharacterSheetView.SheetPage

    @State private var showNewSession = false
    @State private var showArchived = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header

            if activeSessions.isEmpty {
                Text("No sessions yet — start one below, or tap “+ day sheet” on the character sheet.")
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
                                   session: session,
                                   color: character.sessionColor(session),
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

    /// Every new session is born with its first Priest Spell Sheet already
    /// attached — a session with no day to open isn't much use at the table.
    private func createSession(date: Date, title: String) {
        let session = Session(date: date, title: title)
        character.sessions.append(session)

        var sheet = SpellSheet()
        sheet.sessionID = session.id
        // The sheet is born on the same date as the session, not "now" —
        // otherwise a backdated session would fall out of order in the
        // chronological list of sheets.
        sheet.date = date
        sheet.title = "Day 1"
        sheet.wisdomAtCreation = character.abilities.wisdom
        sheet.slotBoard = character.freshSlotBoard()
        character.spellSheets.append(sheet)

        page = .spells(sheet.id)
    }

    private var header: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Campaign Index")
                    .font(Paper.hand(30))
                    .foregroundStyle(Paper.penInk)
                Text("\(character.sessions.count) sessions logged")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            Button { showNewSession = true } label: {
                Text("+ new session")
                    .font(Paper.printed(12))
                    .tracking(1)
                    .foregroundStyle(Paper.ink)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }
            .buttonStyle(.plain)
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
                               session: session,
                               color: character.sessionColor(session),
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
        character.sessions.filter { !$0.isArchived }.sorted { $0.date > $1.date }
    }

    private var archivedSessions: [Session] {
        character.sessions.filter { $0.isArchived }.sorted { $0.date > $1.date }
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

    private func open(_ session: Session) {
        guard let latest = sheets(in: session).max(by: { $0.date < $1.date }) else { return }
        page = .spells(latest.id)
    }

    private func toggleArchive(_ session: Session) {
        guard let index = character.sessions.firstIndex(where: { $0.id == session.id }) else { return }
        character.sessions[index].isArchived.toggle()
    }

    /// Deletes the session and every sheet in it along with it — otherwise
    /// they'd be left orphaned, with no session to show up under.
    private func deleteSession(_ session: Session) {
        let deletedIDs = Set(sheets(in: session).map(\.id))
        let wasShowingDeleted: Bool = {
            if case .spells(let id) = page { return deletedIDs.contains(id) }
            return false
        }()
        character.spellSheets.removeAll { deletedIDs.contains($0.id) }
        character.sessions.removeAll { $0.id == session.id }
        if wasShowingDeleted { page = .record }
    }
}

private struct SessionRow: View {
    @Binding var character: PlayerCharacter
    let session: Session
    let color: Color
    let dayCount: Int
    let onOpen: () -> Void
    let onToggleArchive: () -> Void
    let onDelete: () -> Void

    @State private var showReport = false

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

                    EditableText(value: titleBinding, placeholder: "unnamed session",
                                 size: 16, underline: false)

                    Spacer(minLength: 4)

                    Text(dayCount == 1 ? "1 day" : "\(dayCount) days")
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)

                    Button { showReport = true } label: {
                        Text("report")
                            .font(Paper.printedItalic(10))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    .buttonStyle(.plain)

                    Menu {
                        Button(session.isArchived ? "Reopen session" : "Close session",
                               action: onToggleArchive)
                        Button("Delete session", role: .destructive, action: onDelete)
                    } label: {
                        Text("⋯")
                            .font(Paper.printed(16))
                            .foregroundStyle(Paper.inkSoft)
                            .padding(.horizontal, 4)
                    }
                    .buttonStyle(.plain)
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
            get: { character.sessions.first { $0.id == session.id }?.title ?? "" },
            set: { newValue in
                if let index = character.sessions.firstIndex(where: { $0.id == session.id }) {
                    character.sessions[index].title = newValue
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
                        .font(Paper.printed(13))
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
                                     allowsSoftwareKeyboard: true, onCommit: {})
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
