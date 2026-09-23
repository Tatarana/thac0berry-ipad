import Foundation

/// Base de kits de sacerdote — vem de `EmbeddedKits.kits`, literais Swift
/// de verdade, SEM bundle/`Data`/`JSONDecoder` nenhum em runtime.
///
/// **NÃO troque isso de volta pra ler JSON do bundle** (nem
/// `Bundle.main.url(forResource:)`, nem varredura de diretório com
/// `FileManager.contentsOfDirectory`, nem um arquivo único, nem vários
/// pedaços menores) — TODAS essas variações foram tentadas nesta feature
/// (v0.81 a v0.84) e todas falharam com a mesma mensagem genérica
/// ("The data couldn't be read because it is missing"), pelo mesmo motivo
/// que já tinha derrubado o `spells.json` de exemplo em v0.68-0.71 (ver
/// `EmbeddedSampleSpells.swift`). A causa REAL só apareceu depois: não era
/// bug de bundle nenhum — era `DecodingError.keyNotFound` (13 dos 97 kits
/// não têm a chave `mechanics.armor.allowedTypes`), e o Swift renderiza
/// esse erro especificamente com essa mesma frase genérica de "missing",
/// fácil de confundir com arquivo sumido. Já corrigido em
/// `KitArmorRules.init(from:)` (`Models/Kit.swift`) pra quem algum dia
/// quiser voltar a decodificar JSON de verdade — mas a base em uso agora é
/// a embutida, que nem passa perto de `JSONDecoder`.
final class KitDatabase: ObservableObject {
    @Published private(set) var kits: [Kit] = []
    /// Mantido só pra compatibilidade com o resto do app (`HomeView`/
    /// `CampaignListView`/`KitCompendiumView` já checam isso) — sempre
    /// `nil` agora que não há leitura de bundle nenhuma pra falhar.
    @Published private(set) var loadError: String? = nil

    init() {
        kits = EmbeddedKits.kits.sorted { $0.name < $1.name }
    }

    func kit(id: String) -> Kit? {
        kits.first { $0.id == id }
    }

    /// Kits elegíveis pra uma classe (como o valor aparece em
    /// `classEligibility.allowedClasses` — "Cleric", "Druid" etc.),
    /// alfabético. Sem filtro (`nil`/vazio) devolve a base inteira.
    ///
    /// Caso especial: os 57 kits de sacerdote especializado (um por
    /// divindade) só têm `"Specialty Priest"` em `allowedClasses` — é como
    /// o dado de origem descreve o grupo, mas o app não tem uma classe
    /// separada "Specialty Priest" (`CharacterClass` só tem `Cleric`,
    /// `Druid` etc.): um sacerdote especializado é jogado mecanicamente
    /// como Cleric. Sem esse caso especial, escolher "Cleric" na ficha
    /// esconderia os 57 kits de divindade — justamente o grupo mais
    /// numeroso e o que mais faz sentido pra um Cleric escolher.
    func kits(allowedFor className: String? = nil) -> [Kit] {
        guard let className, !className.isEmpty else { return kits }
        return kits.filter { kit in
            let allowed = kit.classEligibility.allowedClasses
            if allowed.contains(className) { return true }
            if className == "Cleric" && allowed.contains("Specialty Priest") { return true }
            return false
        }
    }

    /// Só os kits genéricos (Fighting-Monk, Warrior Priest, ...) — exclui
    /// os de sacerdote especializado por divindade.
    func generalKits() -> [Kit] {
        kits.filter { !$0.isSpecialtyPriest }
    }

    /// Só os kits de sacerdote especializado, opcionalmente restritos a um
    /// panteão (como aparece em `pantheon`, ex. "Faerûnian").
    func specialtyPriestKits(pantheon: String? = nil) -> [Kit] {
        let specialty = kits.filter(\.isSpecialtyPriest)
        guard let pantheon, !pantheon.isEmpty else { return specialty }
        return specialty.filter { $0.pantheon == pantheon }
    }
}
