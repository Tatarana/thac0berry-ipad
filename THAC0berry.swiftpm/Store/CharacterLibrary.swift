import Foundation

/// Guarda os personagens em um JSON único no diretório Documents, com a
/// mesma decisão de segurança do Just Pencil It: proteção de dados nativa
/// do iOS na classe `.completeUnlessOpen`, sem criptografia própria por cima.
final class CharacterLibrary: ObservableObject {
    @Published var characters: [PlayerCharacter] = [] {
        didSet { scheduleSave() }
    }
    @Published private(set) var lastError: String? = nil

    private let fileName = "characters.json"
    private var saveWorkItem: DispatchWorkItem?

    private var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)[0]
        return documents.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    // MARK: - Leitura e escrita

    private func load() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            // Primeira execução: a pasta abre com uma ficha preenchida, para
            // dar pra ver como o app fica em uso de verdade.
            characters = [PlayerCharacter.kelmon()]
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            characters = try decoder.decode([PlayerCharacter].self, from: data)
        } catch {
            // JSON gravado por uma versão anterior (sem equipamento, divindade
            // etc.) não decodifica. Melhor abrir com a ficha de exemplo do que
            // com a pasta vazia e sem saída.
            lastError = "Não consegui ler a ficha salva: \(error.localizedDescription)"
            if characters.isEmpty { characters = [PlayerCharacter.kelmon()] }
        }
    }

    /// Salva com um pequeno atraso, para não escrever no disco a cada toque
    /// em um slot durante o combate.
    private func scheduleSave() {
        saveWorkItem?.cancel()
        let work = DispatchWorkItem { [weak self] in
            self?.saveNow()
        }
        saveWorkItem = work
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: work)
    }

    func saveNow() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(characters)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtectionUnlessOpen])
            lastError = nil
        } catch {
            lastError = "Não consegui salvar: \(error.localizedDescription)"
        }
    }

    // MARK: - Operações sobre a lista

    func character(with id: UUID) -> PlayerCharacter? {
        characters.first { $0.id == id }
    }

    func index(of id: UUID) -> Int? {
        characters.firstIndex { $0.id == id }
    }

    @discardableResult
    func addCharacter() -> PlayerCharacter {
        var new = PlayerCharacter()
        new.name = ""
        // Só quem tem ficha de magia (Clérigo, por ora) já nasce com uma
        // folha do primeiro dia — as outras classes nem mostram a aba.
        if new.characterClass.hasSpellSheet {
            var firstSheet = SpellSheet()
            firstSheet.title = "Primeiro dia"
            firstSheet.wisdomAtCreation = new.abilities.wisdom
            // Vazia por enquanto: sem nada preenchido em "Spell Slots" na
            // ficha ainda, não há o que herdar.
            firstSheet.slotBoard = new.freshSlotBoard()
            new.spellSheets = [firstSheet]
        }
        characters.append(new)
        return new
    }

    func delete(at offsets: IndexSet) {
        characters.remove(atOffsets: offsets)
    }

    func update(_ character: PlayerCharacter) {
        guard let index = index(of: character.id) else { return }
        characters[index] = character
    }
}
