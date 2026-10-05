# THAC0berry: guia para agentes

Ficha de personagem de AD&D 2e para iPad (SwiftUI + PencilKit), em `THAC0berry.swiftpm/`.
Leia isto antes de mexer em qualquer coisa. Cada regra abaixo custou pelo menos uma
rodada perdida. O histórico completo está em `TODO.md` (longo; busque pela versão).

## 1. Ambiente: não existe Mac

- O dono do projeto só tem **PC Windows + iPad**. O app é testado no **Swift Playgrounds
  4.7 no iPad**. Não há Xcode nem simulador local.
- O único compilador de verdade é o **CI no GitHub** (seção 6). Nunca afirme que algo
  "compila" sem o CI verde.
- Idioma: converse com o usuário em **português**. Comentários no código em português,
  **texto da interface em inglês**.

## 2. Como trabalhar com o usuário

1. **Proponha e espere o "ok" antes de codar.** Não faça mudança que não foi pedida
   ("aproveitei e otimizei X"). Já aconteceu e foi revertido.
2. **Não assuma: confirme.** Por exemplo, "a `main` é o que roda no iPad?" precisa ser
   perguntado, não suposto.
3. Uma funcionalidade por entrega. Lotes grandes já tornaram impossível achar a causa
   de uma falha (v1.52).
4. Ciclo: branch → push → CI verde → gerar zip (seção 7) → usuário testa no iPad →
   merge em `main`.
5. Diagnóstico no iPad: prefira **pacotes de bisseção** (variações mínimas, cada uma
   aberta como projeto novo) a hipóteses lidas no código.

## 3. Armadilhas do Swift Playgrounds (iPad)

- **"Build Failed" sem nenhuma mensagem = o próprio Playgrounds travou** (crash interno,
  `_assertionFailure` numa Task da main thread, sempre o mesmo ponto nos logs). Não é
  erro de código: erro de Swift sempre aparece no painel. Peça os logs em Ajustes →
  Privacidade e Segurança → Análise e Melhorias → Dados de Análise
  (`Swift Playground-*.ips`, `JetsamEvent-*.ips`).
- **Esse crash é intermitente.** Aconteceu também sem nenhuma mudança relevante no
  projeto (v1.99.4, 2026-10-05), e a mesma versão rodou depois de algumas tentativas.
  Antes de investigar o código, peça ao usuário para fechar o Playgrounds de vez e
  tentar de novo, e use um **pacote de controle** (a última versão que rodou) para
  separar "problema do código" de "problema do Playgrounds".
- **Ícone de app via asset catalog: suspeito, não comprovado.** Na bisseção de
  2026-10-04, só a variante sem `Assets.xcassets`/`appIcon` rodou, mas como o crash é
  intermitente, isso pode ter sido em parte coincidência. O ícone continua fora até um
  teste repetido mostrar o contrário. A arte está em `Docs/app-icon/AppIcon.png`.
- **Refatorar Views só para acelerar a compilação: adiado até haver Mac com Xcode**
  (decisão do usuário, 2026-10-05). A extração das células do `RuleTableView`
  (branch `maint/c-ruletable`) falhou no Playgrounds 2 de 2 vezes, sem log, embora o CI
  compile; o `RefCell` (v1.99.6) passou. O ganho é de décimos de segundo no build, e
  cada rodada no iPad é cara. Não reabra sem um Mac para depurar.
- `Package.swift`: manter `.process("Resources")`. `.copy` quebra a assinatura do app
  na instalação (v1.84).
- `Package.swift` usa `path: "."`: **tudo dentro de `THAC0berry.swiftpm/` entra no
  target.** Scripts, docs e qualquer arquivo que não seja do app ficam fora dessa pasta.
- Não gere dados como literais Swift (arrays gigantes de structs): trava o compilador
  e o archive (v0.85, v1.67). Dado vai em JSON (seção 4).
- Imagens soltas em `Resources/`: carregar com `Image.bundled("nome")`
  (`Bundle.main.url` + `UIImage`), nunca `Image("nome")`.
- JSON do bundle: carregar via `BundleJSON` (lista o diretório com `FileManager`),
  como os `*Database` já fazem.
- O app é para **iPad**, iOS 17+, e precisa suportar as 4 orientações (multitasking).

## 4. Dados de referência (contrato com o futuro backend/web)

