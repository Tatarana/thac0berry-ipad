import Foundation

/// Leitor único de dados em JSON do bundle. Usa o padrão que já se provou
/// confiável neste toolchain (KitDatabase/RulesDatabase): lista o diretório
/// de recursos com `FileManager` e acha o arquivo pelo nome — em vez de
/// `Bundle.url(forResource:)`. Regra do projeto: só código é compilado;
/// dados vêm de arquivos JSON (schemas em `Docs/`).
enum BundleJSON {
    static func load<T: Decodable>(_ type: [T].Type, file name: String) -> (items: [T], error: String?) {
        guard let resourceURL = Bundle.main.resourceURL,
              let fileURL = try? FileManager.default.contentsOfDirectory(at: resourceURL, includingPropertiesForKeys: nil)
                  .first(where: { $0.lastPathComponent == name })
        else {
            return ([], "Couldn't find \(name) in the app bundle.")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return (try JSONDecoder().decode([T].self, from: data), nil)
        } catch {
            return ([], "Couldn't read \(name): \(error.localizedDescription)")
        }
    }

    /// Variante para arquivos cujo topo é um objeto (tabelas de regras).
    static func loadObject<T: Decodable>(_ type: T.Type, file name: String) -> (value: T?, error: String?) {
        guard let resourceURL = Bundle.main.resourceURL,
              let fileURL = try? FileManager.default.contentsOfDirectory(at: resourceURL, includingPropertiesForKeys: nil)
                  .first(where: { $0.lastPathComponent == name })
        else {
            return (nil, "Couldn't find \(name) in the app bundle.")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return (try JSONDecoder().decode(T.self, from: data), nil)
        } catch {
            return (nil, "Couldn't read \(name): \(error.localizedDescription)")
        }
    }
}
