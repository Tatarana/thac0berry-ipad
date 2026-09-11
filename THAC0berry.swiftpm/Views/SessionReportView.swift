import SwiftUI

/// A read-only report for a session: spells cast per level (plus Turn
/// Undead attempts) as a small bar chart, and how much charge magic items
/// burned through — all summed across the days in the session. Meant for
/// pasting a quick recap to the group after the table, without opening
/// sheet after sheet.
struct SessionReportView: View {
    let character: PlayerCharacter
    let session: Session

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                header

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        section(title: "Spells & Turn Undead") {
                            if chartRows.isEmpty {
                                emptyLine("Nothing cast or attempted in this session yet.")
                            } else {
                                VStack(spacing: 6) {
                                    ForEach(chartRows) { row in
                                        BarChartRow(label: row.label, count: row.count,
                                                    maxCount: maxChartCount, color: row.color)
                                    }
                                }
                            }
                        }

                        section(title: "Magic Item Charges") {
                            if itemCharges.isEmpty {
                                emptyLine("No magic item charges used in this session.")
                            } else {
                                ForEach(itemCharges) { charge in
                                    CountLine(name: "\(charge.itemName) — \(charge.spellName)",
                                              count: charge.used,
                                              unit: charge.used == 1 ? "charge" : "charges")
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Session Report")
                    .font(Paper.hand(28))
                    .foregroundStyle(Paper.penInk)
                Text(subtitle)
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            Button("close") { dismiss() }
                .font(Paper.printed(13))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var subtitle: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en_US")
        let dateText = formatter.string(from: session.date)
        let dayWord = sheets.count == 1 ? "day" : "days"
        let name = session.title.isEmpty ? dateText : "\(session.title) · \(dateText)"
        return "\(name) — \(sheets.count) \(dayWord)"
    }

    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            FieldLabel(text: title)
            content()
        }
    }

    private func emptyLine(_ text: String) -> some View {
        Text(text)
            .font(Paper.printedItalic(13))
            .foregroundStyle(Paper.inkSoft)
    }

    // MARK: - Session data

    private var sheets: [SpellSheet] {
        character.spellSheets.filter { $0.sessionID == session.id }
    }

    private var turnUndeadTotal: Int {
        sheets.reduce(0) { $0 + $1.turnUndeadUsed }
    }

    private struct ChartRow: Identifiable {
        let id: String
        let label: String
        let count: Int
        let color: Color
    }

    /// Counts every spell cast (spent slots + Additional Spells entries
    /// with a known level) bucketed by circle, an "Other" bucket for
    /// entries with no recognized level, and Turn Undead as its own bar —
    /// all in one chart, in the order they'd be read on a sheet: circle 1
    /// up, then whatever's left over, then Turn Undead.
    private var chartRows: [ChartRow] {
        var byLevel: [Int: Int] = [:]
        var otherCount = 0

        for sheet in sheets {
            for slot in sheet.slotBoard.slots where slot.isSpent {
                byLevel[slot.level, default: 0] += 1
            }
            for entry in sheet.entries {
                let count = max(entry.castCount, 1)
                if let level = entry.spellLevel {
                    byLevel[level, default: 0] += count
                } else {
                    otherCount += count
                }
            }
        }

        var rows = byLevel.sorted { $0.key < $1.key }.map {
            ChartRow(id: "level-\($0.key)", label: "Level \($0.key)", count: $0.value, color: Paper.penInk)
        }
        if otherCount > 0 {
            rows.append(ChartRow(id: "other", label: "Other", count: otherCount, color: Paper.penInk))
        }
        if turnUndeadTotal > 0 {
            rows.append(ChartRow(id: "turn-undead", label: "Turn Undead", count: turnUndeadTotal, color: Paper.turnHeader))
        }
        return rows
    }

    private var maxChartCount: Int {
        chartRows.map(\.count).max() ?? 0
    }

    private struct ItemCharge: Identifiable {
        let id: String
        let itemName: String
        let spellName: String
        let used: Int
    }

    private var itemCharges: [ItemCharge] {
        var totals: [String: (itemName: String, spellName: String, used: Int)] = [:]

        for sheet in sheets {
            for item in sheet.magicItems {
                for spellUse in item.spells where spellUse.usedCount > 0 {
                    let itemName = item.name.isEmpty ? "Unnamed item" : item.name
                    let spellName = spellUse.spellName.isEmpty ? "unnamed spell" : spellUse.spellName
                    let key = "\(itemName)|\(spellName)"
                    var entry = totals[key] ?? (itemName, spellName, 0)
                    entry.used += spellUse.usedCount
                    totals[key] = entry
                }
            }
        }

        return totals.values
            .map { ItemCharge(id: "\($0.itemName)|\($0.spellName)", itemName: $0.itemName,
                              spellName: $0.spellName, used: $0.used) }
            .sorted { $0.used > $1.used }
    }
}

/// One bar of the report's chart: a label, a hand-ruled bar proportional to
/// the largest value on the chart, and the raw count written at the end —
/// same plain shapes as the rest of the paper UI, no chart library.
private struct BarChartRow: View {
    let label: String
    let count: Int
    let maxCount: Int
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(Paper.printed(12))
                .foregroundStyle(Paper.ink)
                .frame(width: 86, alignment: .leading)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.white.opacity(0.25))
                    Rectangle()
                        .fill(color.opacity(0.8))
                        .frame(width: barWidth(in: geometry.size.width))
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1))
            }
            .frame(height: 16)

            Text("\(count)")
                .font(Paper.hand(16))
                .foregroundStyle(Paper.penInk)
                .frame(width: 28, alignment: .trailing)
        }
    }

    private func barWidth(in totalWidth: CGFloat) -> CGFloat {
        guard maxCount > 0 else { return 0 }
        let fraction = CGFloat(count) / CGFloat(maxCount)
        return max(totalWidth * fraction, count > 0 ? 3 : 0)
    }
}

private struct CountLine: View {
    let name: String
    let count: Int
    let unit: String

    var body: some View {
        HStack {
            Text(name)
                .font(Paper.printed(14))
                .foregroundStyle(Paper.ink)
            Spacer(minLength: 8)
            Text("\(count) \(unit)")
                .font(Paper.hand(16))
                .foregroundStyle(Paper.penInk)
        }
        .padding(.vertical, 2)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}