- **Fonte única: o repo [`thac0berry-data`](https://github.com/Tatarana/thac0berry-data)**
  (clone em `E:\dev\thac0berry\thac0berry-data`): os JSON em `data/` e os schemas em
  `schemas/`, validados no CI de lá. **Não edite os JSON aqui:** mude lá e traga com
  `python Scripts/sync_data.py`. `Resources/*.json` é só a cópia que o Playgrounds
  precisa dentro do projeto; o CI `data.yml` acusa divergência (também roda toda
  segunda).
- **Mudou um modelo Swift decodificável → atualize o schema em `thac0berry-data` na
  mesma entrega.**
- **Armadilha do Codable:** `var x: T = default` com Codable *sintetizado* **exige a
  chave** no JSON. Campo novo em modelo existente precisa de `init(from:)` com
  `decodeIfPresent(...) ?? default`, senão os JSON antigos param de decodificar.
  Foi o bug dos `priest_*.json` (v1.81–v1.86).
- Declarar `init(from:)` próprio remove o memberwise init sintetizado; redeclare-o se
  algum código usa.
- A mensagem "The data couldn't be read because it is missing" costuma ser
  `DecodingError.keyNotFound`, **não** arquivo ausente. Logue o erro completo.

## 5. Dados do usuário (não perder personagens)

- Tudo é salvo em **um único** `Documents/library.json` (`Store/CharacterLibrary.swift`):
  campanhas, personagens e preferências, em JSON com datas ISO-8601.
- **Nunca quebre a decodificação de um `library.json` existente.** Campo novo entra
  como opcional ou com `decodeIfPresent`; renomear ou remover campo exige migração.
  `LossyArray` descarta um personagem que não decodifica, em vez de perder todos.
- O arquivo tem `schemaVersion` (`CharacterLibrary.currentSchemaVersion`, hoje 1; 0 =
  salvo antes do campo existir). Mudou o formato de um jeito que um build antigo não lê?
  Suba o número e escreva a migração em `load()`. Arquivo de formato **mais novo** abre
  só para leitura (`isReadOnly`): nada é gravado por cima.
- Há binários embutidos (base64) no JSON: `NotebookEntry.drawingData`,
  `PlayerCharacter.portraitImageData` e `SpellSheet.inkNotes`. Não mexa no formato
  deles sem um plano de migração aprovado.
- Não semear personagem ou campanha de exemplo automaticamente (pedido do usuário,
  v1.66).

## 6. CI (GitHub Actions)

- `.github/workflows/typecheck.yml` (macOS): roda `swiftc -typecheck` contra o SDK do
  iOS 17, com ranking das funções lentas e alerta para arquivo com mais de 1500 linhas
  ou função com mais de 1 s, e depois `xcodebuild` do `.swiftpm` completo.
- `.github/workflows/data.yml` (Linux): valida os JSON contra os schemas.
- **`gh` não está instalado**, e os logs dos steps exigem login. O repo é público:
  leia os resultados pelas **anotações**, sem autenticação:
  `https://api.github.com/repos/Tatarana/thac0berry-ipad/actions/runs?head_sha=<sha>` →
  `.../actions/runs/<id>/jobs` → `.../check-runs/<job_id>/annotations`.
- Limite: o CI **não reproduz** bugs do Playgrounds (o do ícone passava no CI).

## 7. Pacote para teste no iPad

- O usuário apaga a pasta local, descompacta o zip e abre no Playgrounds.
- **Cada cópia de projeto no Playgrounds tem armazenamento próprio**: abrir um zip como
  projeto *novo* (outra pasta) começa sem personagens. Para testes assim, lembre o
  usuário de exportar backup antes (Settings → Backup) e nunca peça para apagar o
  projeto original.
- Gere o zip a partir dos **blobs do git** (`git ls-tree` + `git cat-file blob`, com
  permissões 0644 e diretórios 0755), em `dist/` (que está no gitignore).
- **Não use `git archive`:** neste PC `core.autocrlf=true` faz ele converter os textos
  para CRLF, e o zip deixa de ser idêntico ao repo.
- Para diagnóstico, cada variante sai com pasta e selo de versão próprios
  (ex.: `THAC0berry-D1.swiftpm`, `displayVersion: "1.98-D1"`).

## 8. Versão e registro

- Toda entrega que muda o app: incrementar `displayVersion` e `bundleVersion` no
  `Package.swift`. O selo no canto do app mostra a versão, e é por ele que o usuário
  confirma que está rodando o build certo.
- Registrar a entrega no fim do `TODO.md` (`## AJUSTE vX.YY (data) — título`): o que
  mudou, por quê e o que ficou pendente.

## 9. Direção do projeto

- Haverá **backend e versão web** compartilhando os dados. A **linguagem do backend não
  está decidida**: o usuário quer avaliar hospedagem e deploy antes. Não assuma Swift
  nem TypeScript.
- Já feito: dados em JSON com schemas; `schemaVersion` no `library.json`; inventário das
  regras de jogo que estão nas telas (`Docs/inventario-regras-nas-telas.md`, com a
  proposta de lotes). Próximo: mover essas regras em lotes; depois, separar um módulo de
  regras. **Cada lote só com aprovação.**
- Regra de jogo nova não vai para uma View: fica em `Store/` (funções puras sobre os
  modelos).
- **Modelo de dados e sincronização:** `docs/modelo-de-dados-e-sync.md` no repo
  [`thac0berry-backend`](https://github.com/Tatarana/thac0berry-backend) (aprovado em
  2026-10-05). A web fica em [`thac0berry-web`](https://github.com/Tatarana/thac0berry-web). Inclui: mestre com acesso temporário à ficha de outro jogador, caderno
  individual, login Google + "Entrar com Apple".
- **O app vai para a App Store.** Isso exige ícone (hoje fora do projeto, ver seção 3),
  política de privacidade, exclusão de conta dentro do app e Apple Developer Program.
  Ver a seção 12 do documento de modelo de dados.

## 10. Documentação

`README.md` (visão geral e estrutura), este arquivo (regras), `thac0berry-data`
(dados e formato), `TODO.md` (histórico de cada versão). Em caso de conflito com o
código, o código vale; corrija o documento.
