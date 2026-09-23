import Foundation

/// Os 91 kits de sacerdote, embutidos como literais Swift de verdade — SEM
/// JSON, `Bundle`, `Data` ou `JSONDecoder` nenhum em runtime.
///
/// Gerado automaticamente a partir dos `priestKit1/2/3.json` originais (que
/// foram REMOVIDOS do bundle — não tente reintroduzi-los como recurso).
/// Isso não foi capricho: é o mesmo problema, pela terceira vez, já
/// documentado no TODO.md pro caso do `spells.json`/`EmbeddedSampleSpells`.
///
/// Histórico rápido (ver TODO.md pros detalhes completos):
/// 1. `KitDatabase` lia um `priestKits.json` único (~1MB) via
///    `Bundle.main.url(forResource:)` — falhou com "The data couldn't be
///    read because it is missing".
/// 2. Trocado pra varredura de diretório (`FileManager.contentsOfDirectory`,
///    o padrão que `SpellDatabase.priestFiles()` usa pros `priest_*.json`
///    de magia) — MESMA mensagem, bug continuou.
/// 3. Dividido em 3 arquivos menores (`priestKit1/2/3.json`, ~330KB cada,
///    bem abaixo do maior `priest_*.json` que já funcionou) — MESMA
///    mensagem de novo, nos 3 arquivos.
/// 4. Convertido pra literais Swift (`EmbeddedKits.swift`) num array único
///    de 97 elementos — o Build passou a falhar sem NENHUMA mensagem de
///    erro ("Build Failed" genérico), clássico timeout do type-checker do
///    Swift num array literal grande com elementos aninhados. Corrigido
///    dividindo em vários arquivos com constantes tipadas (`EmbeddedKits_
///    PartN.swift`) — ver o comentário em qualquer um deles.
/// 5. Removidos os 6 kits "Create Your Own" (cartas de kit em branco pro
///    jogador preencher, sem regras nem texto de verdade — só uns
///    fragmentos de HTML/wikitexto de layout de carta) — não fazem
///    sentido num app de fichas, só poluíam a lista. E consertado o
///    `briefSummary` de todos os outros: vinha direto de um trecho do
///    wikitexto original (com `__NOTOC__`, tabela de estatísticas
///    truncada, etc. ainda dentro) em vez de um resumo de verdade —
///    agora é derivado do primeiro parágrafo já limpo de `fullText`.
///
/// A essa altura o padrão bate exatamente com o que já tinha acontecido com
/// `spells.json`: bundle + `Data` + `JSONDecoder` em runtime, pra um
/// recurso ADICIONADO DEPOIS que o projeto já existia no Swift Playgrounds
/// (em vez de ter nascido junto com ele, como os `priest_*.json` de magia
/// originais), simplesmente não é confiável nesse toolchain on-device —
/// não importa o tamanho do arquivo nem o método de leitura. A correção
/// que resolveu pra `spells.json` (`EmbeddedSampleSpells.swift`) foi tirar
/// o JSON de runtime por completo; aqui é a mesma ideia, só que pra base
/// INTEIRA de kits em vez de um punhado de exemplos.
enum EmbeddedKits {
    /// Monta o array a partir das constantes tipadas nos arquivos
    /// `EmbeddedKits_PartN.swift` — nunca colocar os `Kit(...)` de volta direto
    /// aqui dentro de um array literal só (ver comentário em qualquer um dos
    /// arquivos de parte pro motivo).
    static let kits: [Kit] = [
        embeddedKit000,
        embeddedKit001,
        embeddedKit002,
        embeddedKit003,
        embeddedKit004,
        embeddedKit005,
        embeddedKit006,
        embeddedKit007,
        embeddedKit008,
        embeddedKit009,
        embeddedKit010,
        embeddedKit011,
        embeddedKit012,
        embeddedKit013,
        embeddedKit014,
        embeddedKit015,
        embeddedKit016,
        embeddedKit017,
        embeddedKit018,
        embeddedKit019,
        embeddedKit020,
        embeddedKit021,
        embeddedKit022,
        embeddedKit023,
        embeddedKit024,
        embeddedKit025,
        embeddedKit026,
        embeddedKit027,
        embeddedKit028,
        embeddedKit029,
        embeddedKit030,
        embeddedKit031,
        embeddedKit032,
        embeddedKit033,
        embeddedKit034,
        embeddedKit035,
        embeddedKit036,
        embeddedKit037,
        embeddedKit038,
        embeddedKit039,
        embeddedKit040,
        embeddedKit041,
        embeddedKit042,
        embeddedKit043,
        embeddedKit044,
        embeddedKit045,
        embeddedKit046,
        embeddedKit047,
        embeddedKit048,
        embeddedKit049,
        embeddedKit050,
        embeddedKit051,
        embeddedKit052,
        embeddedKit053,
        embeddedKit054,
        embeddedKit055,
        embeddedKit056,
        embeddedKit057,
        embeddedKit058,
        embeddedKit059,
        embeddedKit060,
        embeddedKit061,
        embeddedKit062,
        embeddedKit063,
        embeddedKit064,
        embeddedKit065,
        embeddedKit066,
        embeddedKit067,
        embeddedKit068,
        embeddedKit069,
        embeddedKit070,
        embeddedKit071,
        embeddedKit072,
        embeddedKit073,
        embeddedKit074,
        embeddedKit075,
        embeddedKit076,
        embeddedKit077,
        embeddedKit078,
        embeddedKit079,
        embeddedKit080,
        embeddedKit081,
        embeddedKit082,
        embeddedKit083,
        embeddedKit084,
        embeddedKit085,
        embeddedKit086,
        embeddedKit087,
        embeddedKit088,
        embeddedKit089,
        embeddedKit090,
    ]
}
