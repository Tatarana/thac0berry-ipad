# TODO — Base de magias real + navegação

> **Lembrete de processo:** incrementar `displayVersion`/`bundleVersion`
> em `THAC0berry.swiftpm/Package.swift` a cada entrega — ficou parado em
> "0.4" por várias rodadas de mudança sem ninguém notar. Agora em 0.7
> (bundleVersion 10).

Registro do que ficou combinado sobre trocar a base de exemplo (poucas
dezenas de magias) pela base real de Priest: **1.795 magias** ao todo
(níveis 0-7 padrão, Orisons, Quest Spells, High-Level/Epic e True Dweomer),
cobrindo 5 cenários (Generic, Forgotten Realms, Dark Sun, Greyhawk,
Planescape, Ravenloft).

> **Limitação conhecida — cenários incompletos:** o campo `setting` de
> cada magia vem direto do JSON de origem (`entry["setting"]["name"]`),
> que por sua vez veio de uma wiki, não do Priest Spell Compendium físico.
> Por isso só existem 6 valores (Generic, Forgotten Realms, Dark Sun,
> Greyhawk, Planescape, Ravenloft) — faltam Al-Qadim, Birthright,
> Dragonlance, Kara-Tur/The Horde, Maztica, Red Steel, Savage Coast e
> Spelljammer, que o Compendium também cobre. Decisão do usuário
> (2026-09-12): manter como está por ora — o filtro reflete fielmente o
> que a fonte original rotulou, em vez de arriscar um re-tageamento
> manual/por IA que possa errar magia por magia. Revisitar só se o
> usuário trouxer os dados corretos do livro.

## 1. Importar a base real de magias

- [x] Formato definido: usuário fornece em **JSON**, um arquivo por
      nível/tipo (`level_1.json` ... `level_7.json`, `level_0_orisons.json`,
      `quest_spells.json`, `high_level_epic.json`), mais um `index.json`
      leve com todas as entradas.
- [x] Escopo confirmado: importar **tudo** (1.795), todos os cenários —
      sem filtrar nada na importação. O cenário de cada magia (`setting`)
      fica só como informação exibida no detalhe, filtro por cenário fica
      para depois.
- [x] Modelo `Spell` (`Models/Spell.swift`) estendido com `spheres: [String]`,
      `fullDescription: String?` e `setting: String?`, além dos campos que já
      existiam. `summary` continua sendo o resumo curto.
- [x] Script de conversão criado: `Scripts/convert_spells.py`, roda um
      arquivo por vez (`python3 convert_spells.py entrada.json saida.json`),
      mapeia o schema da wiki pro schema do app (componentes viram string
      "V, S, M", descrição completa vem de `description.fullText`, `id` da
      fonte é reaproveitado direto — já vem em slug único).
- [x] `SpellDatabase.load()` (`Store/SpellDatabase.swift`) adaptado: carrega
      `spells.json` (exemplos de Kelmon) + qualquer `priest_*.json` presente
      no bundle, soma tudo num array só. Em caso de `id` repetido entre
      arquivos, o primeiro carregado (`spells.json`) vence.
- [x] Bug encontrado e corrigido: o `id` que vem da fonte é único dentro
      de um arquivo, mas não entre níveis — a wiki tem casos de magias com
      nomes iguais e slugs iguais em círculos diferentes ("Float" nível 1 e
      "Float" nível 2 são magias distintas). O script gera
      `priest-<nível>-<slug>` (ex.: `priest-1-bless`).
- [x] **Importação completa**: os 10 arquivos convertidos e integrados —
      `priest_level_0_orisons.json` (58), `priest_level_1.json` (211),
      `priest_level_2.json` (263), `priest_level_3.json` (276),
      `priest_level_4.json` (303), `priest_level_5.json` (258),
      `priest_level_6.json` (189), `priest_level_7.json` (162),
      `priest_quest_spells.json` (42), `priest_high_level_epic.json` (33).
      Total: **1.795 magias reais** + 62 exemplos do Kelmon = 1.857
      entradas, todos os `id` únicos conferidos (nenhuma colisão).
- [x] `damageDice`/`damage` — extração heurística por regex criada em
      `Scripts/extract_damage.py` (abordagem híbrida: regex cobre os
      formatos mais comuns; o resto fica só com `damage` em texto livre,
      nunca mais os dois campos `null` pra quem claramente tem dano/cura).
      Roda direto do JSON cru da fonte (reusa `convert_spells.convert_entry`
      por dentro), não do já convertido — importante pra magia reversível,
      cujo `fullText` mistura o efeito direto com o da forma reversa (ex.:
      "Regenerate Light Wounds", uma cura, tem o dano de "degenerate light
      wounds" no mesmo bloco de texto); pra essas, usa só
      `description.sections.mainEffect`, sem o parágrafo da reversa.
      Modelo `SpellDamage` ganhou `bonusPerLevel`/`maxBonus` (dado FIXO,
      só o bônus somado escala por nível, com teto opcional — ex.: Frost
      Fingers "1d3 + 2/nível, até +20") — formato diferente do
      `scalesWithLevel` que já existia (esse escala o DADO, não o bônus).
      Bug encontrado e corrigido: quando `damage` existe mas não dá pra
      estruturar (`damageDice` nulo), a célula da folha (`SpellSheetView`)
      tentava mostrar a frase inteira, espremida/ilegível na coluna
      estreita. Agora mostra só `*` — sinaliza "tem dano/cura, mas não
      simplificável; ver detalhe da magia" —, diferente de `—`, reservado
      só pra quem realmente não tem dano/cura nenhum. O texto completo
      continua disponível na janela de detalhe (`SpellDetailSheet`), sem
      limite de espaço.
      Mais dois verbos de dano cobertos ("deals"/"receives N points of
      damage") depois do teste no nível 1.
      **Aplicado nos 10 arquivos da base real** (1.795 magias: 192 com
      `damageDice` estruturado, 150 só com `damage` em texto — mostram `*`
      na folha —, 1.453 sem dano/cura de verdade). Validado campo a campo
      contra a versão anterior de cada arquivo antes de aplicar — só
      `damage`/`damageDice` mudaram, nada mais.

## 2. Favoritos do jogador (global — antes era por personagem)

- [x] `favoriteSpellIDs: Set<String>` nasceu em `PlayerCharacter`
      (`Models/Character.swift`), com `isFavorite`/`toggleFavorite` — por
      personagem, não global.
- [x] Estrela pra marcar/desmarcar em `SpellDetailSheet` (só aparece quando
      a magia existe de verdade na base, não pra nome livre).
- [x] Na lista de candidatos pra memorizar (`SlotEditorSheet`), favoritos do
      círculo aparecem primeiro, antes da lista completa.
- [x] **Mudança de escopo (2026-09-19)**: pedido do usuário — "quem escolhe
      as magias são os jogadores", um jogador que gosta de uma spell tende a
      usá-la em QUALQUER personagem Priest que criar, não só num específico.
      `favoriteSpellIDs` saiu de `PlayerCharacter` e virou
      `CharacterLibrary.favoriteSpellIDs` — uma preferência global do
      jogador, salva junto com campanhas/personagens em `library.json`.
      `CharacterLibrary.isFavorite(_:)`/`toggleFavorite(_:)` substituem os
      métodos que existiam em `PlayerCharacter` (removidos; o campo em si
      ficou como legado só pra migração). Efeitos: a estrela do Grimório
      passou a aparecer mesmo quando ele é aberto direto da Tela Principal,
      sem personagem nenhum associado (antes sumia nesse caso); a ordenação
      de candidatos no `SlotEditorSheet` usa os favoritos globais, mas
      continua olhando o HISTÓRICO DE USO deste personagem específico pro
      desempate de "mais usada". Migração automática no primeiro carregamento
      de uma biblioteca salva antes da mudança: junta os favoritos que já
      existiam em cada personagem num conjunto só, sem perder nada.
- [x] **Estrela direto no `SlotEditorSheet` (2026-09-20)** —
      `SpellPaperRow` (`Views/SpellSheetView.swift`) ganhou `isFavorite`/
      `onToggleFavorite` opcionais; quando presentes, desenha a mesma
      estrela ★/☆ que já existia no Grimório, como um botão PRÓPRIO (não
      dispara a ação de escolher a magia). `SlotEditorSheet` passa
      `library.isFavorite(spell.id)`/`library.toggleFavorite(spell.id)`
      nas duas listas (candidatos da escrita à mão e lista completa do
      círculo) — favoritar aqui já reflete na ordenação (favoritos vêm
      primeiro em `levelList`), sem precisar sair da tela de escolha.
- [x] **Descartado a pedido do usuário (2026-09-20)** — favoritar magias de
      item mágico (`ItemSpellRow`) fica fora do escopo.

## 3. Ordenar por "mais usadas" (sem precisar marcar nada)

- [x] `spellUsageCounts()` em `PlayerCharacter`, calculado direto do
      histórico existente (`spellSheets` → `slotBoard.slots`).
- [x] Ordem final na lista de candidatos: favoritos → mais usadas → resto
      em ordem alfabética.

## 4. Esferas de acesso (fase 2 — mais escopo, avaliar depois)

- [x] Superado pelo item 16 (2026-09-20) — esferas de acesso por
      personagem implementadas por completo (sugestão do kit, editor na
      Ficha, sinal/ordenação na Folha de Magias). Ver item 16.

## 5. Navegação em seções na lista completa

- [x] Feito junto com o item 6 abaixo — o Grimório já agrupa por círculo
      com títulos recolhíveis (mesmo padrão do "old sessions" em
      `CampaignIndexView`). Falta só agrupar por esfera também, se algum
      dia isso ficar mais útil do que por círculo.

## 6. Grimório — tela de consulta separada

Implementado como `Views/SpellbookView.swift`, aba "spellbook" na ficha
(ao lado de "index"), só pra classes com ficha de magia.

- [x] Nova página/aba acessível a partir da ficha (mesmo padrão de acesso
      do Índice de Campanha).
- [x] Lista agrupada por círculo, recolhível (por esfera fica pra depois,
      ver item 5).
- [x] Campo de busca reaproveitando `SpellDatabase.matches`.
- [x] Filtro rápido "só favoritas".
- [x] Toque abre `SpellDetailSheet` em modo consulta.
- [x] Estrela de favoritar direto na lista.
- [x] **Componente de lista unificado (2026-09-20)** — `SpellbookRow`
      (deste arquivo) e `SpellPaperRow` (`SpellSheetView.swift`) eram duas
      implementações quase idênticas (mesma estrela, mesmo botão de
      selecionar) divergindo só no nível de detalhe mostrado. Viraram UM
      componente só, `SpellPaperRow` com um `SpellRowStyle` novo
      (`.detailed`, o formato de sempre da Folha de Magias — nome +
      horário + resumo + aviso de esfera; `.compact`, o do Grimório — só
      nome + esferas numa linha). `SpellbookRow` foi removido; o Grimório
      agora chama `SpellPaperRow(spell:style: .compact, ...)` direto.

## 7. Ficha oficial (Sheet) redesenhada a partir do PDF real

A aba "Sheet" foi reconstruída pra ficar o mais parecida possível com a
página 1 de um PDF de ficha oficial (`MI_ADDCharSheet46.pdf`) que o
usuário forneceu como referência — cabeçalho com Kit/Origem, Atributos
com os sub-campos relabeled pro texto do PDF, Jogadas de Proteção com
Resistência Mágica, um bloco novo de Detalhes de Combate (CAs por
situação, testes, ficha de morte), a tabela "Target's AC / To Hit #"
(calculada sozinha a partir do THAC0, com ajuste manual célula a célula
pra bônus situacional), três blocos de Modificadores de Combate, a tabela
de armas com os campos novos (tamanho/tipo/velocidade/ajustes) e uma
tabela de Proficiências. Tudo que não está na página 1 do PDF (Equipment,
Tesouro, Itens Mágicos, Idiomas, Aliados, Experiência, Spell Slots, as
listas antigas de proficiência em armas/perícias) foi movido pra uma aba
nova, "Equipment".

- [x] Todos os campos novos do modelo (`Models/Character.swift`) são
      `Optional` — nenhuma ficha salva antes desta versão perde dados ou
      falha ao carregar (mesma regra de segurança do Codable que já
      valeu pra `CharacterClass`).
- [x] Primeira rodada (visual "de app", cards empilhados com tarja
      escura) rejeitada pelo usuário — "parece Excel". Reconstruída:
      releu a imagem do PDF de verdade e trocou os `SheetBlock`
      genéricos por peças de formulário próprias (`FormCell`,
      `FormSectionTitle`, `ArmorClassShield` com o desenho do escudo)
      que desenham a grade de caixinhas com moldura fina do PDF —
      Atributos e Jogadas de Proteção lado a lado, Combate com o
      escudo de CA de verdade, a tira "Target's AC / To Hit #" rolando
      na horizontal, Modificadores de Combate e Proficiências em
      tabelas de verdade em vez de listas de app.
- [x] **Jogadas de Proteção — Start/Mod/Total (2026-09-20)** — usuário
      pediu de volta: "é muito importante ter o MOD, pois podemos aplicar
      manualmente um ajuste temporário". `SavingThrows.modifiers` (`Models/
      Character.swift`) trocou de texto livre (`[String: String]?`,
      descritivo, sem efeito nenhum no número) pra ajuste numérico
      (`[String: Int]?`, positivo = bônus/facilita, negativo = penalidade)
      — `setModifier` some com a chave quando o valor volta a 0, pra não
      acumular lixo em ficha salva. Novo `SavingThrows.total(for:)` calcula
      Start − Mod na hora (positivo FACILITA a jogada — reduz o alvo,
      regra do PHB cap. 9 — por isso é subtração, não soma) — nunca
      guardado, só exibido, então não tem como o Total ficar
      dessincronizado dos outros dois campos. `SavingThrowsForm`
      (`CharacterSheetView.swift`) virou 3 colunas de verdade (Start/Mod/
      Total, a última só leitura, em negrito) em vez de Alvo/Modificador-
      texto; campo "Start" continua sendo escrito sozinho pelo
      `ConsequenceEngine` numa subida de nível, igual sempre foi — o
      jogador só ganhou o "Mod" de verdade e o "Total" calculado por cima.
- [x] **Proficiências (2026-09-20)** — checado a pedido do usuário: as
      listas antigas (`PlayerCharacter.weaponProficiencies: [String]`,
      `.skills: [EquipmentItem]`) já não apareciam em NENHUMA tela — a
      única referência que restava era a migração de uma vez só (herdar
      pra `proficiencies` na primeira abertura da ficha). Como o projeto
      ainda está em beta (usuário: "não precisa manter compatibilidade com
      fichas antigas"), removidos de vez: os dois campos saíram do model
      (`Models/Character.swift`), a migração em `ProficienciesForm.onAppear`
      (`CharacterSheetView.swift`) virou só "começa com 6 linhas em
      branco", e a ficha de exemplo do Kelmon
      (`Models/SampleCharacter.swift`) passou a escrever os mesmos dados
      direto em `proficiencies` (`ProficiencyEntry`), não mais nos campos
      extintos.

## 8. Tela Principal + ícones ilustrados (Fase 4)

- [x] Nova raiz do app (`HomeView`) com os três ícones grandes (Campaigns/
      Characters/Compendium) + Configurações — ver `Docs/icon-button-spec.md`
      pro levantamento que gerou o pedido de arte.
- [x] Seis das oito imagens entregues já integradas: mapa+bússola
      (Campaigns), medalhão (Characters), pilha de grimórios (Compendium),
      livro do Clérigo/Mago (Compendium hub), engrenagem (Configurações),
      selos de cera de morto/arquivado (status do personagem).
- [x] "Fallen Heroes" — seção nova em `AllCharactersView`, memorial dos
      personagens mortos de todas as campanhas juntas (antes ficavam
      espalhados dentro do elenco de cada campanha); usa o brasão do
      cavaleiro-esqueleto (`Hero-graveyard-01-no-bg.png` → 
      `Resources/banner_fallen_heroes.png`) como cabeçalho.
- [ ] "Session-active" (selo com bandeira e "SESSION ACTIVE", duas versões)
      ainda SEM uso — veio junto no lote de imagens mas não tem casa certa.
      Ideia do usuário (2026-09-18): um jogador costuma ter uma ou duas
      sessões ativas ao mesmo tempo (em campanhas diferentes) — talvez sirva
      pra sinalizar isso em algum lugar, mas ele mesmo não tinha um destino
      certo em mente ao pedir a imagem. Hoje quem indica "sessão ativa" é o
      `SessionBadge` (bandeira colorida por sessão, 26-32pt, na fileira de
      abas da ficha) — a imagem como veio (texto embutido, cor fixa
      vermelho/dourado) não encaixa nesse tamanho/uso sem perder a
      cor-por-sessão. Revisitar quando surgir um caso de uso mais concreto.

### Rodada de feedback 2026-09-18 (pós Fase 4)

- [x] Item 1 — grid da Tela Principal ficava alinhado à esquerda em
      landscape (`.adaptive` decidia que cabiam 4-5 colunas e sobrava vão
      vazio). Trocado por 3 colunas `.flexible` fixas + `frame(maxWidth: 760)`
      centralizando o conjunto.
- [x] Item 2 — o link "Open campaign notebook" (`CampaignDetailView`)
      amarrava sem necessidade o caderno da campanha a um personagem
      específico (empurrava `.character(primeiroDoElenco, .notebook(nil))`,
      trazendo junto a fileira de abas da ficha). Desacoplado: nova rota
      `AppRoute.campaignNotebook(UUID)` + `CampaignNotebookView` standalone
      (`NotebookView.swift`); `NotebookBeadRow`/`NotebookEmptyState`
      trocaram o binding `page: CharacterSheetView.SheetPage` por
      `selection: UUID?`, genérico. Acesso rápido ao caderno de dentro da
      ficha do personagem continua idêntico (bridging `notebookSelection`
      em `CharacterSheetView`).
- [x] Item 3 — brasão de fundo da Tela Principal quase invisível
      (opacidade 0.1) — subiu pra 0.26.
- [x] Item 4 — jornada de marcar personagem como morto:
      - `CharacterCard` agora mostra `deathLine` (data + nota, quando
        registradas) no lugar de "X spells ready" pra personagem morto.
      - Nova `MarkDeadSheet` (folha com `DatePicker` + campo de nota,
        mesmo padrão visual de `NewSessionSheet`) substitui o antigo botão
        que matava na hora com data de hoje/nota em branco sem perguntar
        nada.
      - `CampaignDetailView.castMenu` e o menu de contexto de
        `AllCharactersView` (que antes não tinha NENHUMA ação de
        status — só "Assign to campaign"/"Delete character") agora abrem
        essa folha.
      - Fallen Heroes ganhou "Bring back to active cast" no menu de
        contexto (reaproveitando `library.reviveToAlive`, que já existia
        mas só estava exposto dentro do elenco de campanha).
- [x] Brasão de fundo em cada caixa de Fallen Heroes (pedido à parte, mesmo
      dia): opacidade 0.16 → 0.4, ainda com queixa de "muito apagado" na
      primeira entrega — subiu de novo.
- [x] Bug em campo, reportado com print (2026-09-18): "Failed to read
      spells.json: The data couldn't be read because it is missing" — visto
      na tela de Campanhas e na Tela Principal (as duas mostram
      `spellbook.loadError`).
      - 1ª tentativa (v0.68): trocar a leitura de `Bundle.main.url(forResource:
        withExtension:)` por reaproveitar a URL achada numa varredura de
        diretório (`FileManager.contentsOfDirectory`) — teoria de que as duas
        APIs podiam divergir. Reportado de volta: mesma mensagem, bug
        continuou.
      - 2ª tentativa (v0.69): a pista real é que APENAS `spells.json` — de
        longe o menor JSON do projeto (29KB) — falhava, enquanto todo
        `priest_*.json` (300-700KB cada) carregava sem problema. Solução
        tentada: parar de depender de recurso de bundle pra ele, embutindo
        o `spells.json` original como uma ÚNICA STRING Swift gigante
        (~1100 linhas, literal bruto `#"""..."""#`). Reportado de volta:
        MESMA mensagem — só que agora vinda claramente do lado do literal
        embutido ("Failed to read the embedded sample spells"), não mais
        do bundle.
      - 3ª tentativa (v0.71, a que resolveu — confirmado por diagnóstico
        embutido na própria mensagem de erro, ver abaixo): a v0.70
        adicionou build/versão E contagem de arquivos de sacerdote
        encontrados direto na mensagem de erro, pra parar de adivinhar. O
        print de volta confirmou build 0.70(76) rodando (não era cache) e
        10 `priest_*.json` encontrados (certo) — ou seja, o problema era
        mesmo só o literal embutido. Causa provável: o compilador on-device
        do Swift Playgrounds não lida bem com um literal de string bruta
        gigante (~29KB) — a `Data` gerada a partir dele decodificava vazia
        ("The data couldn't be read because it is missing" é exatamente a
        mensagem que o `JSONDecoder`/Foundation dá pra `Data` de tamanho
        zero). Solução final: nada de JSON pra esses exemplos — os 62
        `Spell` do Kelmon (`SampleCharacter`) viraram literais Swift de
        verdade (`Spell(id: ..., name: ..., ...)`), gerados a partir do
        `spells.json` original mas sem JSON nem `Data` nem `JSONDecoder`
        nenhum em runtime — impossível falhar por "missing" porque não há
        leitura nenhuma acontecendo. A base de sacerdote de verdade
        (`priest_*.json`) continua vindo do bundle sem mudança — sempre
        funcionou.

### Rodada de feedback 2026-09-18 (parte 2)

- [x] Excluir/arquivar campanha direto da listagem (`CampaignListView`),
      igual já existia na listagem de personagens (`AllCharactersView`) —
      toque longo no cartão da campanha. Antes só dava pra fazer isso
      entrando na campanha (`CampaignDetailView.header`); este é um atalho
      a mais, reaproveitando `library.deleteCampaign`/`updateCampaign`.
- [x] Tela Principal: os três ícones grandes saíram de logo abaixo do
      título e viraram uma "doca" ancorada embaixo da tela (`Spacer` entre
      o cabeçalho e a barra + grid). Num iPad na mão, o topo da tela é a
      parte mais longe do polegar — o título continua lá (onde se espera
      achar o nome do app), a navegação principal desceu pra perto da mão.
- [x] Pergunta do usuário (2026-09-18): "qual a diferença prática de uma
      campanha arquivada e uma ativa?" — resposta honesta: NENHUMA além do
      rótulo no cartão. `isArchived` nunca escondia a campanha de lugar
      nenhum, ao contrário do que já acontecia com personagem arquivado
      (seção recolhida dentro do elenco). Corrigido: `CampaignListView`
      agora separa campanhas ativas (sempre visíveis) de arquivadas
      (`DisclosureGroup` recolhido no fim, "Archived (N)") — mesmo padrão
      já usado pra Dead/Archived em `CampaignDetailView.castSection`.

### Rodada de feedback 2026-09-18 (parte 3) — página "Character Description"

- [x] Pedido: replicar a página 4 do PDF de referência
      (`MI_ADDCharSheet46.pdf`) como uma nova página da ficha, com upload
      de imagem no quadrado do retrato.
      - `Models/Character.swift`: 11 campos novos em `PlayerCharacter`, todos
        `Optional` com `= nil` (mesma convenção do resto do model, pra JSON
        de personagem já salvo continuar decodificando igual) — `birthDate`,
        `birthRank`, `nationality`, `racialAbilities`, `skin`, `vision`,
        `handedness`, `personality`, `hitPointsByLevel`, `backgroundHistory`
        e `portraitImageData: Data?` (o retrato em si). Campos que já
        existiam desde a página 1 (nome, classe, raça, alinhamento, etc.)
        foram reaproveitados direto, sem duplicar dado.
      - `Views/CharacterDescriptionView.swift` (novo arquivo):
        `CharacterDescriptionPage` — a tabela de dados pessoais em
        HStack/VStack de células próprias (`DescCell`/`DescCellStatic`,
        seguindo o padrão já usado por `ClericReferenceView`/`RefCell` de
        cada página ter suas próprias células privadas, já que `FormCell`
        de `CharacterSheetView.swift` é `private` e não dá pra reusar de
        fora), bloco de Personality e de Background/History em
        `PaperTextEditor` (TextEditor com placeholder, mesmo padrão da
        descrição de itens mágicos na Priest Spell Sheet) e a linha de Hit
        Points by Level.
      - `CharacterSketchBox`: upload de retrato de verdade via
        `PhotosPicker` (PhotosUI, primeira vez usado no projeto — picker do
        sistema roda fora do processo do app, sem pedir permissão de
        biblioteca de fotos pra seleção simples). Imagem escolhida passa
        por `UIImage.resizedForSketch(maxDimension: 800)` + JPEG
        (`compressionQuality: 0.82`) antes de virar `Data` salva no
        personagem — mesma lógica de redimensionar ícones que já existia,
        pra não inflar o `library.json` (o retrato vira base64 inline no
        JSON do personagem via `Codable`). Botão "Remove photo" limpa o
        campo.
      - Encaixada como página 3 (índice 2) do pager da aba Sheet
        (`RecordSheetPagerView`, `Views/CharacterSheetView.swift`) — fixa
        pra TODAS as classes, não só quem tem magia. `maxPageIndex` passou
        de `hasSpellSheet ? 2 : 1` pra `hasSpellSheet ? 3 : 2`; a página de
        referência do Clérigo (só pra quem tem magia) virou a última
        (índice 3) em vez da 2ª.
- [x] Feedback de campo (v0.74 → v0.75): dois bugs na página nova.
      1. Só Racial Abilities/Personality/Background (os três campos de
         texto livre) respondiam ao toque — os campos curtos da tabela
         (Character Name, Birth Date, Race, etc., todos via `EditableText`
         genérico) não abriam o balão de edição. Correção: `DescCell`
         deixou de delegar pro `EditableText` compartilhado e passou a
         implementar seu próprio botão+balão, cobrindo a célula INTEIRA
         (etiqueta incluída), não só a área onde o valor aparecia — área
         de toque bem maior e sem depender de como o pager resolve frames
         flexíveis dentro do `ScrollView` de cada página.
      2. O retrato enviado por upload estourava a moldura do "Character
         Sketch" verticalmente. Causa: a altura fixa (240pt) só era
         aplicada de FORA do `PhotosPicker`, e nem sempre esse valor é
         repassado a tempo pro rótulo customizado calcular o
         `.aspectRatio(.fill)` antes do `.clipped()`. Correção: a altura
         fixa agora é aplicada direto no `ZStack` do retrato, antes do
         `.clipped()` — o corte deixa de depender dessa propagação.
      - **Sem simulador neste ambiente** pra confirmar visualmente — só dá
        pra validar sintaxe (chaves/parênteses balanceados). Ambas as
        correções seguem o padrão já comprovado em produção (`FormCell`
        cobrindo a célula inteira; frame fixo antes de `clipped()`), mas
        precisam de confirmação em campo de novo.
- [x] 2ª rodada de feedback de campo (v0.75 → v0.76) — o botão+popover da
      correção anterior criou problema novo em vez de resolver:
      1. Usuário prefere escrita DIRETO na ficha (sem abrir balão) — mesmo
         padrão que já funcionava em Racial Abilities/Personality/
         Background. `DescCell` perdeu o `Button`+`.popover()` de vez e
         passou a usar `InlineTextField` (a mesma `HandwritingField` que já
         funciona nessas três células) pra TODOS os campos da tabela.
      2. Efeito colateral do popover: escrever em "Hit Points by Level"
         aparecia em "Personality"; escrever em "Race"/"Nationality"
         aparecia em "Racial Abilities" — texto indo pro campo errado.
         Como o `EditableText`/`InlineTextField` compartilhados (usados no
         resto do app sem esse problema) continuaram intocados, a causa
         mais provável é o `Button`+`@State`+`.popover()` que eu tinha
         acabado de adicionar em `DescCell` — removido junto com o item 1,
         não precisou de correção em separado.
      3. `hitPointsByLevelField` também trocou de `EditableText` (balão)
         pra `InlineTextField` (direto), pela mesma razão do item 1.
      4. Retrato: agora cabe verticalmente, mas ao TROCAR de foto estourava
         a moldura na horizontal — a imagem só herdava largura do `ZStack`
         ao redor, sem `.frame` próprio antes do corte. Correção: a caixa
         do retrato (`CharacterSketchBox`) passou a usar `GeometryReader`
         pra medir o espaço real disponível e aplicar esse tamanho exato
         (`geo.size`) direto na `Image`, com `.clipped()` logo em seguida —
         não depende mais de nenhuma propagação de frame vinda de fora.
      - De novo, sem simulador aqui pra confirmar visualmente — só sintaxe
        validada.
- [x] Feedback de campo (v0.76 → v0.77): "Deu bom, obrigado!" — funcionou.
      Ajuste fino pedido: a tabela de dados pessoais (o bloco antes de
      "Personality") precisava de mais espaço na coluna da esquerda, "por
      volta de 20% a mais". `HStack` com `.frame(maxWidth: .infinity)`
      sempre reparte em partes IGUAIS entre os filhos — não dá pra pesar
      uma coluna sem medir a largura disponível na mão. Nova
      `weightedRow(height:weights:cells:)`: usa `GeometryReader` pra pegar
      a largura real da linha e calcula o pixel de cada coluna a partir de
      pesos (`[1.2, 1]` pro par Character Name/Player Name e pra Racial
      Abilities/bloco direito, `[1.2, 1, 1, 1]` pras linhas de 4 colunas) —
      a 1ª coluna de toda linha da tabela agora fica ~20% mais larga que
      as demais, que continuam iguais entre si. Recebe as células como
      `[AnyView]` em vez de `@ViewBuilder` genérico porque `Group(subviews:
      )` (a forma nativa de enumerar um `ViewBuilder` variádico) só existe
      no iOS 18+, e o projeto mira iOS 17.
- [x] Feedback de campo com print (v0.77 → v0.78): "ficou bem
      desalinhado" — print mostrando as bordas verticais da tabela fora de
      prumo entre uma linha e outra. Causa: `weightedRow` normalizava os
      pesos de CADA LINHA separadamente (uma `GeometryReader` por linha) —
      a linha de 2 colunas (Character Name/Player Name) e as linhas de 4
      colunas calculavam a largura da 1ª coluna cada uma do seu jeito, sem
      nenhuma garantia de que as bordas caíssem no mesmo x. Correção:
      trocado por uma ÚNICA `GeometryReader` pra tabela INTEIRA, dividindo
      a largura em 4 "quartos" fixos (`q1` = 1.2 unidades, `q2`/`q3`/`q4` =
      1 cada) — toda célula da tabela usa esses MESMOS quatro valores (ou
      a soma de dois quartos vizinhos pras células de largura dupla, como
      Character Name ou Racial Abilities), então as bordas ficam
      exatamente alinhadas em todas as linhas, como uma tabela de verdade.
      `weightedRow` foi removido (não serve mais pra nada).
- [x] Feedback de campo (v0.78 → v0.79): "fez muito pouca diferença" — o
      peso 1.2x da 1ª coluna (`q1`) era sutil demais pra notar. Subiu pra
      1.8x (quase o dobro da largura das outras três colunas).

## 9. Base de Kits de sacerdote (2026-09-19)

Usuário forneceu `priest_kits.json` (97 kits de Priest — genéricos como
Fighting-Monk/Warrior Priest e os 57 de sacerdote especializado por
divindade de Forgotten Realms) extraído da wiki, mesmo estilo de pipeline
externo já usado pras magias. Passou por 3 rodadas de correção conversando
comigo antes de entrar no app: IDs duplicados (kits "Create Your Own"
repetidos entre sourcebooks), parser de `mechanics` quebrando frase solta
em lista (fragmentos tipo "such as the sword" viravam item de lista),
`mechanics.startingCash` perdendo o multiplicador de ouro (tabelas do tipo
"Starting Cash (x10 gp)" guardavam só o dado, sem o x10 — errava o ouro
inicial por um fator de 10 em 58 dos 97 kits) e sobra de `None` do parser
vazando pra dentro de texto (`"; None."` grudado em `weapons.notes`/
`proficiencies.notes` de 14 kits) — essa última eu limpei aqui mesmo antes
de gerar o recurso final, não precisou de mais uma rodada do usuário.

- [x] `Resources/priestKits.json` — **nome sem underscore de propósito**:
      `SpellDatabase.priestFiles()` varre o bundle atrás de todo `.json`
      que comece com `priest_` pra decodificar como `[Spell]`; um
      `priest_kits.json` cairia nessa varredura e quebraria o carregamento
      de magias tentando ler kit como feitiço.
- [x] `Models/Kit.swift` — struct `Kit` + sub-structs espelhando o schema
      (`classEligibility`, `features` prosa por seção, `description` com
      `briefSummary`/`fullText`/`rawWikitext`, `mechanics` estruturado:
      `requirements.abilities` como `[String: Int]`, `weapons`/
      `proficiencies` com listas + notas, `armor` e `turnUndead`).
      `KitArmorRestriction` é um enum `Codable` à mão porque
      `allowedTypes`/`shieldsAllowed` vêm ora como a string sentinela
      `"as_class"`, ora como lista concreta de tipos — decodifica tentando
      lista primeiro, qualquer string vira `.asClass`. `turnUndead.mode`
      ficou `String` solto (não enum fechado) de propósito: depois de 3
      rodadas de dado sujo nesse arquivo, um valor novo inesperado não pode
      derrubar o kit inteiro no decode.
- [x] `Store/KitDatabase.swift` — `ObservableObject` só carrega o arquivo
      único do bundle (sem varredura de diretório como `SpellDatabase`, não
      existe hoje uma família de arquivos de kit que justifique) e publica
      `[Kit]` ordenado por nome, com `kit(id:)`, `kits(allowedFor:)`,
      `generalKits()`/`specialtyPriestKits(pantheon:)`.
- [x] Injetado em `App.swift` como `@StateObject private var kits` +
      `.environmentObject(kits)`, ao lado de `library`/`spellbook`.
- [x] **UI (0.82)** — `Views/KitCompendiumView.swift` (novo arquivo):
      - `KitCompendiumView`: tela de consulta da base inteira, mesmo
        espírito do `SpellbookView` (item 6) mas agrupada por
        `classEligibility.subclass` ("Cleric"/"Druid"/"Any Priest"/
        "Specialty Priest", ordem fixa nessa sequência) em vez de por
        círculo, com títulos recolhíveis + busca (nome, divindade, título
        na igreja). Aberta a partir de um card novo "Priest Kits" em
        `CompendiumHubView`, entre Priest Grimoire e o placeholder Mage
        Grimoire (`KitCompendiumScreen`, mesma moldura pergaminho do
        `SpellbookScreen`) — ainda sem arte ilustrada própria, cai no
        fallback de `CompendiumTile` (SF Symbol `shield.lefthalf.filled` +
        selo `star.fill` em `Ember.brass`).
      - `KitDetailSheet`: descrição completa (texto corrido +
        requisitos/turn undead/ouro inicial em grade + cada seção de
        `features` como texto), reaproveitada em dois lugares — consulta
        pura no Compendium, e com botão "choose" quando aberta a partir do
        seletor da ficha.
      - `KitPickerSheet`: busca + lista com ★ no kit já selecionado e "ⓘ"
        por linha abrindo o `KitDetailSheet` antes de decidir. O campo
        "Kit" do cabeçalho da Sheet (`RecordHeaderForm` em
        `CharacterSheetView.swift`) trocou de `EditableText` livre pra um
        botão (`KitField`, novo) que abre essa sheet — `character.kit`
        continua sendo o mesmo `String?` de sempre (só grava `kit.name`),
        então ficha antiga com texto livre digitado nesse campo continua
        abrindo normal, só não vem com nenhuma linha destacada no seletor.
- [x] **Bug em campo (v0.82 → v0.83): "Priest Kits vazio, seletor de Kit
      na ficha também não traz nada".** Causa: `KitDatabase.load()` usava
      `Bundle.main.url(forResource: "priestKits", withExtension: "json")`
      — a MESMA API que já tinha causado exatamente esse tipo de bug com
      `spells.json` (ver item 1 acima, v0.68-0.71: "Failed to read
      spells.json: The data couldn't be read because it is missing").
      Esqueci desse precedente ao escrever o loader do zero em vez de
      copiar o padrão do `SpellDatabase`. Dois problemas empilhados:
      1. A leitura em si falhava silenciosamente — igual da vez passada,
         `Bundle.main.url(forResource:)` não acha o JSON nesse ambiente do
         Swift Playgrounds mesmo com o arquivo presente no bundle.
      2. Eu nunca expus `kitDatabase.loadError` em lugar NENHUM da UI — ao
         contrário de `spellbook.loadError`/`library.lastError`, que já
         aparecem em `HomeView`/`CampaignListView`. Resultado: falha virou
         tela em branco sem nenhuma pista, em vez de uma mensagem de erro.
      - Correção 1: `KitDatabase.load()` reescrito pra reaproveitar o
        padrão comprovado de `SpellDatabase.priestFiles()` —
        `FileManager.contentsOfDirectory(at: Bundle.main.resourceURL...)`
        e aí sim ler pela `URL` encontrada, achando o arquivo pelo NOME
        exato (`priestKits.json`) em vez de prefixo (aqui é recurso único,
        não uma família tipo `priest_*.json`). Comentário grande no topo
        do arquivo agora avisa pra nunca mais trocar essa leitura de volta
        pro `Bundle.main.url(forResource:)`.
      - Correção 2: `kits.loadError` somado ao banner de erro que já
        existia em `HomeView`/`CampaignListView`
        (`spellbook.loadError ?? kits.loadError ?? library.lastError`), e
        também mostrado DIRETO nas duas telas novas (`KitCompendiumView`/
        `KitPickerSheet`) no lugar do "no results" — assim uma falha de
        carregamento futura aparece exatamente onde a lista ficaria vazia,
        sem precisar voltar pra Tela Principal pra descobrir por quê.
- [x] **2ª rodada do mesmo bug (v0.83 → v0.84).** A correção 1 acima só
      resolveu metade: com a varredura de diretório o arquivo passou a ser
      ENCONTRADO (não caiu mais no "não encontrado no bundle"), mas
      `Data(contentsOf:)`/`JSONDecoder` continuaram falhando com a mesma
      mensagem "The data couldn't be read because it is missing" — dessa
      vez claramente não é "arquivo não existe" (o `guard` já garantia que
      sim), é leitura/decode falhando com o arquivo grande demais. Pista:
      o maior `priest_*.json` que sempre funcionou tem ~700KB
      (`priest_level_4.json`); o `priestKits.json` único tinha ~1MB.
      Correção: dividido em `priestKit1.json`/`priestKit2.json`/
      `priestKit3.json` (33/33/31 kits, ~330KB cada — bem abaixo do teto
      que já provou funcionar), com `KitDatabase.load()` reescrito pra
      varrer e mesclar os 3 (mesmo padrão de `SpellDatabase.priestFiles()`,
      prefixo `priestKit` em vez de `priest_` pelo mesmo motivo de sempre —
      não colidir com a varredura de magias). Comentário atualizado no
      topo do arquivo documentando as DUAS tentativas fracassadas, pra
      não repetir nenhuma das duas de novo.
- [x] **3ª rodada do mesmo bug (v0.84 → v0.85) — causa real encontrada.**
      As duas rodadas anteriores (varredura de diretório, depois dividir
      em arquivos menores) tratavam sintoma, não causa — e o usuário
      confirmou que o Grimório normal (`spells.json`) continuava
      funcionando no mesmo build, o que descartava regressão geral de
      leitura de bundle. Reli o histórico do item de `spells.json`
      (mais acima neste arquivo) com mais calma e reparei que a "1ª
      tentativa" de lá (varredura de diretório) TAMBÉM tinha falhado com
      a mesma mensagem genérica — ou seja, varredura de diretório nunca
      foi uma correção comprovada em geral, só funcionou por coincidência
      pros `priest_*.json` originais. Isso apontou pra um problema
      específico dos dados de Kit, não do mecanismo de leitura.
      Auditoria em Python no JSON completo (97 kits) contra TODO campo
      não-opcional do `Kit`/`KitMechanics`/etc. achou: 13 dos 97 kits não
      têm a chave `mechanics.armor.allowedTypes` (a chave inteira ausente,
      não `null`). Como o Swift tratava esse campo como não-opcional, o
      `JSONDecoder` estourava `DecodingError.keyNotFound` ao tentar
      decodificar QUALQUER um desses 13 kits — o que derruba o array
      inteiro (`[Kit]`), não só aquele item. E a renderização padrão do
      Foundation pra esse erro específico é literalmente a mesma frase
      genérica "The data couldn't be read because it is missing" que eu
      vinha lendo como sintoma de bug de bundle/tamanho de arquivo — daí
      as duas rodadas anteriores terem mexido no lugar errado.
      Correções:
      1. `KitArmorRules` ganhou um `init(from decoder:)` escrito à mão que
         trata `allowedTypes`/`shieldsAllowed` ausentes como `.asClass`
         (mesma leitura que a sentinela `"as_class"` já tinha) em vez de
         estourar erro — e o memberwise init voltou a ser escrito à mão
         junto, já que um `init(from:)` customizado tira o sintetizado
         automaticamente.
      2. Rodada de auditoria final confirmando ZERO outras chaves
         obrigatórias ausentes em qualquer lugar do dataset (todos os 97
         kits, todos os campos não-opcionais do modelo) — não sobrou
         nenhum outro `keyNotFound` latente esperando pra acontecer.
      3. Decisão arquitetural (cinto e suspensório): eliminado o caminho
         de runtime JSON→Bundle→`Data`→`JSONDecoder` pra Kits por
         completo, gerando `Store/EmbeddedKits.swift` — os 97 kits como
         literais Swift de verdade (`Kit(...)` direto no código), mesmo
         padrão já comprovado nesse projeto pra `spells.json` de exemplo
         (`EmbeddedSampleSpells.swift`, ver histórico acima). Gerado via
         script Python a partir do JSON já corrigido, validado
         estruturalmente (chaves/parênteses/colchetes balanceados após
         remover todos os literais de string válidos, 97 chamadas
         `Kit(...)` confirmadas). `priestKit1/2/3.json` removidos de
         `Resources/` — não existe mais NENHUM JSON de kit no bundle, e
         `KitDatabase.init()` agora só faz
         `kits = EmbeddedKits.kits.sorted { $0.name < $1.name }`, sem
         `Bundle`/`FileManager`/`JSONDecoder` envolvidos.
      Resultado esperado: o bug não deveria mais existir de forma nenhuma,
      já que a causa raiz (chave ausente) foi corrigida E o mecanismo que
      exibia o erro (decode de bundle) foi removido do caminho de
      carregamento dos Kits.
- [x] **4ª rodada (v0.85 → v0.86) — "Build Failed" sem nenhuma mensagem de
      erro no Playgrounds.** O v0.85 (`EmbeddedKits.swift` como um array
      literal único `static let kits: [Kit] = [ Kit(...), Kit(...), ... ]`
      com 97 elementos, cada um profundamente aninhado — vários structs
      dentro de structs, arrays, dicionário) nunca chegou a rodar: o
      Playgrounds reportou apenas "Build Failed", sem detalhe de linha nem
      mensagem — mesmo reiniciando e limpando dados. Isso bate com um
      problema clássico e bem documentado do type-checker do Swift: um
      array literal grande o bastante, com elementos de tipo complexo
      inferido em vez de anotado, faz o compilador tentar checar a
      expressão inteira de uma vez só, e ela pode literalmente nunca
      terminar (o erro usual em Xcode é "the compiler is unable to
      type-check this expression in reasonable time" — mas o Playgrounds
      às vezes só mostra "Build Failed" genérico quando isso acontece,
      sem apontar onde). Não tem nada de errado com os DADOS aqui — a
      sintaxe, os nomes de campo e a ordem dos argumentos de cada
      `Kit(...)` já tinham sido conferidos um a um antes de entregar o
      v0.85 e continuam corretos; o problema é só o tamanho/complexidade
      da ÚNICA expressão de array.
      Correção: `EmbeddedKits.swift` dividido em `EmbeddedKits.swift`
      (só o `enum EmbeddedKits { static let kits: [Kit] = [...] }`,
      agora referenciando 97 CONSTANTES já prontas, não construindo os
      kits ali dentro) + 5 arquivos novos `EmbeddedKits_Part1.swift` a
      `EmbeddedKits_Part5.swift` (~20 kits cada), cada um com constantes
      soltas tipo `let embeddedKit000: Kit = Kit(...)` — tipo EXPLÍCITO
      (`: Kit`) em cada uma. Isso faz o compilador checar cada
      `Kit(...)` isoladamente e rápido (tipo já conhecido, sem inferir
      nada), e o array final em `EmbeddedKits.kits` vira só uma lista de
      97 nomes de constante já tipada — trivial de checar, não uma
      expressão aninhada gigante. Gerado programaticamente a partir do
      v0.85 (extraindo cada bloco `Kit(...)` balanceado e redistribuindo),
      revalidado sintaticamente arquivo por arquivo (aspas/parênteses/
      colchetes balanceados, nenhuma string com quebra de linha crua) e
      conferido que as 97 constantes existem e são todas referenciadas
      no array final.
- [x] **Confirmado pelo usuário: o build funcionou (v0.86).** Primeira
      confirmação real de que a base de Kits carrega e as duas telas
      (Compendium e seletor da ficha) mostram dado de verdade.
- [x] **5ª rodada (v0.86 → v0.87) — três ajustes de qualidade reportados
      depois do primeiro teste real:**
      1. **Texto `__NOTOC__` aparecendo na UI.** É marcação de MediaWiki
         (diretiva "não gerar tabela de conteúdo" da página de origem) que
         tinha vazado pro campo `briefSummary` de praticamente todo kit —
         o `briefSummary` original vinha de um recorte cru do wikitexto
         (`__NOTOC__\n==Título==\nprimeiro parágrafo...` pros kits
         genéricos, ou o início da tabela de estatísticas cortada no meio
         — `{| class="article-table"\n!` — pros 55 kits de sacerdote
         especializado que abrem com uma tabela). `fullText` já vinha
         limpo (é de onde vem o texto da tela de detalhe), então a
         correção foi regenerar `briefSummary` a partir do primeiro
         parágrafo de verdade de `fullText` pra todo kit — removendo
         qualquer tabela/cabeçalho markdown residual do início e
         cortando num limite de frase (~320 caracteres) — em vez de
         tentar remendar o recorte antigo.
      2. **6 kits "Create Your Own" removidos** (`create_your_own`,
         `create_your_own_472`, `create_your_own_283`,
         `create_your_own_284`, `create_your_own_priest`,
         `create_your_own_priest_2`) — são cartas em branco de um dos
         card sets, sem regra nenhuma: a "descrição" é só fragmentos de
         HTML de layout de carta (`<div style="...">`, campos tipo
         "NAME:<br>CLASS/LEVEL:<br>..."). Não servem pra nada num app que
         já tem ficha de personagem própria — só poluíam a lista. Base
         passou de 97 pra 91 kits.
      3. **Seletor de Kit na ficha não filtrava por classe.**
         `KitPickerSheet.filtered` usava `kitDatabase.kits` direto (a
         base inteira, sem filtro nenhum) em vez de
         `kitDatabase.kits(allowedFor:)`, que já existia mas nunca tinha
         sido chamado com um valor de verdade em lugar nenhum da UI —
         escolher qualquer classe sempre mostrava os 91 kits. Corrigido
         em duas pontas: `KitPickerSheet` ganhou um parâmetro
         `className: String?` que filtra a lista, e `KitField`
         (`CharacterSheetView.swift`) passa
         `character.characterClass.rawValue` pra ele. Also corrigido um
         detalhe de regra: os 57 kits de sacerdote especializado só têm
         `"Specialty Priest"` em `allowedClasses` (é como o dado de
         origem descreve o grupo), mas o app não tem uma classe separada
         "Specialty Priest" — um sacerdote especializado é jogado como
         Cleric. Sem tratar esse caso, filtrar por "Cleric" escondia
         justamente os 57 kits de divindade. `KitDatabase.kits(allowedFor:)`
         agora trata "Specialty Priest" como incluído sempre que a classe
         pedida for "Cleric". Pra classes sem kit nenhum (Fighter, Mage,
         Thief etc.), o seletor mostra uma mensagem específica em vez do
         "no results" genérico de busca.
      `EmbeddedKits_Part1..5.swift` regenerados do zero a partir do JSON
      corrigido (mesmo gerador Python, agora com o `briefSummary`
      derivado e os 6 kits filtrados antes de gerar), revalidados do
      mesmo jeito que a rodada anterior (sintaxe balanceada por arquivo,
      ordem de argumento por struct conferida programaticamente contra a
      ordem de declaração — 0 problemas nos 91 kits × 10 tipos de
      struct).
- [ ] **Sem simulador neste ambiente** pra confirmar de verdade — sintaxe e
      ordem de argumento já conferidos programaticamente (0 problemas),
      mas falta o usuário confirmar no Playgrounds que: (a) o Compendium
      não mostra mais `__NOTOC__` nem tabela cortada em nenhum resumo, (b)
      os 6 kits "Create Your Own" sumiram da lista, e (c) trocar a classe
      na ficha realmente filtra o seletor de Kit (Cleric mostra os
      genéricos de Cleric + os 57 de divindade; Druid mostra só os de
      Druid + "Any Priest"; uma classe não-sacerdote mostra a mensagem de
      "sem kit pra essa classe").

## 10. Base de Regras (PHB + DMG) — Rules Reference + atalhos "?" (2026-09-19)

- [x] **Dado de origem: extração de 274 regras / 200 tabelas do Player's
      Handbook e do Dungeon Master's Guide**, entregue pelo usuário numa
      pasta local (`rules_phb/`, 15 arquivos, `rules_dmg/`, 16 arquivos —
      um JSON por capítulo, cada um um array de entradas
      `{id, book, chapter, breadcrumbs, topic, ruleType, summary, content,
      tables, crossReferences, examples, searchKeywords}`). Auditado antes
      de usar: 2 tabelas (Table 10 "Average Height and Weight", Table 34
      "Proficiency Slots") tinham nomes de coluna duplicados que colidiam
      como chave de dicionário e apagavam metade do dado (Male/Female,
      Weapon/Nonweapon) — corrigido reconstruindo `headers`/`rows` a
      partir do `markdown` de fallback com nomes desambiguados. 4 trechos
      de `content` com wikitexto solto (`'''` sem fechar,
      `[[Página|Texto]]` sem `]]`) corrigidos manualmente. 111 das 120
      tabelas com cabeçalho genérico "Col N" precisaram do livro original
      pra recuperar o nome de verdade — especificadas num documento à
      parte (`rules_generic_headers_TODO.md`) pro agente com acesso ao
      texto original preencher, depois validadas de novo (0 problemas em
      9 checagens automatizadas: ids duplicados, linha/cabeçalho
      descasados, `rowCount` inconsistente, "Col N" residual em
      `headers`/`markdown`, marcação de wiki solta, contagem batendo com
      `index.json`, célula nula, tabela vazia).
- [x] **`Models/Rule.swift`** — `RuleEntry`/`RuleTable`, mesmo espírito de
      `Kit.swift`: sem `Codable` de bundle nenhum (não faz sentido aqui —
      o dado nunca é decodificado em runtime, só existe como literal
      Swift compilado). `RuleTable.rows` é `[[String]]` posicional (não
      dicionário) — decisão deliberada pra não reabrir a mesma classe de
      bug de coluna duplicada que já mordeu o dataset duas vezes; todo
      valor de célula (a extração original mistura `str`/`int`/`float`)
      já sai formatado como String no gerador.
- [x] **`Store/EmbeddedRules_Part1..20.swift` + `EmbeddedRules.swift`** —
      mesma técnica de `EmbeddedKits_PartN.swift`: as 274 entradas viram
      constantes top-level individualmente tipadas (`let embeddedRule0000:
      RuleEntry = RuleEntry(...)`, ~14 por arquivo), o array final só
      lista os nomes já tipados. Gerado por um script Python a partir dos
      31 JSONs corrigidos (staged da pasta local pro workspace de nuvem,
      onde o projeto `.swiftpm` de fato vive), revalidado sintaticamente
      (274 declarações × 274 fechamentos batendo, arquivo por arquivo).
- [x] **`Store/RulesDatabase.swift`** — `ObservableObject` no mesmo
      padrão de `SpellDatabase`/`KitDatabase`: `entries` vem direto de
      `EmbeddedRules.entries` (sempre carrega, `loadError` fica `nil` —
      mantido só pra bater com o padrão das outras bases). Busca
      aproximada (`matches(for:limit:minimumScore:book:)`) usa
      `Fuzzy.normalize`/`Fuzzy.similarity` contra `topic` e
      `searchKeywords` (não contra `content` — prosa longa combina com
      quase tudo e vira ruído), com os passos separados em vez de uma
      cadeia `map/filter/sorted` única — mesmo cuidado documentado em
      `SpellDatabase.matches` pra não estourar o tempo do type-checker.
- [x] **`Views/RulesCompendiumView.swift`** — tela de consulta, mesmo
      espírito do `KitCompendiumView`: busca por texto ou navegação
      agrupada por capítulo (ordem do próprio livro, não alfabética), com
      um filtro PHB/DMG/os dois (a DMG tem conteúdo voltado pro Mestre —
      recompensas, criação de item mágico — junto com regra de jogador;
      o filtro deixa esconder sem precisar decidir um "modo DM" à parte,
      que não fazia parte do escopo pedido). Detalhe de uma regra
      (`RuleDetailSheet`) renderiza `content` em blocos
      (`RuleContentParser`/`RuleContentBlock`) — parágrafo, `##`/`###`
      viram subtítulo, lista com `* `/`:* ` vira lista de verdade, e
      `[TABLE_REF: Table N: Título]` resolve pra tabela de verdade
      (`RuleTableView`, grid rolável na horizontal) em vez de continuar
      como texto solto — os `[TABLE_REF: ...]` batem 100% com uma tabela
      da mesma entrada (auditado, 0 referência solta no corpus inteiro).
- [x] **Ponta a ponta** — `RulesDatabase` entra em `App.swift`
      (`@StateObject` + `.environmentObject`, igual `kits`/`spellbook`) e
      `CompendiumHubView.swift` ganha um terceiro cartão "Rules Reference"
      ao lado de Priest Grimoire/Priest Kits (mesmo padrão de
      `NavigationLink` + tela-moldura `RulesCompendiumScreen`). Corrigido
      de passagem: o cartão de Priest Kits ainda dizia "97 kits" — ficou
      pra trás quando a base caiu pra 91 no item 9; agora diz "91 kits".
- [x] **Atalho "?" na ficha** (`RuleLinkButton`) — botão redondo pequeno
      que abre a regra certa direto, sem passar pelo Compendium; some
      sozinho se o `id` não bater com nada na base (mais seguro que abrir
      uma sheet vazia). Ligado em quatro pontos: THAC0
      (`phb_ch09_calculating_thac0`, ao lado do campo — não usa
      `FormSectionTitle`), Proficiencies (`phb_ch05_proficiencies`),
      Saving Throws (`phb_ch09_the_saving_throw`) e Encumbrance
      (`phb_ch06_encumbrance`). `FormSectionTitle` ganhou um parâmetro
      opcional `ruleID` que já cuida do botão colado na borda direita do
      título pros três últimos.
- [ ] **Sem simulador neste ambiente** pra confirmar de verdade — sintaxe
      revalidada programaticamente (0 problemas), mas falta o usuário
      confirmar no Playgrounds que: (a) o build passa com as 274 regras
      embutidas (maior volume de literal já testado no projeto — se
      houver timeout de type-checker, os arquivos-parte já estão bem
      menores que o gatilho original dos Kits, mas vale conferir), (b) a
      tela "Rules Reference" no Compendium busca e navega direito, (c)
      as tabelas renderizam legíveis (inclusive rolando na horizontal
      quando tem muita coluna), e (d) os quatro atalhos "?" na ficha
      (THAC0, Proficiencies, Saving Throws, Encumbrance) abrem a regra
      certa.
- [x] **Ajuste reportado após o primeiro teste real: fundo da linha de
      cabeçalho das tabelas "picado".** O `.background(Paper.ink)` estava
      aplicado no `GridRow` inteiro, mas um `Grid` do SwiftUI dimensiona
      cada célula pelo próprio conteúdo — o fundo escuro só cobria atrás
      de cada palavra do cabeçalho, deixando os espaços entre colunas (e
      as bordas) claros e picotados (ver print do usuário: "Paralyzation,
      Poison, or Death Magic" com fundo escuro só atrás das letras).
      Corrigido em `RuleTableView` (`Views/RulesCompendiumView.swift`):
      `horizontalSpacing`/`verticalSpacing` do `Grid` zerados, e cada
      célula (cabeçalho e dado) agora pinta o próprio fundo com
      `padding` + `frame(maxWidth: .infinity)` em vez de confiar no
      `GridRow` — células vizinhas encostadas formam uma barra contínua
      de verdade, sem gap claro entre elas.

## 11. Motor de Regras + Motor de Consequências (2026-09-19)

- [x] **A ideia, resumida**: o jogador sobe de nível ou muda um atributo
      na ficha e recebe um sinal discreto ("•" vermelho perto do campo de
      Nível); tocando nele abre uma janela mostrando tudo que muda pra
      esse personagem (THAC0, saving throws, slots de magia de sacerdote),
      cada linha com "antes → depois", um botão "ver regra" que abre a
      tabela de verdade (reaproveitando a Referência de Regras/item 10), e
      um botão pra aplicar de uma vez só as mudanças que não dependem de
      dado (THAC0 e saves são determinísticos pela tabela; HP fica de fora
      desta rodada por depender de rolagem).
- [x] **Arquitetura pedida explicitamente pelo usuário antes de
      implementar**: nada de conta de jogo espalhada/duplicada pela UI, e
      já preparado pra suplementos futuros (Dark Sun, Ravenloft) poderem
      adicionar ou SOBRESCREVER uma regra sem mexer no que já existe.
      Ficou em 4 camadas:
      1. **Referência** (`RulesDatabase`/`RuleEntry`, já existia do item
         10) — o texto/tabela pra ler.
      2. **Motor de regras** (`Models/RuleEngine/`, `Store/RuleEngine/`) —
         `RuleProvider`: protocolo com uma `key` lógica estável (ex.
         "thac0"), uma função que calcula o valor a partir de um
         `RuleContext` (retrato mínimo do personagem: nível, classe,
         atributos — não o `PlayerCharacter` inteiro, de propósito, pra
         não acoplar o motor a todo campo novo que a ficha ganhar), e o
         id da `RuleEntry` que documenta a conta.
      3. **Registro de módulos** (`RulesetRegistry`) — módulos ativos em
         ordem de prioridade; resolve uma `key` perguntando a cada módulo
         até um responder. Hoje só existe `CoreRuleset` (PHB/DMG), sempre
         por último (é o piso). Um suplemento futuro só precisa registrar
         provider pras `key`s que ele muda — o resto cai pro Core
         automaticamente, sem duplicar nada.
      4. **Motor de Consequências** (`ConsequenceEngine`) — compara um
         `RuleContext` "antes" com um "agora" perguntando ao
         `RulesetRegistry`, sem saber nada de módulo nenhum: continua
         funcionando sozinho no dia em que um suplemento mudar a resposta
         de "thac0".
- [x] **Providers do Core nesta rodada** — só 3, todos com dado extraído
      do MESMO corpus já auditado do item 10 (não digitado de memória):
      `Thac0ByLevelProvider` (Tabela 53, THAC0 por grupo/nível 1–20),
      `SavingThrowsByLevelProvider` (Tabela 60, as 5 jogadas por
      grupo/faixa de nível), e `PriestSpellSlotsProvider` — que não
      reimplementa nada, só embrulha `PriestTables.spellProgression`
      (Tabela 24) que já existia e já alimenta a folha de magia do
      Clérigo; prova que o motor também acomoda lógica que já existia no
      projeto, não só regra nova. Fighter/Paladin/Ranger agrupam como
      "Warrior", Mage como "Wizard", Cleric/Druid como "Priest",
      Thief/Bard como "Rogue" — o agrupamento padrão do livro
      (`CoreClassGroup`), compartilhado pelos dois providers que precisam
      dele.
- [x] **`ConsequenceItem`** — uma linha da janela: rótulo, valor antigo,
      valor novo, id de regra (pro botão "ver regra"), e um `kind`:
      `.autoApplicable` (ganha botão de aplicar) ou `.alreadyAutomatic`
      (caso dos slots de magia — já é um `computed var` na ficha, não tem
      o que aplicar, só é informativo).
- [x] **Snapshot no personagem** — `PlayerCharacter.lastAppliedLevel`/
      `lastAppliedAbilities` (Optional, mesmo motivo de sempre: fichas
      salvas antes desta versão não têm essas chaves) guardam o retrato
      da última revisão. `ensureConsequenceSnapshotInitialized()` roda no
      `.onAppear` da ficha e só preenche se ainda for `nil` — não marca
      nada como mudança pra fichas já existentes, só a partir daí uma
      mudança de nível/atributo liga o sinal. `markConsequencesReviewed()`
      "zera" o sinal depois que o jogador aplica ou fecha tendo revisado.
- [x] **UI** — `ConsequenceSignalBadge` (o "•") colado no campo de Nível
      do cabeçalho da ficha (`RecordHeaderForm`); `ConsequencePreviewSheet`
      é a janela, no mesmo visual de pergaminho das outras sheets do app,
      com "ver regra" abrindo o `RuleDetailSheet` já existente (mesmo
      componente do atalho "?" do item 10 — zero duplicação de UI de
      regra) e um botão "Apply automatic changes" que chama
      `ConsequenceEngine.applyAutomatic` e depois
      `markConsequencesReviewed()`.
- [x] **Fora de escopo nesta rodada, de propósito** — ~~ajuste de
      atributo (Força/Destreza/etc.) ainda não tem provider~~ fechado no
      item 12; HP por nível continua pedindo dado, então não entra no
      "aplicar automático" sem um terceiro `Kind` novo pro motor; o
      `RulesetRegistry` ainda só tem o Core — Dark Sun/Ravenloft entram
      quando os dados chegarem, só implementando `RulesetModule` novo.
- [ ] **Sem simulador neste ambiente** pra confirmar de verdade — sintaxe
      revalidada programaticamente (0 problemas), mas falta o usuário
      confirmar no Playgrounds que: (a) o sinal "•" aparece só depois de
      mudar nível ou atributo (não em toda ficha já existente ao abrir),
      (b) os números de THAC0/saving throw calculados batem com o que o
      livro diz pro nível/classe testado, e (c) "Apply automatic changes"
      realmente grava os novos valores na ficha e apaga o sinal.

## 12. Consequências: ajuste de atributo + investigação do slot de clérigo (2026-09-19)

Retomando o feedback do usuário depois de testar o item 11 no dispositivo:
"Na mudança de nível ele funcionou [...] embora esteja ainda limitado (não
fala por exemplo do aumento de slots de magia de clérigo). Já na mudança de
atributos ele não indicou nenhuma mudança." — dois problemas separados.

- [x] **Investigação do slot de clérigo "sumido"** — confirmado com o
      usuário que o personagem testado era Clérigo. Revisão estática
      completa de `PriestSpellSlotsProvider`/`ConsequenceEngine`/
      `RulesetRegistry.resolve` (inclusive conferindo que toda linha
      adjacente de `PriestTables.spellProgressionRows`, níveis 1 a 20, é
      diferente da anterior, então qualquer subida de nível nesse
      intervalo tem que gerar diff) NÃO encontrou bug de lógica. O que a
      revisão achou: `RuleValue.displaySummary` pro caso `.intByCircle`
      saía em português ("1× círc. 1") numa janela cujo resto do texto é
      todo em inglês ("What Changes", "Apply automatic changes" etc.) — e
      o rótulo "Priest Spell Progression" não deixa óbvio que a linha é
      sobre GANHAR slots. Corrigido os dois (resumo em inglês, rótulo
      virou "Priest Spell Slots per Level"). **Honestidade**: não dá pra
      garantir que essa era a causa raiz sem o usuário testar de novo — se
      o sinal continuar não aparecendo pra um Clérigo depois desta
      correção de texto, é preciso descrever exatamente o que aparece (ou
      não aparece) na janela pra investigar mais fundo.
- [x] **Seis providers de atributo** — `AbilityDetailProvider` (struct
      genérica, uma só, em vez de ~22 tipos quase idênticos) parametrizada
      por `key`/`label`/`ruleID`/`lookup`; 22 instâncias em
      `AbilityDetailProviders.all` (Força ×6, Destreza ×3, Constituição
      ×4, Inteligência ×4, Sabedoria ×2, Carisma ×3), cada uma lendo uma
      célula de `AbilityTables.swift` (seis `enum`s gerados por script
      Python a partir do mesmo JSON auditado da Referência de Regras —
      `rules_phb/ch01_ability_scores.json`, Tabelas 1-6 — não digitados de
      memória) e devolvendo `.string(...)`. Força tem tratamento especial
      pra 18 excepcional (`StrengthTable.row(score:exceptionalPercentile:)`,
      espelha `AbilityScores.strengthDisplay`).
- [x] **`RuleValue.string(String)`** — novo case (com `stringValue`) pros
      resultados de texto livre, ao lado de `.int`/`.intByCircle`/
      `.savingThrows`.
- [x] **`ConsequenceEngine` grava direto em `AbilityDetails`** — as 22
      regras de atributo são `.autoApplicable`; "Apply automatic changes"
      agora também copia o texto calculado pros campos de
      `PlayerCharacter.details` (`strengthHit`, `dexterityReaction`,
      `constitutionHP` etc.) — os mesmos campos que a seção "o que o app
      sabe calcular" da ficha já lia manualmente.
- [x] **Sabedoria: bônus de magia por círculo** — resolvido no item 17
      (2026-09-20): o campo cru da Tabela 5 ("1st", "1st, 3rd", ...) virou
      soma cumulativa por círculo no formato que `wisdomBonusSpells` já
      esperava. Ver item 17 pro algoritmo.
- [x] **Confirmado pelo usuário** — "Boa! Funcionou!": mudar atributo
      acende o sinal e a janela lista os campos certos.

## 13. Dois ajustes de uso reportados depois do item 12 (2026-09-19)

- [x] **Bug: escrever no campo Nível ia parar no Character Name** — causa
      é o mesmo problema já documentado (e já mitigado nos contadores de
      traço) em `HandwritingField.swift`: um campo em foco anuncia ao
      iPadOS uma área de captura de Scribble maior que ele mesmo, então um
      traço feito dentro do balão de edição do Nível — se o campo
      Character Name (sempre em foco na página, fora de balão) ainda
      estivesse com o foco — era entregue a ele, não ao balão novo. A
      correção dos contadores (`resignPencilFocus()`) nunca tinha sido
      aplicada aos balões de `EditableNumber`/`EditableText` (Nível,
      Raça, Alinhamento etc.) — feito agora: os dois chamam
      `resignPencilFocus()` antes de abrir o balão.
- [x] **Sinal de consequências pequeno demais pra acertar** — trocado o
      "•" de 22pt por um ícone flutuante de verdade: círculo com
      degradê/varinha (`wand.and.stars`), moldura de 44×44pt de área de
      toque (mínimo recomendado pela Apple — bem maior que o desenho
      visível de 26pt), sombra e uma entrada com leve "bounce" só no
      instante em que o sinal aparece.
- [x] **Confirmado pelo usuário, parcialmente** — "O botão novo ficou
      bom!" (item do ícone, confirmado) "mas o problema da escrita nos
      campos de nível e Class/Kit continua" — o `resignPencilFocus()`
      dentro do Button de `EditableNumber` NÃO resolveu. Investigado a
      fundo no item 14.

## 14. Foco da caneta: por que o `resignPencilFocus()` no Button não bastou (2026-09-19)

Nenhum dos três controles da linha "Class / Kit" + "Level" é campo de
escrita — Classe é `Menu`, Kit abre uma sheet de escolha, Nível abre um
balão numérico só depois de TOCAR o número. A hipótese revisada: o
`resignPencilFocus()` que o item 13 colocou dentro da ação do `Button`
só roda depois que o SwiftUI reconhece o toque como um TAP — mas quando
o Character Name (bem acima, sempre em foco enquanto o usuário não
aperta "done"/Return depois de escrever o nome) ainda está com o foco, o
próprio Scribble pode interceptar o toque de caneta ANTES disso,
interpretando-o como escrita pro campo que já está em foco — e nesse
caso o `Button` nunca chega a dar o tap, então o `resignPencilFocus()`
lá dentro nunca roda. É o mesmo raciocínio já documentado pros
contadores de traço (`TallyInput`/`resignPencilFocus()` em
`HandwritingField.swift`), só que aqui o alvo é uma ÁREA inteira, não um
campo só.

- [x] **`simultaneousGesture` na LINHA, não no botão** — `HStack`
      "Class / Kit" + "Level" e `HStack` "Race" + "Alignment" (ambas
      abrigam controle(s) que abrem balão/menu/sheet e ficam perto do
      Character Name) ganharam
      `.simultaneousGesture(DragGesture(minimumDistance: 0).onChanged {
      resignPencilFocus() })` — dispara no instante do toque, correndo
      ao lado do gesto de cada controle (Menu, Button, popover) sem
      cancelar nem atrasar nenhum deles, então larga o foco do Character
      Name ANTES do Scribble ter chance de reivindicar o toque, em vez
      de depois que o tap já teria (ou não) acontecido.
      "Patron Deity / Religion" / "Place of Origin" ficaram de fora de
      propósito — são `InlineTextField` (escrita direta na página, sem
      balão), não sofrem o mesmo problema de "toque nunca vira tap".
- [x] **Não resolveu** — "Ainda não resolveu. Veja como está nas outras
      fichas." Apontou pro caminho certo: a Ficha de Magias
      (`SpellSheetView.swift`) já tinha resolvido esse EXATO problema
      antes, num lugar diferente (linha de magia memorizada perto de um
      `HandwritingField` vazio), e o comentário lá em cima de
      `StrikeInteraction` diz a parte que o item 14 tinha errado: "O
      Scribble do iPadOS não precisa de um UITextField em foco pra
      agarrar um traço: ele mira o campo de escrita mais próximo, foco ou
      não". Ou seja, `resignPencilFocus()` (largar o foco de um campo já
      focado) ataca a metade ERRADA do problema — o Scribble nem precisa
      que o Character Name esteja em foco pra tentar escrever nele, só de
      estar perto já basta. Fechado no item 15.

## 15. O fix de verdade: `ScribbleGuard` (2026-09-19)

Replicando a técnica que já funciona na Ficha de Magias
(`StrikeInteraction`)/nos contadores (`TallyInput`) — uma
`UIScribbleInteraction` de verdade recusando começar ali, não só largar
foco.

- [x] **`ScribbleGuard`** (`HandwritingField.swift`) — um
      `UIViewRepresentable` bem mais simples que `StrikeInteraction`/
      `TallyInput`: só registra a `UIScribbleInteraction` recusando
      `shouldBeginAt` (sempre `false`), SEM nenhum `UIGestureRecognizer`
      próprio — assim ele nunca ganha o toque no hit-test contra o
      Menu/botão de verdade que está na frente dele. Usado via
      `.background(ScribbleGuard())` (atrás, não na frente) nas duas
      linhas afetadas — "Class / Kit" + "Level" e "Race" + "Alignment" —
      ao lado do `.simultaneousGesture(resignPencilFocus())` do item 14
      (mantido de reforço, pro caso de algum campo já estar em foco).
- [x] **Confirmado pelo usuário** — "Deu certo! Obrigado!!"

## 16. Esferas de acesso (2026-09-20)

Item 4 do TODO, finalmente atacado — "esferas de acesso" (que esferas de
magia de clérigo um personagem pode conjurar) só existiam como campo
`spheres` de texto livre em cada magia, sem nada no personagem pra
comparar. Duas decisões do usuário guiaram tudo: **"Os dois: kit sugere,
jogador ajusta"** (o kit nunca decide sozinho) e **"Só sinalizar/ordenar
(Recomendado)"** (nunca bloquear a escolha de uma magia).

- [x] **Limpeza de dados primeiro** — o campo `spheres` do corpus de 1.795
      magias tinha 49 rótulos distintos, vários claramente o mesmo valor
      escrito diferente (`Elemental—Air` vs `Elemental Air`, `Ward` vs
      `Wards`, `Necromancy` vs `Necromantic`, etc.). Pesquisado online
      antes de decidir o que é ruído de verdade — fontes: [Spheres of
      Access (POSM) — AD&D 2e
      Wiki](https://adnd2e.fandom.com/wiki/Spheres_of_Access_(POSM)),
      [Sphere — Forgotten Realms
      Wiki](https://forgottenrealms.fandom.com/wiki/Sphere), [Big Ball of
      No Fun — Dark Sun: Earth, Air, Fire, and
      Water](http://bigballofnofun.blogspot.com/2010/12/dark-sun-earth-air-fire-and-water.html).
      Confirmou que "Elemental Magma"/"Elemental Sun"/"Silt" são esferas
      PARAELEMENTAIS reais de Dark Sun (toda magia com esse rótulo tem
      `setting: "Dark Sun"`), não erro de digitação — quase normalizadas
      embora por engano. Normalização aplicada direto nos 7 JSON do
      bundle afetados (`Resources/priest_*.json`): 49 → 38 rótulos
      distintos, 1.795 magias antes e depois (contagem conferida).
      Deixado de propósito sem mexer: `Elemental Lightning`, `Learning`,
      `Plane`, `Alteration`, `Unknown`, `Elemental All` — nenhum tinha
      fonte clara o bastante pra normalizar com segurança.
- [x] **`PriestSphereCatalog.swift`** (`Store/`) — lista canônica: 16
      esferas maiores do PHB, 4 subesferas elementais, 8 menores do Tome
      of Magic + Cosmos (Player's Option: Spells & Magic), 3
      paraelementais de Dark Sun. Agrupada em `PriestSphereGroup` pra
      exibir em seções em vez de uma lista só de ~32 itens.
- [x] **`PlayerCharacter.sphereAccess`** (`Models/Character.swift`) —
      `[String: SphereAccessLevel]?`, `nil` até o jogador mexer pela
      primeira vez. `SphereAccessLevel` é só `.major`/`.minor` (regra do
      PHB: maior conjura até o nível máximo do personagem na esfera,
      menor trava no 3º círculo). `hasConfiguredSphereAccess` e
      `hasSphereAccess(to:)` são os dois pontos que o resto do app usa —
      o segundo nunca filtra, só responde "bate com alguma esfera
      marcada?".
- [x] **`KitSphereSuggestions.swift`** (`Store/`) — extração por padrão de
      texto (regex) do texto livre de `specialBenefits`/
      `specialHindrances` de cada kit ("cannot cast spells from the X, Y
      spheres", "gains access to the X sphere"), só pra frases claras o
      bastante pra não arriscar erro. Cobre 19 dos 91 kits de sacerdote —
      o resto não menciona esfera no texto ou a frase é ambígua demais
      pra extrair com segurança; esses ficam de fora da sugestão, sem
      tentar adivinhar (mesmo princípio de "não inventar dado de regra"
      já seguido no resto do app). Kit nunca aplica sozinho — só alimenta
      o botão "Apply suggestion" do editor, que o jogador decide usar ou
      não.
- [x] **`SphereAccessEditorSheet.swift`** (`Views/`) — tela nova: lista as
      esferas por grupo, cada uma com três botões (—/Minor/Major), mais
      um banner "Suggested from kit" quando o kit atual do personagem
      (`character.kit`, casado por NOME contra `KitDatabase` pra achar o
      `id` que `KitSphereSuggestions` usa) tem sugestão — mostra o que
      seria negado/concedido e só aplica com um toque explícito em "Apply
      suggestion". Aberta pelo botão "Spheres" novo no cabeçalho da FICHA
      DE PERSONAGEM (`CharacterSheetView.swift`, linha de "Class / Kit"),
      não na Folha de Magias — esfera de acesso é um traço do personagem
      (como Kit/Classe/Raça), não algo do dia de jogo, então mora junto do
      registro permanente. Só aparece pra classe com folha de magias
      (`CharacterClass.hasSpellSheet`, hoje só Cleric). A Folha de Magias
      só LÊ `character.sphereAccess` pro sinal/ordem abaixo — não tem mais
      editor próprio (tinha no rascunho inicial deste item; corrigido
      antes de qualquer usuário ver, a pedido de "o correto não seria...").
- [x] **Sinal/ordem nos candidatos** — `SlotEditorSheet.levelList` (lista
      completa por círculo) e `MemorizedRow.candidates` (sugestões da
      caneta) ganharam um critério de ordenação A MAIS (magia que bate
      com esfera configurada primeiro) e `SpellPaperRow`/`SuggestionLine`
      ganharam um aviso opcional — só quando `hasConfiguredSphereAccess`
      é `true`. Personagem que nunca abriu o editor de esferas (a maioria
      das fichas hoje) não tem NENHUMA mudança de comportamento: a
      ordenação por favorito/uso/alfabética de sempre continua idêntica,
      sem nenhum aviso na tela.
- [x] **Retoque (2026-09-20, pedido do usuário) — aviso invisível na
      prática + regra maior/menor faltando** — usuário testou a v0.95 com
      esferas marcadas e não viu NENHUM marcador na tela de escolha de
      magias. Duas causas, as duas corrigidas juntas:
      1. **Marcador fraco demais pra notar** — era texto itálico 11pt a
         75% de opacidade, espremido entre o nome da magia e o horário de
         conjuração, no meio de uma lista de até ~300 magias por círculo —
         fácil de rolar por cima sem perceber. Virou `SphereBadge`: uma
         pílula com fundo sólido, numa linha PRÓPRIA (não mais dividindo
         espaço com o nome), do mesmo padrão visual que o "log" de
         `SuggestionLine` já usa — impossível de confundir com o resto do
         texto da linha agora.
      2. **Regra incompleta** — só checava "a esfera está marcada, sim ou
         não", ignorando MAIOR vs MENOR. Pela regra do PHB, acesso MENOR
         trava no 3º círculo — uma magia de 6º círculo numa esfera só
         MENOR está fora do alcance do personagem mesmo "tendo" a esfera,
         e isso não gerava aviso nenhum antes. Agora `PlayerCharacter
         .sphereSignal(for:)` (`Models/Character.swift`) centraliza a
         regra pras duas listas (evita duas cópias divergindo) e devolve
         um `SphereSignal` de dois casos: `.outsideSpheres` (nenhuma
         esfera da magia está marcada) e `.minorCircleCap` (tem esfera
         marcada, mas só como Minor, e a magia passa do 3º círculo).
         Continua só AVISO — nunca bloqueia a escolha.
- [x] **Retoque 2 (2026-09-20, pedido do usuário) — ordenar por esfera
      MAIOR, não por "tem a esfera"** — `levelList`/`candidates` ordenavam
      só por `hasSphereAccess` (qualquer esfera marcada, maior OU menor,
      contava igual). Virou `hasMajorSphereAccess` (`Models/Character
      .swift`, novo): só esfera marcada como MAIOR sobe a magia pro topo
      da lista — menor não é aposta segura o bastante pra isso, já que
      trava no 3º círculo (mesmo raciocínio do `SphereSignal.minorCircleCap`
      acima). Continua só reordenação — nunca filtra.
- [x] **Retoque 3 (2026-09-20, pedido do usuário) — bolinha da página do
      Clérigo sumida** — `RecordSheetBeadRow` (linha de bolinhas da aba
      Sheet na Ficha de Personagem) e `RecordSheetPagerView` (o pager de
      verdade por trás dela) tinham cada um sua PRÓPRIA conta de quantas
      páginas existem, e as duas contas divergiam: o pager sabia que o
      Clérigo tem 4 páginas fixas (Ficha, Equipment/Movement/Experience,
      Character Description, tabelas de referência do Clérigo), mas a
      linha de bolinhas calculava 3 pro Clérigo e 2 pras outras classes —
      um a menos dos dois lados, e a 4ª página do Clérigo nunca ganhava
      bolinha própria (ficava sempre em "3 marcadores fixos", exatamente o
      que o usuário reportou). Corrigido criando UMA fonte de verdade —
      `CharacterClass.recordSheetPageCount` (`Models/Character.swift`) —
      que as duas views agora leem, em vez de cada uma reimplementar a
      conta separado (é assim que as duas tinham divergido em primeiro
      lugar).
- [x] **Retoque 4 (2026-09-20, print do usuário)** — v0.97 ordenava por
      `hasMajorSphereAccess`, mas AVISAVA (`sphereSignal`) por uma regra
      diferente: uma magia com esfera Menor dentro do 3º círculo não
      mostra aviso nenhum (regra do PHB — menor funciona normal até o 3º),
      mas também não conta como "maior" pra ordenação — ficava no MESMO
      grupo, sem prioridade, que uma magia de fato fora de qualquer
      esfera. Resultado visível no print do usuário: magias SEM aviso
      (Detect Magic, Analyze Balance, Analyze Opponent) apareciam
      espalhadas ANTES E DEPOIS de magias COM aviso "OUTSIDE SPHERES"
      (Light, Sanctuary, Allergy Field), em vez de todas as sem-aviso
      virem primeiro. Corrigido unificando as duas réguas numa só —
      `PlayerCharacter.sphereSortRank(for:)` (`Models/Character.swift`):
      0 = esfera maior batida, 1 = sem aviso nenhum (menor dentro do
      alcance, ou magia sem `spheres` pra comparar), 2 = com aviso — os
      dois critérios (ordem E aviso) agora usam exatamente a mesma fonte,
      não têm mais como divergir de novo.
- [ ] **Sem simulador** — como sempre neste projeto, verificado só por
      leitura de código e balanceamento de chaves/parênteses/colchetes,
      não rodado num iPad de verdade. Vale conferir na prática: o botão
      "Spheres" na Ficha de Personagem só aparece pra classe com folha de
      magias, e o banner de sugestão de kit depende do nome do kit
      bater exatamente com `Kit.name` da base (texto livre digitado à
      mão em fichas antigas não bate).

## 17. Sabedoria — bônus de magia por círculo (2026-09-20)

Item 12 tinha ficado pendente: o campo `wisdomBonusSpells` (usado por
`wisdomBonus(forCircle:)` pra somar slot extra na Folha de Magias) espera
o total acumulado de bônus por círculo (`"+2 / +2 / +1"`), mas o dado bruto
da Tabela 5 (`bonus_spells_priest`) vem como "quais círculos ganham bônus
NESTE patamar de Sabedoria" ("1st", "1st, 3rd", ...), não o total. Usuário
perguntou o porquê do bloqueio, eu expliquei o descasamento de formato e
propus verificar online antes de implementar — resposta: **"É soma
cumulativa mesmo, não precisa pesquisar. Pode fazer o cálculo e siga esta
regra."**

- [x] **`WisdomTable.bonusSpells(forScore:)`** (`Store/RuleEngine/
      CoreRuleset/AbilityTables.swift`) — tabela crua (`bonusSpellsByScore`,
      Sabedoria 1-25, valores confirmados contra
      `rules_phb/ch01_ability_scores.json`) + soma cumulativa. A tabela
      impressa do PHB repete a mesma lista de círculos em pares de score
      adjacente (13/14 → "1st"; 15/16 → "2nd"; ...) — cada par é UM
      patamar do livro, não dois ganhos separados, então a soma só
      incrementa quando a lista de círculos muda em relação ao score
      anterior. Validado contra os fatos conhecidos de Sabedoria 9-18
      antes de aplicar pro resto da tabela (ex.: Sabedoria 16 = "+1 / +1"
      — um bônus no 1º círculo e um no 2º, nunca "+2 / +2").
- [x] **`AbilityDetailProviders.all`** ganhou a entrada `wisdomBonusSpells`
      (removido o comentário que explicava a exclusão) e
      `ConsequenceEngine.trackedRules` ganhou o `abilityRule` correspondente
      — mesmo padrão automático das outras 22 entradas de atributo: ao
      aceitar as mudanças automáticas, o campo já vem preenchido sozinho.
- [ ] **Sem simulador** — validado só por script Python reproduzindo o
      mesmo algoritmo (bate com o Swift pros 25 valores de Sabedoria) e
      balanceamento de chaves/parênteses; falta confirmar no Playgrounds
      que o campo aparece certo na ficha de um Clérigo com Sabedoria alta.

## 18. Proficiências (não-de-arma) + filtro por Campaign Setting (2026-09-20)

Usuário pediu pra melhorar Proficiencies (item 5 de uma rodada anterior só
tratou a duplicação de campo velho, nunca trouxe dados de verdade). Perguntei
se eu já tinha a descrição de todas — não tinha, só a mecânica das Tabelas
34/37/38 embutida no Rules Reference. Usuário conectou uma pasta local
(`E:\dev\thac0berry\tmp-data\proficiencies\`) com um corpus de 372
proficiências (7 arquivos por grupo + índice), já no mesmo formato de
extração de wiki usado pra Kits/Spells (mecânica completa + prosa completa).
Antes de importar, usuário sugeriu também um seletor de campaign settings
(Dark Sun, Ravenloft etc.) por campanha pra filtrar as opções e não poluir
listas — propus um plano em fases e pedi confirmação; usuário voltou tendo
**adicionado ele mesmo** um campo `campaignSettings: [String]` limpo em
cada entrada do JSON de origem e disse: **"Os arquivos de proficiências já
estão atualizados com o Campaing Setting. Valide-os e siga com a
implementação já com o filtro, se entender que é possível."**

- [x] **Validação dos dados** — 372/372 entradas com `campaignSettings`
      preenchido, 0 ids duplicados (entre os 7 arquivos de grupo e o
      índice), 0 campos nulos inesperados fora dos already-nullable
      `skillsAndPowers.subAbility`/`.characterPointCost` (3 e 1 casos,
      respectivamente, de 89 entradas com Skills & Powers preenchido).
      Distribuição de cenário: Core 285, Dark Sun 20, Al-Qadim 18,
      Forgotten Realms 16, Spelljammer 16, Council of Wyrms 13,
      Planescape 7 — só 3 entradas têm 2 cenários, nenhuma tem 3+.
- [x] **`Models/Proficiency.swift`** — `Proficiency`/`ProficiencyMechanics`/
      `ProficiencySkillsAndPowers`/`ProficiencyDescription`, mesmo padrão
      de `Models/Kit.swift`. Deliberadamente SEM `rawWikitext` (não usado
      em lugar nenhum da UI, nem pros Kits — reduz o payload embutido).
- [x] **`Scripts/generate_embedded_proficiencies.py`** + 25 arquivos
      `Store/EmbeddedProficiencies_PartN.swift` (15 entradas cada, exceto
      a última com 12) + `Store/EmbeddedProficiencies.swift` (índice) —
      mesma técnica de literais Swift tipados individualmente de
      Kits/Rules/Spells: NUNCA ler JSON de bundle em runtime (três
      falhas documentadas antes disso: `spells.json`, `priestKits.json`
      duas vezes). `Store/ProficiencyDatabase.swift` (`ObservableObject`,
      busca substring-depois-fuzzy) segue o mesmo padrão de
      `KitDatabase.swift`, injetado em `App.swift`.
- [x] **`Store/CampaignSettingCatalog.swift`** — lista canônica dos 8
      cenários reais (`Al-Qadim`, `Council of Wyrms`, `Dark Sun`,
      `Forgotten Realms`, `Greyhawk`, `Planescape`, `Ravenloft`,
      `Spelljammer`), união do que já existe em `Spell.setting` e no novo
      `Proficiency.campaignSettings`. `isGeneric(_:)` trata "Generic"
      (Spell) e "Core" (Proficiency) como sinônimos de "sem cenário
      específico, sempre visível, nunca filtrado" — os dois datasets
      usam rótulos diferentes pro mesmo conceito, resolvido aqui sem
      reescrever nenhum dos dois.
- [x] **`Campaign.enabledSettings: Set<String>?`** (`Models/Character.
      swift`) — mesmo padrão aditivo/nunca-quebra-nada de `sphereAccess`:
      `nil` ou vazio = sem filtro, mostra tudo (é o estado de qualquer
      campanha nova ou já existente). `allowsSetting(_:)` (valor único,
      pra Spell) e `allowsAnySetting(_:)` (união multi-valor, pra
      Proficiency) fazem a checagem.
- [x] **`Views/ProficiencyCompendiumView.swift`** — tela de consulta
      (agrupada por `primaryGroup`, busca, SEM filtro de cenário — é
      referência, mostra tudo de propósito), `ProficiencyDetailSheet`
      (mecânica completa + prosa + Skills & Powers quando existir), e
      `ProficiencyPickerSheet` (o seletor de verdade, ESTE sim filtrado
      por `campaign.allowsAnySetting(...)` quando a campanha tiver
      `enabledSettings` configurado — com banner avisando quando o
      filtro está ativo). Ao escolher, preenche nome/slots automaticamente
      e sugere o alvo de "Chk" a partir do atributo relevante da
      proficiência (`suggestedTarget(for:)`/`abilityScore(named:)`,
      switch sobre as seis características).
- [x] **Ligado na Ficha de Personagem** — `ProficiencyFormRow`
      (`Views/CharacterSheetView.swift`) segue o MESMO padrão que já existe
      nas Magic Item Spells da Folha de Magias (`ItemSpellRow`/
      `SpellDetailSheet` em `SpellSheetView.swift`): tocar no NOME da
      proficiência abre a descrição completa (`ProficiencyDetailSheet` —
      mecânica + prosa inteira), com um botão "change" lá dentro que fecha
      a descrição e abre o `ProficiencyPickerSheet` pra trocar. Linha ainda
      vazia, ou com um nome digitado à mão que não bate com nada da base,
      abre o seletor direto (não tem descrição nenhuma pra mostrar ainda).
      Pra isso, `ProficiencyEntry` ganhou `matchedProficiencyID: String?`
      (mesmo papel de `ItemSpellUse.matchedSpellID`) — `nil` numa linha
      antiga/digitada à mão, com fallback comparando o nome contra a base
      (`ProficiencyFormRow.matchedProficiency`). `ProficiencyPickerSheet`
      ganhou o mesmo "use \"X\" as-is" do `SpellWritingSheet`, pra
      proficiência caseira que não está (e talvez nunca esteja) nos 372.
      `ProficienciesForm` repassa o mesmo `campaignBinding` que já percorre
      `OfficialRecordSheet` inteira (sessões, notebook) — sem precisar de
      lookup novo nenhum, só ler `campaignBinding?.wrappedValue`.
- [x] **`Views/CampaignSettingsEditorSheet.swift`** — editor multi-seleção
      sobre `CampaignSettingCatalog.all`, aberto pelo novo botão redondo
      "slider.horizontal.3" no cabeçalho de `CampaignDetailView`. Botão
      "clear filter" só aparece quando há algo marcado.
- [x] **`Views/CompendiumHubView.swift`** — novo tile "Proficiencies" (372
      proficiências), mesma moldura `*Screen` dos outros três
      (Spellbook/Kits/Rules).
- [ ] **Sem simulador** — como sempre neste projeto, verificado só por
      leitura de código e balanceamento de chaves/parênteses/colchetes em
      todo arquivo novo/tocado, não rodado num iPad de verdade. Duas
      constantes geradas (`embeddedProficiency2105` em `_Part21.swift` e
      `embeddedProficiency2406`/`veterinary_healing` em `_Part24.swift`)
      dão falso-positivo no balanceamento — mesma causa já documentada
      pra `EmbeddedRules_PartN.swift`: parênteses de verdade, ímpares,
      dentro da PROSA (`fullText`), não erro de sintaxe — conferido à
      mão que cada declaração fecha certinho (`)` da string, `)` do
      `ProficiencyDescription`, `)` do `Proficiency`). Vale conferir na
      prática: o botão de abrir o seletor na Ficha, o filtro por cenário
      realmente escondendo/mostrando as linhas certas, e o editor de
      Campaign Settings gravando/lendo direito.

### Rodada 2026-09-20 (parte 3) — filtro por ícone no Compendium

Duas coisas pedidas depois de completar as duas rodadas anteriores: (1)
poder consultar a descrição da proficiência a partir da FICHA (feito na
parte 2 — ver acima, mesmo padrão de Magic Item Spells) e (2) um filtro
por campaign setting DENTRO do Compendium de Proficiências (a tela de
consulta livre, sem personagem nenhum envolvido) — "mas sem esses combos
feios de formulário. Use ícones."

- [x] **`CampaignSettingCatalog.icon(for:)`/`.shortLabel(for:)`**
      (`Store/CampaignSettingCatalog.swift`) — um símbolo SF por cenário
      (lua/estrelas pra Al-Qadim, réptil pro Council of Wyrms, sol pro
      Dark Sun, globo pros Forgotten Realms, colunas pro Greyhawk,
      infinito pro Planescape, lua com névoa pro Ravenloft, nave pro
      Spelljammer) + legenda curta pros dois nomes compostos que não
      cabiam inteiros no selinho (`Council of Wyrms` → "Wyrms",
      `Forgotten Realms` → "Realms"). Só strings, sem SwiftUI — mesmo
      espírito Foundation-only do resto do arquivo.
- [x] **`SettingFilterRow`/`SettingFilterChip`**
      (`Views/ProficiencyCompendiumView.swift`) — fileira horizontal de
      selinhos com ícone (sem `Picker`/`Menu`/formulário nenhum): "All"
      (nada marcado, mostra tudo) + um selinho por cenário, preenchido
      quando selecionado. Toque-e-segure mostra o nome completo
      (`actionTooltip`, mesmo tooltip do resto do app) — a legenda embaixo
      do ícone já é curta o bastante pra maioria dos casos. Filtro é
      LOCAL desta tela (`@State selectedSettings`), independente de
      `Campaign.enabledSettings` — não precisa de campanha nenhuma pra
      usar, é só um jeito rápido de folhear "o que existe pra Dark Sun"
      sem sair do Compendium.
- [x] **`matchesSelectedSettings(_:)`** — mesma regra do filtro da ficha:
      Core/Generic nunca some, esteja o filtro ligado ou não; com um ou
      mais cenários marcados, só mostra proficiências que batem com pelo
      menos um deles (união, não interseção). Aplicado tanto na busca por
      substring quanto no fallback fuzzy (que busca na base inteira sem
      saber de cenário — filtrado por cima antes de devolver). Grupos
      recolhidos abrem sozinhos quando o filtro está ativo, mesmo
      comportamento que já existia pra busca por texto.
- [ ] **Sem simulador** — mesma ressalva de sempre; balanceamento de
      chaves/parênteses conferido nos dois arquivos tocados. Vale conferir
      na prática: os selinhos rolando horizontalmente sem cortar, o
      tooltip de toque-e-segure aparecendo no lugar certo, e a legenda
      "Wyrms"/"Realms" legível no tamanho de fonte pequeno.

### Rodada 2026-09-20 (parte 4) — ícones ilustrados de verdade

Usuário mandou 4 imagens PNG (fundo transparente, mesmo estilo dos ícones
já existentes em `Resources/`) sem dizer pra que cada uma era. Em vez de
adivinhar pelo tema visual, perguntei um por um antes de aplicar
(`AskUserQuestion`) — a resposta corrigiu duas das minhas suposições:
o ícone 2 não é uma bússola, é uma cruz (Priest Kits), e o ícone 4
(grimório aberto) não é pro Mage Grimoire, é pro Rules Reference.

- [x] **4 PNGs recortados e redimensionados** (`Scripts`-less, script
      Python ad-hoc: `getbbox()` pra cortar a margem transparente sobrando
      + 14px de respiro, redimensiona pro maior lado caber em 720px —
      mesma faixa de tamanho dos ícones que já existiam em `Resources/`,
      tipo `icon_priest_grimoire.png`). Salvos como:
      - `icon_priest_kits.png` — cruz com frasco e incensário (ícone 2).
      - `icon_rules_reference.png` — grimório aberto com runas e amuleto
        de coruja (ícone 4).
      - `icon_proficiencies.png` — martelo, pena e ferramenta cruzados
        (ícone 3).
      - `icon_consequence_signal.png` — escudo com flecha/lança
        flamejante (ícone 1).
      Os três primeiros nomes JÁ eram os que `CompendiumHubView.swift`
      esperava (`imageName: "icon_priest_kits"`/`"icon_rules_reference"`/
      `"icon_proficiencies"`, adicionados nas rodadas anteriores) — só
      colocar o PNG no lugar certo já troca o fallback de símbolo SF pela
      arte de verdade, sem mexer em código nenhum dos três tiles.
- [x] **`ConsequenceSignalBadge`** (`Views/ConsequencePreviewSheet.swift`)
      — o sinal que acende perto de Nível/Atributo quando uma mudança na
      ficha impacta outro ponto (ex.: subir de nível, mudar um atributo)
      trocou o símbolo `wand.and.stars` pelo `icon_consequence_signal.png`
      dentro do mesmo círculo com gradiente/sombra de sempre — com
      fallback pro símbolo antigo se a arte não carregar por algum
      motivo, mesmo espírito defensivo do resto do app.
- [ ] **Sem simulador** — como sempre, só balanceamento de código
      conferido; os PNGs em si (proporção, nitidez dentro do círculo de
      44pt do sinal, enquadramento nos tiles do Compendium) só dá pra
      confirmar rodando no Playgrounds de verdade.

### Rodada 2026-09-20 (parte 5) — dois retoques depois da parte 4

Dois problemas relatados depois de testar a parte 4:

- [x] **Bug: grupo não recolhia com filtro de cenário ligado** (Compendium
      de Proficiências) — `isExpanded(_:)` tinha virado um `if
      expandedGroups.contains... return true; if busca... return true;
      return !selectedSettings.isEmpty` — com QUALQUER cenário marcado, a
      última linha sempre devolvia `true`, sem nunca checar se o usuário
      tinha acabado de tocar pra fechar. "All" funcionava só porque
      `selectedSettings.isEmpty` fazia a função cair no
      `expandedGroups.contains` de verdade. Corrigido separando os dois
      sentidos: `expandedGroups` guarda exceções (abrir) quando o padrão é
      recolhido (nem busca nem filtro ativos, browse normal), e o novo
      `collapsedGroups` guarda exceções (fechar) quando o padrão é aberto
      (busca OU filtro ativos) — `autoExpand` decide qual dos dois
      conjuntos vale a cada toque, então fechar um grupo agora funciona
      nos dois modos.
- [x] **`ConsequenceSignalBadge` maior + verde-claro** — usuário achou o
      ícone pequeno demais pra enxergar o desenho, e pediu pra trocar o
      fundo laranja/vermelho (herdado de quando o ícone era só o símbolo
      genérico "wand.and.stars", sem cor nenhuma pra combinar) por
      verde-claro, pra combinar com a chama turquesa do escudo. Círculo
      26pt→34pt, ícone 19pt→26pt (a área de toque de 44×44 não mudou —
      só o desenho visível dentro dela cresceu). Novo par
      `Ember.mintGlow`/`.mintDeep` (`Views/EmberTheme.swift`) substitui
      `Ember.glowBright`/`.crimson` no gradiente e na sombra.
- [ ] **Sem simulador** — mesma ressalva de sempre; balanceamento de
      código conferido nos três arquivos tocados. Vale conferir na
      prática: o toque de recolher/expandir em todas as combinações
      (com/sem busca × com/sem filtro), e o tamanho/cor novos do sinal de
      consequências encostando ou não no "Class/Kit" ao lado.

### Rodada 2026-09-20 (parte 6) — sinal maior e por campo específico

Depois de testar a parte 5, mais dois pedidos sobre `ConsequenceSignalBadge`:

- [x] **Dobrar o tamanho de novo** — círculo 34pt→68pt, ícone 26pt→52pt
      (a proporção ícone/círculo, ~0.76, ficou igual à versão anterior).
      `ConsequenceSignalBadge` deixou de ter tamanho fixo: agora recebe
      `diameter: CGFloat = 68` de quem chama, então cada campo pode ter
      um tamanho diferente sem duplicar a view.
- [x] **Sinal por campo, não só grudado no Level** — antes só existia UM
      badge (no campo Level), lendo `character.hasPendingConsequences`
      (verdadeiro se nível OU qualquer atributo mudou). Usuário pediu pra
      ele "aparecer sempre ao lado de onde houve a mudança: nível,
      atributo etc." — ou seja, um badge por campo, aceso só quando
      aquele campo específico mudou. Mudanças:
      - `PlayerCharacter` (`Models/Character.swift`) ganhou
        `hasPendingLevelChange: Bool` e
        `hasPendingAbilityChange(_ keyPath: KeyPath<AbilityScores, Int>) -> Bool`,
        ao lado do `hasPendingConsequences` que já existia (esse
        continua existindo, ainda usado pra abrir a sheet de revisão com
        todas as mudanças juntas).
      - `ConsequenceSignalBadge` (`Views/ConsequencePreviewSheet.swift`)
        agora recebe `isActive: Bool` em vez de checar
        `character.hasPendingConsequences` sozinho — quem chama decide
        com qual condição o sinal acende.
      - O campo **Level** (`RecordHeaderForm`,
        `Views/CharacterSheetView.swift`) passa
        `isActive: character.hasPendingLevelChange, diameter: 68`.
      - Cada linha de **Ability Score** (STR/DEX/CON/INT/WIS/CHA, em
        `AbilityRowForm`/`AbilityScoresForm`) ganhou seu próprio badge,
        menor (`diameter: 30` — a tabela é compacta, sem espaço entre
        linhas pra um círculo de 68pt), acendendo só quando
        `character.hasPendingAbilityChange(\.strength)` (etc.) for
        verdadeiro pra aquele atributo específico.
- [ ] **Sem simulador** — mesma ressalva de sempre; balanceamento de
      código conferido nos três arquivos tocados
      (`Models/Character.swift`, `Views/ConsequencePreviewSheet.swift`,
      `Views/CharacterSheetView.swift`). Vale conferir na prática: o
      tamanho novo do sinal de Level não invadindo demais o "Class/Kit"
      ao lado, e o badge menor de cada atributo não colidindo com a
      linha de cima/baixo na tabela de Ability Scores.

### Rodada 2026-09-20 (parte 7) — um sinal só, do jeito certo

Depois de testar a parte 6, dois problemas relatados:

- [x] **Tamanho inconsistente** — o sinal do Level (68pt) e o de cada
      atributo (30pt) tinham tamanhos bem diferentes; do lado dos
      atributos ficava "pequeno" de novo. Unificado: os dois usam o
      mesmo `diameter: 68` agora — não tinha mais motivo pra manter o
      menor, já que (ver item abaixo) só um sinal aparece por vez em
      toda a ficha, então não tem risco de vários círculos grandes se
      empilhando na tabela de atributos.
- [x] **Um sinal só, não um por campo** — a ideia da parte 6 (um badge
      por campo mudado, todos acesos ao mesmo tempo) na prática "ficava
      replicando a cada ajuste" e ainda por cima todos desapareciam
      juntos ao aplicar as mudanças automáticas de qualquer um deles
      (porque `markConsequencesReviewed()` sempre zerava nível E
      atributos juntos — não tinha como ser por campo mesmo). Trocado
      pelo que o usuário pediu: só o ÚLTIMO campo editado mostra o
      sinal, e tocar nele continua abrindo a soma de TODOS os ajustes
      pendentes (o `ConsequencePreviewSheet` nunca filtrou por campo,
      sempre comparou a ficha inteira — isso não mudou).
      - `PlayerCharacter` (`Models/Character.swift`) ganhou
        `lastChangedField: String?` (nome do campo — "level",
        "strength" etc. — editado por último) e
        `effectiveChangedField: String?`, que decide onde mostrar o
        sinal: usa `lastChangedField` quando ele ainda corresponde a
        uma mudança pendente de verdade, e cai num fallback (nível
        primeiro, depois cada atributo em ordem) pra fichas que já
        tinham uma mudança pendente antes deste campo existir. Zerado
        em `markConsequencesReviewed()`.
      - `RecordHeaderForm` e `AbilityScoresForm`
        (`Views/CharacterSheetView.swift`) ganharam `.onChange` no
        Level e nos Atributos pra atualizar `lastChangedField` a cada
        edição de verdade.
      - Os sete badges (Level + 6 atributos) agora acendem checando
        `character.effectiveChangedField == "<campo>"` em vez de cada
        um checar sua própria mudança isoladamente — só um bate por
        vez.
- [ ] **Sem simulador** — mesma ressalva de sempre; balanceamento de
      código conferido. Vale conferir na prática: editar nível e depois
      um atributo (o sinal deve "pular" pro atributo), editar dois
      atributos em sequência (deve ficar só no último), e aplicar as
      mudanças automáticas (o sinal deve sumir de vez).

### Rodada 2026-09-20 (parte 8) — filtro de cenário do Grimório virou ícone

Usuário perguntou se dava pra filtrar magias de Priest por Campaign
Setting — já dava (o `Menu` "Setting" em `filtersRow` já existia desde o
item 1), mas ele pediu pra trocar esse menu pelo mesmo padrão de selinhos
de ícone usado no Compendium de Proficiências (item 18, parte 3), pra
manter as duas telas consistentes.

- [x] **`SpellbookView.swift`** (o Grimório — usado tanto a partir do
      personagem quanto do Compendium) — o filtro "Setting" deixou de ser
      `Menu`/dropdown e virou `SettingFilterRow`/`SettingFilterChip`,
      cópia adaptada dos mesmos componentes de
      `ProficiencyCompendiumView.swift` (cada um é `private`, sem
      conflito entre arquivos): "All" + um selinho por cenário presente
      na base de Priest (`availableSettings`, calculado sobre os dados —
      nunca mostra cenário que não existe em nenhuma magia). Esfera
      continua como `Menu`: não tem ícone natural por esfera e a lista é
      grande demais (dúzias de opções) pra caber numa fileira de selinhos.
- [x] **Comportamento alinhado com o Compendium** — o filtro de cenário
      agora nunca esconde magia "Generic" (`CampaignSettingCatalog.isGeneric`),
      mesma regra já usada no filtro de Proficiências: mesmo com um ou
      mais cenários específicos marcados, o conteúdo básico do PHB
      continua aparecendo. Antes (com o `Menu`) uma magia "Generic" sumia
      da lista se qualquer cenário específico estivesse selecionado — não
      fazia muito sentido, e ninguém tinha pedido esse comportamento de
      propósito.
- [ ] **Sem simulador** — mesma ressalva de sempre; balanceamento de
      código conferido. Vale conferir na prática: os selinhos cabendo
      lado a lado (scroll horizontal) sem cortar texto, e magias
      "Generic" continuando visíveis com um cenário específico marcado.

## 19. "Toda versão nova eu perco meus personagens" — Backup manual (2026-09-20)

Usuário relatou perder a biblioteca inteira (campanhas + personagens) a
cada versão nova, sem nenhum erro aparecer na tela — só vira o Kelmon de
exemplo. Investigado (`Store/CharacterLibrary.swift`): não é falha de
leitura do `library.json` (que já era tolerante a campo novo, e passou a
ser tolerante a ITEM corrompido também — ver abaixo). É outra coisa: o
usuário confirmou que reimporta o `.zip` inteiro que eu mando no chat a
cada rodada, substituindo o projeto no Swift Playgrounds. Isso cria um
projeto NOVO — mesmo `bundleIdentifier`, mas uma pasta Documents PRÓPRIA e
vazia, porque o Swift Playgrounds não trata "reimportar o mesmo projeto"
como "atualizar o app instalado": `library.json` simplesmente não existe
na cópia nova, sem decode nenhum envolvido, daí `load()` cair direto no
branch de "primeira execução" (`seedSample()`) — sem erro, porque
tecnicamente não é um erro, é uma pasta vazia de verdade.

- [x] **Diagnóstico confirmado com o usuário** — perguntei duas coisas:
      (1) aparece algum erro na tela quando isso acontece? Resposta: não,
      só vira o Kelmon direto. (2) como ele instala cada versão nova?
      Resposta: reimportando o `.zip` que mando no chat. As duas respostas
      batem exatamente com a causa acima (se fosse falha de decode, o
      `lastError` já aparece em `HomeView`/`CampaignListView` — ver linha
      abaixo).
- [x] **Rede de segurança: decode não falha mais por ITEM** — antes,
      `Array<Campaign>`/`Array<PlayerCharacter>` inteiros falhavam se UM
      item só tivesse um campo ilegível (ex.: um enum com valor que o
      build atual não reconhece mais) — derrubando a lista toda de
      arrasto. Novo `LossyArray<Element>` (`CharacterLibrary.swift`)
      decodifica item por item: um item ruim é descartado, o resto
      continua. `LibraryData` ganhou `init(from:)` manual pra usar esse
      wrapper (o `encode(to:)` continua sintetizado normalmente). Isso é
      só reforço — não é a causa do bug relatado, mas evita esse OUTRO
      jeito de perder dado, caso aconteça no futuro.
- [x] **Export/Import manual** (`SettingsView.swift`, seção "Backup") —
      dá pro jogador levar os dados de uma cópia do projeto pra outra sem
      depender de como o Swift Playgrounds trata reimportação:
      - **Export Library**: `CharacterLibrary.exportSnapshot()` empacota
        campanhas + personagens + favoritos no mesmo formato do
        `library.json`; `.fileExporter` (diálogo nativo do iOS) deixa
        salvar em Arquivos/iCloud/AirDrop, nome sugerido com a data
        (`THAC0berry-backup-AAAA-MM-DD.json`).
      - **Import Library**: `.fileImporter` escolhe um arquivo `.json`;
        `previewImport(from:)` só CONFERE o conteúdo (conta campanhas/
        personagens) antes de aplicar — um alerta de confirmação mostra
        esses números e avisa que é destrutivo (substitui tudo, não faz
        merge) antes do jogador confirmar. `importSnapshot(from:)` só
        roda depois da confirmação.
      - Passo recomendado pro usuário a partir de agora: **exportar um
        backup ANTES de reimportar um `.zip` novo**, e importar de volta
        depois — evita perder a biblioteca na troca de versão, e também
        serve como backup manual de tempos em tempos independente disso.
- [ ] **Ainda vale investigar** (fora do escopo desta rodada, mas
      registrado): dá pra evitar a reimportação virar projeto novo
      alterando COMO o usuário atualiza (abrir sempre o MESMO projeto —
      ex.: a pasta sincronizada `thac0berry-ipad` já atualizada em vez do
      `.zip` do chat)? Não testado neste ambiente — vale o usuário
      confirmar se abrir a pasta sincronizada direto no Swift Playgrounds,
      sem reimportar nada, preserva a biblioteca entre rodadas.
- [ ] **Sem simulador** — mesma ressalva de sempre; balanceamento de
      código conferido. Vale conferir na prática: Export abrindo o
      diálogo nativo de salvar, Import lendo um arquivo exportado antes e
      mostrando os números certos no alerta de confirmação.

## 20. Apontamentos do Playground (2026-09-20)

Usuário mandou print dos avisos/erro que o próprio Swift Playgrounds
mostra pro projeto. Um deles era erro de verdade (impedia compilar), os
outros dois eram avisos — corrigidos os três:

- [x] **Erro: `SettingsView.swift`** — `FileWrapper(regularFileContents:)`
      não existe; o rótulo certo do inicializador é
      `regularFileWithContents:`. Erro de digitação meu na rodada do item
      19 (Export/Import), nunca compilado de verdade neste ambiente (sem
      simulador aqui — só balanceamento de parênteses, que não pega erro
      de nome de parâmetro). Corrigido em `BackupDocument.fileWrapper(configuration:)`.
- [x] **Aviso: `NotebookView.swift`** — `PKToolPicker.shared(for: window)`
      foi depreciado no iOS 14 (um picker por JANELA); a Apple pede uma
      instância própria por canvas agora. Trocado por `PKToolPicker()`
      guardado no `Coordinator` (`var toolPicker: PKToolPicker?`) — sem
      essa referência forte o picker seria liberado assim que
      `updateUIView` termina e sumiria da tela.
- [x] **Aviso: `CharacterSheetView.swift`** — `if let session { ... }` em
      `SpellSheetBeadRow.body` nunca usava o `session` desembrulhado
      dentro do bloco (`DayThreadRow` lê `daySheets`/`sessionLabel`, que
      recalculam `session` sozinhos); trocado por `if session != nil`,
      sugestão do próprio compilador.
- [ ] **Sem simulador** — mesma ressalva de sempre, mas desta vez com um
      motivo a mais pra levar a sério: foi exatamente a falta de
      compilação real neste ambiente que deixou passar o erro do
      `FileWrapper` na rodada anterior. Vale abrir no Swift Playgrounds e
      confirmar que os três apontamentos somem.

### Rodada 2026-09-20 (item 20, parte 2) — orientação faltando

Mais um apontamento do Playground, no nível do projeto (não de um
arquivo): "All interface orientations must be supported unless the app
requires full screen."

- [x] **`Package.swift`** — `supportedInterfaceOrientations` tinha só
      `.landscapeRight`/`.landscapeLeft`/`.portrait`, faltando
      `.portraitUpsideDown`. No iPad, o multitasking (Split View/Slide
      Over) fica ligado por padrão, e nesse modo a Apple exige suportar as
      quatro orientações — a não ser que o app abra mão de multitasking
      com `requiresFullScreen: true`, o que não é o caso aqui (o app não
      pede tela cheia obrigatória em lugar nenhum). Adicionado
      `.portraitUpsideDown` à lista.
- [ ] **Sem simulador** — mesma ressalva de sempre; vale conferir no
      Playground que o aviso some.

### Rodada 2026-09-20 (item 21) — abreviação Forgotten Realms, Alignment travado, Weapon Combat puxando página

Pedido de 4 pontas numa mensagem só.

- [x] **`CampaignSettingCatalog.shortLabel(for:)`** — "Forgotten Realms" virava
      "Realms" no selinho do filtro; trocado pra "Forgotten", como pedido.
- [x] **Campo "Alignment" travado nas 9 combinações do PHB** — era
      `EditableText` livre (qualquer texto). Novo arquivo `Views/
      AlignmentPicker.swift`: `AlignmentOption` (as 9 combinações Lei/
      Caos×Bem/Mal + sigla de 2 letras cada), `AlignmentField` (botão que
      mostra o valor atual, mesmo padrão do `KitField`) e
      `AlignmentPickerSheet` (busca com `HandwritingField` — aceita
      escrever com a caneta, mas o texto só FILTRA a lista de 9, nunca vira
      valor gravado direto — é assim que a trava acontece mesmo aceitando
      Scribble). Ligado nos dois lugares que editavam o campo:
      `RecordHeaderForm` (cabeçalho da Folha 1) e a tabela de dados
      pessoais em `CharacterDescriptionView.swift` (nova `DescCellPicker`,
      igual ao `DescCellStatic` visualmente mas tocável — única célula
      dessa tabela que não escreve direto, porque só ali a trava do PHB
      exige). Fichas antigas com texto livre no campo continuam mostrando
      esse texto até o jogador abrir o seletor e trocar por uma das 9.
- [x] **"Weapon Combat" puxando a página ao trocar** — a tabela vive dentro
      do `ScrollView(.horizontal)` de `WeaponCombatForm`, que por sua vez
      mora dentro do `UIPageViewController` de folhear a aba Sheet (gesto
      também horizontal) — os dois gestos competiam sempre que o toque
      começava em cima da tabela, e o `ScrollView` interno costumava ganhar
      do folhear de página. Como a tabela tem ~710pt de largura mínima e
      cabe inteira em paisagem no iPad (rolagem nem fazia falta nesse
      caso), `.scrollDisabled(...)` agora desliga o gesto de rolagem
      exatamente quando a largura disponível já é suficiente — some o
      conflito na paisagem (caso comum) e continua rolando normal em
      retrato, onde a rolagem é mesmo necessária.
- [ ] **Sem simulador** — ressalva de sempre; vale conferir no Playground
      (e especialmente testar o folhear de página encostando o dedo em
      cima da tabela de armas, paisagem e retrato).

**Avaliado, não implementado** (item 3 do pedido) — "Level Changes",
"Movement" e "Encumbrance" preenchidos automaticamente pelo app: hoje
`MovementForm`/`EncumbranceForm`/`LevelChangesForm` são só grade em branco
pra preencher a mão (a Encumbrance já vem com a estrutura de penalidade
padrão do PHB pré-preenchida — `-1/-2/-4` de ataque, `+1/+3` de CA —, mas
não os PESOS que definem cada faixa). Pra automatizar de verdade faltam 4
tabelas estruturadas que NENHUM corpus embarcado tem hoje (só existem como
texto solto dentro da Referência de Regras, não como dado): progressão de
THAC0 por classe×nível (1-20), progressão de jogadas de proteção por
classe×nível, taxa de movimento base por raça, e os limites de peso por
Força que definem Light/Moderate/Heavy/Severe. São dado oficial do PHB,
mas digitar essas 4 tabelas à mão sem fonte JSON pra conferir é fácil de
errar — não é do tamanho de "as 9 combinações de alinhamento" (curto,
fechado, baixo risco). Respondida separadamente no chat com um plano.

### Avaliação 2026-09-20 (item 22) — pasta `mundane_items` (item futuro, sem implementação ainda)

Usuário conectou `tmp-data/mundane_items` e pediu só uma avaliação do que dá
pra fazer com ela — decidiu não implementar nada agora, mas fica registrado
pra retomar quando quiser.

Conteúdo: 10 JSONs, ~306 itens do PHB —

- `weapons.json` (67): nome, tamanho, tipo (P/S/B), speed factor, ataques
  por rodada, dano pequeno/grande, alcance. Bate quase campo a campo com
  `WeaponEntry` (`Models/Character.swift`) — dá pra fazer um Weapon
  Compendium + seletor, igual ao padrão já usado em Kit/Proficiência
  (`KitField`/`KitPickerSheet`), pra preencher a linha da Weapon Combat
  table sozinho ao escolher a arma (THAC0/ajuste de dano continuam
  manuais, dependem do personagem).
- `armor_and_shields.json` (21), com `baseAC` — hoje `character.armorRating`
  é texto livre (`ArmorField` em `CharacterSheetView.swift`); dá pra virar
  seletor sugerindo a AC.
- `clothing.json`, `general_equipment.json`, `animals.json`,
  `transport.json`, `food_and_lodging.json`, `household_provisioning.json`,
  `services.json`, `tack_and_harness.json` (~250 itens juntos, maioria com
  custo e peso) — dá pra virar catálogo geral pro Equipment da página 2
  (`Page2EquipmentEntry`), preenchendo peso sozinho ao escolher um item da
  lista. Ligação com a avaliação do item 21 (Level Changes/Movement/
  Encumbrance automáticos): se o peso vier de um item real escolhido em vez
  de digitado, o "Total Weight" já dá pra somar sozinho — mas ainda falta a
  tabela de Força→capacidade de carga do PJ (não está neste corpus, só tem
  `carryingCapacity` pra alguns animais/montarias) pra classificar
  Light/Moderate/Heavy/Severe automaticamente.

Tamanho do trabalho: equivalente aos compêndios de Kit/Proficiência que já
existem (base + tela de consulta + seletor), por peça (Weapon / Armor /
Equipment geral). Perguntei ao usuário por onde começar — resposta: guardar
a avaliação por enquanto, sem implementar nada ainda.

### Rodada 2026-09-21 (item 23) — logos de verdade pros campaign settings

Usuário anexou `campaign-settings-icons.zip` (17 logos PNG/JPG de cenários
oficiais, arte preta em fundo branco) e pediu pra usá-los representando os
cenários no app.

- [x] **Processamento das 8 imagens que já tinham cenário correspondente**
      (Al-Qadim, Council of Wyrms, Dark Sun, Forgotten Realms, Greyhawk,
      Planescape, Ravenloft, Spelljammer — os outros 9 logos do zip
      são de cenários que o app ainda não reconhece, ver nota abaixo):
      fundo branco virou transparência (alpha = luminosidade invertida),
      recortadas na própria arte com uma margem pequena, achatadas pra
      320×320 num canvas quadrado. Resultado: 8 PNGs `campaign_*.png` em
      `Resources/`, arte preta pura sobre transparente — pensadas pra
      renderizar como TEMPLATE (herdam a cor do contexto, exatamente como
      os SF Symbols que substituem).
- [x] **`CampaignSettingCatalog.logoImageName(for:)`** — novo mapa cenário→
      nome do PNG, paralelo ao `icon(for:)` (SF Symbol) que já existia;
      `icon(for:)` continua existindo como fallback de quem chamar sem
      logo carregado.
- [x] **`SettingFilterChip`** (as duas cópias privadas — `Proficiency
      CompendiumView.swift` e `SpellbookView.swift`) — ganhou
      `imageName: String? = nil`; quando presente, usa
      `Image.bundled(_:).renderingMode(.template)` em vez do SF Symbol,
      mesmo comportamento de cor selecionado/não-selecionado de antes
      (o template herda `foregroundStyle`, então nada mais mudou no
      selinho). Sem logo (`imageName == nil`, ex. o chip "All") ou PNG que
      não carrega, cai pro SF Symbol de sempre.
- [x] **`CampaignSettingsEditorSheet`** (tela de escolher os cenários da
      campanha) — cada linha ganhou o logo do cenário ao lado do nome,
      mesmo truque de template; cenário sem logo continua só com o nome,
      sem buraco no lugar do ícone.
- [ ] **Sem simulador** — ressalva de sempre; vale conferir no Playground
      que os logos aparecem certinho nos três lugares (filtro do
      Compêndio de Proficiências, filtro do Grimório de Sacerdote, editor
      de Campaign Settings) e que a cor muda igual ao SF Symbol quando o
      selinho fica selecionado.

**Sobrou dos 17 logos do zip**: Birthright, Dragonlance, Jakandor,
Kara-Tur, Lankhmar, Maztica, Mystara, Savage Coast e Savage Lands — nenhum
desses é um cenário que `CampaignSettingCatalog.all` reconhece hoje (a
lista só inclui cenário que aparece de verdade em `Spell.setting` ou
`Proficiency.campaignSettings`; adicionar um cenário novo aqui sem
conteúdo real atrás dele só criaria um filtro que nunca mostra nada). Os
logos continuam disponíveis pra usar se algum dia entrar conteúdo real
de algum desses cenários na base.

### Avaliação 2026-09-21 (item 24) — qualidade dos dados de `mundane_items`

Usuário reenviou o mesmo corpus do item 22 (`Arquivo.zip`, os mesmos 10
JSONs — provavelmente porque a ponte com o dispositivo caiu nesta sessão)
pedindo desta vez uma avaliação de QUALIDADE, não só de encaixe. Rodei
verificação estrutural em cima dos 306 itens (sem `Bundle.main`/decoder
nenhum — só Python neste ambiente, pra não gastar ida-e-volta com o
dispositivo à toa). Achados:

- **Estrutura básica: limpa.** Nenhum `id` duplicado ou faltando, nem
  dentro de cada arquivo nem entre os 10 arquivos juntos (dá pra tratar
  como um namespace global de IDs sem colisão). `index.json` bate certinho
  com a contagem real de cada arquivo.
- **`weapons.json` — dois problemas reais de tipo, pegam quem decodificar
  direto pra `Int`/`String` fixo:**
  - `range.short/medium/long` é quase sempre `Int`, mas as duas entradas
    de Staff sling usam `String` (`"—"`, `"30-60"`).
  - `damage.l` do Whip é `1` (`Int`), enquanto todo o resto do arquivo usa
    `String` (`"1d2"` etc.).
  Ambos os campos precisam decodificar como `String` sempre (convertendo
  `Int`→texto na hora), não como `Int`/`Double` — senão o decoder quebra o
  JSON inteiro nessas 3 linhas.
- **CORRIGIDO (2026-09-21) — não era falha de extração.** Usuário mandou
  print da tabela original (PHB cap. 6). Os `type: null`/`damage: null`
  batem exatamente com o livro:
  - "Short bow", "Long bow" e "Composite short bow" mostram "—" na
    própria tabela pros campos Type/Damage — a munição (Flight/Sheaf
    arrow) é vendida e estatada numa linha À PARTE, não por arco. As
    entradas sintéticas "Long bow (Flight arrow)"/"(Sheaf arrow)" que já
    existem no JSON foram uma escolha de quem gerou o arquivo (juntar
    arco + munição padrão numa linha só, já que qualquer arco comum usa
    a mesma flecha) — só que só fizeram essa junção pro Long bow, não pro
    Short bow nem pro Composite short bow, que ficaram sem variante
    utilizável. Como é a MESMA munição (Flight/Sheaf arrow não muda por
    arco), dá pra completar "Short bow (Flight/Sheaf arrow)" e "Composite
    short bow (Flight/Sheaf arrow)" reaproveitando os mesmos 1d6/1d6 e
    1d8/1d8 já confirmados no arquivo — não é inventar dado novo, é
    aplicar a mesma munição já documentada a outro arco que a usa. Ainda
    assim, vou confirmar com o usuário antes de fazer essa duplicação.
  - "Scourge" e "Whip" também mostram "—" no Type na tabela real — não é
    campo faltando, é o livro mesmo sem classificar o tipo de dano desses
    dois. `type: null` pode ficar como está.
  - O dano Large do Whip é literalmente "1" impresso no livro (não uma
    rolagem de dado) — o JSON com `l: 1` (Int) está fiel à fonte; só
    precisa decodificar como texto flexível (`Int` ou `String`) por causa
    da mistura de tipo já registrada acima, não por erro de conteúdo.
- **CONFIRMADO (2026-09-21) — `armor_and_shields.json`, 1 linha lixo de
  verdade.** Usuário mandou print da tabela de Armor do PHB: "Helmet" É um
  cabeçalho de seção no livro (linha com "—"/"—" antes de Great helm/
  Basinet, mesmo padrão de "Shield" antes de Body/Buckler/Medium/Small) —
  só que o extrator INCLUIU o cabeçalho "Helmet" como se fosse um item
  (`id: "helmet"`, tudo nulo), enquanto excluiu corretamente o cabeçalho
  "Shield" irmão (não existe `id: "shield"` solto no arquivo, só os 4
  escudos de verdade). Inconsistência real do extrator, não do livro —
  descartar essa 1 linha antes de importar continua sendo a correção
  certa.
- **CONFIRMADO — `weapons.json`, os valores de tipo misto são fiéis à
  fonte.** Print da Table 45 (Missile Weapon Ranges) do PHB bate
  exatamente com o JSON: Staff sling bullet/stone têm range Short "—",
  Medium "30-60", Long 90 — os MESMOS três formatos (traço/faixa/número)
  que já tinha achado na checagem de tipo. Não precisa e não deve
  "consertar" esse dado — só decodificar o campo `range` sempre como
  texto de exibição (nunca `Int` fixo), porque o livro mesmo mistura os
  formatos.
- **Custo/peso: texto livre, do jeito que o livro imprime — não é bug.**
  Tem faixa de preço ("4,000-10,000 gp" pro Full plate), preço duplo por
  unidade ("5 sp/3 gp" hospedagem dia/semana), nota com asterisco ("5
  sp*"), placeholder de peso desprezível ("**", "*"). Ficam OK como texto
  de exibição (mesmo tratamento que `WeaponEntry`/`Page2EquipmentEntry`
  já dão pros campos deles hoje) — não dá pra tentar somar/parsear esses
  campos como número sem tratamento caso a caso.
- **`animals.json`** — 13 dos 35 animais têm `carryingCapacity` (os de
  tração/montaria: Camel, cães, burros, elefantes, cavalos, boi) e os
  outros 22 não (bicho de criação/estimação, sem capacidade de carga no
  PHB — faz sentido). "Pony" sem `carryingCapacity` — usuário confirmou
  (2026-09-21) que é assim mesmo, deixar como está.

**Pra que serve cada arquivo no app** (mesmo mapeamento do item 22, agora
com a ressalva de qualidade acima): `weapons.json` → Weapon Compendium +
seletor pra Weapon Combat table (`WeaponEntry`); `armor_and_shields.json`
→ seletor de Armor sugerindo `baseAC` (depois de descartar a linha
"helmet"); as outras 7 → catálogo geral pro Equipment da página 2
(`Page2EquipmentEntry`); `animals.json` → referência futura de
montarias/transporte, se algum dia fizer sentido.

Sem implementação nesta rodada — usuário pediu só a avaliação. Ponte com
o dispositivo caiu nesta sessão, então este registro só existe aqui no
workspace da nuvem por enquanto; sincronizo com o repo do Windows assim
que a ligação voltar.

### Rodada 2026-09-21 (item 25) — Weapon Compendium

Usuário: "Manda bala! Use os padrões já existentes, tando no Compendium
quanto na ficha, ok?" — implementa a avaliação do item 22/24
(`weapons.json`) como uma quinta base de consulta, seguindo à risca os
padrões já estabelecidos por `KitDatabase`/`ProficiencyDatabase` e pelas
telas de Kit/Proficiência.

- **Dado**: `Models/Weapon.swift` (`Weapon`/`WeaponRange`, ver o
  comentário do arquivo pra por que fica separado de `WeaponEntry`) +
  `Store/EmbeddedWeapons.swift`/`EmbeddedWeapons_Part1-4.swift` (mesmo
  padrão de literais Swift embutidos — NUNCA lido de JSON/bundle em
  runtime, ver o comentário histórico em `KitDatabase.swift`) +
  `Store/WeaponDatabase.swift` (`ObservableObject`, mesmo shape de
  `ProficiencyDatabase`). 69 armas: as 67 do corpus original menos Short
  bow/Composite short bow (sem dano próprio no livro) mais as 4 variantes
  "(Flight arrow)"/"(Sheaf arrow)" de cada uma, reaproveitando a MESMA
  munição que Long bow/Composite long bow já usavam — não é dado
  inventado, é a Table 45 do PHB reaplicada, confirmado com o usuário nas
  duas rodadas de prints anteriores (itens 23/24 acima).
  - Wired em `App.swift` como `@StateObject` + `.environmentObject`, do
    lado das outras 6 bases.
- **Compendium**: `Views/WeaponCompendiumView.swift` — `WeaponCompendiumView`
  (busca + lista agrupada por tipo de dano: Piercing/Slashing/
  Bludgeoning/misturado/"Unclassified" pras armas que o próprio livro não
  classifica, ex. Whip), `WeaponDetailSheet` (tamanho, tipo, speed factor,
  #AT, dano S/L, alcance C/M/L), `WeaponPickerSheet`/`WeaponPickerRow`
  (usado a partir da ficha — busca, "use as typed" pra arma caseira fora
  da base, "Clear current weapon"). Mesmo trio de telas que
  `KitCompendiumView`/`ProficiencyCompendiumView` já usam.
  - Nova entrada "Weapons" em `Views/CompendiumHubView.swift`
    (`WeaponCompendiumScreen`), mesmo padrão das outras 4 — sem arte
    ilustrada própria ainda (`icon_weapons` não existe em `Resources/`),
    cai no fallback de SF Symbol (`shield.righthalf.filled`) que o
    `CompendiumTile` já suporta.
- **Ficha**: `WeaponEntry` ganhou `matchedWeaponID: String? = nil`
  (`Models/Character.swift`, mesmo papel de
  `ProficiencyEntry.matchedProficiencyID`). `WeaponFormRow`
  (`Views/CharacterSheetView.swift`) trocou o campo de nome livre
  (`InlineTextField`) por um botão — mesmo gesto de "tocar no nome" de
  `ProficiencyFormRow`: linha já ligada a uma arma da base abre a
  descrição num toque (com "change" pra trocar), linha vazia ou não-ligada
  abre o seletor direto. Escolher uma arma no seletor preenche nome,
  tamanho, tipo, speed factor, #AT, dano S/L e alcance sozinho; THAC0 e o
  ajuste de dano/acerto continuam sempre manuais — são do PERSONAGEM, não
  da arma, a mesma arma tem THAC0 diferente pra cada jogador.
  Homebrew continua funcionando: "use as typed" no seletor aceita
  qualquer nome sem bater com a base (mesma saída de emergência do
  `ProficiencyPickerSheet.useAsTyped`).
- Sem simulador neste ambiente — verificação só por leitura de código +
  balance-check de parênteses/chaves/colchetes (script Python, mesmo de
  sempre). v1.15/122 → v1.16/123.

### Rodada 2026-09-21 (item 26) — Armor/Shield + Equipment (itens diversos)

Usuário: "Boa! Agora implemente pra armor/shield e itens diversos" —
continua o item 25 pro resto da avaliação do item 22/24: `armor_and_
shields.json` vira o Armor Compendium + seletor de "Armor" na ficha, e as
7 categorias restantes do corpus (general_equipment/clothing/food_and_
lodging/household_provisioning/services/tack_and_harness/transport, 183
itens) viram o Equipment Compendium + seletor na tabela de Equipment da
página 2. `animals.json` continua de fora (referência futura, sem tela
própria — usuário já tinha confirmado que não há pressa).

- **Armor/Elmo/Escudo** (20 itens — a base original de 21 menos a linha
  "Helmet" descartada no item 24): `Models/ArmorPiece.swift`
  (`ArmorPiece`/`ArmorPieceKind`) + `Store/EmbeddedArmor.swift`/
  `EmbeddedArmor_Part1.swift` (mesmo padrão de literais embutidos) +
  `Store/ArmorDatabase.swift`. `Views/ArmorCompendiumView.swift` —
  `ArmorCompendiumView` (busca + agrupado em Armor/Helmets/Shields),
  `ArmorDetailSheet`, `ArmorPickerSheet` (usado só no campo "Armor" do
  bloco de Armadura da ficha — só lista `kind == .armor`, preenche
  `character.armorRating` com o `baseAC`). Elmo e Escudo NÃO têm `baseAC`
  na tabela de preços do PHB (não é lacuna de extração, é assim que o
  livro apresenta — confirmado no item 24) — por isso só ficam como
  referência de consulta no Compendium; o campo "Shield" da ficha
  continua texto livre, sem seletor, pra não inventar um número de AC que
  não está na fonte.
  - Nova entrada "Armor" em `Views/CompendiumHubView.swift`.
- **Equipment** (183 itens de 7 categorias): `Models/MundaneItem.swift` +
  `Store/EmbeddedMundaneItems.swift`/`EmbeddedMundaneItems_Part1-8.swift` +
  `Store/MundaneItemDatabase.swift`. `Views/MundaneItemCompendiumView.swift`
  — `MundaneItemCompendiumView` (busca + agrupado por categoria, "Miscel-
  laneous Equipment" primeiro por ser a maior), `MundaneItemDetailSheet`
  (custo/peso), `MundaneItemPickerSheet`/`MundaneItemPickerRow` (usado na
  tabela de Equipment da página 2 — "use as typed" pra item caseiro fora
  do catálogo, mesmo padrão dos seletores anteriores).
  - Nova entrada "Equipment" em `Views/CompendiumHubView.swift`.
- **Ficha**: `ArmorField` (dentro de `ArmorBlock`, `Views/
  CharacterSheetView.swift`) ganhou um `onPick` opcional — só o rótulo
  "Armor" virou botão (o número em si continua editável na hora, pra
  ajustes rápidos tipo bônus mágico); tocar nele abre o `ArmorPickerSheet`.
  `Page2EquipmentEntry` ganhou `matchedItemID: String? = nil` (mesmo papel
  de `matchedWeaponID`/`matchedProficiencyID`) e `Page2EquipmentRow`
  trocou o campo "Item" de `InlineTextField` livre pro mesmo botão
  "tocar pra ver/trocar" de `WeaponFormRow`/`ProficiencyFormRow` — escolher
  um item preenche o peso sozinho; "Location" (onde o jogador guarda)
  continua sempre manual, é decisão de mesa.
- 3 bases embutidas a mais rodando junto (Weapon/Armor/Equipment) — todas
  `@StateObject` em `App.swift`, mesmo padrão das 4 anteriores.
- Sem simulador neste ambiente — verificação só por leitura de código +
  balance-check de parênteses/chaves/colchetes. v1.16/123 → v1.17/124.

### Rodada 2026-09-21 (item 27) — Compendium de Armas/Armadura/Equipment vira tabela

Usuário: "O Compendium dos 3, armas, armaduras e itens não podem virar
tabelas? Como eles não possuem descrição, acho que o formato atual não
funciona bem, dificulta encontrar a informação." — Kit/Proficiência têm
descrição de prosa de verdade, então "nome + toque pra abrir" faz sentido
pra eles; Weapon/Armor/Equipment são só linhas de tabela de preço do PHB
(nome + alguns números), então esconder os números atrás de um toque só
atrapalhava achar informação. As 3 telas de browse (não os seletores da
ficha, que continuam de uma linha só — lá o objetivo é escolher rápido,
não comparar) agora mostram uma linha de cabeçalho fixa + todas as
colunas de cada item direto na lista, dentro de um `ScrollView(.horizontal)`
(mesmo padrão de `WeaponCombatForm` na ficha, sem o cuidado de desabilitar
o gesto — aqui não tem `UIPageViewController` por perto competindo pelo
toque). Tocar na linha continua abrindo o Detail Sheet (mantido por
consistência, mas deixou de ser a única forma de ver o dado).

- `Views/WeaponCompendiumView.swift`: colunas Weapon/Size/Type/Speed/#AT/
  Dmg S-M/Dmg L/Range S-M-L.
- `Views/ArmorCompendiumView.swift`: colunas Item/AC/Cost/Weight.
- `Views/MundaneItemCompendiumView.swift`: colunas Item/Cost/Weight
  (Categoria continua como o cabeçalho do grupo, não uma coluna — já
  agrupa por ela).
- Agrupamento (por Type/Kind/Category) e busca continuam do jeito que
  estavam — só a linha de cada item que virou tabela.
- Sem simulador neste ambiente — verificação só por leitura de código +
  balance-check de parênteses/chaves/colchetes. v1.17/124 → v1.18/125.

### Rodada 2026-09-21 (item 28) — Ícones dos 3 Compendiums novos

Usuário mandou `Arquivo.zip` com 3 medalhões ilustrados (mesmo estilo dos
já usados em Priest Grimoire/Priest Kits/Proficiencies/Rules Reference —
selo de couro e latão, fundo já transparente) e pediu pra usar nos
Compendiums novos: `weapons-01-nobg.png` → Weapons (espada e machado
cruzados sobre escudo), `armor-01-nobg.png` → Armor (peitoral + elmo),
`items-01-nobg.png` → Equipment (mochila + tocha).

- Mesmo processamento das logos de campaign setting (item 23): recorte
  justo no bounding box do conteúdo com alpha (script Python/PIL,
  `getbbox()` + ~3% de padding uniforme), sem reprocessar cor — essas 3 já
  vieram com fundo transparente de verdade (diferente das logos de
  campaign setting, que precisavam de inversão branco→alpha).
  `Resources/icon_weapons.png`/`icon_armor.png`/`icon_equipment.png`.
- Nenhuma mudança de código necessária: `CompendiumHubView.swift` já
  passava esses três `imageName` pros `CompendiumTile` desde os itens
  25/26 (`Image.bundled` caía no fallback de SF Symbol até agora, porque
  os arquivos não existiam ainda) — só soltar os PNGs no lugar certo já
  resolve.
- v1.18/125 → v1.19/126.

### Avaliação 2026-09-21 (item 29) — itens mágicos (`Arquivo.zip`, corpus novo)

Usuário mandou um corpus NOVO (não é o `mundane_items` dos itens 22/24 —
este é de itens MÁGICOS) e pediu só a avaliação, mesmo padrão de sempre:
sem implementação nesta rodada.

**Volume**: 8 arquivos por categoria + `index.json` mestre, 5.669 itens
no total (265 armor_and_shields, 2.010 miscellaneous_a_to_m, 1.067
miscellaneous_n_to_z, 473 potions_and_oils, 285 rings, 348
rods_staves_wands, 335 scrolls_and_books, 886 weapons). Pra comparar de
escala: é 3x o tamanho da base de magias (1.795) e 15x a de proficiências
(372) — de longe o maior corpus já avaliado neste projeto.

**Qualidade — muito melhor que o `mundane_items`, sem achado de bug
estrutural nenhum**:
- `index.json` e os 8 arquivos por categoria batem 100%: 0 id duplicado
  dentro/entre arquivos, todo id do índice existe no arquivo que ele
  aponta, toda entrada dos 8 arquivos está no índice — sem cruzamento
  quebrado.
- Schema perfeitamente consistente — cada arquivo tem UM key-set só
  (todo item da mesma categoria com exatamente os mesmos campos), nada
  do bug de chave-faltando que já pegou Kits antes (ver comentário em
  `KitDatabase.swift`). Campos extras por categoria: `enchantment`
  (weapons), `power` (rings/rods_staves_wands), `containsSpells`
  (scrolls_and_books).
- `description.fullText` vazio: 0/5.669. `name` vazio: 0/5.669. Só 5
  itens sem `briefSummary` (variantes de "Wand of Wonder"/scrolls
  genéricos — o resumo faltando não impede nada, o `fullText` continua
  completo).
- ~500 itens com `xpValue`/`goldValue` nulos, mas com `rawXP`/`rawValue`
  literais tipo `"— xp"`/`"— gp"`/`"None"` — mesmo padrão já visto no
  `mundane_items` (itens únicos/de artefato tipo "Bracers of
  Invulnerability" genuinamente não têm preço no livro; fiel à fonte,
  não é lacuna de extração).
- `creator` e `intelligentItemProperties` vêm `null` em TODOS os 5.669
  itens — campos "mortos" nesta extração (a informação de item
  inteligente, quando existe, está dentro do `fullText` em prosa, só não
  foi estruturada à parte). Não atrapalha nada, só não dá pra filtrar
  "itens inteligentes" como categoria separada sem reler o texto.
- 320 nomes duplicados no corpus inteiro (ex. "Helm of Telepathy"
  aparece 2x) — mas sempre com `id` diferente e fonte diferente (o mesmo
  nome de item foi reimpresso/reinterpretado em sourcebooks diferentes ao
  longo de décadas). Não é bug — só significa que a UI vai precisar
  mostrar a fonte junto do nome pra desambiguar, igual `Kit.sourceBook` já
  faz na coluna do Compendium de Kits.
- `campaignSettings` preenchido em 663/5.669 itens (~12%), com os MESMOS
  valores que `CampaignSettingCatalog` já usa (Forgotten Realms,
  Greyhawk, Oriental Adventures/Kara-Tur, Spelljammer, Mystara/Known
  World, Al-Qadim, Dragonlance, Ravenloft, Maztica, Dark Sun) — encaixa
  direto no filtro de campaign setting que Grimório/Proficiências já têm,
  sem precisar inventar mapeamento novo.

**Achado que MUDA o plano técnico** — 737 sourcebooks diferentes citados
em `sources[].book`, e a fonte dominante de longe é *Encyclopedia
Magica* (5.136 citações) — um compêndio 2e de 4 volumes que cataloga
praticamente todo item mágico já publicado, não só PHB/DMG. O resto do
corpus soma trading cards da TSR (1991-93), Dragon Magazine, Polyhedron
Newszine, e até material de D&D Básico (*Rules Cyclopedia*, *D&D Master
Set* — nem é AD&D 2e). Isso é BEM mais amplo que qualquer base já
implementada (Kits/Proficiências/Armas/Armadura/Equipment eram todos
PHB ou handbook próximo) — vale decidir com o usuário se entra o corpus
inteiro (mais completo, mas cheio de item de card/fanzine obscuro) ou só
um subconjunto mais "core" (ex. só o que cita DMG/Encyclopedia Magica,
descartando trading card/Polyhedron) antes de implementar.

**Achado técnico importante**: dado o tamanho (5.669 itens, ~20MB de
JSON, ~18MB sem contar `description.rawWikitext` que é markup bruto da
wiki, redundante com `fullText` e sem uso óbvio no app — removê-lo cai
pra ~10,6MB), o padrão de literais Swift embutidos usado pra
Kits/Proficiências/Armas/Armadura/Equipment (um `let` por item, ~25 por
arquivo) NÃO é viável aqui — precisaria de ~230 arquivos `_PartN.swift`
só pra isso, provavelmente travando o type-checker do Swift Playgrounds
mesmo dividido. A saída certa é o MESMO padrão que `SpellDatabase.swift`
já usa pra magias (1.795 itens, ordem de grandeza mais parecida): ler
JSON de verdade do bundle em runtime, um arquivo por categoria,
`JSONDecoder` com todos os campos `Optional` pra tolerar o que faltar. O
"nunca leia JSON do bundle" documentado em `KitDatabase.swift` não é uma
regra geral — foi um diagnóstico errado de um `DecodingError.
keyNotFound` real (13 kits sem uma chave) que apareceu com a mensagem
genérica "missing"; já com esse corpus (schema 100% consistente, sem
chave faltando) e seguindo o padrão comprovado de `SpellDatabase.swift`
(que já lê `priest_*.json` do bundle sem problema nenhum hoje), ler JSON
em runtime aqui é seguro.

**Pra que serviria cada arquivo**: `weapons.json`/`armor_and_shields.json`
→ estender os Compendiums que já existem (Weapon/Armor) com uma seção
"Magic" separada da mundana, ou um Compendium de Magic Items à parte que
cruza com o mundano pelo nome-base; `rings.json`/`rods_staves_wands.json`
→ categorias novas, sem equivalente mundano na ficha ainda;
`potions_and_oils.json`/`scrolls_and_books.json`/`miscellaneous_*.json` →
idem, tudo novo. Nenhum desses tem uma linha própria na ficha oficial
hoje (diferente de Weapon Combat/Equipment) — entrar como Compendium de
consulta pura seria o primeiro passo natural, uma linha na ficha void
seria decisão separada.

Sem implementação nesta rodada — usuário pediu só a avaliação.

## 30. Magic Item Compendium — escopo full, filtro por fonte (2026-09-21, v1.20)

Usuário: "Acho melhor já irmos no escopo full, já que os dados estão bons.
Mas será possível filtrar por fonte?" — decisão de implementar o corpus
INTEIRO (5.669 itens, não um subconjunto "core"), com um pedido extra de
filtro por sourcebook. Perguntei a granularidade do filtro (grupo de
fonte / livro específico / os dois) e o usuário escolheu explicitamente:
"Os dois: grupo primeiro, livro depois".

**Investigação de schema antes de escrever Swift** (corrigindo duas
suposições erradas da avaliação do item 29): `defenseBonus` NÃO é um
`Int?` simples — é um dict com 8 chaves sempre juntas (`acBonus`,
`savingThrowBonus`, `magicResistance`, `abilityScoreBonus` [dict
atributo→bônus, mesmo padrão de `KitRequirements.abilities`],
`hitPointBonus`, `attackBonus`, `resistances` [`[String]`],
`regenerates` [`Bool`]) em 434 dos 5.669 itens. `power.spell` também é
um dict, não sempre nulo — `{id, name, class}`, presente em 23 dos 546
itens com `power`, EXATAMENTE o mesmo shape de `containsSpells[]`
(`scrolls_and_books.json`) — as duas usam a mesma struct
`MagicItemSpellRef` no modelo.

**Pré-processamento** (`Scripts/preprocess_magic_items.py`, novo) —
corta do corpus bruto (~20MB) tudo que a auditoria de tipos do item 29
confirmou sempre nulo/morto: `description.rawWikitext` (maior ganho,
~47% do tamanho, texto wiki bruto redundante com `fullText`),
`intelligentItemProperties`, `creator`, `economyAndXP.weight`,
`sources[].volume`, `classification.magicSchool`. Resultado: 8 arquivos
`Resources/magic_<categoria>.json`, 9,19MB no total (vs. ~20MB bruto),
mesma convenção de nome que `priest_*.json` já usa pra magias.

**Modelo** (`Models/MagicItem.swift`, novo) — `Codable` de verdade, lido
em runtime do bundle (não literal Swift embutido) — mesmo padrão que
`SpellDatabase` já comprova pras 1.795 magias, necessário aqui pela
escala: o padrão de literal embutido (um `let` por item,
`EmbeddedX_PartN.swift`) precisaria de ~230 arquivos de partição só pra
isso, risco real de travar o type-checker do Swift Playgrounds. O
comentário "nunca leia JSON do bundle" em `KitDatabase.swift` foi
reexaminado e é um diagnóstico ERRADO da época (um
`DecodingError.keyNotFound` mascarado atrás da mensagem genérica
"missing", não uma falha real de leitura de bundle) — não é uma regra
geral da toolchain. Todo campo que só existe nalguma categoria
(`enchantment` só em armas, `power` só em anéis/varinhas/cajados/
bastões, `containsSpells` só em pergaminhos/livros) é `Optional`.

**Base** (`Store/MagicItemDatabase.swift`, novo) — varredura de
`magic_*.json` no bundle, mesmo padrão de `SpellDatabase.priestFiles()`
(nome + URL da MESMA varredura, evitando o bug documentado de pedir a
URL de novo por outro caminho). `MagicItemSourceGroup` implementa o
agrupamento por fonte em 7 grupos (Encyclopedia Magica — 5.102 itens,
só 1 título; Dragon Magazine — 1.143 itens, 104 edições; Polyhedron
Newszine — 405 itens, 28 edições; Trading Cards — 353 itens, 3 títulos;
Basic D&D non-AD&D — 186 itens, Rules Cyclopedia/D&D Basic-Expert-
Companion-Master-Immortals Set; Other Sourcebooks — catch-all, 3.503
itens, 597 títulos distintos, dominado por *The Book of Marvelous
Magic*/*Dungeon Master Guide*; Unknown — 117 itens sem fonte
cadastrada). **Corrigido antes de virar código**: o protótipo em Python
do item 29 checava o prefixo abreviado "D&D Master Set" e por isso
"Dungeons & Dragons Master Set" (o título de verdade no corpus, por
extenso) caía no catch-all por engano — a versão Swift
(`MagicItemSourceGroup.basicDnDPrefixes`) checa os títulos completos
desde o início. `groups(for:)` devolve TODOS os grupos que alguma fonte
do item toca (item pode ter mais de uma fonte); `books(in:items:)`
alimenta o segundo nível do filtro.

**Tela** (`Views/MagicItemCompendiumView.swift`, novo) — formato PROSA
("nome + tap to open"), não tabela — ao contrário de Weapon/Armor/
Equipment (item 27): itens mágicos têm `description.fullText` de
verdade, mesmo critério que já vale pra Kit/Proficiência. Agrupado por
`classification.broadCategory` (7 grupos — A-M/N-Z de "Miscellaneous" no
arquivo de origem mesclam num grupo só, já que os dois têm o MESMO
`broadCategory`, o split é só artefato de extração). Filtro de fonte em
dois níveis exatamente como o usuário pediu: `SourceGroupFilterRow`
(selinho de texto por grupo, só um selecionado por vez) e, só quando um
grupo está escolhido, `BookFilterRow` (livros daquele grupo específico,
via `MagicItemSourceGroup.books(in:items:)`). `MagicItemDetailSheet`
mostra XP/Gold com fallback pro texto bruto (`rawXP`/`rawValue`) quando
o valor estruturado falta, fontes, tags de campaign setting (soltas —
ver nota abaixo), e as seções condicionais (`enchantment`/`power`/
`containsSpells`/`defenseBonus`) só aparecem quando a categoria do item
as preenche.

**Achado que corrige uma suposição do item 29**: os rótulos de
`campaignSettings` deste corpus (Forgotten Realms, Greyhawk, "Oriental
Adventures / Kara-Tur", Spelljammer, "Mystara / Known World", Al-Qadim,
Dragonlance, Ravenloft, Maztica, Dark Sun) NÃO batem exatamente com
`CampaignSettingCatalog.all` (que tem "Council of Wyrms"/"Planescape",
ausentes aqui, e não tem "Dragonlance"/"Maztica"/os dois rótulos
compostos daqui) — a avaliação anterior tinha dito "encaixa direto", o
que era impreciso. Por isso `campaignSettings` aparece só como tag
solta na ficha de detalhe (`MagicItemDetailSheet`), sem entrar no
filtro de ícone que Grimório/Proficiências já usam — juntar os dois
catálogos de verdade fica pra uma rodada futura, se fizer sentido.

**Escopo desta rodada**: só Compendium de consulta — SEM linha nova na
ficha do personagem, sem seletor (`MagicItemPickerSheet`), igual a
conclusão do item 29: nenhuma seção existente da ficha mapeia num campo
óbvio de item mágico (ao contrário de Weapon/Armor/Equipment, que já
tinham campo pronto pra receber um seletor).

**Pendente**: ícone ilustrado próprio pro tile "Magic Items" — por
enquanto cai no fallback de SF Symbol (`wand.and.stars`) que
`CompendiumTile` já usa quando `imageName` não carrega, igual o
"Mage Grimoire" ainda "Coming soon" ao lado. `App.swift` ganhou
`@StateObject private var magicItems = MagicItemDatabase()` e o
`.environmentObject` correspondente, mesmo padrão dos outros oito.

Sem simulador/compilador neste ambiente — verificação foi checagem de
código linha a linha, balanceamento de parênteses/colchetes/chaves via
script Python (rodado depois de cada lote de mudança) e uma checagem
Python separada validando os 5.669 itens dos 8 `Resources/magic_*.json`
contra exatamente as chaves obrigatórias que `CompendiumMagicItem.
init(from:)` espera — precisa validar numa build de verdade no iPad
antes de confiar 100%.

### Correção 2026-09-21 (item 30, parte 2) — build real apontou "Invalid redeclaration of 'MagicItem'"

Usuário rodou a build de verdade no Swift Playgrounds (primeira vez que
este item passa por um compilador de verdade, não só a checagem estática
daqui) e voltou com uma cascata de erros — "Invalid redeclaration of
'MagicItem'", "'MagicItem' is ambiguous for type lookup", e um monte de
erro secundário em `SpellSheet.swift`/`MagicItemDatabase.swift`/
`MagicItemCompendiumView.swift`/`SpellSheetView.swift` (tudo cascata do
mesmo problema raiz, confirmado por não sobrar nenhum erro independente
depois de corrigir).

Causa: `Models/SpellSheet.swift` já tinha um `struct MagicItem`
(`redeclaration` — o item mágico de texto livre com cargas de magia que
o JOGADOR preenche na folha de magias, usado por `SampleCharacter.swift`
e `SpellSheetView.swift` há muito mais tempo que este Compendium) —
faltou conferir nomes existentes antes de nomear o modelo novo do
Compendium (o padrão que este projeto segue pra evitar exatamente isso,
`grep` antes de introduzir um tipo, não foi seguido desta vez). Os dois
tipos não têm relação nenhuma entre si (um é dado de REGRA vindo do
corpus da wiki, o outro é o que o jogador escreve na ficha) mas o nome
igual colidia direto.

Corrigido renomeando só o tipo NOVO (o da ficha já tem uso espalhado por
3 arquivos, mexer nele seria bem mais arriscado) — `MagicItem` →
`CompendiumMagicItem` em `Models/MagicItem.swift` (o arquivo continua
com esse nome, só o `struct` de dentro mudou),
`Store/MagicItemDatabase.swift` e `Views/MagicItemCompendiumView.swift`.
Os nomes dos tipos auxiliares (`MagicItemClassification`,
`MagicItemEconomy`, `MagicItemSource`, `MagicItemDatabase`,
`MagicItemSourceGroup`, `MagicItemCompendiumView` etc.) não colidiam —
todos já tinham sufixo/prefixo suficiente pra serem identificadores
distintos de `MagicItem`, só o nome CURTO estava duplicado. Confirmado
por `grep` que sobra só UMA declaração de `struct MagicItem` no projeto
inteiro (a de `SpellSheet.swift`) e nenhuma declaração duplicada de
`CompendiumMagicItem`. Reforça a mesma lição do TODO — checar o
`grep -rn "struct NomeNovo"` antes de introduzir qualquer tipo, mesmo
quando "parece" um nome óbvio e livre.

## 31. "Janela pula na tela" ao escrever com a caneta no seletor de item/arma (2026-09-21, v1.21)

Usuário: "ao editar um item ou uma arma na ficha do personagem, abre a
janela de edição com um campo de texto e uma lista de itens para
escolha. Se eu opto por escrever o nome no item nesta caixa texto, ao
iniciar o traço a janela sobe na tela por conta de uma barra que surge
no canto inferior direito da tela" — com print de antes/depois mostrando
a barrinha flutuante (desfazer, idioma "PT", ditado, confirmar) por cima
da ficha.

"Campo de texto + lista de itens" é o `WeaponPickerSheet`/
`ArmorPickerSheet`/`MundaneItemPickerSheet` (mesmo padrão do
`KitPickerSheet`/`ProficiencyPickerSheet`) — a busca (`searchField`) de
cada um usava `HandwritingField(..., allowsSoftwareKeyboard: true)`,
diferente do resto da ficha (que sempre usou `false`).

**Causa**: `HandwritingField` decide entre caneta-só e caneta+teclado
trocando `field.inputView` entre um `UIView()` vazio (`false` — Scribble
escreve, teclado nunca aparece) e `nil` (`true` — teclado de verdade
disponível). O que a impressão mostra não é o teclado — é o painel
flutuante de Scribble que o próprio iPadOS oferece perto de qualquer
campo com `inputView` não-nulo assim que a caneta encosta (desfazer,
troca de idioma, ditado, confirmar — documentado pela Apple como parte
do Scribble). Como esse painel "mora" no canto da tela, a `ScrollView`/
popover sobe pra manter o campo em foco visível acima dele — a "janela
pulando" relatada. Não existe API pública pra manter o teclado
disponível e suprimir só esse painel: a única forma comprovada de nunca
mostrá-lo é `inputView` não-nulo mesmo vazio, ou seja, `false`.

**Correção**: `allowsSoftwareKeyboard: true` → `false` em TODO uso do
app (13 arquivos — buscas de todos os Compendiums, os `*PickerSheet`,
os balões de `EditableText`/`EditableNumber`/`InlineTextField`/
`AlignmentPicker`/`CampaignIndexView`/`MarkDeadSheet`), não só nos três
que o usuário citou — o mesmo painel apareceria em qualquer um deles
mais cedo ou mais tarde, já que compartilham o mesmíssimo código. A
caneta continua escrevendo perfeitamente em todos (Scribble não depende
de `inputView`), só a alternativa de digitar no teclado de verdade some
— mesmo comportamento que o resto da ficha (Character Name, etc.) já
tinha sem reclamação nenhuma desde sempre. Documentado o porquê na
própria doc comment de `allowsSoftwareKeyboard` em
`Views/HandwritingField.swift`, pra não reaparecer `true` por engano
numa tela nova.

Sem simulador — verificação foi `grep` confirmando os 20 usos corrigidos
e nenhum `allowsSoftwareKeyboard: true` restante, mais balanceamento de
parênteses/chaves nos 14 arquivos tocados.

## 32. Teclado sob pedido nos campos de busca (2026-09-21, v1.22)

Usuário, depois da correção do item 31, perguntou se dava pra manter o
teclado disponível de outro jeito — "usar uma janela fixa, que não se
movimenta" ou "já disparar a abertura da barra assim que a janela
abrir" — deixando claro que digitar deveria ser "a exceção, não a
regra".

Avaliei as duas ideias e descartei as duas: "janela fixa" precisaria de
`.ignoresSafeArea(.keyboard)` nos 14 Compendiums/seletores pra a folha
parar de reagir ao painel flutuante — sem simulador pra testar, arrisca
sobrepor o painel em cima da lista/campo sem eu conseguir confirmar que
ainda dá pra ler o que está embaixo; "abrir a barra já de cara" resolve
o pulo mas troca "pula quando eu escrevo" por "pula toda vez que a tela
abre", o oposto do pedido (caneta devia ser o caminho comum, sem sobra
nenhuma de teclado aparecendo sozinho).

Implementei uma terceira: o campo de busca nasce só-caneta (sem o
painel, sem pulo — igual ao item 31) e ganha um ÍCONE DE TECLADO
(⌨, ao lado de "Search") que o usuário toca só quando quer digitar de
verdade — aí sim `allowsSoftwareKeyboard` vira `true` NAQUELE campo,
NAQUELE momento, por escolha explícita, e o painel/pulo só aparece
porque foi pedido, não por padrão. Cada tela tem seu próprio estado
(ligar num Compendium não liga nos outros) e sempre volta a nascer
desligado da próxima vez que a tela abrir — a exceção nunca vira regra
sozinha.

Criado `SearchField` (`Views/HandwritingField.swift`) — um componente
único que substitui os 14 blocos idênticos de `FieldLabel` + 
`HandwritingField` + `DottedRule` que cada Compendium/seletor
(Weapon/Armor/Equipment/Magic Item/Kit/Proficiency/Rules/Spellbook/
Alignment, browse E picker) tinha copiado e colado. Cada `searchField`
computed property virou uma linha só (`SearchField(text: $query,
placeholder: "...")`), 13 arquivos tocados. Ficar como componente único
também evita o mesmo bug do item 31 voltar por acidente numa tela nova —
trocar `allowsSoftwareKeyboard` errado só é possível agora dentro do
`SearchField` em si, não mais espalhado em 14 cópias.

**Fora do escopo desta rodada**: os balões pequenos de edição rápida
(`EditableText`/`EditableNumber`/`InlineTextField` em `PaperFields.swift`,
mais os campos soltos de `CampaignIndexView`/`MarkDeadSheet`/
`CharacterSheetView`) continuam só-caneta, sem o botão de teclado — não
são "campo de texto + lista" (o que o usuário relatou), e o espaço
apertado desses balões (340×64pt ou menos) deixaria o ícone de teclado
apertado ali dentro. Se fizer falta digitar num deles também, entra numa
rodada futura.

Sem simulador — verificação foi `grep` confirmando os 14 `searchField`
convertidos pra `SearchField(...)` e nenhum `HandwritingField` cru
sobrando nesses lugares, mais balanceamento de parênteses/chaves em
todo `Views/*.swift`.

## 33. Dois retoques no item 32 — teclado abre no mesmo toque, botão "use as-is" mais forte (2026-09-21, v1.23)

Usuário, depois de confirmar que o item 32 funcionou: (1) perguntou se
o ícone de teclado dava pra já ABRIR o teclado, não só destravar a
possibilidade — do jeito que tinha ficado, tocar o ícone só permitia o
teclado aparecer, mas o usuário ainda precisava tocar o CAMPO em
seguida pra ele realmente subir, dois toques em vez de um; (2) notou
que o botão "use ... as-is" dos seletores (aparece quando o que foi
escrito não bate com nada da base) está apagado demais — `Paper.
printedItalic(13)` + `Paper.inkSoft`, a mesma linguagem visual que o
app usa pra texto explicativo/nota de rodapé, não pra ação — dá a
entender que é só uma legenda, não um botão que faz algo.

**Item 1 — teclado abre no mesmo toque**: `HandwritingField` ganhou
`requestsFocus: Binding<Bool>` (default `.constant(false)`, então todo
uso antigo continua igual sem precisar mudar nada) — quando verdadeiro,
`updateUIView` chama `uiView.becomeFirstResponder()` (assíncrono, via
`DispatchQueue.main.async`, porque mexer de volta no `Binding` durante
um ciclo de atualização da SwiftUI dispara "modifying state during view
update") e desliga o próprio pedido de volta a `false` na sequência —
um gesto de "fogo e esquece", nunca fica ligado depois do primeiro foco
(senão um re-render qualquer roubaria o foco à força de novo). O botão
de teclado do `SearchField` agora liga `focusRequested = true` no MESMO
toque que liga `typingEnabled = true` — um toque só, teclado sobe na
hora.

**Item 2 — botão "use as-is" mais forte**: trocado de texto solto
(itálico, tinta clara) pra um selo cheio — fundo `Paper.ink`, texto
`Paper.sheet` em negrito, cantos arredondados, mesma linguagem visual
já usada pelos selinhos de filtro selecionados (`TextFilterChip` do
Magic Item Compendium) — agora lê como um botão de ação de verdade, não
como nota de rodapé. Aplicado nos 3 lugares com exatamente esse padrão:
`WeaponPickerSheet`, `MundaneItemPickerSheet`, `ProficiencyPickerSheet`.
Não mexi nos "use as-is" da Priest Spell Sheet (`SpellSheetView.swift`,
3 ocorrências) — ali o botão já convive misturado numa lista de magias
sugeridas, contexto visual diferente e não reportado; fica pra outra
rodada se fizer falta lá também.

Sem simulador — verificação foi checagem de código linha a linha (com
atenção especial ao `DispatchQueue.main.async` do `requestsFocus`, pra
não disparar antes do `inputView` já estar `nil` — confirmado que a
troca de `inputView` acontece SÍNCRONA, antes do bloco de foco, na
mesma chamada de `updateUIView`) e balanceamento de parênteses/chaves
em todo `Views/*.swift`.

## 34. [ADIADO — backlog] Aplicar regras do PHB na escolha de Class + Kit (2026-09-21)

Usuário pediu pra avaliar (não implementar ainda): ao escolher Class +
Kit na criação/edição do personagem, (a) adicionar automaticamente as
proficiências que o kit concede, (b) avisar se algum atributo estiver
abaixo do mínimo exigido pelo kit, (c) checar se a raça escolhida é
permitida pra aquele kit/classe. Avaliação (sem código ainda, feature
segurada a pedido do usuário pra tratar do seletor de raças primeiro —
ver item 35):

- **(a) e (b) são diretas.** `Kit.mechanics.proficiencies.bonus:
  [String]` já lista os nomes das proficiências que o kit dá, e
  `PlayerCharacter.proficiencies: [ProficiencyEntry]?` é só um array
  simples (`name`/`slots`/`target`) — dá pra popular automaticamente
  casando o nome do kit com o nome exato da Proficiency Compendium
  (mesmo padrão de `Fuzzy.normalize`/`AlignmentOption.match` já usado
  em `AlignmentPicker.swift`). `KitRequirements.abilities: [String:
  Int]` já é um dicionário "atributo → mínimo" pronto pra comparar
  contra `AbilityScores` do personagem e mostrar aviso — nenhum dado
  novo necessário nos dois casos.
- **(c) tem uma lacuna de dado.** `KitRequirements.races: String?` é
  texto livre (ex. "Any except elf", "Half-elf, human") — não uma
  lista estruturada. Levantamento feito no corpus de kits (`grep
  "races:" EmbeddedKits_Part*.swift`) mostrou só 14 padrões distintos,
  todos simples (listas separadas por vírgula, "Any", "Any except X [e
  Y]") — melhor do que o temido no início: dá pra estruturar
  (`allowedRaces: [String]` + flag "sem restrição") sem virar
  curadoria manual pesada. Ainda assim é trabalho extra que os itens
  (a)/(b) não têm, por isso fica pra depois deles.
- **Arquitetura**: o motor de regras já existente (`RuleProvider` →
  `RulesetRegistry` → `ConsequenceEngine` → `ConsequencePreviewSheet`,
  hoje usado em subida de nível/mudança de atributo) é o encaixe
  natural — mas `RuleContext` hoje só carrega `level`/`characterClass`/
  `abilities`, precisaria ganhar `kit` e `race` pra essas regras novas
  entrarem nele. Alternativa mais simples: uma validação própria só
  pra tela de escolha de kit, sem passar pelo `ConsequenceEngine` (que
  foi desenhado pra comparar "antes/depois" de uma mudança já feita,
  não pra avisar ANTES de confirmar uma escolha) — decidir isso quando
  a feature voltar à mesa.

Nada implementado ainda — é só o registro da avaliação pedida, pra não
perder o raciocínio até a feature ser retomada.

## 35. Seletor de Raça (PHB) + sinal de "mudou sozinho" na ficha (2026-09-22, v1.24)

Usuário pediu pra segurar o item 34 (regras de Class+Kit) e focar num
seletor de Raça primeiro. Sessão inteira de investigação/conferência de
dados ANTES de escrever qualquer código — resumo do que foi decidido e
por quê:

**Levantamento de dados (feito em conversa, sem gravar nada ainda):**
As 6 raças do PHB (Human, Dwarf, Elf, Gnome, Half-Elf, Halfling — sem
Half-Orc, que só existe em suplemento) e as tabelas envolvidas já
estavam TODAS no corpus de Regras (`Store/EmbeddedRules_Part*.swift`):
Table 7 PHB "Racial Ability Requirements" (`phb_ch02_character_race_tables`,
mínimo/máximo de atributo + ajustes fixos), Table 7 DMG "Racial Class
and Level Limits" (`dmg_ch02_racial_level_restrictions` — é citação do
DMG, não do PHB, apesar do mesmo número de tabela; corrigido depois que
o usuário perguntou "Dwarf não pode ser Paladino?"/"Elfo só chega a 15
como mago?" e eu reconferi a fonte linha por linha), Table 8 "Prime
Requisite Bonuses", e as descrições em prosa de cada raça
(`phb_ch02_dwarf`/`_elf`/`_gnome`/`_half_elf`/`_halfling`/`_human`), de
onde saiu a resistência mágica de verdade do Elf (90% vs. sleep/charm)
e Half-Elf (30%) e o bônus de saving throw por Constituição do
Dwarf/Gnome/Halfling.

**Bug de dado encontrado e corrigido com a ajuda do usuário**: a Table 7
DMG (Class and Level Limits) tinha os `headers` com 6 colunas de raça
mas cada `row` só trazia 5 valores — uma coluna inteira (Halfling)
tinha se perdido na extração do corpus, provavelmente um problema de
OCR/scraping no momento em que esse material foi processado. Eu não
tinha percebido isso na hora — cheguei a "completar" os números de
Halfling de memória própria em respostas anteriores da conversa, o que
violava a regra de nunca inventar dado de regra fora do corpus. O
usuário mandou uma foto da página real do PHB com a tabela completa;
usei ela pra fechar só a coluna que faltava (Halfling), mantendo as
outras 5 exatamente como já estavam (bateram 100% com o corpus). Lição
registrada: sempre CONTAR as colunas de `headers` contra o tamanho de
cada `row` antes de apresentar uma tabela extraída como confiável —
neste caso o corpus tinha um `RuleTable` estruturalmente inconsistente
e passou despercebido até eu tentar transcrever pra código de verdade.

**Decisões de escopo (todas do usuário, registradas aqui pra não
repetir a pergunta depois):**
1. Multi-classe/dual-classe por raça — fica de fora por enquanto
   (só texto corrido no PHB, sem tabela estruturada; entra numa rodada
   futura se for pedido).
2. Arquitetura: enum fechado com dados fixos (`Models/Race.swift`),
   mesmo padrão do `AlignmentOption` — não passa pelo `RuleEngine`/
   `RulesetRegistry` em tempo de execução, porque o conteúdo é fixo e
   sem ambiguidade, igual o Alignment.
3. Regra geral de aplicação: **quando a raça determina algo sozinha,
   sem depender de decisão do jogador e sem BLOQUEAR nada (nível
   máximo, por exemplo) — aplica direto na ficha.** Quando envolve um
   limite/trava (mínimo de atributo, limite de classe/nível) — só
   aviso, mostrando a tabela oficial, nunca impede a escolha.

**O que ficou dentro de "aplica direto" (regra 3 acima):**
- `PlayerCharacter.race` — grava o nome escolhido.
- Ajustes fixos de atributo (`RaceOption.abilityAdjustments`): Dwarf
  +1 CON/−1 CHA, Elf +1 DEX/−1 CON, Gnome +1 INT/−1 WIS, Halfling +1
  DEX/−1 STR (Human e Half-Elf não têm ajuste nenhum).
- `SavingThrows.spellResistance` (campo que já existia — "linha extra
  do PDF oficial", descoberto nesta investigação): Elf ganha "90% vs.
  sleep & charm", Half-Elf "30% vs. sleep & charm", as outras raças
  ficam vazias.
- `PlayerCharacter.racialAbilities` (a caixa "Racial Abilities" da
  página 4) — preenchida com um resumo de referência (infravisão,
  bônus de combate, detecção subterrânea etc.), mas SÓ se o campo
  ainda estiver vazio — nunca sobrescreve texto que o jogador já
  escreveu ali.

**O que ficou como AVISO apenas, mostrando a tabela (nunca trava):**
- Mínimo/máximo de atributo (Table 7 PHB) — se o atributo atual do
  personagem estiver fora da faixa da raça escolhida.
- Limite de classe/nível (Table 7 DMG) — se a classe atual do
  personagem não bate com o que a raça permite, ou já passou do nível
  máximo permitido.
- Implementado como um painel dentro do próprio `RacePickerSheet`
  (`RaceWarningPane`), não um `.alert()` do sistema — porque o pedido
  era "mostrando a tabela", e um alert nativo não formata texto em
  lista decentemente. Escolher uma raça sem aviso nenhum aplica na
  hora; com aviso, troca a lista por esse painel com "Cancel"/"Use
  [raça] anyway" antes de aplicar.

**Deixado de fora por enquanto (documentado, não esquecido)**: o bônus
de saving throw vs. magia/veneno por Constituição que Dwarf, Gnome e
Halfling ganham (Table 9) NÃO entra automaticamente nos 5 números de
`SavingThrows` ainda — esse bônus mistura categorias (o bônus de
veneno do Halfling não vale pra Paralyzation/Death, que dividem a
mesma célula na ficha), e aplicar direto arriscaria inflar um número
que a regra não cobre. `RaceOption.hasConstitutionSaveBonusVsMagic`
já existe como sinalizador, só falta decidir como (ou se) refletir
isso nos números da ficha sem essa ambiguidade.

**Sinal "mudou sozinho" (pedido extra do usuário nesta mesma rodada)**:
`PlayerCharacter.recentAutoChanges: Set<String>?` guarda quais campos
foram tocados por uma ação automática (hoje só o seletor de Raça) e
ainda não "piscaram" — `Views/ChangeFlash.swift` (novo) é um
`ViewModifier` genérico e reutilizável (`.changeFlash(character:key:)`)
que lê essa marca, acende um fundo verde-menta (mesma cor do
`ConsequenceSignalBadge`) por ~2s com fade de entrada/saída, e consome
a marca sozinho — pensado pra qualquer campo futuro que outra automação
venha a mexer sozinha, não só raça. Aplicado nos 6 campos de atributo
(`AbilityRowForm`, novo parâmetro opcional `flashKey`), em `Spell
Resistance` (`SaveResistanceLine`, que ganhou binding de `character`
pra isso) e em `Racial Abilities`
(`CharacterDescriptionPage.descriptionTable`). Não usa relógio de
parede — o contador só começa quando o campo aparece na tela de
verdade (`onAppear`/`onChange`), então escolher raça na aba
"Description" e só depois abrir a aba "Sheet" ainda mostra o atributo
piscando lá, em vez de a animação já ter acontecido escondida numa aba
fechada.

**Arquivos novos**: `Models/Race.swift` (o enum `RaceOption` com todas
as tabelas + `apply(to:)`), `Views/RacePickerSheet.swift`
(`RaceDescCell`, `RacePickerSheet`, `RaceWarningPane`),
`Views/ChangeFlash.swift` (`ChangeFlash`/`OptionalChangeFlash` e a
extensão `.changeFlash`).
**Arquivos mexidos**: `Models/Character.swift` (campo
`recentAutoChanges` + 3 helpers em `PlayerCharacter`),
`Views/CharacterSheetView.swift` (`AbilityRowForm` ganhou `flashKey`,
`SaveResistanceLine` ganhou binding de `character`),
`Views/CharacterDescriptionView.swift` (célula "Race" trocada por
`RaceDescCell`, célula "Racial Abilities" ganhou `.changeFlash`).

Sem simulador — verificação foi checagem de código linha a linha
(nomes de campo conferidos contra `PlayerCharacter`/`AbilityScores`/
`SavingThrows`/`CharacterClass` reais antes de escrever qualquer
switch, pra não inventar chave que não existe) e o script de
balanceamento de parênteses/colchetes/chaves em todo arquivo novo ou
mexido nesta rodada.

## 36. v1.25 — dois bugs relatados na v1.24 (seletor de Raça e piscada de mudança automática)

**2026-09-22.** Logo depois de entregar a v1.24 (item 35), o usuário
testou no iPad de verdade e reportou dois problemas:

1. "Não consigo nem setar a raça... não tem opção de selecionar nem de
   escrever" — o campo "Race" na aba Description não reagia a toque
   nenhum, nem abria o seletor nem deixava escrever livre (que era o
   comportamento antigo, antes da v1.24).
2. "As alterações feitas automaticamente não estão ficando de outra
   cor temporariamente, ou está muito sutil que nem vejo" — a piscada
   do `ChangeFlash` não aparecia de forma perceptível.

**Investigação.** Sem simulador nem compilador Swift neste ambiente,
a verificação foi 100% leitura de código: reli `Models/Race.swift`,
`Views/RacePickerSheet.swift`, `Views/ChangeFlash.swift` e os pontos
de uso em `Views/CharacterDescriptionView.swift` e
`Views/CharacterSheetView.swift` inteiros, linha a linha, comparando
com o padrão do Alignment (`DescCellPicker`/`AlignmentPickerSheet`,
que já existia antes e continuava funcionando normal segundo o
usuário) — mesma estrutura (`Button` com `.buttonStyle(.plain)` +
`.sheet(isPresented:)`), mesmos nomes de campo (`character.race`,
`character.abilities.*`, `character.saves.spellResistance`,
`character.characterClass`, `character.level`), mesmos tipos
auxiliares (`Fuzzy`, `SearchField`, `PaperBackground`, `DottedRule`,
`Ember.mintGlow`) — todos existentes e usados do jeito certo. Também
conferi o zip `THAC0berry_v1.24.zip` já entregue contra a cópia local:
idêntico, sem corrupção. Perguntei pro usuário se o Alignment (mesmo
padrão de botão+sheet, na mesma tela) continuava funcionando — ele
confirmou que sim, só o Race que ficou inerte — o que descarta erro de
compilação (se o módulo inteiro não compilasse, nada mais funcionaria,
nem o Alignment) e aponta pra algo específico do `RaceDescCell`/
`RacePickerSheet`, mas **não encontrei uma causa concreta e
reproduzível revendo o código** — o padrão é byte-a-byte equivalente
ao do Alignment que funciona.

**O que mudou mesmo sem causa confirmada** (mudança defensiva, pra
reduzir a superfície de risco, não uma correção comprovada):

- `RaceDescCell` deixou de ter seu próprio `@State private var
  isPickerPresented` — esse estado subiu pra
  `CharacterDescriptionPage` (`isRacePickerPresented`, passado como
  `Binding<Bool>`). Motivo: `RaceDescCell` é instanciado dentro de
  `descriptionTable`, uma `var` computada (não um tipo próprio)
  reavaliada a cada re-render da página — o `@State` interno *deveria*
  sobreviver a isso (identidade estrutural estável, igual o
  `DescCellPicker` que já fazia a mesma coisa e funciona), mas por
  segurança tirei essa variável de dentro de uma struct recriada com
  frequência e botei num lugar que só existe uma vez por página.
- Acrescentei `.contentShape(Rectangle())` explícito no label do botão
  do Race (o `DescCellPicker` não tinha isso e funciona, então não é a
  causa raiz mais provável, mas é uma prática recomendada pra evitar
  área de toque menor que a moldura visível, sem custo nenhum).
- `ChangeFlash`: subiu a opacidade do fundo de 0.45 pra 0.75, **somou
  uma borda sólida** da mesma cor (`Ember.mintGlow`) por cima — o
  fundo sozinho quase não aparecia em cima de campos pequenos como os
  de atributo — e esticou o tempo aceso de 2.2s pra 3.2s.

**Se o campo Race continuar sem reagir a toque depois desta versão**,
o próximo passo é um teste mais cirúrgico direto no dispositivo (typar
algo temporário tipo mudar a cor de fundo do botão só pra confirmar se
o toque está sendo capturado antes mesmo de abrir o sheet), porque a
leitura de código sozinha já foi esgotada nesta rodada sem achar o
defeito.

**Arquivos mexidos nesta rodada**: `Views/RacePickerSheet.swift`
(`RaceDescCell` perdeu o `@State` próprio, ganhou `isPresented:
Binding<Bool>` e `.contentShape`), `Views/CharacterDescriptionView.swift`
(`CharacterDescriptionPage` ganhou `isRacePickerPresented`, call site
do `RaceDescCell` atualizado), `Views/ChangeFlash.swift` (opacidade,
borda, duração), `Package.swift` (1.24/131 → 1.25/132).

## 37. v1.26 — causa real do bug do Race achada: campo duplicado, seletor só ligado num dos dois

**2026-09-22.** O usuário mandou print de tela confirmando o bug do
item 36 — e o print revelou a causa de verdade, que a leitura de
código sozinha (sem rodar o app) não tinha pego: **existem DOIS
campos "Race" na ficha**, os dois lendo/escrevendo o mesmo
`character.race`, mas em telas diferentes:

1. `RecordHeaderForm` (`CharacterSheetView.swift`) — o cabeçalho da
   PÁGINA 1, a primeira coisa que aparece ao abrir a ficha, bem ao
   lado do campo Alignment.
2. `CharacterDescriptionPage.descriptionTable` (`RaceDescCell`) — a
   tabela da aba "Character Description", página 4, um espelho da
   mesma informação pra bater com o layout do PDF oficial.

O seletor de Raça (item 35) só tinha sido ligado no nº 2. O nº 1 —
que é o campo que o usuário estava de fato tocando, porque é o
primeiro que aparece — continuava com o `EditableText` livre de
sempre. Isso bate exatamente com os dois sintomas do print:

- Ficha já existente (Kelmon, Race = "Human"): tocar abria o balão de
  edição de texto livre do `EditableText` (a tela com "Elf" digitado,
  X e "done" no print) — nunca o seletor.
- Ficha nova (Race = "" vazio): `EditableText(value: ..., placeholder:
  "")` com texto E placeholder vazios praticamente não desenha nada
  nem dá área de toque nenhuma — daí "não tem opção de selecionar nem
  de escrever" ser literal: o campo estava lá, mas invisível e sem
  alvo de toque.

A piscada de cor "continua imperceptível" também se explica sozinha
por isso: o usuário nunca tinha conseguido de fato aplicar uma raça
(só mexia no campo errado), então `RaceOption.apply(to:)` nunca
rodou, `recentAutoChanges` nunca foi marcado, e não tinha o que
piscar — não era (só) questão de opacidade.

**Correção**: novo `RaceField` (`Views/RacePickerSheet.swift`), mesmo
padrão do `AlignmentField` que já existia do lado dele no cabeçalho —
`Button` com `HandValue` (texto "—" quando vazio) que abre o mesmo
`RacePickerSheet`. Troquei o `EditableText` do `RecordHeaderForm`
por ele. Os dois campos (cabeçalho e tabela da página 4) agora abrem
o mesmo seletor e escrevem no mesmo `character.race` — continuam
sincronizados porque sempre foram o mesmo dado, só a UI de edição que
tava faltando num dos dois lugares.

Mantidas também as mudanças defensivas do item 36 (estado do seletor
subido pra `CharacterDescriptionPage`, `.contentShape` explícito,
piscada mais forte) — não atrapalham nada, e a piscada mais visível
ainda vale a pena agora que o fluxo de aplicar raça vai realmente
rodar.

**Arquivos mexidos**: `Views/RacePickerSheet.swift` (`RaceField`
novo), `Views/CharacterSheetView.swift` (`RecordHeaderForm` usa
`RaceField` em vez de `EditableText` na linha "Race"), `Package.swift`
(1.25/132 → 1.26/133).

## 38. v1.27 — três ajustes depois do Race funcionar de verdade

**2026-09-22.** Com o campo Race do cabeçalho funcionando (item 37), o
usuário testou de verdade e mandou mais 3 pontos:

**1. "Racial Abilities" quebrando o layout.** Ao trocar de raça, o
texto que `RaceOption.apply(to:)` preenche sozinho (um parágrafo
inteiro, ex. a descrição de habilidades do Half-Elf) vazava pra fora
da célula, por cima das colunas vizinhas (print anexado confirmou).
Causa: a célula usava `DescCell`/`InlineTextField`, que é baseado em
`HandwritingField` de UMA LINHA SÓ, sem quebra de texto — nunca doeu
antes porque o jogador só digitava frases curtas ali. Troquei só essa
célula pra usar `PaperTextEditor` (a mesma já usada em
Personality/Background/Noteworthy Events, baseada num `TextEditor`
de verdade, com quebra de linha e contida na própria moldura).

**2. Campos duplicados (Race/Alignment).** O usuário pediu pra tirar
a edição duplicada — Race e Alignment editáveis tanto no cabeçalho
(página 1) quanto na tabela de "Character Description" (página 4).
Decisão: manter as DUAS células na tabela da página 4 (pra bater com
o layout do PDF oficial, que tem essas colunas), mas trocá-las pra
`DescCellStatic` (só-leitura) — exatamente o mesmo tratamento que
"Class" já tinha ali, com o mesmo motivo ("já edita na página 1, não
precisa de um segundo jeito"). Removi o código agora morto:
`DescCellPicker` (o botão+sheet do Alignment na página 4) e
`RaceDescCell` (o equivalente pro Race, do item 35 — nunca chegou a
ser o problema real, era só um espelho que ninguém tocava).

**3. Saving Throws e THAC0 sem destaque quando nível/atributo muda.**
O app já tinha um sinal de "algo mudou, vem conferir"
(`ConsequenceSignalBadge`, de uma sessão anterior a esta) — mas ele só
aparecia perto do campo Level/atributo em si (`effectiveChangedField`,
que mostra só UM sinal por vez, no último campo mexido). Saving
Throws e THAC0 são justamente as coisas que o jogador precisa ir
conferir/recalcular na mão quando nível ou atributo muda, e não
tinham sinal nenhum. Acrescentei o mesmo `ConsequenceSignalBadge`
(menor, diâmetro 30) no título de "Saving Throws" e ao lado do campo
THAC0 base, ativo com `character.hasPendingConsequences` (não o
`effectiveChangedField` de um único campo — aqui faz sentido mostrar
sempre que HOUVER algo pendente, já que os dois dependem de nível E
de todos os atributos). Tocar continua abrindo o mesmo
`ConsequencePreviewSheet` de sempre, que já mostra a lista completa
do que mudou.

**Arquivos mexidos**: `Views/CharacterDescriptionView.swift`
(Alignment/Race viram `DescCellStatic`, `DescCellPicker` removido,
"Racial Abilities" usa `PaperTextEditor`, `isRacePickerPresented`
removido de `CharacterDescriptionPage` — não tinha mais chamador),
`Views/RacePickerSheet.swift` (`RaceDescCell` removido, comentários
atualizados), `Views/CharacterSheetView.swift` (badge no título de
Saving Throws e ao lado do THAC0 base), `Package.swift` (1.26/133 →
1.27/134).

## 39. v1.28 — Alignment e Race saem de vez da tabela da página 4

**2026-09-22.** O usuário achou que a versão só-leitura do item 37
ainda ia confundir ("vai tentar alterar por ali e não vai conseguir")
e pediu pra remover os campos de verdade, sem quebrar o layout.

As duas linhas que tinham Alignment/Race (cada uma com 4 colunas:
`Alignment | Deity | Height | Weight` e `Race | Nationality | Hair |
Eyes`) viraram UMA linha só com os 6 campos que sobraram — Deity,
Height, Weight, Nationality, Hair, Eyes — em 6 colunas iguais. Essa
linha sai da grade `q1/q2/q3/q4` compartilhada com o resto da tabela
(que existe pra alinhar as bordas verticais entre todas as linhas,
ver comentário mais acima) porque 6 colunas não divide os 4 "quartos"
de forma limpa — mas como é uma tabela editorial (não uma planilha
onde toda borda tem que bater), o desalinhamento de uma linha no meio
é um preço pequeno por não ter mais campo nenhum duplicado. A tabela
caiu de 5 pra 4 linhas (3 × 42pt + 126pt de Racial Abilities), um
pouco mais compacta que antes.

Alignment e Race continuam editáveis só no cabeçalho da página 1
(`RecordHeaderForm` → `AlignmentField`/`RaceField`).

**Arquivos mexidos**: `Views/CharacterDescriptionView.swift` (linha
combinada de 6 colunas, altura da tabela ajustada), `Package.swift`
(1.27/134 → 1.28/135).

## 40. v1.29 — Birth Date/Rank/Age/Sex + Deity/Height/Weight/Nationality/Hair/Eyes em 2 linhas de 5

**2026-09-22.** Pedido do usuário: em vez de 1 linha de 4 (Birth Date/
Birth Rank/Age/Sex) seguida da linha de 6 que sobrou depois de tirar
Alignment/Race (item 39), redistribuir os 10 campos em 2 linhas de 5
cada — melhor aproveitamento do espaço. Ficou: linha 1 = Birth Date,
Birth Rank, Age, Sex, Deity; linha 2 = Height, Weight, Nationality,
Hair, Eyes (mesma ordem de leitura de antes, só cortada diferente).
Colunas iguais (`fifth = larguraTotal / 5`), mesma lógica de "sai da
grade `q1..q4` só nestas linhas" do item 39.

## 41. v1.29 — realce verde de verdade em vez de ícone, no Saving Throws e no THAC0

O usuário testou o sinal do item 38 (`ConsequenceSignalBadge`, o
ícone circular verde) no Saving Throws/THAC0 e não gostou: "ao invés
de deixar os campos alterados em verde, você exibiu o ícone pequeno
ao lado deles. Tá errado." Pediu o mesmo tipo de realce que outras
mudanças automáticas já usam no app (fundo/borda verde direto em
cima do campo, como o `ChangeFlash` da Raça) em vez de um ícone
separado.

Troquei os dois lugares que eu tinha acrescentado no item 38 (mantive
o `ConsequenceSignalBadge` como está em Level/atributos — esse já foi
pedido explicitamente pelo usuário numa sessão anterior, não é o
mesmo caso): novo `PendingConsequenceHighlight`
(`Views/ConsequencePreviewSheet.swift`), um `ViewModifier` puramente
visual — fundo + borda `Ember.mintGlow`, sem `Button` nem toque
próprio (de propósito: embrulhar um `Button` em cima de um campo que
já é tocável sozinho, tipo `EditableNumber`, quebraria o toque dele).
Diferença pro `ChangeFlash`: não é uma piscada que passa sozinha —
fica aceso enquanto `character.hasPendingConsequences` continuar
`true`. Aplicado no título de "Saving Throws" inteiro (não tem um
único campo pra apontar, é a seção toda que precisa de revisão) e no
próprio campo numérico do THAC0 base (esse sim é um valor único).

**Arquivos mexidos**: `Views/CharacterDescriptionView.swift` (linhas
de 5), `Views/ConsequencePreviewSheet.swift`
(`PendingConsequenceHighlight` novo), `Views/CharacterSheetView.swift`
(badge trocado pelo realce em Saving Throws e THAC0), `Package.swift`
(1.28/135 → 1.29/136).

## 42. v1.30 — lote de 6 pedidos: ícone do Kit, filtro de Proficiências, proposta de fonte, XP automático, filtro de Equipamento, Magic Items

**2026-09-22.** Usuário mandou 6 pedidos de uma vez. O que foi feito:

1. **Ícone do Kit mais fácil de tocar.** `KitField`
   (`Views/CharacterSheetView.swift`) não dá pra escrever (é só um
   seletor), então o texto sozinho como alvo de toque era pequeno
   demais e sem aviso visual claro de que abria algo. Acrescentei um
   ícone de seta (`chevron.down.circle.fill`, cor `Ember.crimson`) do
   lado do valor, mais padding vertical e `contentShape` cobrindo a
   linha inteira — a área tocável ficou bem maior, e o ícone deixa
   claro que existe uma lista pra escolher mesmo com o campo vazio.

2. **Proficiências: já filtra por classe?** Não — conferido em
   `ProficiencyPickerSheet` (`Views/ProficiencyCompendiumView.swift`):
   o único filtro que já existia era por cenário de campanha
   (`campaign.allowsAnySetting`). Não há filtro nenhum ligado à classe
   do personagem. Acrescentei um filtro por `primaryGroup` (General/
   Warrior/Wizard/Priest/Rogue/Psionicist/Racial-Special — o único
   eixo "de classe" limpo o bastante no corpus pra virar filtro; o
   outro candidato, `mechanics.groups`, é texto livre demais e mistura
   sourcebook no meio, ex. "Wizard (Rogue - Thief's Handbook)", por
   isso ficou de fora). Fileira de chips nova (`ProficiencyGroupChipRow`),
   seleção única, junto do campo de busca.

3. **Tamanho de fonte — proposta, sem código ainda.** Levada pro
   usuário em texto (não implementada nesta rodada) — ver conversa.

4. **XP needed for next level — preenchimento automático.** Conferido
   primeiro que o corpus de regras TEM as 4 tabelas de progressão
   completas e corretas (Table 14: Warrior, Table 20: Wizard, Table
   23: Priest, Table 25: Rogue — `Store/EmbeddedRules_Part14.swift`/
   `Part15.swift`), cobrindo as 8 classes do app (Fighter, Paladin,
   Ranger, Mage, Cleric, Druid, Thief, Bard) — conferi
   `headers.count`/cada `row.count` linha a linha antes de copiar,
   igual sempre. Copiei os valores pra `Models/
   ExperienceProgressionTable.swift` (constante Swift, não fica
   reparseando texto) e liguei em `ExperienceForm`
   (`Views/CharacterSheetView.swift`): recalcula sozinho quando nível
   OU classe mudam (`onChange`), com o mesmo `ChangeFlash` que a Raça
   já usa. Continua um campo de texto normal — o jogador pode
   sobrescrever à mão se a mesa usar variante de regra diferente.

5. **Filtros no seletor de Equipamento.** `MundaneItemPickerSheet`
   (`Views/MundaneItemCompendiumView.swift`) só tinha busca por nome —
   o único eixo limpo nos dados de item mundano (`MundaneItem.category`
   — Clothing/Food & Lodging/Household Provisioning/Miscellaneous
   Equipment/Services/Tack & Harness/Transport) virou filtro (`cost`/
   `weight` são texto livre, não dá pra filtrar por faixa de valor sem
   parsear cada formato de preço do PHB, o que arriscaria errar
   silenciosamente — fica pra depois se o usuário quiser essa
   granularidade). Fileira de chips por categoria, seleção única,
   igual o padrão novo do item 2.

6. **Magic Items ligado à base.** `QuantifiedItem`
   (`Models/Character.swift`) ganhou `matchedItemID: String?`, mesmo
   padrão de `Page2EquipmentEntry`. Nova `MagicItemQuantifiedRow`
   (`Views/CharacterSheetView.swift`) troca o nome-como-texto-livre por
   um botão: item já ligado (ou nome batendo exato, fallback pra
   fichas antigas) abre a descrição via `MagicItemDetailSheet`; item
   vazio/não-ligado abre `MagicItemPickerSheet`
   (`Views/MagicItemCompendiumView.swift`, novo — busca nos 5.669
   itens de `MagicItemDatabase`, com "usar como digitado" pra item
   caseiro/criado pelo jogador, igual `MundaneItemPickerSheet` já faz
   pro Equipment). `QuantityListBlock` ganhou a flag
   `usesMagicItemDatabase` pra trocar de linha só no bloco "Magic
   Items" — "Treasure / Other Possessions" continua 100% texto livre,
   sem nenhuma mudança.

**Arquivos mexidos**: `Views/CharacterSheetView.swift` (`KitField`,
`ExperienceForm`, `QuantifiedItemRow`/`QuantityControls`/
`MagicItemQuantifiedRow`/`QuantityListBlock`), `Views/
ProficiencyCompendiumView.swift` (filtro de grupo), `Views/
MundaneItemCompendiumView.swift` (filtro de categoria), `Views/
MagicItemCompendiumView.swift` (`MagicItemPickerSheet` novo),
`Models/Character.swift` (`QuantifiedItem.matchedItemID`), `Models/
ExperienceProgressionTable.swift` (novo), `Package.swift`
(1.29/136 → 1.30/137).

## 43. v1.31 — retoques no lote 42: ícone do Kit, blur por classe, fonte, bug do XP e bug do sinal preso

**2026-09-22.** Usuário testou o item 42 e voltou com 7 pontos:

1. **Kit — visual não ficou bom.** Tirei o ícone de seta
   (`chevron.down.circle.fill`) que eu tinha acrescentado; agora o
   campo mostra "None" (em vez de "—") quando não há kit escolhido, e
   o próprio texto continua sendo o botão que abre o seletor — igual
   sugerido. A área de toque maior (`contentShape`/padding) continuou
   por baixo dos panos, só sem elemento visual novo.

2. **Proficiências — esmaecer grupos que não são o da classe.** Em vez
   de só filtrar, agora toda linha que não é "General" nem o grupo da
   classe do personagem (`CharacterClass.proficiencyGroup`, novo —
   Warrior/Wizard/Priest/Rogue por classe) fica com opacidade
   reduzida (0.4) — continua visível e tocável, só menos chamativa. O
   chip do grupo da classe ganhou uma estrelinha (★) no rótulo. Só
   esmaece quando nenhum filtro de grupo foi escolhido a dedo (aí o
   jogador já filtrou de propósito).

3. **Fonte — passo 1 aplicado.** Todo `8.5pt` do app (rótulos da
   tabela de Character Description, cabeçalho da tabela de
   Encumbrance, chips de filtro por cenário em Proficiências/Grimório)
   subiu pra `10pt` — o piso agora é 10pt em vez de 8.5pt. Nenhum
   `frame` fixo precisou mudar (os lugares onde isso foi aplicado já
   tinham `maxWidth: .infinity` ou `minimumScaleFactor`, sem risco de
   cortar texto).

4. **Bug: XP needed for next level não atualizava ao subir/descer de
   nível.** Causa raiz: a página 2 (`ExperienceForm`) vive dentro de
   um `UIPageViewController` (`RecordSheetPagerView`) que só atualiza
   a página VISÍVEL — mudar o nível na página 1 nunca disparava o
   `onChange` de `ExperienceForm` porque a página 2 estava fora de
   tela e "congelada". Mudei a conta pra um método no MODELO
   (`PlayerCharacter.refreshXPNeededNextLevel()`), chamado direto de
   onde nível e classe são editados DE VERDADE (`RecordHeaderForm` →
   `onChange(of: character.level)`, e `ClassPicker.select(_:)`) — a
   página 2 continua recalculando no `onAppear`, mas só como segunda
   garantia agora.

5. Ok, filtro de Equipamento aprovado, sem mudança.

6. Ok, Magic Items aprovado, sem mudança.

7. **Bug novo: sinal de consequência ficava preso na tela.** Subir o
   Kelmon pro nível 12 só mexeu em slots de magia (`kind:
   .alreadyAutomatic` — já em vigor sozinho, sem nada "pra aplicar")
   — sem nenhum item `.autoApplicable`, o `ConsequencePreviewSheet`
   nunca mostrava o botão "Apply automatic changes", só "close". E
   "close" nunca chamava `character.markConsequencesReviewed()`,
   então `hasPendingConsequences` ficava `true` pra sempre, com o
   sinal aceso sem jeito nenhum de apagar. Corrigido: quando não há
   nada aplicável (`!hasAutoApplicable`), "close" agora TAMBÉM marca
   revisado — só abrir e ler a janela já é a revisão completa nesse
   caso. Quando existe algo de verdade aplicável e o jogador fecha
   sem aplicar, o sinal continua aceso de propósito.

**Arquivos mexidos**: `Views/CharacterSheetView.swift` (`KitField`,
`RecordHeaderForm`, `ClassPicker`, `ExperienceForm`), `Views/
ProficiencyCompendiumView.swift` (esmaecimento por grupo), `Views/
ConsequencePreviewSheet.swift` (`closeTapped()`), `Views/
CharacterDescriptionView.swift`/`Views/SpellbookView.swift` (fontes
8.5→10pt), `Models/Character.swift`
(`CharacterClass.proficiencyGroup`, `PlayerCharacter.
refreshXPNeededNextLevel()`), `Package.swift` (1.30/137 → 1.31/138).

## 44. v1.32 — retoques no item 43: None de verdade no Kit, "change" no Magic Item, opacidade que não aparecia

**2026-09-22.** Usuário testou o item 43 e voltou com mais ajustes:

1. **Kit sem volta pro "None".** O `KitPickerSheet` já tinha um jeito
   de limpar (um linkzinho "Clear current kit" abaixo da busca), mas
   claramente não estava óbvio o suficiente — usuário não achou.
   Virou uma linha de verdade no TOPO da lista, com a mesma cara de
   qualquer Kit escolhível (estrela quando é a seleção atual), sempre
   visível (não só quando já há um kit escolhido) — muito mais fácil
   de achar que um link de texto pequeno.

   **Magic Items sem "change".** `MagicItemDetailSheet` não tinha o
   botão "change" que `MundaneItemDetailSheet`/`ProficiencyDetailSheet`
   já têm — ganhou um `onChangeItem` opcional (`nil` na consulta solta
   do Compêndio, preenchido só quando abre a partir da ficha) que
   fecha a descrição e reabre `MagicItemPickerSheet`, mesmo padrão do
   Equipment mundano.

2. **Opacidade "não funciona".** 0.4 de opacidade sozinho não lia como
   "esmaecido" — tinta escura sobre pergaminho claro numa alfa só
   ainda parece texto normal de relance. Reforçado pra 0.28 JUNTO com
   `saturation(0)` nas linhas esmaecidas — a combinação dos dois é
   bem mais perceptível que opacidade sozinha. Também reordenei os
   chips: "General" e o grupo da classe do personagem agora vêm
   primeiro (mais à esquerda), antes do resto da ordem fixa —
   `availableGroups` calcula os dois recomendados primeiro, filtra
   pra não duplicar, e só depois anexa o resto.

3. **Fonte, fase 2 — análise de risco (sem código ainda).** Levada pro
   usuário em texto — ver conversa.

**Arquivos mexidos**: `Views/KitCompendiumView.swift` (linha "None"),
`Views/MagicItemCompendiumView.swift` (`onChangeItem`), `Views/
CharacterSheetView.swift` (fio do `onChangeItem`), `Views/
ProficiencyCompendiumView.swift` (opacidade reforçada, reordenação de
chips), `Package.swift` (1.31/138 → 1.32/139).

## 45. v1.33 — fonte, fase 2 (escopo reduzido, célula por célula)

**2026-09-22.** Usuário topou a fase 2 depois da análise de risco.
Em vez de um multiplicador único, fui célula por célula em
`CharacterSheetView.swift` (maior concentração de larguras fixas — 66
`frame(width:)`), subindo SÓ onde havia folga real: campos com
`minimumScaleFactor` já configurado (a fonte cresce e, se algum dia
não couber, o próprio SwiftUI encolhe de volta sozinho — sem risco de
cortar texto) ou frame flexível (`maxWidth: .infinity`, ou largura
generosa sobrando pro texto que cabe nela).

Mudanças: `FormCell` (rótulo genérico de célula, usado 5× —
Encumbrance e outras) 7.5→9pt; cabeçalho "Start/Mod/Total" da tabela
de Saving Throws 7.5→9pt (ganhou `lineLimit(1)`/
`minimumScaleFactor(0.75)` de segurança, já que a coluna é estreita —
34pt); "XPs Needed"/"Total XPs" (`ExperienceHeaderCell`) 9→10pt;
cabeçalho "By"/"At Levels" (Level Changes) 9→10pt; rótulos de linha
de Encumbrance ("Light"/"Moderate"/...) e de Level Changes
10→11pt (ambos já tinham `minimumScaleFactor`); "ARMOR"/"CLASS" (selo
do escudo de AC), "Hit Dice:", a nota itálica abaixo do THAC0 base, e
"of" (nas linhas de quantidade) 10→11pt, todos sem restrição de
largura.

Deixei de fora de propósito: os cabeçalhos das tabelas de
Equipamento/Armas/Proficiências (colunas de 24-54pt de largura sem
`minimumScaleFactor`, tipo "Wt"/"Chk"/"Slots") — já estão no piso de
10-10.5pt da fase 1 e uma coluna daquelas não tem folga nenhuma pra
crescer sem cortar texto ou desalinhar com a linha de dados embaixo;
a tabela de Character Description (`CharacterDescriptionView.swift`)
— a altura de linha é uma conta FIXA só (`42 * 3 + 126`), mudar a
fonte sem recalcular essa conta arrisca cortar texto verticalmente, e
eu não tenho como testar isso sem compilador; e `SpellSheetView.swift`
— já estava inteira em 10pt ou mais antes desta rodada, nenhum
"pequeno demais" sobrando pra resolver.

**Arquivos mexidos**: `Views/CharacterSheetView.swift` (13 tamanhos de
fonte ajustados, listados acima), `Package.swift` (1.32/139 →
1.33/140).

## 46. v1.34 — fonte, fase 2 (tabela de Character Description)

**2026-09-22.** Usuário aprovou o resultado da fase 2 em
`CharacterSheetView.swift` ("Boa! Ficou bom.") e pediu pra seguir pra
uma das outras 3 áreas deixadas de fora na análise de risco do item
45 ("Bora pra uma das outras 3 áreas citadas") — escolhi a tabela de
dados pessoais de `CharacterDescriptionView.swift` por ser conteúdo de
alta visibilidade (primeira coisa que se vê na página).

O risco identificado no item 45 era real: a `GeometryReader` da
tabela inteira tem uma altura FIXA vinda de fora (antes,
`.frame(height: 42 * 3 + 126)`), soma das alturas mínimas de cada
`DescCell`/`DescCellStatic`. Subir a fonte sem subir essa conta junto
arriscava cortar texto verticalmente (o `126` do bloco "Racial
Abilities" nem era um número solto — já era `42 × 3`, só que escrito
na mão). Resolvido criando uma constante única `rowHeight` (subiu de
42 pra 46) e trocando a conta fixa por `rowHeight * 3 + rowHeight * 3`
— a mesma fórmula de antes, só que derivada da constante em vez de
recalculada à mão, então qualquer ajuste futuro de altura de linha
propaga sozinho pra tabela inteira sem precisar decorar a conta. Toda
célula (`Character Name`/`Player Name`, `Birth Date`/`Birth Rank`/
`Age`/`Sex`/`Deity`, `Height`/`Weight`/`Nationality`/`Hair`/`Eyes`,
`Skin`/`Vision`/`Handedness`/`Class`/`Origin`) agora passa
`minHeight: rowHeight` explicitamente em vez de depender do valor
default sozinho, deixando a intenção clara no call site.

Fontes: rótulo pequeno de cada célula (`DescCell`/`DescCellStatic`,
"Character Name"/"Age"/"Deity"/etc.) 10→11pt; valor digitado
(`InlineTextField` dentro de `DescCell`) 13→14pt; valor fixo da
célula "Class" (`DescCellStatic`, `Paper.hand`) 17→18pt; rótulo
"Racial Abilities" 10→11pt (a caixa em si só usa `PaperTextEditor`,
que já rola o próprio conteúdo — sem risco de corte, só a altura da
caixa que subiu junto com `rowHeight * 3`, de 126 pra 138, pra
continuar batendo com as 3 sub-linhas de Skin/Vision/Handedness/
Class/Origin ao lado).

Deixei de fora, como no item 45: os cabeçalhos das tabelas de
Equipamento/Armas/Proficiências (`CharacterSheetView.swift`, colunas
estreitas sem `minimumScaleFactor`) e `SpellSheetView.swift` (já
estava tudo em 10pt+ antes da fase 2 começar) — continuam nas duas
áreas restantes das 3 citadas pelo usuário, caso ele peça pra seguir
mais uma rodada.

**Arquivos mexidos**: `Views/CharacterDescriptionView.swift`
(`rowHeight` extraído como constante, fontes de `DescCell`/
`DescCellStatic` subidas, altura da tabela e da caixa "Racial
Abilities" recalculadas em cima da constante), `Package.swift`
(1.33/140 → 1.34/141).

## 47. v1.35 — dois retoques no v1.34 (rótulo Personality + linha Character/Player Name)

**2026-09-22.** Usuário testou o v1.34 e voltou com print + 2 pontos:

1. "O texto 'Personal Abilities' [sic, é 'Personality'] está
   nitidamente menor que 'Racial Abilities' e 'Character Sketch'."
   Raiz: o item 46 subiu "Racial Abilities" pra 11pt junto com o
   resto da tabela, e "Character Sketch" (título da caixa de retrato)
   já estava em 11pt de antes — mas "Personality" (rótulo do bloco
   logo abaixo da tabela) tinha ficado pra trás em 10pt, sem eu ter
   notado que os três títulos aparecem lado a lado/próximos na
   mesma página e precisam bater. Corrigido: 10→11pt.
2. "Na primeira linha desta página, configure tamanhos iguais para
   Character Name e Player Name." Não era questão de fonte (as duas
   células já usavam o mesmo tamanho) e sim de LARGURA da caixa:
   "Character Name" usava `q1 + q2` (a `q1` carrega um peso extra de
   1.8x, criado só pra dar mais espaço à caixa "Racial Abilities" lá
   embaixo) enquanto "Player Name" usava `q3 + q4` (peso 1x cada) —
   a caixa de Character Name saía uns 40% mais larga que a de Player
   Name. Corrigido com uma constante nova, `half` (metade da largura
   total da tabela), usada nas duas células dessa linha. Como a 1ª
   linha não precisa mais alinhar borda com a linha de baixo — as
   duas linhas seguintes (Birth Date/.../Deity e Height/.../Eyes) já
   saem da grade `q1..q4` por conta própria (5 colunas não dividem 4
   quartos, ver comentário existente) — sair da grade aqui também não
   quebra alinhamento nenhum que já não estivesse quebrado.

**Arquivos mexidos**: `Views/CharacterDescriptionView.swift`
(rótulo "Personality" 10→11pt; `half` extraído pra Character
Name/Player Name), `Package.swift` (1.34/141 → 1.35/142).

## 48. v1.36 — fonte, fase 2 (confirmação da Ficha de Magias)

**2026-09-22.** Usuário pediu pra confirmar a 3ª área citada na
análise de risco do item 45, `SpellSheetView.swift` — lá eu tinha
dito que "já estava inteira em 10pt ou mais". Reconferindo com
`grep` em vez de confiar na memória do item 45: essa afirmação
estava ERRADA em dois pontos.

1. `FieldLabel` (rótulo pequeno versalete, `PaperTheme.swift`) estava
   em 9.5pt — abaixo do piso de 10pt que a fase 1 estabeleceu pro
   resto do app. Esse componente é COMPARTILHADO por quase toda a
   ficha (rótulos de campo nos Compêndios, cabeçalhos de tabela na
   Ficha de Magias) — a maioria dos usos tem largura flexível
   (seguro pra crescer), mas dois cabeçalhos de coluna na tabela de
   magias memorizadas ("Cast", `frame(width: 42)`, e "Dmg/Heal",
   `frame(width: 70)`) travam a largura de fora, então subir a fonte
   sem rede de segurança arriscava cortar essas duas palavras.
   Corrigido: 9.5→10.5pt + `lineLimit(1)`/`minimumScaleFactor(0.75)`
   (mesmo padrão já usado no cabeçalho "Start/Mod/Total" de Saving
   Throws, item 45) — some SwiftUI encolhe sozinho se algum dia não
   couber, sem cortar texto.
2. `SphereBadge` (a pílula de esfera ao lado do nome da magia) estava
   em 9pt — mais abaixo ainda. É uma pílula de largura flexível
   (sem `frame` travado), então subi direto pra 10pt sem rede de
   segurança extra.

Fora esses dois, mais três textos que já estavam OK mas ficaram
"atrás" do resto do app na conversa fiada dos rótulos vizinhos
(mesmo problema do item 47 com "Personality"): o botão "description"
e o "of" das linhas de quantidade (`Paper.printedItalic(10)` →
`11pt`, igual ao "of" já ajustado em `CharacterSheetView.swift` no
item 45) e o texto de esferas ao lado do nome da magia na lista
compacta (`Paper.printedItalic(10.5)` → `11pt`, já tinha
`lineLimit(1)`, largura flexível).

Não achei mais nenhum tamanho abaixo de 10pt no arquivo depois desse
ajuste (reconferido com `grep`).

**Arquivos mexidos**: `Views/PaperTheme.swift` (`FieldLabel` 9.5→
10.5pt + rede de segurança), `Views/SpellSheetView.swift` (`SphereBadge`
9→10pt; "description"/"of"/esferas na lista compacta 10/10.5→11pt),
`Package.swift` (1.35/142 → 1.36/143).

## 49. v1.37 — fonte, fase 2 (última área: cabeçalhos de Equipamento/Armas/Proficiências)

**2026-09-22.** Última das 3 áreas de risco da análise do item 45 —
os cabeçalhos de coluna das tabelas de Equipamento, Combate com Armas
e Proficiências, em colunas estreitas (24-88pt) que ainda estavam no
piso de 10-10.5pt da fase 1, sem NENHUMA rede de segurança. Essa era
a área mais arriscada das três (a mais estreita de todas, "Chk" da
tabela de Proficiências, tem só 28pt pra 3 letras maiúsculas).

Segui a receita já validada nas rodadas anteriores (cabeçalho
"Start/Mod/Total" de Saving Throws, item 45; `FieldLabel`, item 48):
subir a fonte pra 11pt E adicionar `lineLimit(1)` +
`minimumScaleFactor` na MESMA rodada, nunca uma sem a outra — assim,
se a coluna mais estreita não couber o texto no tamanho cheio, o
próprio SwiftUI encolhe sozinho de volta, sem cortar nada. O fator de
encolhimento variou por tabela conforme o aperto real:

- Equipamento ("Location" 64pt/"Wt" 40pt): 10→11pt,
  `minimumScaleFactor(0.75)`.
- Combate com Armas ("#AT"/"Size"/"Type"/"Speed" 40-54pt,
  "Hit/Dmg Adj"/"Damage" 88pt): 10.5→11pt,
  `minimumScaleFactor(0.7)` — essa tabela já tinha rolagem horizontal
  própria pra quando as colunas não cabem na tela inteira (modo
  retrato), mas isso só resolve a largura do conjunto, não uma coluna
  individual estourando a própria célula — por isso a rede de
  segurança continua necessária por célula, mesmo com o scroll.
- Proficiências ("Slots" 40pt/"Chk" 28pt): 10→11pt,
  `minimumScaleFactor(0.65)` — fator mais baixo por ser a coluna mais
  apertada das três tabelas.

De quebra, achei o cabeçalho "Wt"/"Move"/"Atk"/"AC" da tabela de
Encumbrance (já tinha `frame(maxWidth: .infinity)`, ou seja, largura
livre — sem risco real) ainda em 10pt, um degrau abaixo do resto da
fase 2 nas linhas vizinhas dela; subi junto pra 11pt com a mesma rede
de segurança, por consistência.

Com isso as 3 áreas da análise de risco original (item 45) estão
completas.

**Arquivos mexidos**: `Views/CharacterSheetView.swift` (cabeçalhos de
Equipamento/Armas/Proficiências/Encumbrance, listados acima),
`Package.swift` (1.36/143 → 1.37/144).

## 50. v1.38 — 3 correções no v1.37 (Slots numérico, Hit Dice automático, nota do THAC0)

**2026-09-22.** Usuário testou o v1.37 ("Boa! Não quebrou não.") e
voltou com 3 pontos, print do THAC0 em anexo pro item 3.

1. **"Slots" de Proficiências virou campo de texto livre por engano.**
   O campo `ProficiencyEntry.slots` sempre foi `String` — um campo
   sem NENHUMA validação, então qualquer coisa podia ser digitada
   ali, incluindo bobagem que nada tem a ver com "quantos espaços
   essa proficiência gasta" (relatado pelo usuário: a ficha do
   Kelmon tinha "weapon" e "WIS 17" no campo "Slots"). Investigando,
   achei a origem exata: `SampleCharacter.swift` (o personagem de
   exemplo — Kelmon É esse personagem), onde essas 8 linhas de
   proficiência foram criadas com o que devia estar no campo "Chk"
   (o número-alvo da checagem, tipo "Wis 17") espremido dentro de
   "Slots" — não era um bug de gravação em tempo real, era dado de
   exemplo errado desde a criação do Kelmon. Duas mudanças: (a)
   `ProficiencyEntry.slots` virou `Int` de verdade (era o único
   campo numérico da ficha ainda guardado como texto) — o campo na
   tela trocou de `EditableText` pra `EditableNumber`, então não dá
   mais pra digitar texto ali; (b) fichas salvas ANTES dessa mudança
   continuam abrindo — `init(from:)` customizado (mesmo padrão já
   usado em `CharacterClass` pra fichas com nome de classe em
   português) tenta ler como `Int`, senão extrai os dígitos de dentro
   do texto antigo (ex. "2 slots" → 2), senão cai pro padrão de 1;
   nunca falha ao abrir a ficha, só normaliza o valor. Os dados de
   exemplo do Kelmon também foram corrigidos: proficiências de arma
   (Mace/Sling/War hammer) foram pra `slots: 1`, e as 5 de perícia
   foram pra `slots: 1` com o número-alvo (17/15/10/12/15) movido pro
   campo `target` ("Chk"), onde sempre devia ter estado.
2. **"Hit Dice" deve se preencher sozinho ao escolher a classe.**
   Mesmo "motor" do XP needed for the next level (item 30, TODO.md):
   conferido na base de regras (Table 14: Warrior Experience Levels →
   coluna "Hit Dice (d10)"; Table 20: Wizard → "d4"; Table 23: Priest
   → "d8"; Table 25: Rogue → "d6" — as mesmas 4 tabelas já usadas por
   `ExperienceProgressionTable`), virou `CharacterClass.hitDieType` +
   `PlayerCharacter.refreshHitDiceType()`. Diferente da XP, porém,
   "Hit Dice" é um campo de texto LIVRE na ficha (podia ter uma
   anotação própria do jogador, ou uma variante de mesa) — por isso
   só preenche quando está VAZIO, nunca sobrescreve o que já estiver
   escrito (mesma regra que `RaceOption.apply(to:)` usa pra
   `racialAbilities`). Chamado em dois lugares: `ClassPicker.select`
   (cobre trocar de classe) e `CombatForm.onAppear` (cobre abrir uma
   ficha já existente, com classe escolhida e o campo ainda vazio) —
   dessa vez sem o problema de página escondida do
   `UIPageViewController` que afetou o XP, porque "Hit Dice" mora na
   MESMA página do seletor de classe.
3. **Nota ao lado do THAC0 quase ilegível.** `"(base — the table
   below fills itself in)"`, dentro de um `HStack` com `Spacer`
   flexível depois (sem largura travada, sem risco de cortar nada) —
   já tinha sido bumped de 10 pra 11pt na fase 2 (item 45), mas o
   usuário confirmou com print que continuava pequena demais perto
   do "THAC0"/número ao lado. Subi mais, pra 13pt.

**Arquivos mexidos**: `Models/Character.swift`
(`ProficiencyEntry.slots` String→Int + `init(from:)` de migração;
`CharacterClass.hitDieType`; `PlayerCharacter.refreshHitDiceType()`),
`Views/CharacterSheetView.swift` (linha "Slots" virou
`EditableNumber`; `ClassPicker.select`/`CombatForm.onAppear` chamando
`refreshHitDiceType()`; nota do THAC0 11→13pt),
`Views/ProficiencyCompendiumView.swift` (`choose(_:)` atribui
`Int` direto em vez de string interpolada),
`Models/SampleCharacter.swift` (proficiências do Kelmon corrigidas),
`Package.swift` (1.37/144 → 1.38/145).

## 51. v1.39 — corrige erro de build do v1.38

**2026-09-22.** Usuário mandou print do Swift Playgrounds recusando
compilar o v1.38, dois erros idênticos em `Models/Character.swift`:
"Initializer for conditional binding must have Optional type, not
'String'" e o mesmo pra 'Int'. Erro meu no `init(from:)` novo de
`ProficiencyEntry` (item 50): escrevi
`if let intSlots = try? container.decodeIfPresent(Int.self, forKey:
.slots), let intSlots { ... }` — duas amarrações pro mesmo nome. A
primeira (`let intSlots = try? ...`) já entrega o valor
DESEMBRULHADO: desde o Swift 5, `try?` sobre uma função que já
devolve `Int?` não gera `Int??` (dois opcionais empilhados) — ele
"achata" os dois num só, e o `if let` unwrap esse único opcional já
deixando `intSlots` como `Int` puro, não `Int?`. A segunda amarração
(`, let intSlots`) tentava desembrulhar de novo algo que já não era
mais opcional — daí o erro. Removida a segunda amarração das duas
condições (`Int` e `String`); a lógica de fallback (Int primeiro,
senão dígitos do texto antigo, senão 1) continua a mesma, só a
sintaxe estava quebrada. Como não há compilador neste ambiente pra
testar Swift de verdade, esse tipo de erro de sintaxe só aparece
quando o usuário tenta abrir no Playgrounds — importante continuar
pedindo confirmação de build a cada rodada que mexe em código novo
(diferente de só ajuste de fonte/layout, que o balance-check de
parênteses já cobre razoavelmente bem).

**Arquivos mexidos**: `Models/Character.swift` (`ProficiencyEntry.
init(from:)` corrigido), `Package.swift` (1.38/145 → 1.39/146).

## 52. v1.40 — corrige "Hit Dice" não atualizar ao trocar de classe

**2026-09-22.** Usuário testou o v1.39 (build passou) e voltou com 3
pontos: "1. Show! Ficou bom" (Slots numérico); "2. Não tá refletindo
ao trocar de classe" (Hit Dice); "3. Boa!" (nota do THAC0). Só o item
2 precisava de correção.

Causa: `refreshHitDiceType()` (item 50) só preenchia quando
`combat.hitDiceType` estava VAZIO — decisão deliberada na hora, pra
não sobrescrever uma anotação que o jogador tivesse escrito à mão.
Só que isso tem um efeito colateral óbvio em retrospecto: depois do
PRIMEIRO preenchimento automático, o campo deixa de estar vazio, e
toda troca de classe seguinte para de atualizar o valor — exatamente
o bug relatado. O pedido original ("deve entrar naquele motor", o
mesmo do XP) queria o comportamento oposto: sempre resincronizar,
igual `refreshXPNeededNextLevel()` faz.

Resolvido com um parâmetro (`force: Bool = false`) em vez de escolher
um dos dois comportamentos pra sempre: `ClassPicker.select` (troca de
classe explícita) chama com `force: true` — sempre resincroniza,
igual o XP. `CombatForm.onAppear` (roda toda vez que a página
aparece, não só quando o jogador mexe em algo) continua com o padrão
`force: false` — só preenche se vazio, senão o safety net apagaria
uma anotação manual toda vez que a página fosse reaberta.

**Arquivos mexidos**: `Models/Character.swift`
(`refreshHitDiceType(force:)`), `Views/CharacterSheetView.swift`
(`ClassPicker.select` chamando com `force: true`), `Package.swift`
(1.39/146 → 1.40/147).

## 53. v1.41 — ícone de "Magic Items" no Compendium

**2026-09-22.** Usuário mandou a arte (varinha com cristal + poção
brilhante, dentro de um medalhão de couro costurado e latão) pro
ícone de "Magic Items" no hub do Compendium. O código já esperava
esse arquivo — `CompendiumHubView.swift` linha 137 já tinha
`imageName: "icon_magic_items"` desde antes, só que o PNG nunca tinha
sido entregue, então a tile caía no fallback (círculo escuro + SF
Symbol `wand.and.stars`). Cortei a margem transparente ao redor da
arte (`Image.getbbox()`, sem alterar o conteúdo) e salvei como
`Resources/icon_magic_items.png` (693×679px, RGBA com fundo
transparente fora do medalhão) — mesmo nome que o código já procura
via `Image.bundled(_:)`, então não precisou mexer em nenhum arquivo
de código, só adicionar o asset que faltava.

Vale notar pro usuário: essa arte vem com seu PRÓPRIO medalhão de
couro/latão desenhado dentro da imagem, diferente dos outros ícones
de tile do Compendium (Weapons/Armor/Equipment/Proficiencies), que
são só o objeto flutuando sobre fundo transparente, sem moldura
própria (`Docs/icon-button-spec.md`, seção 3, pede exatamente isso
pros ícones "candidatos a virar imagem" da lista da seção 4). Não
teria como cortar o medalhão dessa arte com segurança sem arriscar
estragar o desenho num ambiente sem visualização de imagem
confiável — usei a arte como veio. Se ficar visualmente destoante ao
lado dos outros ícones simples da grade do Compendium, é só avisar
que eu ajusto.

**Arquivos mexidos**: `Resources/icon_magic_items.png` (novo),
`Package.swift` (1.40/147 → 1.41/148).

## 54. v1.42 — conteúdo do Complete Priest's Handbook (CPrH) na Rules
    Reference + 6 armas novas no Weapon Compendium

**2026-09-22.** Usuário mandou um zip com o Complete Priest's
Handbook inteiro já convertido pro mesmo formato JSON usado nos
outros corpi (cap. 1-6 + apêndices, 111 entradas, mesmo pipeline de
extração externo já usado pro PHB/DMG). Pediu pra avaliar o melhor
encaixe no app — o app já tinha os 91 Priest Kits do CPrH
(`KitDatabase`, `sourceBook: "The Complete Priest's Handbook"`), mas
não tinha o conteúdo "de regra"/texto corrido do livro: cap. 1
(Deuses), cap. 2 (Design de Fé), cap. 3 (Sample Priesthoods, 64
entradas — o maior bloco), cap. 4 (regras sobre kits, diferente dos
kits em si), cap. 5 (Role-Playing) e cap. 6 (Equipment and Combat).

Confirmado com o usuário (pergunta com duas partes): (1) o conteúdo
mais "de Mestre" (deuses/fé/role-playing, 34 das 111 entradas) entra
junto em vez de ficar de fora; (2) as 6 armas novas do cap. 6 ("New
Weapons List": Bill, Lasso, Maul, Net, Nunchaku, Scythe) viram itens
de verdade no `WeaponDatabase` (aparecem no Weapon Compendium E no
seletor de arma da ficha), não só texto de referência.

**Regras (111 entradas → livro `"CPrH"` na Rules Reference).** O
schema dos JSONs enviados é quase idêntico ao `RuleEntry` que já
existe (mesma pipeline de origem) — reaproveitei o formato sem
inventar nada novo: `id`/`breadcrumbs`/`topic`/`ruleType`/`summary`/
`content`/`tables`/`searchKeywords` mapeiam direto; `relatedRuleIds`
veio de `crossReferences.relatedRules[].id` (ids já batem 1:1 com os
que eu mesmo gero, mesma pipeline); deixei `relatedSpells`/
`relatedMagicItems` vazios de propósito — o JSON trazia uns poucos
`crossReferences.spells` (ex. "Command Undead" em Death, 3 no total)
mas com um `id` cujo esquema eu não tinha como confirmar contra o
`SpellDatabase` real sem risco de link morto, e o ganho de 3
entradas não valia o risco. Gerei os literais Swift com um script
Python (`Scripts/` não — ficou só no ambiente de trabalho, não é
reusável o bastante pra entrar no repo) que escapa string Swift
caractere a caractere (aspas/backslash/quebra de linha), igual o
pipeline original deve ter feito — sem `Bundle`/`JSONDecoder` em
runtime, mesmo padrão de `EmbeddedRules_Part1..20.swift`. Novos
arquivos `EmbeddedRules_Part21..28.swift` (continuando a numeração,
~14 entradas cada), ids `embeddedRule0274`...`embeddedRule0384`,
todos com `book: "CPrH"`. `RulesCompendiumView` ganhou um terceiro
chip de filtro ("CPrH") ao lado de "PHB"/"DMG", e o agrupamento por
livro (`chapterGroups`) passou a iterar os três.

**Armas ("New Weapons List", 6 itens → `WeaponDatabase`).** O
struct `Weapon` não tinha noção de fonte/livro (sempre foi só PHB,
documentado assim no comentário do arquivo) — adicionei `let source:
String? = nil` com valor padrão, então as 69 armas do PHB (e todo
`EmbeddedWeapons_Part1..4.swift`) continuam compilando sem tocar em
nada; as 6 novas (`EmbeddedWeapons_Part5.swift`) vêm com `source:
"CPrH"`. Duas lacunas de dado que precisei decidir, documentadas no
comentário do arquivo novo: a tabela do cap. 6 do CPrH não lista
"attacks per round" (coluna que a Table 45 do PHB tem) — usei "1"
como padrão pra todas (inferência razoável pra arma de uma mão, não
dado confirmado no livro); e não tem coluna de alcance — `range:
nil` pras 6. Lasso/Net têm `type`/`damageSmall`/`damageLarge` como
`nil` (não `"—"`) porque são armas de captura sem dano próprio — é
literalmente o mesmo padrão que Scourge/Whip já usavam pra "PHB não
classifica". `WeaponDetailSheet.subtitle` trocou o texto fixo "PHB
weapon" por `"\(weapon.source ?? "PHB") weapon"`, então o detalhe de
cada arma nova mostra "CPrH weapon" em vez de mentir que é do PHB; o
resto da tela (agrupamento por `type`, busca, seletor da ficha) não
precisou de nenhuma mudança porque já opera em cima de
`weaponDatabase.weapons` sem hardcoded de fonte.

O texto de "New Weapons" (a regra do cap. 6 que descreve a tabela)
continua na Rules Reference com a tabela embutida também — pequena
duplicação de dado com o `WeaponDatabase`, mas deliberada: o
`[TABLE_REF: New Weapons List]` no meio da prosa quebraria (apareceria
uma referência sem tabela) se eu tivesse tirado a tabela de lá só
por ela também existir no Weapon Compendium.

Contadores em texto fixo atualizados nos dois lugares que citavam os
números antigos: `CompendiumHubView` ("274 rules · PHB & DMG" → "385
rules · PHB, DMG & CPrH"; "69 weapons · PHB weapon table" → "75
weapons · PHB & CPrH") e o subtítulo dentro da própria
`RulesCompendiumView`/`WeaponCompendiumView`.

Não dá pra compilar Swift de verdade neste ambiente (mesma ressalva
de sempre) — validei os 111 literais com um script à parte que
simula parsing de string Swift (rastreia aspas/escape caractere a
caractere pra contar chaves/parênteses/colchetes só fora de string
literal) em vez do grep ingênuo de balanceamento que rodei antes,
porque prosa de livro tem parênteses/aspas soltos que um grep cru
confunde com erro de sintaxe; os 28 arquivos de regra + os 2 de arma
bateram limpo. Ainda assim, como sempre: build de verdade no
Playgrounds é o teste que importa, pode voltar com print de erro se
sobrar algo que só o compilador real pega.

**Arquivos mexidos**: `Store/EmbeddedRules_Part21.swift` até
`Part28.swift` (novos, 111 `RuleEntry`), `Store/EmbeddedRules.swift`
(array final +111), `Store/EmbeddedWeapons_Part5.swift` (novo, 6
`Weapon`), `Store/EmbeddedWeapons.swift` (array final +6),
`Models/Weapon.swift` (`source: String?`), `Views/
RulesCompendiumView.swift` (chip "CPrH", `chapterGroups` com 3
livros, subtítulo), `Views/WeaponCompendiumView.swift`
(`WeaponDetailSheet.subtitle` usa `weapon.source`), `Views/
CompendiumHubView.swift` (subtítulos de Rules Reference e Weapons),
`Store/RulesDatabase.swift` (comentário), `Package.swift` (1.41/148
→ 1.42/149).

## 55. v1.43 — corrige erro de build do v1.42 ("Extra argument 'source' in call")

**2026-09-23.** Usuário mandou print do Swift Playgrounds recusando
compilar o v1.42: `EmbeddedWeapons_Part5.swift`, "Extra argument
'source' in call" — um dos 6 `Weapon(...)` novos que passa `source:
"CPrH"` explicitamente.

Causa: no item 54, adicionei `let source: String? = nil` em
`Weapon` contando com a sintetização automática do memberwise
initializer do Swift pra dar um parâmetro `source:` opcional (com
`nil` como padrão) a partir do valor padrão da propriedade —
funciona pra `var`, mas pelo visto o compilador real usado aqui
NÃO sintetizou esse parâmetro pra este `let` (os 69 `Weapon(...)`
do PHB, que não passam `source:`, aparentemente compilaram OK só
porque a base delas nem chegou a ser tipada antes do erro na Part5
interromper o build — não dá pra confirmar isso sem compilador de
verdade neste ambiente, só o print do usuário). De qualquer forma,
o resultado prático é que o memberwise sintetizado não tinha
`source:` como parâmetro válido nenhum, daí "extra argument".

Resolvido declarando um `init` explícito em `Weapon` com todos os 10
campos, `source: String? = nil` por último — deixa de depender de
sintetização implícita, comportamento garantido independente de
versão/nuance do compilador. Os 69 `Weapon(...)` do PHB (sem
`source:`) e os 6 do CPrH (com `source: "CPrH"`) usam o mesmo init
agora, só que um deles omite o último argumento (tem default).

**Arquivos mexidos**: `Models/Weapon.swift` (`init` explícito em vez
de contar com o memberwise sintetizado), `Package.swift` (1.42/149 →
1.43/150).

## 56. v1.44 — Divindades de Faiths & Avatars + Powers & Pantheons

**2026-09-23.** Usuário mandou um segundo zip, `faiths_and_avatars.zip`,
com dois sourcebooks de Reinos Esquecidos já convertidos pra JSON:
*Faiths & Avatars* (46 divindades) e *Powers & Pantheons* (33
divindades), 79 no total, cada uma com portfólio, alinhamento,
símbolo, plano, aliados/inimigos, dogma/clero em prosa corrida — e,
pra 72 das 79 (faltam em 7), um statblock de combate completo do
avatar (classe/nível, AC, HP, THAC0, magias, resistências). Pediu
avaliação de como encaixar no app antes de mexer em qualquer coisa.

Antes de implementar, levantei que 36 dos 91 Priest Kits já
existentes no app (specialty priests) são de um deus específico, e o
nome bate exatamente (após normalização) com uma entrada deste novo
corpus — ou seja, não é conteúdo isolado, ele *enriquece* dado que
já existe na ficha e no Kit Compendium. Perguntei duas coisas antes
de começar: (1) incluir o statblock de combate do avatar ou só o
perfil narrativo — usuário escolheu incluir tudo; (2) qual(is)
cross-link(s) — Kit→Divindade, ficha→Divindade, ou os dois — usuário
escolheu os dois.

Implementação seguiu o mesmo padrão de sempre (`EmbeddedX_PartN.swift`
com literais Swift, sem `Bundle`/`JSONDecoder` em runtime — ver
ressalva histórica no início deste arquivo). Novo `struct Deity`
(`Models/Deity.swift`) com todos os campos do JSON, e `DeityDatabase`
(`Store/DeityDatabase.swift`, `ObservableObject`) com busca fuzzy
(`matches(for:)`, mesmo padrão de `RulesDatabase`/`SpellDatabase`) e
um lookup por nome exato (`deity(named:)`, só `Fuzzy.normalize` +
igualdade — **não** é fuzzy parcial, de propósito: um cross-link
apontando pra divindade errada é pior do que nenhum link). Os 79
literais (`embeddedDeity000`...`embeddedDeity078`) foram gerados por
script Python a partir dos dois JSONs concatenados (F&A primeiro),
divididos em `Store/EmbeddedDeities_Part1.swift` até `Part8.swift`
(10 por arquivo, mesmo motivo de sempre: manter o type-checker do
Playgrounds rápido).

Duas decisões de qualidade de dado, documentadas em comentário no
próprio `Deity.swift` em vez de "corrigidas" silenciosamente: Ao (o
deus supremo, sem avatar/forma física) tem `alignment: nil` no dado
de origem — mantido `nil`, não inventei um alinhamento; e o `rank`
de Tiamat no JSON é literalmente `"Letter Power"`, quase certamente
um erro de OCR/extração pra "Lesser Power" — mantive verbatim (é o
mesmo princípio do item 54 com dado de tabela: quando a fonte não
bate, eu documento a suspeita em vez de silenciosamente reescrever
pra o que "faz mais sentido"). `DeityCompendiumView` trata isso
agrupando por `rank` com um "Other" pra qualquer coisa fora da lista
esperada de ranks, então Tiamat e Ao aparecem lá em vez de sumir ou
quebrar o agrupamento.

Tela nova: `DeityCompendiumView` (novo tile "Deities" no
`CompendiumHubView`, entre Priest Kits e Rules Reference) — busca,
filtro por livro (Faiths & Avatars / Powers & Pantheons), lista
agrupada por rank (Over-power, Greater/Intermediate/Lesser Power,
Demipower, Other). O detalhe (`DeityDetailSheet`) mostra os campos
narrativos num grid e o texto completo de mitologia/clero sempre
visível — mas o statblock de combate do avatar fica dentro de uma
seção colapsável, fechada por padrão (`showAvatarStatblock`): é
informação densa de "modo combate" que a maioria das consultas (que
divindade é essa, que domínio ela cobre) não precisa ver de cara, e
só existe pra 72 das 79 entradas mesmo.

Os dois cross-links pedidos: (1) `KitDetailSheet` (Kit Compendium)
ganhou um link "View deity: X →" que só aparece quando
`kit.deity` bate com uma entrada da nova base — dos 91 Kits, os ~36
específicos de divindade mostram o link, o resto (Kits genéricos
tipo Cleric/Druid sem deus fixo) não mostra nada. (2) A ficha do
personagem ganhou um botão "?" (`DeityLinkButton`, mesmo estilo
visual do `RuleLinkButton` já usado nas regras) colado no campo
"Patron Deity / Religion" — como é campo de texto livre, o link só
aparece quando o que o jogador digitou bate exatamente (após
normalização) com uma das 79 divindades; nome errado, apelido ou
divindade de outro cenário/homebrew simplesmente não mostra o "?",
sem quebrar nada.

Como sempre, sem compilador Swift de verdade neste ambiente — os 79
literais e todos os arquivos novos/editados passaram pelo script de
balanceamento (rastreia string literal caractere a caractere, só
conta chaves/parênteses fora de aspas), mas o teste que importa é o
build de verdade no Playgrounds.

**Arquivos mexidos**: `Models/Deity.swift` (novo), `Store/
DeityDatabase.swift` (novo), `Store/EmbeddedDeities.swift` (novo,
agregador), `Store/EmbeddedDeities_Part1.swift` até `Part8.swift`
(novos, 79 `Deity`), `Views/DeityCompendiumView.swift` (novo — tela,
detail sheet, `DeityLinkButton`), `App.swift` (`DeityDatabase` como
`@StateObject`/`.environmentObject`), `Views/CompendiumHubView.swift`
(tile "Deities" + `DeityCompendiumScreen`), `Views/
KitCompendiumView.swift` (link "View deity" no `KitDetailSheet`),
`Views/CharacterSheetView.swift` (`DeityLinkButton` no campo "Patron
Deity / Religion", dentro de `RecordHeaderForm`), `Package.swift`
(1.43/150 → 1.44/151).

## 57. v1.45 — corrige rank da Tiamat (confirmado com o usuário)

**2026-09-23.** Item 56 (v1.44) tinha documentado duas dúvidas de
qualidade de dado sem "corrigir" por suposição: o `alignment: nil`
de Ao e o `rank: "Letter Power"` de Tiamat (suspeita de erro de
digitação do livro por "Lesser Power"). Perguntei ao usuário e ele
confirmou as duas: Ao realmente não tem alinhamento (mantido como
está) e Tiamat é mesmo Lesser Power — corrigido.

Trocado `rank: "Letter Power"` → `rank: "Lesser Power"` em
`EmbeddedDeities_Part8.swift` (única ocorrência, é a entrada da
Tiamat). Com isso ela sai do grupo "Other" da tela de Deities e
passa a aparecer junto das outras Lesser Powers no agrupamento por
rank. Comentário em `Models/Deity.swift` atualizado pra refletir que
não é mais uma dúvida em aberto.

**Arquivos mexidos**: `Store/EmbeddedDeities_Part8.swift` (rank da
Tiamat), `Models/Deity.swift` (comentário), `Package.swift`
(1.44/151 → 1.45/152).

## 58. v1.46 — aumenta fontes pequenas nas telas de compendium

**2026-09-23.** Usuário mandou print da tela de detalhe de um Priest
Kit (Auril - Chillbringer) e pediu pra aumentar três textos pequenos
demais: (a) o botão "close" — e que isso valesse pro App inteiro, não
só ali; (b) o subtítulo logo abaixo do título (no caso, "Specialty
Priest kit · Chillbringer · Faerûnian"), avaliando onde esse ajuste
cabe nos demais itens do compendium; (c) o link "View deity: X →".

(a) "close" tinha exatamente o mesmo padrão — `Button("close") {
dismiss() }` seguido de `.font(Paper.printed(13))` — copiado em 26
telas diferentes do App (todo Compendium, ficha, campanha, etc.).
Troquei as 26 ocorrências de uma vez (script pontual que só bate
nesse padrão exato, não em qualquer `Paper.printed(13)` solto, já
que esse tamanho também aparece em botões "choose"/"change" que não
foram tocados) de 13pt pra 16pt.

(b) O subtítulo abaixo do nome — mesmo padrão visual em todo
Compendium: `Text(nome).font(Paper.hand(28))` seguido de
`Text(subtítulo).font(Paper.printedItalic(13))`. Encontrei e ajustei
esse mesmo par em TODOS os itens do Compendium que o usam: Priest
Kits ("Specialty Priest kit · X · Y"), Weapons, Armor, Magic Items,
Mundane Items, Proficiencies e Deities — todos foram de 13pt pra
15pt. A Rules Reference usa um papel um pouco diferente pro mesmo
lugar (breadcrumbs do capítulo, `Paper.printedItalic(12)` em vez de
13, provavelmente porque o texto ali é mais longo) — ajustada
proporcionalmente, de 12pt pra 14pt, mantendo a diferença relativa
com as outras telas.

Não mexi no mesmo padrão fora do Compendium (ex.: o "Item
description" da nota de item mágico na ficha, em `SpellSheetView`) —
o pedido foi especificamente sobre as telas do Compendium, e mudar
ficha/campanha junto seria decisão de mais escopo do que foi pedido.

(c) O link "View deity: X →" (só em `KitCompendiumView`, é o link
novo do item 56) foi de 12pt pra 14pt — mesmo salto proporcional dos
outros ajustes.

**Arquivos mexidos**: `Views/KitCompendiumView.swift`,
`Views/SpellSheetView.swift`, `Views/MagicItemCompendiumView.swift`,
`Views/ConsequencePreviewSheet.swift`,
`Views/WeaponCompendiumView.swift`,
`Views/ProficiencyCompendiumView.swift`, `Views/RacePickerSheet.swift`,
`Views/DeityCompendiumView.swift`,
`Views/MundaneItemCompendiumView.swift`,
`Views/ArmorCompendiumView.swift`, `Views/RulesCompendiumView.swift`,
`Views/MarkDeadSheet.swift`, `Views/AlignmentPicker.swift`,
`Views/SessionReportView.swift`,
`Views/CampaignSettingsEditorSheet.swift`,
`Views/CampaignIndexView.swift`, `Views/SphereAccessEditorSheet.swift`
(todos: botão "close" 13pt → 16pt); mais os subtítulos e o link
"View deity" listados acima. `Package.swift` (1.45/152 → 1.46/153).

## 59. v1.47 — ícones novos: Mage Grimoire, Priest Grimoire, Rules Reference, Deities

**2026-09-23.** Usuário mandou um zip com 4 ilustrações novas (PNG com
fundo transparente, estilo medalhão redondo — couro gravado, aro de
runas, bússola N/S/L/O): uma pro Mage Grimoire, uma pro Priest
Grimoire, uma pra Rules Reference (substituindo as três ilustrações
que já existiam) e uma pro Deities (item novo, criado no item 56 e
que até agora só tinha o SF Symbol `crown.fill` como fallback, sem
arte própria).

As imagens vieram num canvas bem mais largo que o conteúdo (1408×768,
com o medalhão real ocupando só uns 700×690px centralizados) — se
tivesse usado o arquivo cru, o `Image.bundled(...)` +
`.aspectRatio(contentMode: .fit)` do `CompendiumTile` ia encaixar o
canvas inteiro na caixa de 78×62pt, deixando o medalhão minúsculo com
uma faixa transparente enorme dos dois lados. Recortei cada uma pro
bounding box real do conteúdo (com ~8% de margem), então cada arquivo
final ficou perto de quadrado (~800×768) em vez do
16:9 original.

Os 4 arquivos entram exatamente nos nomes que o `CompendiumTile`
já espera via `imageName` (`Views/CompendiumHubView.swift`) —
`icon_mage_grimoire`, `icon_priest_grimoire`, `icon_rules_reference` e
`icon_deities` — então nenhuma linha de código mudou, só os PNGs em
`Resources/`. O tile de Deities (que desde o item 56 já tinha
`imageName: "icon_deities"` no código, só sem o arquivo) passa a
mostrar a ilustração de verdade em vez do fallback de SF Symbol.

**Arquivos mexidos**: `Resources/icon_mage_grimoire.png`,
`Resources/icon_priest_grimoire.png`,
`Resources/icon_rules_reference.png` (substituídos),
`Resources/icon_deities.png` (novo). `Package.swift` (1.46/153 →
1.47/154).

## 60. PLANEJADO — reorganizar o Compendium Hub em macro-categorias

**2026-09-23.** Discutido, não implementado ainda (usuário pediu pra
deixar pra depois). Hoje o Compendium Hub (`CompendiumHubView`) é uma
lista só com 10 tiles (Priest Grimoire, Priest Kits, Deities, Rules
Reference, Proficiencies, Weapons, Armor, Equipment, Magic Items,
Mage Grimoire) e vai crescer mais. Estrutura combinada, pra quando
formos implementar:

- **Characters** (conteúdo específico de classe) → hoje só **Priest**
  (Priest Grimoire + Priest Kits) e **Mage** (Grimoire, ainda "coming
  soon"). **Não** criar tiles vazios de Warrior/Rogue — o app não tem
  nenhum conteúdo dessas classes ainda (precisaria de *Complete
  Fighter's Handbook*/*Complete Thief's Handbook* convertidos, que o
  usuário não mandou). Acrescentar essas classes como mais uma
  entrada dentro de Characters só quando esse material chegar.
- **Rules & Lore** (referência, não amarrada a uma classe) → Rules
  Reference, Proficiencies, **Deities**. Decisão importante: Deities
  fica FORA de Priest — o link "?" de divindade no campo "Patron
  Deity / Religion" da ficha (item 56) aparece pra qualquer classe,
  não só Priest, então enterrar Deities dentro do submenu de Priest
  esconderia isso.
- **Items** → Weapons, Armor, Equipment, Magic Items (sem mudança de
  conteúdo, só de onde fica no hub).

Navegação: 3 níveis pra Characters (Hub → Characters → Priest →
Grimoire/Kits), 2 níveis pra Rules & Lore e Items (Hub → categoria →
item direto, sem terceiro nível, já que não há sub-agrupamento ali).

## 61. v1.48 — sinal de consequência pendente vira ponto único, em cima do dragão

**2026-09-23.** O `ConsequenceSignalBadge` (o ícone que acende quando
nível ou algum atributo mudou e ainda não foi revisado —
`character.hasPendingConsequences`) tinha virado parametrizado no item
41: um badge por campo, aparecendo ao lado do Level OU de uma das seis
linhas de Ability Scores, dependendo de qual campo mudou por último
(`effectiveChangedField`). Usuário achou ruim ele "aparecer em pontos
diversos" e pediu um lugar fixo: sempre em cima do dragão
(`record_badge.png`, no canto superior direito da Ficha — o distintivo
do grupo, abaixo do título "Advanced Dungeons & Dragons / 2nd Edition"),
no mesmo tamanho dele (92pt), "como se substituindo".

Removidos os dois call sites antigos — o overlay no `HeaderLine` do
Level (`RecordHeaderForm`) e o overlay em `AbilityRowForm` (usado nas
seis linhas STR/DEX/CON/INT/WIS/CHA, junto o parâmetro `isPendingChange`
que só servia pra alimentar aquele badge, agora sem uso). No lugar,
`RecordHeaderForm` passou a decidir entre mostrar o dragão OU o
`ConsequenceSignalBadge` (92pt) no mesmo `if`/`else`, na mesma posição:
dragão quando `character.hasPendingConsequences == false` (estado
normal), badge quando `true`. Único sinal de consequência pendente na
ficha inteira agora — continua abrindo `ConsequencePreviewSheet` ao
tocar, como antes.

Não mexi no `PendingConsequenceHighlight` (o realce verde direto nos
títulos de "Saving Throws" e "THAC0", do item 41) — é outro mecanismo,
não um ícone, e o usuário não pediu mudança ali.

**Arquivos mexidos**: `Views/CharacterSheetView.swift` (removidos os
dois overlays de `ConsequenceSignalBadge` e o parâmetro
`isPendingChange` de `AbilityRowForm`; `RecordHeaderForm` alterna
dragão/badge), `Views/ConsequencePreviewSheet.swift` (comentário de
`ConsequenceSignalBadge` atualizado pra refletir o call site único).
`Package.swift` (1.47/154 → 1.48/155).

## 62. v1.49 — lote de 11 itens (bugs de realce, fonte, AC, automações de raça/kit, tabelas de Kit)

**2026-09-24.** Usuário mandou uma lista numerada de 11 pedidos (sem os
prints originais, que ficaram pra outra rodada se precisar). Todos os 11
implementados — o item 11 (ícone do app) chegou pouco depois, num anexo à
parte.

1. **Realce verde do THAC0 disparando com qualquer atributo** — `Thac0TargetForm`/
   `SavingThrowsForm` liam `character.hasPendingConsequences` (flag GLOBAL:
   liga com nível OU qualquer um dos 6 atributos pendente de revisão) em
   vez de checar se aquela seção especificamente mudaria. Nova
   `PlayerCharacter.hasPendingConsequence(forKeys:registry:)`, escopada por
   `ConsequenceEngine.diff` — THAC0 só acende pra "thac0", Saving Throws só
   pra "savingThrows".
2. **Ability Details (Hit Adj, Dmg Adj etc.) não piscavam** — "Apply
   automatic changes" já escrevia certinho nesses campos
   (`ConsequenceEngine.applyAutomatic`) mas nunca chamava
   `markRecentAutoChange`, e `AbilityRowForm` não tinha `.changeFlash`
   nenhum nas células. Os dois corrigidos — `cells` agora carrega uma
   chave de flash por coluna.
3. **Hit Dice não piscava ao trocar de classe** — `refreshHitDiceType(force:)`
   já marcava `recentAutoChange("hitDiceType")` certinho, só que nenhuma
   view lia essa chave. `.changeFlash` adicionado no campo.
4. **Fonte do "choose" menor que "close"** — o item 58 tinha deixado
   "choose"/"change" de fora de propósito ao padronizar "close" pra 16pt.
   Agora os dois batem: `Armor`, `Mundane Item`, `Proficiency`, `Weapon`,
   `Kit`, `Magic Item` e `Spell` (os 7 compêndios/sheets com esse par de
   botões).
5. **Proficiência de bônus do Kit não entrava sozinha na ficha** — só
   `KitProficiencyRules.bonus` (grátis, concedida pelo kit) — `recommended`
   continua só sugestão. `RecordHeaderForm.addBonusProficiencies` reaproveita
   linha vazia ou cria uma nova, sem duplicar (nome normalizado) e linkando
   com `ProficiencyDatabase` quando bate.
6. **Tabelas quebradas na descrição de Kits (ex. Ilmater - Alleviator)** —
   `fullText` de 55 dos 91 kits começa com a tabela "Class Information" em
   sintaxe crua de wikitable (`{| ... |}`), que `Text(String)` mostra como
   lixo de barras/traços. Correção EM TEMPO DE EXIBIÇÃO (sem editar os 91
   arquivos `EmbeddedKits_Part*.swift`, arriscado demais pra fazer à mão):
   `KitDescription.displaySections` remove essa tabela (100% redundante com
   os campos estruturados que `KitDetailSheet` já mostra) e separa o resto
   por cabeçalho `##`, renderizado em negrito de verdade.
7. **Full Plate: "1" solto e AC base não mudava** — o "1" já era o AC
   correto da Full Plate (PHB Table 26 dá o AC RESULTANTE, não um
   modificador), só nunca tinha sido ligado a `character.armorClass` — o
   seletor só anotava o texto de referência. Agora: `equippedArmorBaseAC`/
   `hasShieldEquipped`/`magicArmorBonus` (novos campos) +
   `recalculateArmorClass()` recalculam o AC de verdade. Ampliado pra
   Shield (seletor novo, mesmo `ArmorPickerSheet` com `target: .shield`,
   dá −1 fixo — regra à parte da tabela, nenhum `ArmorPiece` de escudo tem
   `baseAC` isolado no corpus).
8. **Movement não preenchia sozinho pela raça** — tabela pequena e fechada
   (6 valores, PHB Table 6 — diferente das tabelas de progressão por
   nível×classe que faltam no corpus), hardcoded em
   `RaceOption.baseMovementRate` como as outras tabelas de raça já
   existentes no arquivo. Preenche o número solto (`character.movement`) E
   a linha "Base" da tabela de Movement da página 2 — colunas Jog/Run/Day
   continuam manuais (não achei fonte confiável dos multiplicadores).
9. **Level Changes não se ajustava por classe/raça** — reaproveita as
   tabelas por nível que o Motor de Consequências já tinha
   (`Thac0ByLevelProvider`/`SavingThrowsByLevelProvider`) pra preencher as
   linhas THAC0/Saving Throws sozinho (`ConsequenceEngine.refreshLevelChanges`,
   varre níveis 1–20 e detecta onde o valor muda). Weapon/Non-weapon
   Proficiencies continuam manuais — essa tabela (em que nível cada classe
   ganha proficiência nova) segue sem fonte estruturada no corpus, mesma
   lacuna já registrada na avaliação do item 21.
10. **Magic Items de armadura não mudavam o AC** — `MagicItemDefenseBonus.acBonus`
    dos itens com `classification.broadCategory == "Armor/Shield"` agora
    soma em `character.magicArmorBonus`, recalculado a cada mudança na
    lista "Magic Items" (`RecordSheetPageTwo.refreshMagicArmorBonus`,
    `.onChange(of: character.page2MagicItems)`) e alimenta o mesmo
    `recalculateArmorClass()` do item 7.
11. **Ícone do app** — usuário mandou a arte (dragão policial de óculos
    escuros e revólver, pixel art, emblema circular azul sobre fundo
    branco, 1254×1254). O projeto nunca teve ícone próprio antes (só o
    padrão do Swift Playgrounds) — criado `Resources/Assets.xcassets/
    AppIcon.appiconset` no formato "single size" moderno (um PNG só,
    1024×1024, sem canal alfa — ícone de app não pode ter transparência;
    o sistema arredonda os cantos sozinho em tempo de exibição, sem
    precisar gerar o conjunto antigo de tamanhos por idiom) e ligado via
    `iconAssetName: "AppIcon"` no `.iOSApplication` do `Package.swift`.

**Arquivos mexidos**: `Models/Character.swift` (`hasPendingConsequence`,
`equippedArmorBaseAC`/`hasShieldEquipped`/`magicArmorBonus`/
`recalculateArmorClass`), `Models/Race.swift` (`baseMovementRate`, Movement
no `apply(to:)`), `Models/Kit.swift` (`KitDescription.displaySections`),
`Store/ConsequenceEngine.swift` (`applyAutomatic` marca `recentAutoChange`,
`refreshLevelChanges`), `Views/CharacterSheetView.swift` (flashes
escopados, `AbilityRowForm`/`LevelChangeRowView` com chave por célula,
`ArmorClassShield`/`ArmorBlock` usando `character` inteiro, kit→proficiência,
recálculo de AC mágico), `Views/ArmorCompendiumView.swift`
(`ArmorPickerSheet` com `target: .armor/.shield`), `Views/KitCompendiumView.swift`
(`KitDetailSheet` por seções, fonte do "choose"),
`Views/MundaneItemCompendiumView.swift`/`ProficiencyCompendiumView.swift`/
`WeaponCompendiumView.swift`/`MagicItemCompendiumView.swift`/
`SpellSheetView.swift` (fonte do "choose"/"change");
`Resources/Assets.xcassets/AppIcon.appiconset/` (novo, ícone do app).
`Package.swift` (1.48/155 → 1.49/156, `iconAssetName: "AppIcon"`).

**Correção 2026-09-24 (v1.50)**: o Playground do usuário não compilou —
"Extra argument 'iconAssetName' in call" (print anexado). O parâmetro que
eu tinha usado no `.iOSApplication(...)` não existe na API real do
`AppleProductTypes`; o certo é `appIcon:` (tipo `AppIcon`, via
`.asset("AppIcon")`), não `iconAssetName:`. `Package.swift` corrigido
(1.49/156 → 1.50/157); o resto (asset catalog, `AppIcon.appiconset`) não
mudou — o ícone já estava certo, só a chamada que estava errada.

**Correção 2026-09-24 (v1.51)**: segundo erro de build, agora em
`Views/CharacterSheetView.swift` — "Value of type 'Kit' has no member
'proficiencies'" (print anexado), no `addBonusProficiencies(forKit:)` do
item 5. `bonus` mora dentro de `KitMechanics.proficiencies`
(`kit.mechanics.proficiencies.bonus`), não direto em `Kit` — eu tinha
escrito `kit.proficiencies.bonus`, que nem existe (ver `Models/Kit.swift`:
`Kit.mechanics: KitMechanics`, e é `KitMechanics.proficiencies` que é do
tipo `KitProficiencyRules`, com `bonus: [String]`). Corrigido; conferido
também que não havia nenhum outro acesso direto tipo `kit.armor`/
`kit.weapons`/etc. escapando de `kit.mechanics.*` no resto do arquivo.
`Package.swift` 1.50/157 → 1.51/158.

**Item 11 DESLIGADO temporariamente (v1.52), 2026-09-24**: depois das duas
correções acima, o build voltou a falhar — dessa vez sem NENHUMA mensagem
em lugar nenhum (nem no painel "App/Package" que mostrou os dois erros
anteriores). Revisei o resto do lote inteiro de novo, função por função,
tipo por tipo (`ArmorPickerSheet`, `refreshMagicArmorBonus`,
`RecordSheetPageTwo`, `LevelChangesForm`, `RecordHeaderForm`, etc. contra
os modelos reais) e não achei mais nada — sem esse texto de erro pra
seguir, e sem Xcode/simulador neste ambiente pra compilar de verdade, não
dá pra confirmar mais nada por leitura de código sozinha. Como o Swift
Playgrounds é conhecido por engolir erros do compilador de asset catalog
(`actool`) sem mostrar nada na UI (diferente de erro de código Swift, que
sempre aparece nesse painel), e essa foi a única peça nova desde o último
build que funcionou, a hipótese mais forte é aí — mesmo o PNG em si tendo
sido conferido e batendo com o formato certo (1024×1024, RGB 8-bit, sem
alpha, sRGB, sem interlace). Decisão: tirar o ícone da equação por enquanto pra destravar o
teste real dos outros 10 itens (que são o que importa primeiro). Em
`Package.swift`: `appIcon: .asset("AppIcon")` removido. Em disco:
`Resources/Assets.xcassets` movido pra `_icon_wip/Assets.xcassets` (fora
da pasta `Resources/`, então fora do `.process("Resources")` do target —
não entra mais no build; os arquivos continuam no repo, só não fazem
parte do pacote enviado). `Package.swift` 1.51/158 → 1.52/159. Item 11
fica pendente — reabrir depois que o resto estiver confirmado, com o
Playground rodando de novo pra dar sinal de vida no painel de erro caso
volte a travar.

**ROLLBACK COMPLETO (v1.48, 2026-09-24)**: mesmo sem o ícone (v1.52), o
build continuou falhando exatamente do mesmo jeito — sem NENHUMA aba/
mensagem de erro em lugar nenhum, nem depois de "Apagar Dados do App e
Reiniciar". Como dois conteúdos bem diferentes (com ícone e sem ícone)
deram o mesmíssimo silêncio, o ícone deixou de ser suspeito — e sem
Xcode/simulador neste ambiente pra compilar de verdade e sem NENHUMA
mensagem de erro pra investigar, não dava mais pra confirmar nada por
leitura de código sozinha (já tinha revisado o lote inteiro umas 3 vezes).
A pedido do usuário ("volta pro último build estável"), TODO o lote de 11
itens de hoje (2026-09-24) foi revertido à mão, arquivo por arquivo, de
volta ao estado exato de antes desta sessão (`Package.swift` 1.48/155,
igual ao início do dia):
- `Package.swift`: `appIcon`/versão revertidos pra 1.48/155.
- `Models/Character.swift`: removidos `equippedArmorBaseAC`/
  `hasShieldEquipped`/`magicArmorBonus`/`recalculateArmorClass()` (itens
  7/10) e `hasPendingConsequence(forKeys:registry:)` (itens 1/3).
- `Models/Kit.swift`: removido `KitDescription.displaySections`/`Section`
  (item 6) — `fullText` volta a ser exibido cru.
- `Models/Race.swift`: removidos `baseMovementRate` e o preenchimento
  automático de "Movement" em `apply(to:)` (item 8).
- `Store/ConsequenceEngine.swift`: removido `markRecentAutoChange` em
  `applyAutomatic` (item 2) e `refreshLevelChanges`/`levelChangeRow`
  inteiros (item 9).
- `Views/CharacterSheetView.swift`: `SavingThrowsForm`/`Thac0TargetForm`
  voltam a usar `character.hasPendingConsequences` global (não mais
  escopado); `AbilityRowForm.cells` volta a ser 2-tuple sem flash por
  célula; removido `.changeFlash` de Hit Dice/Movement/Proficiencies;
  `ArmorClassShield` volta a receber `armorClass: Binding<Int>` direto;
  `ArmorBlock` perde o seletor de Shield (só Armor); `LevelChangeRowView`/
  `LevelChangesForm` voltam à forma sem `character`/`flashKey`/auto-
  preenchimento; `RecordHeaderForm` perde `ruleset`/`kitDatabase`/
  `proficiencyDatabase` e `addBonusProficiencies`; `ClassPicker` perde a
  chamada a `refreshLevelChanges`; `RecordSheetPageTwo` perde
  `magicItemDatabase`/`refreshMagicArmorBonus`.
- `Views/ArmorCompendiumView.swift`: `ArmorPickerSheet` volta a só Armor
  (`armorRating: Binding<String>`, sem `target`/`character`/recálculo de
  AC); fonte do "choose" volta a 13pt.
- `Views/KitCompendiumView.swift`: descrição do Kit volta a
  `Text(kit.description.fullText)` cru; fonte do "choose" volta a 13pt.
- `Views/MagicItemCompendiumView.swift`, `MundaneItemCompendiumView.swift`,
  `ProficiencyCompendiumView.swift`, `SpellSheetView.swift`,
  `WeaponCompendiumView.swift`: fontes de "choose"/"change" voltam a
  13pt.
- Ícone do app: `Assets.xcassets` continua parado fora do pacote (pasta
  `_icon_wip/` na raiz do repo, não dentro de `THAC0berry.swiftpm/`) —
  os arquivos não se perderam, só ficam de fora até retomar o item 11
  com calma, num momento separado desta sessão.

Resultado: a ficha volta a ter exatamente os bugs originais dos itens
1–10 do pedido do usuário (2026-09-24) — nenhum deles foi corrigido nesta
versão —, mas o projeto volta ao estado que rodava antes de qualquer
mudança de hoje. Todos os 11 itens continuam pendentes de reabertura,
um de cada vez, com verificação de build a cada passo (não mais em lote),
já que não há Xcode/simulador neste ambiente pra confirmar compilação
antes de entregar.

## Ordem sugerida de execução

1. ~~Importar a base~~ — feito, item 1 completo.
2. ~~Favoritos + mais usadas~~ — feito, itens 2 e 3 completos (faltam só os
   dois retoques marcados acima no item 2).
3. ~~Navegação em seções + Grimório~~ — feito, itens 5 e 6 completos.
4. ~~Esferas de acesso~~ — feito, item 16 completo (falta só verificar num
   iPad de verdade, sem simulador aqui — ver ressalva no próprio item).
5. ~~Tela Principal + ícones ilustrados~~ — feito, item 8 completo (falta só
   decidir o destino do selo "Session-active", sem pressa).

## LOTE 1 (v1.53, 2026-09-24) — itens 1, 2, 3 reimplementados

Depois do rollback pra v1.48 (build estável confirmada pelo usuário:
"Essa versão rodou!"), o usuário pediu pra reimplementar a lista de 10
itens pendentes **em lotes de 3, com verificação de build entre cada
lote** — em vez de tudo de uma vez, que foi o que causou o build
silenciosamente quebrado da rodada anterior. Este é o Lote 1.

- **Item 1** — "aumentar/diminuir a WIS fazia o THAC0 piscar em verde
  mesmo sem gerar ajuste nele": `Models/Character.swift` ganhou de volta
  `hasPendingConsequence(forKeys:registry:)`, uma versão ESCOPADA de
  `hasPendingConsequences` (que era global — qualquer consequência
  pendente acendia TODOS os realces). `Views/CharacterSheetView.swift`:
  `SavingThrowsForm` e `Thac0TargetForm` voltam a ter
  `@EnvironmentObject private var ruleset: RulesetRegistry` e usam
  `.pendingConsequenceHighlight(isActive: character.hasPendingConsequence(forKeys: [...], registry: ruleset))`
  com a chave específica de cada seção ("savingThrows"/"thac0") em vez do
  sinal global.
- **Item 2** — "aumentar atributos que impactam os ability scores não
  fazem eles piscarem em verde, apesar de corretamente ajustá-los":
  `Store/ConsequenceEngine.swift`: `applyAutomatic` volta a chamar
  `character.markRecentAutoChange(rule.key)` depois de `apply(newValue,
  &character)` — as regras já escreviam certinho no personagem (THAC0,
  Saving Throws, campos de Ability Details) mas nunca marcavam a mudança
  pro `ChangeFlash` consumir. `Views/CharacterSheetView.swift`:
  `AbilityRowForm.cells` volta a `[(String, Binding<String>, String?)]`
  (terceiro elemento = chave do flash), com
  `.modifier(OptionalChangeFlash(character: $character, key: cells[index].2))`
  em cada célula; as 6 chamadas de `AbilityRowForm` em `AbilityScoresForm`
  (STR/DEX/CON/INT/WIS/CHA) voltam a passar as chaves de cada campo
  (ex.: `("Hit\nAdj", $character.details.strengthHit, "strengthHit")`,
  `nil` pros campos sem regra rastreada ainda).
- **Item 3** — "mudar de Classe ajusta o Hit Dice certinho, mas não
  pisca em verde como aviso": `PlayerCharacter.refreshHitDiceType(force:)`
  já chamava `markRecentAutoChange("hitDiceType")` (não foi tocado nesta
  sessão — sempre esteve lá, mesmo na v1.48). Faltava só o lado da view:
  `CombatForm` em `Views/CharacterSheetView.swift`, o campo "Hit Dice:"
  ganhou `.changeFlash(character: $character, key: "hitDiceType")`.

Verificação feita nesta sessão (sem Xcode/simulador disponível): sweep
`grep -rn "2026-09-24"` nos 3 arquivos tocados, contagem de chaves
`{`/`}` balanceada em cada um, e grep confirmando que nenhum símbolo dos
Lotes 2/3/4 (`baseMovementRate`, `refreshLevelChanges`,
`addBonusProficiencies`, `displaySections`, `equippedArmorBaseAC`,
`hasShieldEquipped`, `magicArmorBonus`, `recalculateArmorClass`,
`refreshMagicArmorBonus`) voltou junto, e que o ícone (`appIcon`/
`iconAssetName`) continua fora do `Package.swift`.

`Package.swift`: `displayVersion` "1.48"→"1.53" (pulando 1.49-1.52, que
ficaram associados à rodada de build quebrado), `bundleVersion`
"155"→"156".

**Itens 4, 5, 6, 7, 8, 9, 10 continuam pendentes** — Lote 2 (itens 4, 8,
9), Lote 3 (itens 5, 6), Lote 4 (itens 7, 10), cada um só depois do
usuário confirmar que o lote anterior compilou. Item 11 (ícone) continua
parado em `_icon_wip/` fora do pacote.

## LOTE 2 (v1.54, 2026-09-24) — itens 4, 8, 9 reimplementados

Depois do usuário confirmar que o Lote 1 (v1.53) rodou, seguindo o Lote 2:
itens 4, 8 e 9.

- **Item 4** — "choose"/"change" numa fonte bem menor que "close",
  padronizar em todas as janelas de escolha: `Views/KitCompendiumView.swift`,
  `ArmorCompendiumView.swift`, `MundaneItemCompendiumView.swift`,
  `ProficiencyCompendiumView.swift`, `WeaponCompendiumView.swift`,
  `MagicItemCompendiumView.swift`, `SpellSheetView.swift` — todos os
  botões "choose" (`Paper.printed`) e "change" (`Paper.printedItalic`)
  foram de 13pt pra 16pt, igual o "close" que já ficava do lado.
- **Item 8** — "Movement preenchido automaticamente ao escolher raça":
  `Models/Race.swift` ganhou `baseMovementRate` (Human/Elf/Half-Elf
  12", Dwarf/Gnome/Halfling 6" — taxa-padrão de Table 7 do PHB) e
  `apply(to:)` agora preenche `page2Movement.base` sozinho (só se
  estava vazio — nunca sobrescreve) e marca
  `markRecentAutoChange("page2MovementBase")`. Só o campo "Base" é
  preenchido — Jog/Run/Day dependem de fatores de encumbrance que o
  app não modela ainda, continuam manuais. `Views/CharacterSheetView.swift`:
  `MovementForm`, linha "Base", ganhou
  `.changeFlash(character: $character, key: "page2MovementBase")`.
- **Item 9** — "Level Changes ajustado automaticamente por classe/raça":
  `Store/ConsequenceEngine.swift` ganhou `refreshLevelChanges(for:registry:force:)`,
  que preenche as linhas "THAC0" e "Saving Throws" da tabela "Level
  Changes" (página 2) varrendo os níveis 1–20 com o MESMO
  `registry.resolve` que já calcula THAC0/Saves de verdade
  (`Thac0ByLevelProvider`/`SavingThrowsByLevelProvider` — Tables 53/60
  do PHB, já conferidas contra o livro) — sem duplicar tabela nenhuma,
  só observando em que níveis o valor resolvido muda. As linhas
  "Weapon Proficiencies"/"Non-weapon Proficiencies" ficam de fora de
  propósito: o app não tem uma tabela verificada de quando cada classe
  ganha slot novo, e chutar esse número arriscava escrever algo errado
  — melhor continuar em branco, como sempre foi. Chamado com
  `force: false` (só preenche linha vazia) ao editar o nível
  (`RecordHeaderForm`, no `.onChange(of: character.level)` e no
  `.onAppear`, rede de segurança pra fichas antigas) e com
  `force: true` (resincroniza mesmo se já tinha algo escrito — a
  tabela muda de classe pra classe) em `ClassPicker.select`.
  `Views/CharacterSheetView.swift`: `RecordHeaderForm` e `ClassPicker`
  ganharam `@EnvironmentObject private var ruleset: RulesetRegistry`;
  `LevelChangesForm`, linhas "THAC0" e "Saving Throws", ganharam
  `.changeFlash(character: $character, key: "levelChanges")`.

Verificação feita nesta sessão (sem Xcode/simulador disponível): sweep
`grep` confirmando ausência de todo símbolo do Lote 3/4
(`addBonusProficiencies`, `displaySections`, `equippedArmorBaseAC`,
`hasShieldEquipped`, `magicArmorBonus`, `recalculateArmorClass`,
`refreshMagicArmorBonus`), contagem de chaves `{`/`}` balanceada em
todos os 10 arquivos tocados, e conferência de que nenhum botão
"choose"/"change" ficou em 13pt.

`Package.swift`: `displayVersion` "1.53"→"1.54", `bundleVersion`
"156"→"157".

**Itens 5, 6, 7, 10 continuam pendentes** — Lote 3 (itens 5, 6), Lote 4
(itens 7, 10), cada um só depois do usuário confirmar que o lote
anterior compilou. Item 11 (ícone) continua parado em `_icon_wip/` fora
do pacote.

## AJUSTE v1.55 — coluna "By" de Level Changes (item 9)

Usuário perguntou, depois do Lote 2 (v1.54), por que a coluna "By" de
"Level Changes" vinha preenchida com o texto genérico "book table" —
pediu ou um link pra consultar a tabela, ou aplicar o valor de verdade
na linha/coluna. Resposta: os dois.

- `Store/ConsequenceEngine.swift`: `refreshLevelChanges` não escreve
  mais nada em "By" (não tinha um número CERTO pra pôr ali — a variação
  de THAC0/Saves entre uma parada e outra não é constante, ex.: Priest
  cai 2 pontos do nível 3 pro 4 mas só 1 do 10 pro 13). Duas mudanças no
  lugar:
  1. "At Levels" da linha THAC0 agora embute o valor de verdade que o
     THAC0 passa a valer em cada parada — ex. "4 (→18), 7 (→16), 10
     (→14)" — puxado do mesmo `registry.resolve` que grava o THAC0 real
     da ficha (não é um número novo, é o mesmo já verificado).
  2. Saving Throws não embute os 5 números na célula (ficaria
     ilegível) — pra essa linha os valores reais já aparecem ao vivo na
     seção "Saving Throws" da própria ficha (pisca em verde quando muda,
     ver item 1), então "At Levels" só avisa QUANDO conferir.
  Novo dicionário `ConsequenceEngine.levelChangeRuleIDs` mapeia cada
  linha pro ID da regra embutida correspondente
  (`phb_ch09_calculating_thac0`/`phb_ch09_the_saving_throw`).
- `Views/CharacterSheetView.swift`: `LevelChangeRowView` ganhou um
  `ruleID: String?` opcional que mostra o botão "?" (`RuleLinkButton`,
  já usado em `FormSectionTitle`) ao lado do título da linha — abre a
  tabela completa do livro (`RuleDetailSheet`) sem sair da ficha.
  `LevelChangesForm` passa `ConsequenceEngine.levelChangeRuleIDs["thac0"]`/
  `["savingThrows"]` nas duas linhas automáticas; Proficiências
  continuam sem "?" (não têm regra embutida pra apontar).

`Package.swift`: `displayVersion` "1.54"→"1.55", `bundleVersion`
"157"→"158".

## AJUSTE v1.56 — coluna "By" de Level Changes ganha valor de verdade

Usuário perguntou de novo (2026-09-24): "'By' fica sempre vazio, como o
jogador preenche? Dê um exemplo." Resposta certa: não deveria ficar pro
jogador preencher — o app já TEM o dado, só faltava usar.

- `Store/ConsequenceEngine.swift`: `levelChangeRow` agora devolve
  `(by:, atLevels:)` em vez de só uma string. Pra THAC0, calcula o
  delta entre uma parada e a anterior (`newInt - oldInt`, os dois já
  resolvidos pelo mesmo `registry.resolve` que grava o THAC0 real) e
  escreve a lista alinhada com "At Levels" — ex., um Cleric fica:
  "By": "-2, -2, -2, -1, -2, -1" / "At Levels": "4, 7, 10, 13, 16, 19"
  (mostrando que no nível 4 o THAC0 cai 2 pontos, no 7 cai mais 2, ...,
  no 19 cai só 1). Um Fighter (cai 1 ponto por nível, do 2 ao 20) fica:
  "By": "-1, -1, -1, -1, ..." (19 vezes) / "At Levels": "2–20".
  `refreshLevelChanges` grava os dois campos agora, não só "At Levels".
- Saving Throws continua sem preencher "By" — são 5 números mudando
  junto (Paralyzation/Poison/Death, Rod/Staff/Wand, Petrification/
  Polymorph, Breath Weapon, Spell), um delta só não diria a qual dos
  cinco se refere. Pra essa linha os valores reais já aparecem ao vivo
  na própria seção "Saving Throws" da ficha (pisca em verde quando
  muda), e o botão "?" ao lado do título abre a Table 60 inteira.

`Package.swift`: `displayVersion` "1.55"→"1.56", `bundleVersion`
"158"→"159".

## PENDÊNCIA — "Level Changes" (item 9) precisa repensar o design

Usuário testou a v1.56 (2026-09-24): "Melhorou, mas acho que não
funciona bem." Sem detalhar o quê especificamente incomodou — só pediu
pra anotar aqui e seguir pros próximos lotes por ora. Retomar com calma
numa sessão futura, sem pressa. Hipóteses a considerar quando isso
voltar à mesa (nenhuma confirmada pelo usuário ainda):
- A lista "By": "-2, -2, -2, -1, -2, -1" alinhada por posição com "At
  Levels" pode estar confusa/pouco legível numa caixinha de texto
  pequena — talvez precise de um formato mais parecido com o do PDF
  original, ou de uma apresentação por linha em vez de tudo numa
  string só.
- Talvez o formato "4 (→18), 7 (→16)..." do "At Levels" da linha THAC0
  esteja poluído — o parêntese com seta pode não ser o que o usuário
  esperava ver ali.
- Vale perguntar ao usuário, quando retomar, o que especificamente não
  funcionou (muito texto? formato errado? preferia só o link "?" sem
  nenhum preenchimento automático? preferia como estava nativamente no
  PDF, sem nenhuma automação nessa tabela?) antes de tentar uma nova
  versão — evitar mais um ciclo de tentativa e erro sem esse dado.

## LOTE 3 (v1.57, 2026-09-24) — itens 5, 6 reimplementados

Usuário confirmou anotar a pendência de "Level Changes" (ver seção
acima) e pediu pra seguir pro próximo lote. Lote 3: itens 5 e 6.

- **Item 5** — "Kit que concede Proficiência deveria adicioná-la
  automaticamente na ficha": `Store/KitDatabase.swift` ganhou
  `kit(named:)` (casa `character.kit`, texto livre, contra o nome de um
  kit da base via `Fuzzy.normalize` — `character.kit` só guarda o nome,
  nunca um id). `Views/CharacterSheetView.swift`: `RecordHeaderForm`
  ganhou `@EnvironmentObject` de `KitDatabase`/`ProficiencyDatabase`, um
  `.onChange(of: character.kit)` e o método
  `addBonusProficiencies(forKit:)` — lê `kit.mechanics.proficiencies.bonus`
  (a lista de proficiências que o kit CONCEDE de graça — distinta de
  `recommended`, que é só sugestão), tenta casar cada nome com a base de
  proficiências (`matchedProficiencyID`) e adiciona uma `ProficiencyEntry`
  nova só se ainda não existir (confere por id casado ou nome
  normalizado — nunca duplica, nunca remove o que já estava lá).
  `ProficienciesForm` ganhou `.changeFlash(character: $character, key: "proficiencies")`
  pra avisar quando isso acontece.
- **Item 6** — "Descrições de Kits com tabelas wikitext quebradas (ex.:
  Ilmater - Alleviator)": bug real, confirmado em 56 dos 91 kits (todos
  os de sacerdote especializado, um por divindade) — `fullText` vinha
  com a tabela-resumo CRUA da wiki (`{| class="article-table" ... |}`)
  grudada no início do texto, porque o pipeline de conversão (fora do
  app) só tratava negrito/links, nunca tabela. `Models/Kit.swift`:
  `KitDescription` ganhou `Section` (title/body) e `displaySections`,
  que descarta a tabela wikitext crua (o dado dela — Ability
  Requirements, Prime Requisite, Weapon/Nonweapon Slots, Bonus/
  Recommended Proficiencies etc. — já aparece estruturado em outro
  lugar da própria `KitDetailSheet`, via `kit.mechanics.*`/
  `kit.features.*`, então não perde informação nenhuma) e separa o
  resto (Overview/Description/Role-Playing/Special Abilities/Special
  Disadvantages) em blocos por `## Heading`, sem `**negrito**` cru
  sobrando. `Views/KitCompendiumView.swift`: a seção "Description" da
  `KitDetailSheet` trocou `Text(kit.description.fullText)` por um
  `ForEach(kit.description.displaySections)`.

Verificação feita nesta sessão (sem Xcode/simulador disponível): sweep
`grep` confirmando ausência de todo símbolo do Lote 4
(`equippedArmorBaseAC`, `hasShieldEquipped`, `magicArmorBonus`,
`recalculateArmorClass`, `refreshMagicArmorBonus`), contagem de chaves
`{`/`}` balanceada nos 4 arquivos tocados.

`Package.swift`: `displayVersion` "1.56"→"1.57", `bundleVersion`
"159"→"160".

**Item 7, 10 continuam pendentes** — Lote 4 (Armor/Shield AC, Magic
Item AC), só depois do usuário confirmar que este lote compilou. Item
11 (ícone) continua parado em `_icon_wip/` fora do pacote.

## AJUSTE v1.58 — proficiência de Kit reaproveita linha vazia (item 5)

Usuário testou o Lote 3 (2026-09-24) e pediu um ajuste: a ficha já
nasce com 6 linhas de Proficiências em branco (`ProficienciesForm.onAppear`)
pro jogador preencher — escolher um Kit que concede proficiência estava
criando uma linha NOVA (a 7ª) em vez de ocupar uma das 6 vazias, o que
deixava a seção com 6 linhas vazias + 1 preenchida em vez de só
preencher uma das que já existiam.

- `Views/CharacterSheetView.swift`: `addBonusProficiencies(forKit:)`
  agora procura primeiro uma linha vazia existente (sem nome e sem
  proficiência já casada — `matchedProficiencyID == nil`) antes de criar
  uma linha nova, e reaproveita ela (preserva `id`/`checked`/`target`
  daquela linha, só troca nome/slots/id casado). Só cria linha nova de
  verdade quando não sobra nenhuma vazia (personagem que já preencheu
  as 6 originais).

`Package.swift`: `displayVersion` "1.57"→"1.58", `bundleVersion`
"160"→"161".

## LOTE 4 (v1.59, 2026-09-24) — itens 7 e 10: Armor Class automático

Últimos dois itens da lista de 10 (item 11, ícone, continua parqueado
à parte). Área de maior risco do pedido inteiro — é a mesma zona
(`ArmorClassShield`/seletor de Armor/recálculo de AC por Magic Item)
que já esteve implicada no travamento de build silencioso que levou
ao rollback pra v1.48 no início desta sessão; usuário foi avisado
antes de começar e confirmou ("Manda bala!").

- Item 7 ("Armor mostra só '1' no campo, AC base não muda; estender
  pra Shield"): o campo "Armor" da página 2 (`character.armorRating`)
  e o círculo grande de AC da página 1 (`character.armorClass`)
  viviam 100% desconectados — escolher uma armadura no seletor só
  preenchia o campinho de texto, sem tocar no AC de verdade. "Shield"
  nem seletor tinha.
- Item 10 ("Magic Items — armadura mágica — não muda o AC"): a lista
  "Magic Items" da página 2 também não tinha nenhuma ligação com o AC,
  mesmo quando o item ligado (`matchedItemID`) tinha um
  `defenseBonus.acBonus` de verdade na base.

**O que mudou:**

- `Store/ConsequenceEngine.swift`: nova `recalculateArmorClass(for:
  magicItemDatabase:)`. Soma `armorRating` (já um AC final de verdade
  na base embutida, ex. Plate Mail = 3) + `shieldRating` (escudo não
  tem `baseAC` próprio na base — a regra central de 2e é -1 fixo de
  AC por qualquer escudo, ver abaixo) + o `defenseBonus.acBonus` de
  cada Magic Item ligado por `matchedItemID` (SUBTRAÍDO — AC menor é
  melhor em 2e, `acBonus` vem como inteiro positivo representando o
  nível de encantamento). Só escreve quando o total calculado é
  diferente do AC atual, e só roda se `armorRating` for um número de
  verdade (campo vazio ou texto livre não numérico não disparam
  nada). Dexterity (`details.dexterityDefense`) fica de fora de
  propósito — nenhum dos dois itens pediu isso, e essa conta já mexe
  na área mais visível da ficha sem precisar arriscar contar um bônus
  em dobro.
- `Views/ArmorCompendiumView.swift`: `ArmorPickerSheet` generalizado
  — trocou o binding fixo `armorRating` por `rating` + um parâmetro
  `kind: ArmorPieceKind` (`.armor` por padrão), então a mesma sheet
  serve pra Armor E Shield agora. `choose(_:)` grava o `baseAC` da
  peça quando existe (armadura) ou, pra escudo (sem `baseAC` na
  base), grava o "-1" fixo da regra central de 2e.
- `Views/CharacterSheetView.swift`:
  - `ArmorBlock`: campo "Shield" ganhou seletor próprio
    (`showShieldPicker`/segunda `ArmorPickerSheet(rating: $character.
    shieldRating, kind: .shield)`), igual ao que "Armor" já tinha.
    `.onChange(of: character.armorRating)` e `.onChange(of: character.
    shieldRating)` chamam `recalculateArmorClass` sempre que um dos
    dois muda (seletor OU digitação direta).
  - `RecordSheetPageTwo`: `.onChange(of: character.page2MagicItems)`
    chama `recalculateArmorClass` sempre que a lista de Magic Items
    muda (item ligado, trocado ou removido).
  - `CombatForm`: `ArmorClassShield` ganhou
    `.changeFlash(character: $character, key: "armorClass")` — o
    círculo de AC pisca verde quando o recálculo automático mexe nele,
    mesma linguagem visual já usada nos outros itens.

De propósito, o recálculo NUNCA roda em `onAppear`/ao abrir a ficha —
só reage a uma mudança de verdade em Armor/Shield/Magic Items. Rodar
no `onAppear` sobrescreveria silenciosamente um AC que o jogador tenha
ajustado a mão por um motivo que a conta automática não conhece (um
efeito temporário, por exemplo) toda vez que ele trocasse de aba e
voltasse — risco maior que o benefício de "sincronizar" uma ficha
salva antes desta versão.

Verificação feita nesta sessão (sem Xcode/simulador disponível): sweep
`grep` confirmando que `ArmorPickerSheet(rating:` é a única forma de
chamada (nenhum resquício do parâmetro antigo `armorRating:` em outro
lugar), ausência de qualquer símbolo do item 11 (ícone), contagem de
chaves `{`/`}` balanceada nos 3 arquivos tocados
(`Store/ConsequenceEngine.swift`, `Views/ArmorCompendiumView.swift`,
`Views/CharacterSheetView.swift`).

`Package.swift`: `displayVersion` "1.58"→"1.59", `bundleVersion`
"161"→"162".

**Os 10 itens de código do pedido original estão implementados.**
Resta só o item 11 (ícone do app), parqueado à parte em `_icon_wip/`
fora do `.swiftpm`, pra retomar só depois do usuário confirmar que
este lote compilou — e a pendência já anotada sobre "Level Changes"
(item 9), pra revisitar quando o usuário disser especificamente o que
não funcionou bem.

## AJUSTE v1.60 — Armor/Magic Items não recalculavam o AC (itens 7/10)

Usuário testou o Lote 4 (2026-09-24) e reportou: "Ao mudar o valor em
'Shield' o AC foi sensibilizado corretamente, mas depois mudei Armor
e incluí/excluí armadura mágica e nada mudou o AC."

**Causa raiz encontrada:** `ConsequenceEngine.recalculateArmorClass`
tinha um `guard` travado só em `armorRating` — se esse campo não
fosse um número válido no momento da chamada, a função inteira
retornava sem calcular NADA, nem a parte de Shield nem a de Magic
Items (que dependiam do mesmo cálculo). `shieldRating` já tinha o
tratamento certo (`Int?` opcional — falha de parse conta como "sem
contribuição", não trava a função); `armorRating` não. E existia uma
fonte concreta de "lixo" nesse campo: `Models/SampleCharacter.swift`
(a ficha de exemplo, Kelmon) tinha `shieldRating = "−2"` usando o
SINAL DE MENOS matemático (U+2212, "−") em vez do hífen ASCII
("-") — `Int.init?(String)` só reconhece o hífen comum. O iPadOS
troca "-" por "–"/"−" sozinho em certos teclados/autocorreção, então
um jogador digitando "-1" a mão corre o mesmo risco.

- `Store/ConsequenceEngine.swift`: `recalculateArmorClass` reescrita
  — `armorRating` agora usa o mesmo tratamento "soft" de
  `shieldRating` (`Int?`, não trava mais os outros dois campos).
  Nova `parsedRating(_:)` normaliza "−"/"–"/"—" pro hífen ASCII antes
  do parse, resolvendo a causa concreta. A função só desiste de vez
  quando NENHUM dos três sinais (Armor/Shield/Magic Items) existe —
  preserva a intenção original de não forçar o AC pra 0 numa ficha
  ainda sem equipamento nenhum.
- `Models/SampleCharacter.swift`: `kelmon.shieldRating` trocado de
  `"−2"` (sinal de menos matemático, inválido) pra `"-2"` (hífen
  ASCII).

Verificação feita nesta sessão (sem Xcode/simulador disponível):
contagem de chaves `{`/`}` balanceada nos 2 arquivos tocados.

`Package.swift`: `displayVersion` "1.59"→"1.60", `bundleVersion`
"162"→"163".

## LOTE 5 (v1.61, 2026-09-24) — item 11: ícone do app

Último item do pedido original de 2026-09-24. Reaberto só agora, de
propósito, depois dos 10 itens de código confirmados pelo usuário —
essa é EXATAMENTE a peça que causou o travamento de build silencioso
(sem nenhuma mensagem de erro em lugar nenhum) que levou ao rollback
completo pra v1.48 no início desta sessão, inclusive com a MESMA
imagem (dragão policial de óculos escuros e revólver, pixel art,
emblema circular azul, 1254×1254 — reenviada pelo usuário agora).

**Hipótese da causa raiz, revisitada:** relendo o histórico da
tentativa anterior (linhas ~3928-3960 acima), o catálogo
`Assets.xcassets/AppIcon.appiconset` tinha sido colocado DENTRO de
`Resources/` (`Resources/Assets.xcassets/...`). Esse é o lugar
errado — projetos de App do Swift Playgrounds esperam o
`Assets.xcassets` na RAIZ do pacote, do lado do `Package.swift`, não
dentro de uma pasta de recurso genérico (`Resources/`, que só é
processada pelo `.process("Resources")` do target pra recursos de
runtime — o catálogo de ícone é compilado por um caminho separado,
específico do Swift Playgrounds). Nunca dá pra confirmar 100% sem
Xcode/simulador neste ambiente, mas é uma diferença estrutural real e
uma explicação plausível pro silêncio total do build (o Swift
Playgrounds é conhecido por engolir erro de `actool`/asset catalog
sem mostrar nada na UI, diferente de erro de código Swift).

**O que mudou desta vez:**

- `THAC0berry.swiftpm/Assets.xcassets/AppIcon.appiconset/` criado na
  RAIZ do pacote (não dentro de `Resources/`) — `AppIcon.png`
  (1024×1024, RGB 8-bit, SEM canal alfa — confirmado por script,
  ícone de app não pode ter transparência) + `Contents.json` no
  formato "single size" moderno (`idiom: "universal"`, um PNG só, sem
  precisar gerar o conjunto antigo de tamanhos por idiom).
- `Package.swift`: `appIcon: .asset("AppIcon")` adicionado ao
  `.iOSApplication(...)` — MESMA posição/sintaxe já confirmada
  correta na tentativa anterior (o parâmetro certo é `appIcon:`, não
  `iconAssetName:`, que já tinha dado erro de compilação claro da vez
  passada e foi corrigido; o problema que restou era silencioso e
  ligado ao catálogo, não a este parâmetro). `displayVersion`
  "1.60"→"1.61", `bundleVersion` "163"→"164".
- `_icon_wip/` (pasta fora do pacote onde o ícone ficou parqueado o
  dia inteiro) removida — o ícone agora vive de verdade dentro do
  `.swiftpm`.

Entregue como versão ISOLADA de propósito — se o build travar
silenciosamente de novo, é só reverter este lote sozinho (`Package.
swift` volta pra 1.60/163 sem `appIcon:`, `Assets.xcassets` sai do
pacote) sem arriscar nenhum dos 10 itens de código já confirmados.

Verificação feita nesta sessão (sem Xcode/simulador disponível):
`Assets.xcassets` confirmado FORA de `Resources/` (script), PNG
confirmado 1024×1024 RGB sem alpha (script), nenhuma referência a
`iconAssetName` sobrando em `Package.swift`.

**Com isto, os 11 itens do pedido original de 2026-09-24 estão
implementados** — resta confirmar que o build do Playground aceita o
ícone desta vez, e a pendência já anotada sobre "Level Changes" (item
9), que segue em aberto até o usuário detalhar o que não funcionou
bem.

## LOTE 6 (v1.62, 2026-09-24) — caderno: caneta preta, folha pautada/quadriculada

Usuário testou v1.61 (ícone) — "Assim rodou liso! Uhuuuuu!!" — e trouxe
três pedidos novos pro caderno de anotações:

1. **Caneta abria branca** — quase invisível no papel claro do caderno.
2. **Dois estilos de folha novos**: pautada e quadriculada, com opção de
   trocar.
3. **Configurações gerais**: escolher o estilo de folha PADRÃO pra folha
   nova (liso/pautado/quadriculado).

**O que mudou:**

- `Views/NotebookView.swift` (`DrawingCanvas`, a folha de desenho livre):
  cor da tinta trocada de um azul-marinho (`#1E3557`) pra preto
  (`defaultInkColor = UIColor.black`). A causa do "branco" não era o
  valor inicial (`makeUIView` já não era branco) — é que `PKToolPicker`
  sincroniza, ao ser anexado, a ÚLTIMA cor de tinta usada em QUALQUER app
  com Apple Pencil no aparelho (estado do SISTEMA, não deste app) por
  cima do que já tinha sido definido — por isso a cor agora é reafirmada
  de novo logo DEPOIS do anexo em `updateUIView`, não só em `makeUIView`.
- `Models/Character.swift`: novo `enum NotebookPaperStyle` (`.plain`/
  `.lined`/`.grid`) e `NotebookEntry.paperStyle: NotebookPaperStyle?`
  (Optional pela convenção de sempre — folha antiga sem a chave cai pra
  `.plain`, que já era o único estilo que existia). `Campaign.
  addNotebookPage(kind:paperStyle:)` ganhou o segundo parâmetro (default
  `.plain`, pra não quebrar chamada antiga).
- `Views/NotebookView.swift`: nova `NotebookPaperTexture` — desenha linhas
  horizontais (pautada) ou malha (quadriculada) como FUNDO da área de
  escrita/desenho (`Canvas`, sem capturar toque — `.allowsHitTesting(false)`),
  atrás tanto da folha transcrita quanto da de desenho livre. Cabeçalho da
  folha (`NotebookPageView.header`) ganhou um `Menu` pra trocar o estilo
  DESTA folha a qualquer momento — cada folha guarda a própria escolha,
  independente da folha ao lado.
- `Store/CharacterLibrary.swift`: novo `@Published var
  defaultNotebookPaperStyle: NotebookPaperStyle = .plain` (mesmo padrão de
  `favoriteSpellIDs` — persiste em `library.json`, entra no Export/Import
  de backup, decode com fallback pra `.plain` em biblioteca salva antes
  deste pedido).
- `Views/SettingsView.swift`: nova seção "Notebook" com um Picker
  segmentado ligado a `library.defaultNotebookPaperStyle` — só afeta
  folha NOVA; folha existente mantém o que já tinha (trocável no próprio
  cabeçalho, ver acima).
- `NotebookBeadRow`/`NotebookEmptyState` (os dois lugares que criam folha
  nova): ganharam `@EnvironmentObject private var library:
  CharacterLibrary` pra ler o padrão configurado na hora de chamar
  `addNotebookPage`.

Verificação feita nesta sessão (sem Xcode/simulador disponível): sweep
`grep` confirmando as 2 chamadas de `addNotebookPage` atualizadas, os
tipos novos (`NotebookPaperStyle`/`NotebookPaperTexture`) declarados uma
única vez cada, contagem de chaves `{`/`}` balanceada nos 4 arquivos
Swift tocados.

`Package.swift`: `displayVersion` "1.61"→"1.62", `bundleVersion`
"164"→"165".

## AJUSTE v1.63 — caneta da escrita livre ainda abria branca

Usuário testou v1.62 e reportou: "a cor da caneta na escrita livre
permanece a branca por padrão", mesmo depois do ajuste de reafirmar a
cor logo após anexar o `PKToolPicker`.

**Causa raiz:** a reafirmação em v1.62 acontecia na MESMA passada de
`setVisible`/`addObserver` — mas a sincronização do `PKToolPicker` (a
última cor usada em qualquer app com Pencil no aparelho, ver AJUSTE
v1.62 acima) acontece de forma ASSÍNCRONA, alguns instantes DEPOIS
dessas chamadas retornarem, não durante. Uma atribuição só, síncrona,
perdia essa corrida — o picker ainda vencia por cima logo em seguida.

- `Views/NotebookView.swift` (`DrawingCanvas.updateUIView`): a cor
  agora é reafirmada TRÊS vezes no anexo inicial — imediatamente, e de
  novo via `DispatchQueue.main.async`/`asyncAfter(0.3s)`, que rodam
  DEPOIS de qualquer sincronização pendente do picker no mesmo
  runloop. Só acontece uma vez no anexo inicial — nunca briga com uma
  cor que o jogador escolha depois.

Verificação feita nesta sessão (sem Xcode/simulador disponível):
contagem de chaves `{`/`}` balanceada em `Views/NotebookView.swift`.

`Package.swift`: `displayVersion` "1.62"→"1.63", `bundleVersion`
"165"→"166".

## AJUSTE v1.64 — causa raiz real da caneta branca: cor adaptativa do PencilKit

Usuário testou v1.63 (reafirmação tripla contra suposta corrida
assíncrona com o `PKToolPicker`) e reportou: "Nada mudou". Isso invalida
a teoria usada em v1.62 e v1.63 — o problema nunca foi TIMING.

**Causa raiz de verdade:** o PencilKit trata `UIColor.black` e
`UIColor.white` como cores ADAPTATIVAS — ele inverte automaticamente
entre preto e branco de acordo com o `userInterfaceStyle` (claro/escuro)
do canvas, pra tinta continuar visível em qualquer fundo (comportamento
documentado da Apple, não um bug de sincronização). O papel deste app é
sempre claro, mas o SISTEMA podia estar em Modo Escuro — nesse caso o
`.black` literal virava branco por baixo dos panos, e reatribuir
`.black` de novo (mesmo três vezes, em instantes diferentes) não tinha
efeito nenhum, porque a cor em si continuava sendo a adaptativa.

- `Views/NotebookView.swift` (`DrawingCanvas`):
  - `defaultInkColor` trocado de `UIColor.black` pra um RGB explícito
    quase-preto (`UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)`)
    — deixa de ser a cor especial que o PencilKit reconhece e inverte.
  - `makeUIView` e `updateUIView` agora forçam
    `canvas.overrideUserInterfaceStyle = .light` no `PKCanvasView`,
    removendo de vez o gatilho da inversão, não importa o tema do
    sistema no aparelho.
  - A reafirmação tripla de v1.63 (baseada na teoria de corrida, já
    descartada) foi simplificada de volta pra uma reafirmação única
    logo após anexar o `PKToolPicker` — suficiente agora que a cor em
    si não é mais adaptativa.

Verificação feita nesta sessão (sem Xcode/simulador disponível):
contagem de chaves `{`/`}` balanceada em `Views/NotebookView.swift`
(141/141); sweep `grep` confirmando que nenhum outro lugar do arquivo
usa `.black`/`.white`/`.label` (cores adaptativas) pra tinta.

`Package.swift`: `displayVersion` "1.63"→"1.64", `bundleVersion`
"166"→"167".

## AJUSTE v1.65 — tinta já saía preta, mas o seletor de cor do PKToolPicker mostrava branco

Usuário testou v1.64 (RGB explícito + canvas travado em modo claro) e
confirmou que a TINTA já saía preta de verdade. Só sobrou um efeito
colateral: o seletor de cor do próprio `PKToolPicker` (a barrinha
flutuante da Apple Pencil, com os círculos de cor) continuava mostrando
branco como a cor "atual" selecionada.

**Causa raiz:** o `PKToolPicker` é um popover do SISTEMA, fora da
hierarquia de views do app — ele tem sua PRÓPRIA propriedade
`overrideUserInterfaceStyle`, independente da que o AJUSTE v1.64 já
usa no `PKCanvasView`. Travar só o canvas resolve o traço desenhado na
tela, mas não o picker: sem travar ele também, seus próprios swatches
(inclusive o círculo que mostra a cor atual) continuavam seguindo o
tema do sistema e resolvendo de forma adaptativa.

- `Views/NotebookView.swift` (`DrawingCanvas.updateUIView`): agora
  também define `toolPicker.overrideUserInterfaceStyle = .light` logo
  ao criar a instância do picker, junto do travamento que já existia
  no canvas.

Verificação feita nesta sessão (sem Xcode/simulador disponível):
contagem de chaves `{`/`}` balanceada em `Views/NotebookView.swift`
(141/141); confirmado via documentação oficial da Apple
(`PKToolPicker.overrideUserInterfaceStyle`) que essa propriedade existe
e controla exatamente a aparência do próprio picker, separada da do
canvas.

`Package.swift`: `displayVersion` "1.64"→"1.65", `bundleVersion`
"167"→"168".

## LOTE 7 (v1.66, 2026-09-24) — tirar a criação automática da campanha padrão e do Kelmon

Pedido do usuário: "tire a criação automática da campanha padrão e do
Kelmon".

- `Store/CharacterLibrary.swift` (`load()`): na primeira execução (sem
  `library.json` ainda no disco), o app parava de semear a campanha +
  personagem de exemplo (`PlayerCharacter.kelmonWithCampaign()`, o
  Kelmon) e simplesmente abria com `campaigns`/`characters` vazios —
  já é o valor padrão dos `@Published` no topo da classe, então não
  precisa de nenhum código extra pra isso.
- Mesma remoção no branch de erro (JSON salvo de uma versão antiga que
  não decodifica mais): antes também caía pro Kelmon de exemplo; agora
  só registra o erro em `lastError` e deixa a pasta vazia, pronta pra
  um Import de backup (`SettingsView`) se o jogador tiver um.
- O helper `seedSample()` ficou sem chamada nenhuma — removido.
  `Models/SampleCharacter.swift` (o `kelmonWithCampaign()` em si) foi
  MANTIDO no projeto, só não é mais chamado de lugar nenhum — não tem
  motivo pra apagar o arquivo por uma limpeza de referência que pode
  voltar a ser útil (testes, por exemplo).
- Conferido que as telas que listam campanha/personagem
  (`CampaignListView`, `AllCharactersView`) já tinham estado vazio
  (`campaigns.isEmpty`/`characters.isEmpty`) preparado de antes — abrir
  sem nada semeado não é um estado novo pro app, só deixou de nascer
  pré-preenchido.

Verificação feita nesta sessão (sem Xcode/simulador disponível):
contagem de chaves `{`/`}` balanceada em `Store/CharacterLibrary.swift`
(82/82); sweep `grep` confirmando que `kelmonWithCampaign`/
`seedSample` não têm mais nenhuma chamada ativa.

`Package.swift`: `displayVersion` "1.65"→"1.66", `bundleVersion`
"168"→"169".

## LOTE 8 (v1.67, 2026-09-25) — Rules/Kits/Proficiencies/Deities: de literal Swift pra JSON

Pedido do usuário: analisar o que mais contribuía pro tamanho do projeto,
depois de duas tentativas frustradas de mandar o app pra loja pelo Swift
Playgrounds (erro genérico "Build failed", sem log nenhum acessível, e
nenhum build sequer chegando no App Store Connect).

**Diagnóstico:** o projeto tinha 27 MB de `Resources/` (imagens + JSON),
mas o suspeito de verdade pro archive travar era outra coisa: 3.9 MB de
dados embutidos como literal Swift puro em `Store/EmbeddedRules_PartN.swift`
(29 arquivos), `EmbeddedKits_PartN.swift` (6), `EmbeddedProficiencies_PartN.swift`
(26) e `EmbeddedDeities_PartN.swift` (9) — no total, 171 arquivos `.swift`/
~56 mil linhas no projeto inteiro. Esses literais gigantes já tinham sido
divididos em vários arquivos-parte numa sessão anterior especificamente
pra evitar o erro clássico do type-checker do Swift ("unable to type-check
this expression in reasonable time") — só que isso só ajuda o build de
Debug/execução local: o build de Release/Archive (o que o "Distribute App"
usa) compila com "whole module optimization", que junta tudo de nsovo
num módulo só não importa quantos arquivos-parte existam. Isso bate com
o sintoma relatado: "roda liso localmente, mas o archive pra loja sempre
falha".

**A solução, pedida e executada nesta sessão:** converter Rules, Kits,
Proficiencies e Deities de volta pra JSON carregado em runtime (tirando
tudo isso da frente do type-checker) — mantendo Armor/MundaneItems/
Weapons/SampleSpells como estavam (pequenos, não valem o risco).

- Escrito `Scripts/swift_lit_to_json.py` — um parser mecânico (tokenizer +
  recursive descent) que lê o literal Swift diretamente e emite JSON, SEM
  passar o texto por nenhum modelo de linguagem — importante pra um corpus
  de texto de regras/livro que não pode sofrer paráfrase ou perda
  silenciosa. Lida com string literal (mesmas regras de escape do JSON:
  `\"` `\\` `\n` `\t` `\r`), número, bool, `nil`, array, dicionário
  (inclusive `[:]` vazio), chamada de struct com argumento nomeado, e o
  caso especial do enum `KitArmorRestriction` (`.asClass` → string
  sentinela `"as_class"`, `.specific([...])` → array desembrulhado — o
  mesmo formato que o `Codable` customizado dele já espera).
- Gerados `Resources/rules.json` (385 registros), `Resources/kits.json`
  (91), `Resources/proficiencies.json` (372), `Resources/deities.json`
  (79) — contagens conferidas uma a uma contra o número de constantes
  `let embeddedX000N` de origem (bate exato nos quatro) e contra os
  comentários de cada `Models/*.swift` ("274 entradas... 385 no total
  depois de CPrH", "97 kits menos 6 = 91", "372 proficiências", "79
  divindades").
- `Models/Rule.swift` (`RuleEntry`/`RuleTable`) e `Models/Deity.swift`
  (`Deity`) ganharam conformidade `Codable` — não tinham antes porque só
  existiam como literal. `Kit`/`Proficiency` já eram `Codable` de uma
  tentativa anterior (ver histórico abaixo).
- `Store/RulesDatabase.swift`, `KitDatabase.swift`,
  `ProficiencyDatabase.swift`, `DeityDatabase.swift`: `init()` trocou de
  `= EmbeddedX.entries` pra um `load()` que lê o JSON do bundle — mesmo
  mecanismo já comprovado confiável neste toolchain em
  `SpellDatabase.priestFiles()` (`Bundle.main.resourceURL` +
  `FileManager.contentsOfDirectory`, filtrando pelo nome do arquivo, em
  vez de `Bundle.main.url(forResource:)` direto).
- **Sobre o bug histórico dos Kits** (documentado em `KitDatabase.swift`:
  três tentativas de ler JSON já tinham falhado, v0.81-v0.84, com a
  mensagem genérica "The data couldn't be read because it is missing"):
  a causa real era `DecodingError.keyNotFound` (13 dos 97 kits sem a
  chave `mechanics.armor.allowedTypes`), já corrigida faz tempo em
  `KitArmorRules.init(from:)` com `decodeIfPresent`. Essa correção nunca
  foi desfeita — só não tinha voltado a ser testada contra JSON de
  verdade até agora. Os 91 kits decodificaram sem erro nenhum.
- Removidos: `Store/EmbeddedRules.swift` + `EmbeddedRules_Part1..28.swift`,
  `EmbeddedKits.swift` + `EmbeddedKits_Part1..5.swift`,
  `EmbeddedProficiencies.swift` + `EmbeddedProficiencies_Part1..25.swift`,
  `EmbeddedDeities.swift` + `EmbeddedDeities_Part1..8.swift` — 70 arquivos,
  ~3.9 MB de código Swift.

**Resultado:** o projeto inteiro caiu de 171 pra 101 arquivos `.swift`
(~56 mil → ~27 mil linhas) — `Store/` sozinho foi de 5.1 MB de código
Swift pra 336 KB. O peso total em disco do pacote praticamente não mudou
(os mesmos dados só migraram de literal Swift pra JSON) — o que importa
aqui não é o tamanho do `.ipa`, é o volume que o type-checker do Swift
processa durante a compilação de Release/Archive.

Verificação feita nesta sessão (sem Xcode/simulador disponível): contagem
de chaves `{`/`}` balanceada nos 8 arquivos Swift tocados; contagem de
registros de cada JSON conferida contra o número de constantes de origem
(bate exato: 385/91/372/79); sweep `grep` confirmando que nenhum código
fora dos 4 `*Database.swift` ainda referencia `EmbeddedRules`/
`EmbeddedKits`/`EmbeddedProficiencies`/`EmbeddedDeities`; spot-check
manual de registros específicos (Akadi, Amaunator, Adviser, a tabela
"Method I Characters" da regra de criação de personagem) comparando o
JSON gerado contra o texto original.

**Ainda não verificado** (preciso do Playgrounds/Xcode de verdade pra
confirmar): se isso realmente resolve o "Build failed" no archive de
distribuição — a teoria é forte (literal Swift gigante é uma causa
documentada e conhecida de travamento do type-checker em builds de
Release), mas só um envio de verdade pra loja confirma.

`Package.swift`: `displayVersion` "1.66"→"1.67", `bundleVersion`
"169"→"170".

## AJUSTE v1.68 (2026-09-26) — Bônus de magia por Sabedoria não era cumulativo

Bug relatado pelo usuário: clérigo nível 11 com Sabedoria 19 deveria ter
5 slots base de 1º círculo + 3 de bônus de Sabedoria = 8 no total, mas o
app calculava só +2 no 1º círculo (7 no total).

**Causa raiz:** `WisdomTable.bonusSpells(forScore:)`, em `AbilityTables.swift`,
soma a Tabela 5 do PHB (`bonusSpellsByScore`, um valor por score de 13 a
25) pra virar o texto "+N / +N / ..." usado em `AbilityDetails.wisdomBonusSpells`.
A tabela impressa do livro mostra "1st" tanto na linha 13 quanto na 14
(mesma leitura visual em Sabedoria 13-14, 15-16 etc.), e o código
interpretava isso como "um patamar só, conta uma vez" — pulava a soma
quando a lista de círculos de um score repetia a do score anterior.

Isso está errado: cada score de 13 a 25 é seu próprio evento de bônus,
mesmo repetindo o círculo do score anterior. A prova está no próprio
texto da regra, já presente em `Resources/rules.json` (id
`phb_ch01_wisdom`, extraído do PHB): "a priest with a wisdom of 15 is
entitled to **two** 1st-level bonus spells and **one** 2nd-level bonus
spell" — ou seja, em Sabedoria 15 o 1º círculo já está em +2 (ganho em
13 E em 14 separadamente), não +1 como o código calculava.

**Correção:** removida a checagem "só soma se mudou em relação ao score
anterior" — agora soma a lista de círculos de TODO score de 1 até o
score do personagem, sem pular repetidos.

Conferido contra os dois pontos de verdade disponíveis no projeto: (1) o
exemplo textual da própria regra (Sabedoria 15 → "+2 / +1", bate exato);
(2) o personagem de amostra em `SampleCharacter.swift` (Sabedoria 17,
`wisdomBonusSpells` hardcoded como "+2 / +2 / +1") — com a fórmula nova
dá exatamente "+2 / +2 / +1"; com a fórmula antiga (bugada) dava
"+1 / +1 / +1", ou seja, o sample já estava certo e só a fórmula estava
errada. Para Sabedoria 19 (caso relatado): "+3 / +2 / +2 / +1" — 1º
círculo +3, batendo com a conta do usuário (5 base + 3 = 8).

`Package.swift`: `displayVersion` "1.67"→"1.68", `bundleVersion`
"170"→"171".

## AJUSTE v1.69 (2026-09-26) — o conserto da v1.68 não bastava: o bônus nunca chegava nos slots de verdade

Usuário testou a v1.68 e reportou "Não funcionou. Tá igual". Investigando
de novo: a v1.68 corrigiu a SOMA do bônus de Sabedoria (Tabela 5), mas só
consertou o texto da célula "Bonus Spells" da tabela de atributos
(`AbilityDetails.wisdomBonusSpells`) — um campo de texto livre que só é
regravado quando o jogador muda a Sabedoria e toca em "Apply automatic
changes" na prévia de consequências. Pior: mesmo esse texto NUNCA
alimentava a grade real de slots da Priest Spell Sheet.

**A causa raiz de verdade:** `PriestTables.spellProgression(level:wisdom:)`
(`Models/Character.swift`), a função que `PlayerCharacter.
computedSpellSlotAllotments` usa pra montar a grade de slots de folha nova,
só lia a Tabela 24 (Priest Spell Progression) pura — usava `wisdom`
apenas pra travar/destravar 6º e 7º círculo (`wisdomRequirementByCircle`,
Sabedoria mínima 17/18), nunca somava o bônus da Tabela 5. Clérigo nível
11 com Sabedoria 19 sempre teria 5 slots de 1º círculo, não importa o
conserto no texto — o número real de slots nunca dependia dele.

**Correção:**
- `WisdomTable.bonusSpells(forScore:)` (`AbilityTables.swift`) virou uma
  casca fina em cima de um novo `WisdomTable.bonusSpellTotals(forScore:)`,
  que devolve `[círculo: total]` (não só o texto formatado) — pra dar pra
  outro código somar de verdade, não só mostrar.
- `PriestTables.spellProgression` agora soma `bonusSpellTotals(forScore:
  wisdom)[circle]` em cima do valor da Tabela 24, pra cada círculo que a
  tabela já concede nesse nível (bônus nunca destrava um círculo novo
  sozinho — só reforça um que a classe já tem, exatamente como a regra do
  livro diz).
- `SpellSheetView.CircleBlock` (rótulo "Level N - X Slots (base+bônus)")
  trocou de ler o texto livre pra calcular direto de
  `WisdomTable.bonusSpellTotals`, usando `sheet.wisdomAtCreation` (a
  Sabedoria congelada no dia em que aquela folha foi criada) — bate com a
  mesma Sabedoria que gerou `slots.count` daquela folha específica.

Conferido programaticamente fora do Xcode: clérigo nível 11, Sabedoria 19
→ `[8, 6, 6, 4, 2, 1, 0]` (1º círculo 8 = 5 base + 3 bônus, exatamente o
relatado pelo usuário).

**Nota pro jogador:** uma folha de magia (`SpellSheet`) já criada antes
desta versão mantém a contagem antiga até você criar um "novo dia" (o "+"
ao lado das abas de dia) — é aí que a grade é remontada do zero a partir
de `computedSpellSlotAllotments`. Não precisa mexer na Sabedoria nem
editar texto nenhum à mão desta vez.

`Package.swift`: `displayVersion` "1.68"→"1.69", `bundleVersion`
"171"→"172".

## LOTE 9 (v1.70, 2026-09-27) — 5 ajustes na Priest Spell Sheet

1. **Magic Item Spells — "Item" era só texto livre.** `MagicItemPickerSheet`
   (usado desde 2026-09-24 só pro bloco "Magic Items" da página 2) deixou
   de tomar um `QuantifiedItem` inteiro e passou a tomar `name`/
   `matchedItemID` separados — reaproveitado agora também no cartão de
   item mágico da Priest Spell Sheet (`MagicItemCard`, `SpellSheetView.
   swift`). Tocar no nome abre a descrição do catálogo (`MagicItemDetailSheet`,
   com "change") quando já está ligado a um item de lá, ou o buscador
   (com busca por nome + "usar como digitado", nunca obriga escolher um
   item existente) quando não está. `SpellSheet.MagicItem` ganhou o campo
   `matchedItemID: String?` (opcional, fichas antigas continuam
   decodificando como item caseiro/`nil`).

2. **Magia de item mágico — "Unnamed Spell" + "change" obrigatório pra
   escolher.** `ItemSpellRow`: tocar numa magia AINDA SEM NOME agora vai
   direto pro buscador (`SpellWritingSheet`), pulando a tela de descrição
   vazia ("Unnamed spell") que só servia pra abrigar o botão "change" —
   igual ao padrão dos outros lugares (slot de memorização, Additional
   Spells). Uma magia JÁ escolhida continua abrindo a descrição normal (com
   "change" lá dentro, ver item 4). `SpellWritingSheet` também ganhou uma
   listagem inicial (`allSpells`, base inteira em ordem alfabética) — antes
   só mostrava alguma coisa depois de começar a digitar; agora já lista as
   magias disponíveis de cara, igual o `SlotEditorSheet` já fazia com
   `levelList` — sem restrição de círculo aqui, porque um item mágico pode
   conjurar qualquer magia do jogo.

3. **Additional Spells — 7 linhas fixas, nenhuma forma de adicionar mais.**
   As linhas em branco embaixo da folha eram 100% decorativas (`Color.
   clear` + `DottedRule`, sem `HandwritingField` nenhum) — só a linha ativa
   de cima (`writingLine`) realmente escrevia, mas via de 6-a-7 linhas
   visuais dava a impressão de um teto. Reduzido o padrão pra 3 linhas
   decorativas, com um botão "+ add line" que soma mais sob demanda —
   `writingLine` continua sendo a única forma de REGISTRAR uma magia (nunca
   teve teto de verdade), as linhas de baixo são só a régua da folha.

4. **Slots de magia — depois de escolher, não dava pra trocar.** A bolinha
   do slot já abria `SlotEditorSheet` (trocar/limpar/marcar usado) desde
   sempre, mas só isso — tocar na PRÓPRIA linha memorizada abria
   `SpellDetailSheet` sem nenhum botão de ação (`onChangeSpell` só vinha
   preenchido nas magias de item mágico, nunca no círculo de magia). Agora
   o círculo de magia também passa `onChangeSpell`, reabrindo o mesmo
   `SlotEditorSheet` completo.

5. **Slots de magia — riscar marca usado, mas não dava pra desmarcar.** O
   gesto de riscar de novo já era um `toggle` (`CircleBlock.toggle`), e a
   bolinha do slot já tinha "mark as used"/"unmark as used" dentro do
   editor — mas de novo só alcançável pela bolinha, não pela linha. Mesmo
   conserto do item 4: `SpellDetailSheet` ganhou um botão opcional "mark as
   used"/"unmark as used" (`isSpent`/`onToggleSpent`), ligado no círculo de
   magia junto do "change".

`Package.swift`: `displayVersion` "1.69"→"1.70", `bundleVersion`
"172"→"173".

## AJUSTE v1.71 (2026-09-27) — feedback do usuário testando o Lote 9

Usuário testou v1.70: itens 1, 3 e 4 confirmados ("Boa!"); dois ajustes
finos pendentes.

- **Item 2 ainda sem "usar como digitado" de verdade.** O botão já
  existia (`SpellWritingSheet`), mas vivia DENTRO da lista rolável de
  candidatos, em texto itálico pequeno e apagado — com até 8 sugestões
  por aproximação na frente dele, fácil de nunca chegar lá rolando, e sem
  cara de botão. Usuário reportou só ter "fechar a tela" como opção
  visível. Movido pra FORA do `ScrollView`, fixo logo abaixo do campo de
  escrita (aparece assim que se digita algo, sem precisar rolar nada), com
  o mesmo estilo "pill" preenchido que `MagicItemPickerSheet.useAsTyped`
  já usa — texto branco em fundo escuro, não dá mais pra confundir com
  legenda.
- **Item 4 — "mark as used"/"unmark as used" pequeno demais.** O botão
  novo (`SpellDetailSheet`, adicionado no Lote 9) estava em 13pt itálico;
  igualado aos 16pt do "change"/"close" ao lado, no mesmo cabeçalho.

`Package.swift`: `displayVersion` "1.70"→"1.71", `bundleVersion`
"173"→"174".

## AJUSTE v1.72 (2026-09-28) — crash ao criar página "Freeform" (desenho livre) no caderno

Usuário reportou: "Ao tentar criar uma nova página de notebook do tipo
Escrita Livre o app trava e fecha, sem nenhuma mensagem." Só a folha de
desenho travava — a transcrita (texto) nunca deu problema.

**Causa raiz:** o caderno usa o mesmo `UIPageViewController` com curl de
página (`.pageCurl`) que a Priest Spell Sheet já usa (`DayPagerView`) — ver
`NotebookPagerView`. Criar uma folha nova pede pro pager virar a página
com animação (`setViewControllers(..., animated: true)`), e é DENTRO
dessa mesma passada de `updateUIViewController`/`didFinishAnimating` que
`DrawingCanvas.updateUIView` anexa o `PKToolPicker` e chama
`uiView.becomeFirstResponder()` pela primeira vez. `becomeFirstResponder()`
sobe uma janela de sistema (o `PKToolPicker`) e mexe na cadeia de first
responder — mutação que colide com a transação de animação do curl ainda
em andamento, e é isso que travava o app (só ao NASCER a folha, quando o
anexo do picker acontece pela primeira vez). A folha transcrita
(`NotebookTextArea`, um `UITextView` comum) nunca chama
`becomeFirstResponder()` sozinha — só responde a um toque do jogador,
bem depois de qualquer animação ter terminado — por isso nunca crashava.

**Correção:** `DrawingCanvas.updateUIView` (`Views/NotebookView.swift`)
adia todo o bloco de anexar o `PKToolPicker`/`becomeFirstResponder()` pra
`DispatchQueue.main.async` — roda no próximo ciclo do run loop, depois que
a transação de animação da virada de página já terminou, em vez de no
meio dela. Reordenar chamadas ou reafirmar cor não resolveria nada aqui —
o problema nunca foi O QUE se chama, e sim QUANDO.

`Package.swift`: `displayVersion` "1.71"→"1.72", `bundleVersion`
"174"→"175".

## AJUSTE v1.73 (2026-09-28) — v1.72 não resolveu; segunda tentativa no crash do "Freeform"

Usuário testou a v1.72 e reportou "O problema está exatamente igual" —
com um detalhe novo, importante: a PRIMEIRA folha do caderno (criada a
partir do estado vazio, sem nenhuma folha antes) funciona em "Freeform"
sem problema nenhum. Só trava quando já existe pelo menos uma folha e o
jogador toca no "+" pra adicionar uma nova "Freeform page".

Isso aponta pra causa raiz mais precisa: a primeira folha nasce dentro de
`makeUIViewController`, com `setViewControllers(..., animated: false)` —
sem NENHUMA animação de curl rolando. Toda folha seguinte nasce dentro de
`updateUIViewController`, com `animated: true` — com a animação de curl de
verdade em andamento. `DrawingCanvas` é a única das duas folhas que chama
`becomeFirstResponder()` sozinha (liga o `PKToolPicker`) assim que a view
entra numa janela — e a v1.72 só adiava essa chamada com
`DispatchQueue.main.async`, ou seja, pro PRÓXIMO CICLO do run loop. Um
ciclo não é tempo nenhum perto da duração da animação de curl (várias
dezenas de ciclos) — o anexo continuava caindo bem no meio da transação de
animação, só um instante depois. Por isso "exatamente igual": a mudança
não tocava na janela de tempo real do problema.

**Segunda causa, encontrada na mesma revisão:** a comparação que decide
recarregar o traço em `updateUIView` também estava errada, de um jeito
que pode sozinho travar o app (não só no Freeform recém-criado, mas em
qualquer passada de render dessa folha): comparava
`uiView.drawing.dataRepresentation()` contra `drawingData ?? Data()` — mas
um `PKDrawing` vazio de verdade NÃO serializa como bytes vazios (o formato
tem cabeçalho próprio mesmo sem traço nenhum). Numa folha nova
(`drawingData == nil`), essa comparação batia "diferente" em TODA passada
de `updateUIView`, reatribuindo `uiView.drawing = PKDrawing()` de novo a
cada vez — reatribuição que o próprio `PKCanvasViewDelegate` pode
enxergar como mudança e devolver pro binding, disparando outra passada de
`updateUIView` (possivelmente ainda no meio da animação de curl) — o tipo
de laço de atualização de estado que trava o app.

**Correção de verdade desta vez — duas partes:**
1. **Sinal real de "terminou de aparecer", não uma estimativa de tempo.**
   Novo `PageReadiness` (`Views/NotebookView.swift`): um disparo único por
   folha, criado em `Coordinator.makePage` e guardado tanto no
   `NotebookPageController` (que o completa no `viewDidAppear` — o aviso
   que o próprio UIKit dá quando a folha terminou de aparecer, curl
   incluso, tanto pra troca animada quanto pra primeira folha sem
   animação) quanto na `DrawingCanvas` correspondente (que só liga o
   `PKToolPicker`/chama `becomeFirstResponder()` de dentro de
   `readiness.onReady { ... }`, nunca mais amarrado a `window != nil` ou a
   `DispatchQueue.main.async`).
2. **Comparação de dados corrigida.** `DrawingCanvas.Coordinator` ganhou
   `lastSyncedData: Data?` — o último valor que O PRÓPRIO coordinator
   colocou no canvas ou leu de volta dele. `updateUIView` agora compara
   `drawingData` (o binding de fora) contra esse valor, não contra uma
   reserialização do canvas nem contra `Data()` — só recarrega o traço
   quando o valor de fora mudou de verdade (folheou pra outra página).

`Package.swift`: `displayVersion` "1.72"→"1.73", `bundleVersion`
"175"→"176".

## AJUSTE v1.74 (2026-09-28) — ordem das magias embaralhava ao criar folha nova

Usuário reportou: ao criar uma nova Priest Spell Sheet, ela herda as
magias certas do dia anterior (correto), mas em ordem aleatória — magia A
no slot 1 e B no slot 2 viravam B no slot 1 e A no slot 3, por exemplo.

**Causa raiz:** `SpellSlotBoard.sortSlots()` (`Models/Character.swift`)
ordena os slots por conjurador, depois por círculo, e usava `id.uuidString`
como critério de desempate ENTRE slots do mesmo círculo — de propósito,
pra ter uma ordem determinística mesmo se o array físico virasse por causa
de alguma reconstrução em outro lugar do código. O problema: `SpellSheet.
nextDay()` dá um `id` NOVO E ALEATÓRIO pra cada slot ao criar a folha do
dia seguinte (de propósito — dois dias não podem ter slots com a mesma
identidade, ou uma busca por id casaria na folha errada). Como o
desempate do sort usava justamente esse id, a ordem visual do círculo
virava loteria toda vez que uma folha nova nascia, mesmo com os MESMOS
feitiços memorizados — e isso disparava sempre, porque `CharacterSheetView.
newSheet()` chama `reconciled(...)`, que chama `SpellSlotBoard.setCount`
pra cada círculo (mesmo sem mudar a quantidade), e `setCount` sempre
termina chamando `sortSlots()`.

**Correção:** novo campo `SpellSlot.orderKey: Int` — a posição do slot
dentro do próprio círculo, um critério de desempate separado do `id` que
`nextDay()` NUNCA toca (só o `id` muda de um dia pro outro; `orderKey`
segue junto no mesmo slot). `sortSlots()` passou a desempatar por
`orderKey` em vez de `id.uuidString`; `setCount` atribui `orderKey`
sequencial (a partir do maior já usado naquele círculo) só aos slots
NOVOS que ele cria, nunca reatribuindo os que já existiam. Folha salva
antes desta versão decodifica `orderKey` como `0` pra todo mundo — inofensivo,
porque nesse caso o desempate empata e o sort (garantidamente estável a
partir do Swift 5) preserva a ordem física que o array já tinha, que já é
a ordem certa pra quem nunca rodou esse código antes.

`Package.swift`: `displayVersion` "1.73"→"1.74", `bundleVersion`
"176"→"177".

## AJUSTE v1.75 (2026-09-28) — fundo escuro nos campos de contagem por traço

Pedido do usuário: os campos de contagem por risco (`TallyBoard` — Turn
Undead, cargas de item mágico, conjurações extras em Additional Spells)
não sinalizavam bem onde riscar. Pedido: fundo mais escuro em TODOS os
contextos, com os traços claros o bastante pra continuar legíveis em cima
dele.

Os quatro lugares que usam contagem por traço (`CharacterSheetView.
QuantityControls`, e três em `SpellSheetView`: Turn Undead, cargas de
item mágico, Casts de Additional Spells) já passavam pelo mesmo
componente compartilhado, `TallyBoard`/`TallyMarks` — então a mudança
centralizada ali cobre os quatro de uma vez, sem precisar tocar em cada
chamador.

**Mudança:**
- `Paper.tallyWell` (`Views/PaperTheme.swift`): novo fundo escuro — a
  mesma cor de `Paper.ink`, só que preenchendo um retângulo de verdade em
  vez de só escrever por cima. Aplicado como `.background` de
  `TallyBoard`, com cantos arredondados e um contorno bem sutil (mesma
  cor dos traços, bem apagada) pra marcar a área sem virar um bloco preto
  chapado.
- `Paper.tallyMark` (= `Paper.sheet`, o tom claro do pergaminho) e
  `Paper.tallyMarkExhausted` (um vermelho claro novo, `#EC7660`) — os
  traços e o "risco em andamento" (o arrasto ainda não solto) trocaram de
  `Paper.ink`/`Paper.redInk` (escuros, sumiriam no fundo novo) pra essas
  duas cores claras. Mesma cena de sempre nos comentários do código — um
  risco claro na parede escura da cela — só que agora a parede é de
  verdade, não só o pergaminho por baixo.

`Package.swift`: `displayVersion` "1.74"→"1.75", `bundleVersion`
"177"→"178".

## AJUSTE v1.76 (2026-09-28) — "clear slot" direto na linha memorizada

Pedido do usuário: escolhida uma magia num slot de memorização, só dava
pra marcar como usada ou trocar por outra — não tinha como esvaziar o
slot de volta.

A ação já existia — `SlotEditorSheet` (aberto pela bolinha do círculo)
sempre teve "clear slot" — só não estava alcançável do jeito mais óbvio:
tocar na PRÓPRIA linha memorizada abre `SpellDetailSheet`, que já tinha
"change" (reabre o `SlotEditorSheet` completo) e "mark/unmark as used",
mas nenhum botão de limpar direto.

**Correção:** `SpellDetailSheet` (`Views/SpellSheetView.swift`) ganhou um
parâmetro opcional `onClearSlot`, escondido por padrão (`nil`) — só o
chamador de slot de memorização (`SpellSheetView`'s `detailSlot`) passa
ele, e só quando o slot não está vazio (`slot.isEmpty ? nil : ...`); os
outros dois chamadores (magia de item mágico, Additional Spells) não têm
um "slot" pra esvaziar, então continuam sem o botão, igual sempre foi com
`onToggleSpent`. O botão "clear slot" aparece em vermelho ao lado de
"mark as used", e fecha a folha ao usar — depois de limpo não sobra nada
pra ver naquela descrição.

`Package.swift`: `displayVersion` "1.75"→"1.76", `bundleVersion`
"178"→"179".

## AJUSTE v1.77 (2026-09-28) — "Efeitos Ativos": magias/itens com duração finita

Pedido do usuário: um jeito de anotar efeitos temporários (buffs/
debuffs com duração finita) direto na ficha, cobrindo cinco mecânicas
bem diferentes entre si:
(a) Regenerate — uma reserva de cura (ex.: 3d4+6) que só começa a curar
1/round quando o personagem toma o PRÓXIMO dano, dentro de uma janela de
X horas;
(b) Stone Skin — anula os próximos X ataques físicos recebidos, com
duração;
(c) Recitation — +3 fixo em To Hit e em TODOS os Saving Throws por N
rounds;
(d) poção de Fire Giant Strength — SUBSTITUI (não soma) a Força por um
valor fixo (22) por N rounds;
(e) uma magia que dá 10 PV temporários por X tempo, sendo que dano
sofrido enquanto ela está ativa nunca pode ser curado de volta.

Antes de implementar, propus duas abordagens e discuti com o usuário:
(A) só um quadro de "post-its" com contadores genéricos, sem o app saber
nada sobre a mecânica de cada um; (B) um modelo tipado por mecânica, com
os campos de combate ganhando valores calculados automaticamente. Fomos
pro meio-termo: modelo tipado (sabe o que cada efeito FAZ), mas sem
inventar um motor de fórmulas novo — cada efeito escreve (e desfaz) nos
campos que a ficha já tem pra isso.

**Modelo novo:** `Models/ActiveEffect.swift` — `ActiveEffect` com um
`kind`:
- `.flatBonus` — soma um bônus onde a ficha já tem lugar pra isso: uma
  linha nova em To Hit/Damage/AC Modifiers (mesma tabela de sempre,
  `EquipmentItem`), ou +N no campo "Mod" de todos os cinco Saving
  Throws (`SavingThrows.setModifier`, que já existia — "posso aplicar
  manualmente um ajuste temporário" era literalmente o motivo desse
  campo). `toHitAndSaves` cobre os dois de uma vez (caso do Recitation).
- `.statOverride` — SUBSTITUI um atributo (Força, Destreza... CA,
  THAC0), guardando o valor anterior pra devolver quando o efeito
  encerrar (caso da poção de Fire Giant Strength).
- `.attackNegation` / `.bankedHeal` / `.tempHP` — reaproveitam o mesmo
  contador "X de Y" que os itens mágicos e o Turn Undead já usam com o
  `TallyBoard` (traço com a Apple Pencil), só com significados
  diferentes: ataques anulados, HP já curado do banco, ou PV temporário
  já consumido.
- `.note` — só uma anotação livre, sem mecânica nenhuma.

`PlayerCharacter` ganhou `activeEffects: [ActiveEffect]?` e os métodos
que escrevem/desfazem na ficha de verdade: `applyActiveEffect` (uma vez,
na criação de um `.flatBonus`/`.statOverride`),
`revertActiveEffectApplication`/`endActiveEffect` (desfaz exatamente o
que foi aplicado, nunca deixa um bônus "grudado"), e `applyDamage` — um
ponto único de dano (chamado agora por `WoundsBlock.commit`, em vez de
mexer direto em `hitPointsCurrent`) que:
- desconta primeiro de qualquer `.tempHP` ativo (o que se perde ali
  nunca cura, mesmo depois do efeito acabar — regra do item (e));
- dispara um `.bankedHeal` ainda pendente no primeiro dano recebido
  (regra do Regenerate, item (a)).

Todo campo tocado automaticamente (Força, THAC0, CA, Saving Throws)
chama `markRecentAutoChange`, reaproveitando o `ChangeFlash` que já
existia (a mesma piscada verde de quando a Raça mexe em atributo
sozinha) — `armorClass` já tinha o `.changeFlash`; `thac0` ganhou um
novo, só faltava.

**Tela nova:** `Views/ActiveEffectsView.swift` — aba própria "✨" na
fileira de cima da Ficha (`CharacterSheetView.SheetPage.effects`),
disponível pra QUALQUER classe (ao contrário de Sessions/Spellbook, só
de quem tem ficha de magia). Um cartão por efeito, com "End" (desfaz e
remove) e o corpo certo pro `kind`; "+ Add effect" abre um formulário
(sem `Form`/`List` nativo — os mesmos componentes de sempre, `SheetBlock`/
`InlineTextField`/`EditableNumber`/`Menu`, pra não destoar visualmente
do resto da ficha).

Também: selo "+N temp" ao lado da caixa de Hit Points quando há PV
temporário ativo (`CombatForm`), só leitura.

`Package.swift`: `displayVersion` "1.76"→"1.77", `bundleVersion`
"179"→"180".

## AJUSTE v1.78 (2026-09-29) — "Efeitos Ativos": 12 ajustes de feedback

Depois de testar a v1.77, o usuário mandou uma lista de 12 pontos.
Reestruturei o recurso pra resolver todos numa passada só:

**Item/componente separados** — `ActiveEffect` (o "item", ex.
"Recitation") virou só nome/duração/notas + uma lista dinâmica de
`EffectComponent` (o mecanismo em si). Antes um item só podia ter UM
efeito mecânico; agora pode ter quantos precisar — resolve os itens
**(2)** e **(3)**: a combinação "To Hit + Saving Throws" que vinha junto
virou dois `EffectComponent`s separados (um bônus de To Hit, outro de
Saves), escolhidos e adicionados um por vez com o botão "+ add another"
na tela de criação.

**(1) Editar efeito salvo** — cada cartão ganhou um botão de lápis
("Edit") ao lado do "End", que abre o mesmo formulário de criação já
preenchido. Salvar uma edição não é só "desfaz tudo, aplica tudo de
novo" — `PlayerCharacter.saveEditedActiveEffect` compara componente por
componente (pelo `id`, estável entre uma edição e outra) pra nunca
"curar de volta" PV temporário que já tinha sido perdido pra dano só
por trocar o nome do item, por exemplo.

**(4) Ícone da aba brilhando** — `PlayerCharacter.hasActiveEffects`
(true enquanto a lista de efeitos não estiver vazia) liga o brilho
contínuo do ícone "✨" na fileira de abas, igual ao brilho de aba
selecionada, mas persistente.

**(5) Bônus de To Hit não refletia** — a v1.77 só inseria uma linha
descritiva numa tabela cosmética (sem nenhum campo numérico
dependente). Agora um `.flatBonus` em "To Hit" escreve direto no THAC0
de verdade (THAC0 menor = mais fácil de acertar, então "+N To Hit" vira
"-N no THAC0"), e Armor Class faz o mesmo com o campo de CA — os dois
com bookkeeping pra devolver o valor certinho quando o efeito acabar.

**(6) Cor verde/vermelha persistente** — novo
`PlayerCharacter.activeEffectPolarity(for:)`, consultado a cada
redesenho (diferente do `ChangeFlash`, que só pisca uma vez e apaga).
Enquanto um Efeito Ativo estiver mexendo em Força/Destreza/Constituição/
Inteligência/Sabedoria/Carisma, THAC0, Armor Class ou Saving Throws
(Total), o campo fica tingido de verde (bom) ou vermelho (ruim)
continuamente, não só num flash.

**(7) e (8) Janela pequena / pula ao escrever** — as duas reclamações
tinham a MESMA causa: `.presentationDetents([.medium, .large])` troca a
apresentação padrão do iPad (um cartão de formulário de tamanho fixo,
centralizado) por um bottom sheet redimensionável que o UIKit expande
sozinho pra `.large` no instante em que qualquer campo ganha foco —
mesmo sem nenhum teclado de software aparecer (não é o painel do
Scribble; é o próprio sheet reagindo a "um campo pegou foco"). Removi o
modifier e adotei o mesmo padrão de cartão fixo já usado em
`NewSessionSheet` (`CampaignIndexView.swift`): `.sheet()` simples, sem
detents, `VStack` com `.frame(width: 460)`. Resolve os dois de uma vez.

**(9) e (10) PV temporário** — removi o contador separado de "+N temp"
que existia ao lado da caixa de Hit Points. Agora um efeito `.tempHP`
soma direto em Current HP na hora de ativar (ex.: 30/30 + 10 temp =
40/30, exatamente como pedido) — sem número duplicado em lugar nenhum.
`PlayerCharacter.applyDamage` (chamado por `WoundsBlock.commit` em vez
de mexer direto em `hitPointsCurrent`) desconta o dano do PV temporário
primeiro só pra fins de contabilidade interna (saber quanto ainda não
foi perdido, pra devolver certo se o efeito acabar antes de consumido) —
mas o desconto em Current HP é sempre o dano INTEIRO, nunca só a
diferença (bug que eu mesmo encontrei revisando o código antes de
entregar: a primeira versão dessa conta descontava de menos).

**(11) Limite de 48 horas no Regenerate** — não tinha motivo pra
existir; o campo "window to trigger" do `.bankedHeal` (e a duração do
item como um todo) virou texto livre (`healWindowLabel`/
`durationLabel`), sem limite numérico nenhum — pode escrever "6 hours",
"3 rounds" ou "2000 hours", o app só guarda a anotação (não tem relógio
de rounds/turnos em lugar nenhum do app, então nunca fingiu contar isso
sozinho).

**(12) Botão Salvar não habilitava** — o formulário agora sempre nasce
com pelo menos um `EffectComponent` totalmente preenchido com valores
padrão válidos (nunca um estado "vazio" onde não fica claro o que
falta); o único requisito real pra salvar passou a ser só o nome do
item, então nenhum tipo de efeito fica com o botão travado sem
explicação.

`Package.swift`: `displayVersion` "1.77"→"1.78", `bundleVersion`
"180"→"181".

## AJUSTE v1.79 (2026-09-29) — item (8) de novo: causa era outra

O usuário testou a v1.78 e o pulo ao escrever o nome do efeito
continuava exatamente igual. O primeiro reparo (remover
`.presentationDetents`) estava certo, mas resolvia só o item (7)
("janela pequena") — o pulo do item (8) é causado por outra coisa que eu
não tinha visto: o `ScrollView` que envolve o formulário.

`NewSessionSheet` (que o usuário apontou como referência de solução) não
tem `ScrollView` — é só um `VStack` direto. O formulário de Efeitos
Ativos precisa de `ScrollView` porque a lista de efeitos pode crescer
sem limite ("+ add another") e não cabe sempre no cartão fixo. E é
justamente isso: o `ScrollView` do SwiftUI tem um desvio automático de
teclado embutido — quando QUALQUER campo de texto ganha foco, ele
reserva/rola espaço achando que um teclado vai aparecer. Isso acontece
mesmo com `allowsSoftwareKeyboard: false` (o campo usa um `UIView()`
vazio como `inputView`, sem teclado nenhum de verdade) — pro UIKit, ter
QUALQUER `inputView` já dispara a notificação de "teclado apareceu", e o
`ScrollView` reage a essa notificação de qualquer forma, mesmo sem
software keyboard nenhum na tela.

Correção: `.ignoresSafeArea(.keyboard, edges: .bottom)` no `ScrollView`
do formulário — desliga esse desvio automático. Como o teclado de
verdade nunca aparece, não existe altura nenhuma real pra reservar.

`Package.swift`: `displayVersion` "1.78"→"1.79", `bundleVersion`
"181"→"182".

## AJUSTE v1.80 (2026-09-29) — 4 ajustes finos nos Efeitos Ativos

**(A) Verde ilegível** — `Ember.mintGlow` (o verde usado pra marcar um
ajuste "bom" nos itens 6/da v1.78) foi pensado pra texto/gradiente em
cima de fundo ESCURO (`ConsequenceSignalBadge`), não pra tinta sobre
pergaminho claro — por isso quase sumia. Criei `Paper.greenInk`, um
verde-tinta escuro pareado em peso/contraste com o `Paper.redInk` já
usado pro "ruim", e troquei o uso em `polarityColor`.

**(B) Fontes pequenas demais** — "+ add another" (12→14) e as frases de
explicação dentro de cada bloco de efeito (11–11.5→12.5–13): o hint do
tipo escolhido, a nota de "Damage não tem campo único", a explicação do
Banked Heal e a do Temporary HP.

**(C) Escolher quais Saving Throws** — antes um `.flatBonus` em "Saving
Throws" só podia valer pra todos os cinco de uma vez (Paralyzation/
Poison/Death, Rod/Staff/Wand, Petrification/Polymorph, Breath Weapon,
Spell). `EffectComponent` ganhou `savingThrowIDs: Set<String>?` (`nil` =
todos, mesmo comportamento de sempre — fichas salvas antes desta versão
continuam idênticas) e a tela de criação/edição ganhou uma fileira de
chips ("All" + um por save) pra marcar só os que interessam — ex.: um
anel que só protege contra Breath Weapon. `applyComponent`/
`revertComponent` agora só tocam nos saves marcados.

**(D) Contador de ataque negado na Ficha** — `Stone Skin` e afins
(`.attackNegation`) ganharam uma janelinha flutuante fixa no canto
superior direito da Ficha (`AttackNegationFloatingBadge`), visível em
QUALQUER aba, não só dentro de "✨ Efeitos Ativos" — mesmo `TallyBoard`
de sempre, riscando/apagando direto dali. Some sozinha quando não há
nenhum `.attackNegation` ativo.

`Package.swift`: `displayVersion` "1.79"→"1.80", `bundleVersion`
"182"→"183".

## AJUSTE v1.81 (2026-09-29) — Grimório do Mago

O ladrilho "Mage Grimoire" na tela de Compêndio já existia desde a
entrega da Priest Grimoire, só que desligado ("Coming soon") — hoje ele
entra no ar, a partir da base de magias de mago que o usuário mandou
(`wizard_spells.zip`, 2.608 magias, mesmo formato de scrape da wiki que
gerou a base de Priest, só que numa versão mais nova/rica do scraper).

`Scripts/convert_wizard_spells.py` — irmão de `convert_spells.py` (que já
convertia a base de Priest), adaptado pro formato de origem desta base:
aqui `school` chega como objeto (`{"primary": [...], "subSchool": ...}`)
em vez de texto pronto, então o script junta em `school` (texto, mesmo
formato "Escola, Escola" que o Priest já usa) e também grava a lista
solta em `schools` — campo NOVO em `Spell` (`Models/Spell.swift`),
equivalente ao `spheres` do Priest, só que pro eixo que faz sentido pro
Mago (Abjuration, Alteration, Conjuration/Summoning, Divination,
Enchantment/Charm, Illusion/Phantasm, Invocation/Evocation, Necromancy,
Chronomancy...).

11 arquivos gerados em `Resources/wizard_level_0_cantrips.json` até
`wizard_level_9.json` mais `wizard_high_level_epic.json` (tier 10 —
10th Level/Netherese e True Dweomer, equivalente ao "High-Level/Epic" do
Priest) — mesmo padrão de arquivo por nível que o Priest já usa, pelo
mesmo motivo (carregar mais rápido, um erro de leitura não derruba os
outros). `SpellDatabase.load()` generalizado: a varredura que só pegava
`priest_*.json` do bundle agora pega `priest_` E `wizard_` (helper
renomeado de `priestFiles()` pra `bundleFiles(withPrefix:)`).

`SpellbookView` — a tela do Grimório em si — ganhou um parâmetro
`caster: CasterType = .divine` e virou genérica: título ("Priest
Spellbook" vs "Mage Grimoire"), o filtro de eixo (Sphere vs. School,
lendo `spheres`/`schools` conforme o caster) e os rótulos de círculo
(Orisons/Quest Spells no Priest, Cantrips no Mago, os dois com
High-Level/Epic no topo) mudam sozinhos; busca, favoritos e filtro de
cenário continuam idênticos pros dois. `CompendiumHubView` ganhou uma
`MageGrimoireScreen` (mesma moldura da `SpellbookScreen` do Priest, só
passando `caster: .arcane`) e o ladrilho virou `NavigationLink` habilitado.

A ficha do personagem (aba "Sheet" com slot de magia) continua só pra
Clérigo (`CharacterClass.hasSpellSheet`) — este ajuste é só o livro de
CONSULTA (procurar, favoritar, ler a descrição), igual o Priest
Grimoire já era; memorizar magia de mago num slot de verdade é um
recurso maior, fora do que foi pedido aqui.

`Package.swift`: `displayVersion` "1.80"→"1.81", `bundleVersion`
"183"→"184".

## AJUSTE v1.82 (2026-09-29) — erro "priest_*.json ... is missing" na tela inicial

O usuário testou a v1.81 e a tela inicial mostrou um aviso listando TODOS
os `priest_*.json` como "The data couldn't be read because it is
missing" — mas os 11 arquivos `wizard_*.json` novos (Grimório do Mago)
carregaram normalmente, sem erro nenhum.

Causa: depois que o Grimório do Mago somou ~5 MB de JSON a mais ao
bundle de recursos, a PRIMEIRA leva de arquivos lidos por
`SpellDatabase.load()` — os de Priest, escaneados antes por ordem
alfabética ("priest\_" < "wizard\_") — passou a falhar na primeira
tentativa de leitura, enquanto os de Wizard, lidos segundos depois na
mesma chamada, sempre funcionavam. Isso é a marca registrada de uma
corrida no primeiro acesso ao bundle de recursos logo na inicialização
do app (algo ainda não "pronto" bem no início, mas já pronto pouco
depois) — não corrupção nem arquivo realmente ausente do bundle.

Correção: `load()` agora faz uma segunda passada, só para os arquivos
que falharam na primeira — com uma pausa curta (0,35s, só uma vez, na
inicialização) antes de tentar de novo. Só sobra erro na tela inicial se
um arquivo falhar nas DUAS tentativas.

`Package.swift`: `displayVersion` "1.81"→"1.82", `bundleVersion`
"184"→"185".

## AJUSTE v1.83 (2026-09-29) — o erro dos priest_*.json continuava (a correção anterior não resolveu)

O usuário testou a v1.82 e o mesmo aviso continuou aparecendo — só que
agora com "(after retry)" no final de cada linha, confirmando que a
segunda tentativa (a pausa de 0,35s da v1.82) rodou, mas não resolveu
nada: os mesmos 10 arquivos de Priest, sempre os mesmos, falhando do
mesmo jeito.

Isso descarta a hipótese da v1.82 (corrida de timing simples no primeiro
acesso ao bundle): uma corrida de verdade teria sumido, ou pelo menos
mudado de arquivo, entre uma tentativa e outra. Falhar sempre exatamente
igual, nos mesmos arquivos, mesmo depois de esperar e tentar de novo, é
cara de outra coisa.

Suspeito novo: o `Package.swift` descrevia a pasta `Resources` com
`.process("Resources")` — essa opção manda cada recurso pelo pipeline de
PROCESSAMENTO/compilação de assets do compilador on-device do Swift
Playgrounds (pensado pra `.xcassets`, `.strings`, storyboard etc.), não
pra arquivos de dados crus como JSON. Um bug nesse pipeline de
processamento (por exemplo ao lidar com uma leva grande de arquivos
JSON com nomes parecidos, ~4 MB de Priest processados antes dos ~5,5 MB
de Wizard) explicaria uma falha determinística e sempre no mesmo grupo
de arquivos — diferente de uma corrida de timing, que seria
inconsistente.

Correção: `Package.swift` trocou `.process("Resources")` por
`.copy("Resources")`, que pula esse pipeline de processamento inteiro e
só copia os bytes dos arquivos pro bundle final como estão — o jeito
correto de embutir dado bruto (JSON, e qualquer arquivo de dados
parecido no futuro).

Como rede de segurança pra essa troca (`.copy` pode ou não preservar
"Resources/" como subpasta dentro do bundle final, diferente de
`.process`), `SpellDatabase.bundleFiles(withPrefix:)` passou a varrer o
bundle RECURSIVAMENTE em vez de só a raiz — funciona nos dois layouts
possíveis.

Também: `load()` agora tenta até 4 vezes (era 2), re-varrendo o bundle a
cada tentativa em vez de reusar as URLs da primeira varredura (a v1.82
reusava a mesma URL na segunda tentativa — se a URL capturada é que
estivesse errada, esperar não ajudaria nunca, só re-escanear ajuda); e
`readBatch` agora guarda o erro de verdade (domínio+código do `NSError`,
e se o arquivo existe/tamanho em bytes quando falha) em vez de só "sim/
não" — se isso ainda não resolver, a mensagem de erro na tela inicial já
vem com pista de verdade pra próxima rodada, em vez de precisar
adivinhar de novo.

`Package.swift`: `displayVersion` "1.82"→"1.83", `bundleVersion`
"185"→"186".

## AJUSTE v1.84 (2026-09-29) — v1.83 nem compilava ("Type 'String' does not conform to protocol 'Error'")

Erro de compilação de verdade dessa vez, não bug de runtime: `readBatch`
tinha voltado a assinatura `-> Result<[Spell], String>`. O `Result` da
biblioteca padrão do Swift exige que o segundo parâmetro de tipo
(o caso de erro) obedeça ao protocolo `Error` — e `String` não obedece.
O Playgrounds acusou isso na hora de compilar, antes mesmo de instalar
o app.

Correção: troquei o `Result<[Spell], String>` por um enum bem simples e
só meu (`SpellDatabase.ReadResult`, com casos `.success([Spell])` e
`.failure(String)`) que não depende do protocolo `Error` nenhum — resolve
o mesmo problema (devolver o motivo real da falha pra tentativa de
diagnóstico da v1.83) sem esbarrar na exigência do `Result` de verdade.
Nada mais mudou da v1.83 (o `.copy("Resources")` no `Package.swift`, a
varredura recursiva, as 4 tentativas re-varrendo o bundle) — só esse
enum.

`Package.swift`: `displayVersion` "1.83"→"1.84", `bundleVersion`
"186"→"187".

## AJUSTE v1.85 (2026-09-29) — v1.84 quebrou a INSTALAÇÃO (code signing) — a troca de `.process` pra `.copy` foi revertida

O usuário testou a v1.84 e nem chegou a abrir: erro
`Error Domain=NSOSStatusErrorDomain Code=-67072 "(null)"
UserInfo={SecComponentPath=file:///.../THAC0berry.app/wizard_level_7.json}`
na tela inicial do app THAC0berry (fora do app, no launcher do
Playgrounds) — isso é erro de CODE SIGNING na hora de instalar o app no
iPad, nem chega a rodar código Swift nenhum.

Causa: a v1.83 trocou `Package.swift` de `.process("Resources")` pra
`.copy("Resources")`, apostando que o pipeline de processamento de
recursos do compilador fosse o culpado pelo bug original (priest_*.json
"missing"). Errado, e essa troca criou um problema NOVO e pior: o Swift
Playgrounds precisa que os recursos passem pelo `.process` pra montar
corretamente o envelope de assinatura do app nesse tipo de build
(.iOSApplication / App Playground) — pulando esse pipeline com `.copy`
quebra a assinatura e o app nem instala.

Correção: revertido — `Package.swift` voltou pra
`.process("Resources")`, exatamente como era até a v1.82. A mudança de
empacotamento de recursos foi abandonada por completo como estratégia
pro bug original.

O que fica pro bug original (priest_*.json "missing") é só o lado da
LEITURA em `SpellDatabase.load()`, que segue melhorado: até 4 tentativas
re-escaneando o bundle (recursivamente) a cada uma em vez de reusar uma
URL antiga, e a mensagem de erro agora traz o motivo REAL da falha
(domínio+código do erro do sistema, e se o arquivo existe/tamanho em
disco) em vez de só "missing". Se o erro original voltar a aparecer
nessa build, a mensagem vai trazer a pista que faltava pra achar a causa
de verdade — sem arriscar quebrar o build de novo.

`Package.swift`: `displayVersion` "1.84"→"1.85", `bundleVersion`
"187"→"188".

## AJUSTE v1.86 (2026-09-29) — a causa REAL do bug "priest_*.json não lê", achada por fim

A v1.85 instalou certinho (o revert do code signing funcionou), mas o
erro de sempre voltou — só que dessa vez com o diagnóstico melhorado da
v1.83 mostrando a mensagem de verdade pela primeira vez:

```
Failed to read priest_level_1.json after 4 tries (decode error, 427649
bytes read: The data couldn't be read because it is missing.)
```

Reparem: "427649 bytes read" bate EXATAMENTE com o tamanho de verdade do
arquivo no disco. Ou seja, a leitura do arquivo sempre funcionou, 100%
das vezes, em toda essa novela desde a v1.82 — o problema NUNCA foi o
arquivo "sumir" do bundle. Era a DECODIFICAÇÃO do JSON que falhava, e o
Swift/Foundation tem um bug de UX conhecido: quando um decode falha (por
exemplo por uma chave faltando) e você pega a mensagem de erro genérica
(`error.localizedDescription`), ele devolve "The data couldn't be read
because it is missing." — a MESMA frase de um arquivo genuinamente
ausente do disco, mesmo o arquivo tendo sido lido inteiro e correto.
Essa coincidência de mensagem é a razão de quatro rodadas seguidas (timing
de bundle, `.process` vs `.copy`, code signing, cache do Playgrounds)
terem mirado no lugar errado.

Causa raiz de verdade: quando o Grimório do Mago foi criado (v1.81),
`Models/Spell.swift` ganhou um campo novo, `var schools: [String] = []`.
Um valor padrão em Swift NÃO faz o `Codable` sintetizado aceitar a chave
ausente no JSON — o decoder automático continua exigindo a chave
`schools` em TODO arquivo, com ou sem valor padrão. Os `wizard_*.json`
(convertidos por um script escrito já sabendo desse campo) sempre
tiveram a chave `schools`. Os `priest_*.json` (convertidos por
`convert_spells.py`, escrito antes do campo existir) NUNCA tiveram — a
decodificação de cada um deles falhava com `DecodingError.keyNotFound`
pra chave `schools`, todo santo lançamento desde a v1.81.

Correção: `Spell` ganhou um `init(from decoder:)` próprio, trocando
`decode` por `decodeIfPresent(...) ?? valorPadrão` pros campos aditivos
(`spheres`, `schools`, `fullDescription`, `setting`) — agora uma chave
nova no formato pode faltar num arquivo JSON antigo sem quebrar a
decodificação, do jeito que já devia ter sido desde a primeira vez que um
campo opcional foi adicionado. (Precisou também declarar de novo, à mão,
o inicializador "normal" que os 62 exemplos do Kelmon usam — assim que a
struct ganha QUALQUER inicializador próprio, o Swift para de gerar o
memberwise init automático sozinho.)

Nada em `Package.swift`/`SpellDatabase.swift` precisou mudar por causa
disso — as 4 tentativas com re-varredura e o diagnóstico com erro real
(que foi o que finalmente expôs esse bug) continuam do jeito que
ficaram na v1.85, e são úteis de qualquer forma pra qualquer bug parecido
no futuro.

`Package.swift`: `displayVersion` "1.85"→"1.86", `bundleVersion`
"188"→"191" (pulei alguns números usados só nos builds de diagnóstico
que não chegaram a ser uma versão de verdade).

## AJUSTE v1.87 (2026-09-29) — Wizard Kits (fase 1 de paridade Priest/Wizard)

Usuário pediu (após o `wild_mage`/`kits.json` de Priest já funcionando):
"Hoje só temos as regras de personagens Priests. Vamos fazer o mesmo pra
Wizard e tudo que é específico desta classe." Começando pelo mais
contido: 41 kits de mago (`wizard_kits.json` anexado, 49 brutos, 8
"Create Your Own" excluídos — mesma exclusão já feita pros 6 "Create
Your Own" de sacerdote).

Decisão de arquitetura: em vez de um arquivo/model/tela separados pra
kit de mago, ele entra no MESMO array que os 91 kits de sacerdote já
usam (`Resources/kits.json`, `Models/Kit.swift`, `Store/KitDatabase.swift`)
— a wiki de origem já trata os dois como a mesma categoria (Character
Kit), e `KitDatabase.kits(allowedFor:)` já filtra por
`classEligibility.allowedClasses` de forma totalmente genérica, sem nada
hardcoded pra sacerdote. Resultado: zero mudança em `KitDatabase.swift`.

Novo script `Scripts/convert_wizard_kits.py` normaliza as diferenças de
esquema entre o `wizard_kits.json` bruto e o formato que `Kit.swift`
espera (`allowedClasses: ["Wizard"]` → `["Mage"]` pra bater com
`CharacterClass.mage`; `alignment` singular → `alignments` lista;
`weapons.forbidden` ausente → sempre `[]`; `armor`/`turnUndead`
sintetizados com valores neutros, já que kit de mago não tem restrição
de armadura própria nem Turn Undead; um kit sem `mechanics` nenhuma
— `wild_mage` — ganha uma vazia do zero) — mesma filosofia de
`convert_spells.py`/`convert_wizard_spells.py`: tratar a diferença de
esquema no script Python, não deixar o decoder Swift mais defensivo.
Ficou registrado explicitamente no comentário do script (item 4) que
esse é o MESMO tipo de bug que derrubou `Spell.schools` na v1.81-1.86 —
chave nova ausente quebrando o decode inteiro com mensagem enganosa —
pra não repetir.

`Models/Kit.swift`: `KitMechanics` ganhou `weaponSlots:
KitWeaponSlotRules?` (Optional de verdade, não um array com valor
padrão) — justamente pra aproveitar que `Codable` sintetizado trata tipo
opcional como `decodeIfPresent` automático, sem precisar de `init(from:)`
próprio, do jeito que `schools` deveria ter sido desde o início.

`Views/KitCompendiumView.swift`: generalizada com `classGroup: String =
"Priest"` (mesma ideia de `SpellbookView(caster:)` quando o Grimório do
Mago foi criado) — filtra `kitDatabase.kits` por
`classEligibility.classGroup`, esconde o campo "Turn Undead" (só faz
sentido pra sacerdote) e mostra "Weapon Slots" quando presente.

`Views/CompendiumHubView.swift`: `KitCompendiumScreen` ganhou o mesmo
parâmetro `classGroup` repassado; novo tile "Wizard Kits" (41 kits) ao
lado do "Priest Kits" existente, mesmo padrão de "Mage Grimoire" ao lado
de "Priest Grimoire".

Ainda faltam (fases seguintes, "tudo que é específico desta classe"):
especialização de escola / escolas opostas (equivalente de Sphere Access
pra Wizard) e Ficha de Magias do Mago (paridade com a Ficha de Magias de
Clérigo, `hasSpellSheet`). Sequenciamento a confirmar com o usuário.

`Package.swift`: `displayVersion` "1.86"→"1.87", `bundleVersion`
"191"→"192".

## AJUSTE v1.88 (2026-09-29) — Wizard Spell Sheet (fase 2 de paridade Priest/Wizard)

Segunda fase do pedido "Vamos fazer o mesmo pra Wizard e tudo que é
específico desta classe" — depois dos Kits (v1.87), agora a própria Ficha
de Magias. Pedido explícito do usuário: "baseado nas Priest Spell Sheets,
crie a Wizard Spell Sheet."

Achado bom: o modelo de dados (`SpellSlot`/`SpellSlotBoard`/`SpellSheet`)
já era genérico por `CasterType` (`.divine`/`.arcane`) desde que o Grimório
do Mago existe — não precisou mudar NADA lá. `SpellSheetView.swift`
(a tela em si) também já escondia sozinho tudo que só faz sentido pra
sacerdote (bônus de Sabedoria, bloco de Turn Undead, selo de esfera) atrás
de checagens `caster == .divine`/campos opcionais — bastou trocar os dois
textos fixos do cabeçalho ("Priest Spell Sheet — Game Day" e "Wisdom") por
uma versão condicional (`isWizard`).

O que precisou de verdade:
- **Tabela de progressão de magia do Mago** (Tabela 21 do PHB — "Wizard
  Spell Progression"), `WizardTables` em `Models/Character.swift`,
  espelhando `PriestTables`. Conferida contra duas transcrições
  independentes da tabela antes de codificar (não é o tipo de dado pra
  arriscar de memória). Diferença importante da tabela do sacerdote: o
  mago NÃO ganha slot bônus por Inteligência alta — Inteligência entra só
  como TETO de círculo alcançável (Tabela 4, coluna "Max Spell Level"),
  reaproveitando o `IntelligenceTable` que já existia em `AbilityTables.swift`
  (usado pelo campo de texto "Max Spell Level" da ficha) em vez de duplicar
  os números — só ganhou um `maxSpellLevelInt(forScore:)` que lê o "9th"/
  "4th" existente como `Int`.
- `PlayerCharacter.computedSpellSlotAllotments` passou a ramificar por
  classe (Clérigo → `PriestTables`, Mago → `WizardTables`, resto → vazio)
  em vez de só checar `hasSpellSheet`.
- `CharacterClass.hasSpellSheet` agora inclui `.mage` — e todo lugar que
  usava esse booleano pra decidir "mostra bloco de esfera" (o botão
  "Spheres" no cabeçalho da ficha) precisou virar uma checagem explícita
  de `== .cleric`, porque esferas de acesso não existem pra mago (isso é
  escola/oposição de escola, fase ainda não implementada).
- `PriestSpellSlotsProvider` (Motor de Consequências) também estava
  checando `hasSpellSheet` — trocado por `== .cleric` explícito, e um
  `WizardSpellSlotsProvider` novo cobre `.mage` do lado, registrado em
  `CoreRuleset.swift` e `ConsequenceEngine.trackedRules`.
- `SpellSheet.wisdomAtCreation` — o campo continua se chamando isso (mudar
  o NOME da propriedade mudaria a chave que o `Codable` sintetizado espera,
  quebrando fichas de Clérigo já salvas, exatamente a classe de bug já
  documentada em `Spell.init(from:)`) mas agora guarda Sabedoria OU
  Inteligência conforme a classe, via `PlayerCharacter.
  spellSheetAbilityScoreAtCreation` — os 6 lugares que criavam folha nova
  passaram a usar esse getter em vez de ler `abilities.wisdom` direto.
- 4ª página da aba Sheet (tabelas de referência) — `RecordSheetPagerView`
  agora escolhe entre `ClericReferencePage` (já existia) e a nova
  `WizardReferencePage` (Wizard Spell Progression + Intelligence) conforme
  a classe. `RefTableTitle`/`RefCell`/`RefFootnotes` deixaram de ser
  `private` em `ClericReferenceView.swift` pra serem reaproveitadas em vez
  de duplicadas.
- Menu ☰ da ficha: "Priest Spellbook" virou "Mage Grimoire" quando a
  classe é Mago, e `SpellbookView` (aberta a partir dali) passa a receber
  `caster: .arcane`/`.divine` conforme a classe, em vez de sempre `.divine`.

Ainda faltam (fases seguintes, "tudo que é específico desta classe"):
especialização de escola / escolas opostas (o equivalente de Sphere Access
pro Mago). Sequenciamento a confirmar com o usuário.

`Package.swift`: `displayVersion` "1.87"→"1.88", `bundleVersion`
"192"→"193".

## AJUSTE v1.89 (2026-09-29) — Livro de magias do Mago (fase 3 de paridade Priest/Wizard)

Pedido do usuário: diferente do Clérigo (que tem acesso a QUALQUER magia
das esferas liberadas — `sphereAccess` é só sinal, nunca filtro, decisão
de design já documentada), o Mago no AD&D 2e precisa ter aprendido a
magia antes de poder memorizá-la num slot. O Grimório (`SpellbookView`)
continua sendo a base de referência inteira (milhares de magias arcanas);
o "livro de magias" é um subconjunto PESSOAL de cada personagem Mago.

Três decisões confirmadas com o usuário via pergunta de esclarecimento
antes de implementar:
- **Bloqueio de verdade**, não só sinal visual — magia fora do livro não
  aparece pra escolher/memorizar num slot da Wizard Spell Sheet (ao
  contrário de Sphere Access).
- **Lista editável simples** — sem simular "chance to learn" da Tabela 4
  (rolagem de dado): o jogador decide o que entra no livro, mesma
  filosofia de nunca rolar dado sozinho já documentada pra Hit Points.
- **Começa com Read Magic** — Mago nível 1 novo já nasce com essa magia
  no livro (regra do PHB 2e), via `seedWizardSpellbookIfNeeded`.

Implementação:
- `WizardSpellbookEntry` (novo struct, `Models/Character.swift`) — `id`,
  `name`, `matchedSpellID` (opcional — casa com uma magia real do
  Grimório) e `level` (só usado por entradas "free entry", sem match no
  Grimório — magia homebrew ou achada em jogo).
- `PlayerCharacter.wizardSpellbook: [WizardSpellbookEntry]` + helpers
  (`wizardSpellbookMatchedIDs`, `wizardKnows(spellID:)`,
  `wizardSpellbookSpells(level:in:)`, `wizardSpellbookFreeNames(level:)`)
  e `seedWizardSpellbookIfNeeded(in:)` — só age se `characterClass == .mage`
  e o livro ainda está vazio (nunca sobrescreve edição do jogador), chamado
  a partir de `ClassPicker.select(_:)` (`CharacterSheetView.swift`) toda
  vez que a classe muda pra Mago.
- `SpellDatabase.matches(...)` ganhou parâmetro `restrictToIDs: Set<String>?`
  — filtra a base antes de pontuar, reaproveitado pelo restante do fluxo
  de busca fuzzy já existente.
- `SpellSheetView.swift` — `MemorizedRow` e `SlotEditorSheet` (edição de
  slot da Wizard Spell Sheet) agora restringem `candidates`/`levelList` ao
  livro pessoal quando `slot.caster == .arcane`, com mensagens diferentes
  conforme o caso: nome bate com uma entrada "free entry" do livro → botão
  "use as-is"; nome não está no livro → aviso vermelho "Not in your
  spellbook — add it from 'My Spellbook' on the character sheet."; lista
  vazia pro círculo → mesmo aviso adaptado. Clérigo continua sem nenhuma
  restrição (só esfera como sinal, como já era).
- `WizardSpellbookEditorSheet.swift` (nova tela) — "My Spellbook", aberta
  pelo novo botão "Spellbook" no cabeçalho da ficha (visível só pra Mago,
  ao lado de onde "Spheres" aparece só pro Clérigo): busca no Grimório
  (mesma técnica de duas etapas — substring primeiro, fuzzy se não achar
  nada — de `SpellbookView.filtered`) com botão add/"in book ✓" por
  resultado, fallback pra adicionar entrada livre (nome digitado + círculo
  1-9) quando a busca não bate com nada da base, e lista do livro atual
  agrupada por círculo com botão remover por entrada. Vive fora da Folha
  de Magias do dia de propósito — é traço PERMANENTE do personagem, mesmo
  raciocínio já usado pra Sphere Access.

Ainda faltam (fases seguintes, "tudo que é específico desta classe"):
especialização de escola / escolas opostas. Sequenciamento a confirmar
com o usuário.

`Package.swift`: `displayVersion` "1.88"→"1.89", `bundleVersion`
"193"→"194".

## AJUSTE v1.90 (2026-09-30) — Ajustes no Livro de Magias do Mago (feedback pós-v1.89)

Três pedidos do usuário depois de testar a v1.89:

1. **"My Spellbook" virou folha de verdade, não janela.** Era uma `.sheet`
   modal aberta por um botão no cabeçalho — mesmo raciocínio já usado pro
   Grimório (`SpellbookView`/`.spellbook`, que sempre foi folha, nunca
   modal): virou `SheetPage.mySpellbook`, acessível pelo menu ☰ (só pra
   Mago, ao lado de "Mage Grimoire"), embutida no `ScrollView` da ficha
   igual às outras páginas. `WizardSpellbookEditorSheet` perdeu o botão
   "close"/`dismiss()` e o `PaperBackground`/`ZStack` próprios (a página já
   fornece isso) e as duas `ScrollView` internas de altura fixa viraram
   conteúdo comum, deixando a rolagem inteira pro `ScrollView` externo. O
   antigo botão "Spellbook"/`isWizardSpellbookPresented` no cabeçalho saiu;
   trocar de classe pra algo que não seja Mago (mesmo Clérigo, que tem
   ficha de magia mas não livro pessoal) redireciona pra Ficha se "My
   Spellbook" estiver aberta.
2. **Círculos oferecidos pra aprender agora têm teto.** Novo
   `PlayerCharacter.wizardMaxKnowableCircle` (maior círculo com pelo menos
   1 slot em `computedSpellSlotAllotments`, ou seja: Wizard Spell
   Progression Tabela 21 + teto de Inteligência Tabela 4, o mesmo cálculo
   que já decide os slots da Spell Sheet) passou a restringir tanto a
   busca de "My Spellbook" (resultado de círculo maior desaparece, com um
   aviso explicando que existe resultado mas está fora de alcance) quanto
   o seletor de círculo da entrada livre (1 até o teto, não mais sempre
   1-9) quanto o novo botão do Grimório (item 3) — não faz sentido
   oferecer aprender um círculo que ainda nem dá pra lançar.
3. **Adicionar direto do Grimório.** `SpellbookView`/`SpellPaperRow`
   ganharam um botão "+"/"✓" por magia (mesmo padrão da estrela de
   favorito, botão próprio que não abre o detalhe) — só aparece quando o
   Grimório está aberto num personagem Mago E a magia está dentro do
   círculo alcançável (item 2); fora do alcance a magia continua visível
   pra consulta, só sem o botão. Escreve no mesmo
   `character.wizardSpellbook` que "My Spellbook" — as duas telas ficam
   sincronizadas.

`SpellDatabase.matches(restrictToIDs:)`, os dados de
`WizardSpellbookEntry`/`PlayerCharacter.wizardSpellbook` e a restrição de
verdade na Wizard Spell Sheet (`SlotEditorSheet`/`MemorizedRow`) da v1.89
continuam exatamente como estavam — este ajuste só mexeu em ONDE e COMO
o jogador edita o livro.

`Package.swift`: `displayVersion` "1.89"→"1.90", `bundleVersion`
"194"→"195".

## AJUSTE v1.91 (2026-09-30) — Especialização de Escola do Mago (PHB Table 22)

Correção de um pedido anterior: onde o usuário tinha dito "círculos do
mago" (implementado na v1.90 como teto de círculo pra aprender magia),
ele quis dizer "escolas de magia" — pediu a regra completa do PHB antes de
implementar. Pesquisada e conferida em duas fontes independentes (a wiki
AD&D 2e e a página de Escolas Opostas do Complete Wizard's Handbook, que
documenta a mesma mecânica do PHB) antes de escrever qualquer código —
mesmo cuidado já tomado com a Wizard Spell Progression (v1.88).

**A regra (PHB Table 22):** especializar é OPCIONAL — um Mago pode
continuar generalista (sem bônus, sem restrição, comportamento de
sempre) ou escolher uma das oito escolas (Abjuration, Alteration,
Conjuration/Summoning, Divination, Enchantment/Charm, Illusion/Phantasm,
Invocation/Evocation, Necromancy — "Lesser Divination" é universal, não
entra nessa lista). Quem especializa ganha +1 slot por círculo onde já
tem magia, e passa a ter escolas OPOSTAS bloqueadas de verdade — lista
FIXA por escola (não é "a oposta + as duas vizinhas, à escolha do
jogador" como se pensou antes de perguntar), com contagem variando pela
força da escola (fraca = 1, moderada = 2, forte = 3):

- Abjuration ↔ Alteration, Illusion
- Alteration ↔ Abjuration, Necromancy
- Conjuration/Summoning ↔ Divination, Invocation/Evocation
- Divination ↔ Conjuration/Summoning
- Enchantment/Charm ↔ Invocation/Evocation, Necromancy
- Illusion/Phantasm ↔ Necromancy, Invocation/Evocation, Abjuration
- Invocation/Evocation ↔ Enchantment/Charm, Conjuration/Summoning
- Necromancy ↔ Illusion/Phantasm, Enchantment/Charm

O bônus de aprendizado (+15%/-15%) e o de teste de resistência (±1) do
PHB ficam só documentados, não implementados — não existe rolagem de
"chance to learn" nem resolução de salvamento por magia no app, mesma
linha de nunca simular dado que já vale pra Hit Points e pro próprio
livro de magias.

Implementação:
- `WizardSchool` (novo enum, `Models/Character.swift`) — as oito escolas,
  `oppositionSchools` (a tabela fixa acima) e `specialistTitle` (Abjurer,
  Transmuter, etc., só pra exibição).
- `PlayerCharacter.wizardSchool: WizardSchool? = nil` — `nil` é
  generalista, seguro pra fichas antigas.
- `PlayerCharacter.isSpellOpposedBySchool(_:)` — bloqueio de verdade
  (mesma filosofia do livro em si), `false` sempre pra generalista e pra
  magias marcadas "All"/"All Schools" na base (universais, tipo Read
  Magic/Detect Magic).
- `computedSpellSlotAllotments` (Mago) — +1 slot em todo círculo com
  count > 0 quando especializado.
- "My Spellbook" ganhou uma seção "Specialization" (Menu: Generalist ou
  uma das 8 escolas) — trocar de escola já REMOVE do livro qualquer magia
  batida com a base que fica oposta pela troca (`setSchool(_:)`); a busca
  da própria tela também passou a filtrar por escola oposta, com aviso
  separado de "fora do círculo" vs. "de escola oposta" quando a busca não
  acha nada usável.
- `SpellbookView` — o botão "+"/"✓" (item 3 da v1.90) agora checa círculo
  E escola (`isEligibleForWizardSpellbook`, substituiu o `wizardSpellbookMaxCircle`
  passado direto pra `LevelSection`, que virou um closure `(Spell) -> Bool`).

`Package.swift`: `displayVersion` "1.90"→"1.91", `bundleVersion`
"195"→"196".

## AJUSTE v1.92 (2026-09-30) — Warrior: merge de regras + Weapon Specialization (Fighter)

Início da implementação do grupo Warrior (Fighter/Paladin/Ranger + Kit
Barbarian), a partir do zip `warrior_rules.zip` fornecido pelo usuário com
os quatro sourcebooks: Complete Fighter's Handbook (CFH), Complete
Paladin's Handbook (CPaH), Complete Ranger's Handbook (CRH) e Complete
Barbarian's Handbook (CBarbH). Antes de codar, 4 perguntas foram
esclarecidas com o usuário: (1) escopo = tudo, incluindo Kits; (2) dados
de Kits = o usuário fornece um JSON estruturado depois (o zip só tem os
NOMES dos kits em prosa, sem stat block, então o compêndio de Warrior
Kits fica pendente até lá); (3) Barbarian é Kit de Fighter, não uma nova
`CharacterClass` (regra oficial); (4) prioridade desta rodada = Weapon
Specialization do Fighter.

**1) Rules Reference — merge dos 4 livros.** Mesma mecânica já usada pro
CPrH: `Resources/rules.json` ganhou 249 entradas novas (CBarbH:51,
CFH:81, CPaH:65, CRH:52), sem nenhuma colisão de ID — total agora é 634
entradas (era 385). Atualizado em todo lugar que citava a lista/contagem
antiga: `CompendiumHubView` (subtítulo do tile "Rules Reference"),
`RulesCompendiumView` (cabeçalho, e a fileira de chips de filtro por
livro, que agora rola na horizontal pra caber os 7 códigos: PHB, DMG,
CPrH, CFH, CPaH, CRH, CBarbH) e o doc-comment de `RulesDatabase`.

**2) Weapon Specialization (Fighter) — `Models/Character.swift` +
`Views/CharacterSheetView.swift`.** Regra conferida direto no texto do
Complete Fighter's Handbook cap. 4 ("Single-Weapon Proficiency, Weapon
Specialization") que o próprio usuário enviou: só Fighter especializa
(nunca Paladin/Ranger, mesmo sendo do grupo Warrior); corpo-a-corpo custa
1 slot extra de proficiência e dá +1 pra acertar / +2 de dano; arco/besta
custa 2 slots extras e, em vez de bônus de dano, ganha uma faixa de
alcance "point-blank" (besta 6–30ft, arco 6–60ft) com +2 pra acertar
dentro dela, podendo atirar antes da iniciativa se a arma já estiver
pronta e o alvo à vista; só uma especialização na criação do personagem,
outras depois conforme novos slots são ganhos.

Implementação: `WeaponEntry.isSpecialized: Bool? = nil` (novo campo —
`Optional`, não `Bool = false`, pela mesma razão de sempre: ficha salva
antes desta versão não tem essa chave no JSON e o decode síntese exige a
chave presente mesmo havendo default). Na tabela "Weapon Combat"
(`WeaponFormRow`), um botão "☆ spec"/"★ spec" aparece só quando
`character.characterClass == .fighter`, ao lado do nome da arma. Ligar a
especialização semeia os campos "Hit/Dmg Adj" — mas SÓ se estiverem
vazios, nunca sobrescrevendo o que o jogador já tiver digitado à mão
(mesmo padrão de "semear sem atropelar" já usado em `freshSlotBoard()` e
`seedWizardSpellbookIfNeeded`): corpo-a-corpo ganha "+1"/"+2"; arco/besta
(detectado por substring "bow"/"crossbow" no nome da arma — não há campo
estruturado de categoria em `WeaponEntry`) ganha "+2*" no Hit Adj, sem
mexer no Dmg Adj, com o asterisco explicado num rodapé que só aparece pro
Fighter, abaixo da tabela.

Pendente pras próximas rodadas (não esquecer, mas não foi pedido agora):
habilidades de Paladin (Detect Evil, Lay on Hands, Cure Diseases, Turn
Undead, montaria especial, magias de Clérigo a partir do nível 9) e de
Ranger (Tracking, Hide in Shadows/Move Silently, Animal Empathy, Species
Enemy, Nature Lore, Survival, Followers); o compêndio de Warrior Kits
continua bloqueado até o usuário mandar o JSON estruturado dos kits.

## AJUSTE v1.93 (2026-09-30) — 6 correções do feedback pós-v1.92 (Warrior)

Feedback do usuário testando a v1.92, com 2 screenshots anexados:

**1. Mensagem errada no seletor de Kit.** "Choose a Kit" mostrava, pra
qualquer classe sem kit disponível, "\(classe) has no priest kits — priest
kits only apply to Cleric and Druid" — já estava desatualizada antes do
Warrior (Mago tem 41 kits desde a v1.87) e ficava simplesmente errada pro
grupo Warrior. `KitCompendiumView.swift`/`emptyMessage` agora diferencia:
grupo Warrior (Fighter/Paladin/Ranger) ganha uma mensagem específica
explicando que os kits ainda não estão na base — só o texto de regras
veio no zip, o JSON estruturado dos kits (incluindo Barbarian) é o
usuário quem vai mandar — as outras classes sem kit ganham uma mensagem
genérica só "sem kits ainda", sem citar Cleric/Druid feito regra fixa.

**2. Fonte ilegível no rodapé de Weapon Combat.** O parágrafo inteiro de
Weapon Specialization (adicionado na v1.92) virou uma linha curta em fonte
10 + o botão "?" de sempre (`RuleLinkButton`), que abre o texto completo
do Complete Fighter's Handbook em `RuleDetailSheet` — sheet de leitura,
fonte normal, exatamente o padrão já usado nos "?" de outras seções da
ficha (Level Changes, Patron Deity, Proficiencies).

**3. Non-proficiency penalty não era preenchido sozinho.** Ficava sempre
vazio até o jogador digitar, mesmo a Tabela 34 do PHB já dizendo o valor
certo só pela classe (Fighter/Paladin/Ranger -2, Cleric/Druid -3, Thief/
Bard -3, Mago -5). Criada `ProficiencySlotsTable`
(`Store/RuleEngine/CoreRuleset/ProficiencySlotsTable.swift`, dados
conferidos contra `phb_ch05_proficiencies`/`phb_ch05_weapon_proficiencies`
em `rules.json`) — `CombatModifiersForm.onAppear` agora semeia o campo com
ela na primeira vez que a linha "Non-proficiency penalty" é criada, sem
nunca sobrescrever o que o jogador já tiver editado.

**4. "Onde eu adiciono as Weapon Proficiencies?"** Resposta: não existe
(nunca existiu) uma lista separada de slots de proficiência de arma — cada
arma na tabela "Weapon Combat" JÁ É a proficiência (ver doc de
`WeaponEntry`/`Weapon` no histórico do projeto). Isso nunca ficava
explícito na tela. Duas linhas curtas resolvem: uma logo abaixo do título
"Weapon Combat" dizendo isso, e outra logo abaixo do título "Proficiencies"
lembrando que aquela lista é só Nonweapon.

**5. "Não consegui escolher o kit de Barbarian".** Mesma causa do item 1 —
a lista de kits do Fighter está mesmo vazia (Warrior Kits pendente do JSON
que o usuário vai fornecer), só a mensagem de erro escondia isso. Resolvido
junto com o item 1; nenhum kit foi inventado/homebrewado pra preencher a
lacuna — o usuário pediu explicitamente pra fornecer os dados estruturados
depois, e inventar um Barbarian agora arriscaria divergir do que ele vai
mandar.

**6. Sem página de tabelas úteis pro Warrior.** `CharacterClass` ganhou
`hasReferencePage` (generaliza o antigo `hasSpellSheet` que controlava
sozinho a 4ª página da aba Sheet) — agora também true pro grupo Warrior.
Nova `Views/WarriorReferenceView.swift`/`WarriorReferencePage`: Tabela 34
completa (Proficiency Slots, com a linha da classe do personagem
destacada) + um resumo consultável de Weapon Specialization, ambos com
botão "?" linkando pro texto fonte no compêndio. THAC0 e Saving Throws NÃO
entraram nessa página — já são calculados automaticamente pra qualquer
classe em "Level Changes" (página 2), não é exclusividade de quem tem
ficha de magia.

## AJUSTE v1.94 (2026-09-30) — Rogue: merge de regras + Ninja (classe nova) + Thieving Skills/Backstab/Bardic Abilities

Segunda rodada de grupo completo, igual o Warrior — zip `rougue_rules.zip`
com 3 sourcebooks: Complete Bard's Handbook (CBH), Complete Ninja's
Handbook (CNH), Complete Thief's Handbook (CTH). Antes de codar, 3
perguntas foram esclarecidas com o usuário: (1) Ninja = nova
`CharacterClass` (não Kit de Thief, ao contrário do Barbarian) — o próprio
CNH trata ninja como classe própria do grupo Rogue, com Table 1 (XP/Hit
Dice) igual à Table 25 do PHB mas requisitos/restrição racial/thieving
skills todos próprios; (2) prioridade desta rodada = "Todas" (Thieving
Skills + Backstab + Bardic Abilities, já que o app não tinha NENHUMA
mecânica de Rogue implementada até agora); (3) Kits (Bard/Thief/Ninja)
ficam pendentes do JSON estruturado que o usuário vai fornecer — mesmo
acordo do Warrior, nenhum kit foi inventado.

**1) Rules Reference.** 149 entradas novas (CBH:43, CNH:42, CTH:64), zero
colisão de ID — total 634 → 783. Book codes CBH/CNH/CTH somados aos 7 que
já existiam (agora 10 ao todo); `CompendiumHubView`/`RulesCompendiumView`/
`RulesDatabase` atualizados, mesma mecânica de sempre.

**2) Ninja — nova `CharacterClass`.** `CharacterClass.ninja`, grupo
"Rogue" (`proficiencyGroup`), Hit Die d6 (Table 1 do CNH = Table 25 do
PHB). `ExperienceProgressionTable`/`CoreClassGroup` ganharam a entrada
(conferida linha a linha contra a tabela do CNH — bate exatamente com
Thief/Bard, já que o PHB Table 53/60 de THAC0/Saves são por GRUPO, não por
classe específica). `Race.swift`: Dwarf e Halfling marcados `.unlimited`
pro Ninja (CNH: "Races Allowed: Human, Dwarf, Halfling" — sem tabela
numérica de limite de nível no texto-fonte, então não inventei um teto;
Elf/Gnome/Half-Elf continuam proibidos pelo `default` de sempre, CNH:
"There are no demihuman ninja clans").

**3) Thieving Skills — Thief, Bard e Ninja.** Nova seção "Thieving Skills"
na página 1 da ficha (`ThievingSkillsForm`), só pro grupo Rogue
(`CharacterClass.hasThievingSkills`). Uma linha editável de % por
habilidade (8 pro Thief/Ninja, 4 pro Bard), semeada uma vez com Base +
Raça + Destreza — TODOS os números vêm das Tables 26-28 do PHB
(`phb_ch03_rogue_tables`, já tabeladas no `rules.json`) e, pro Ninja, das
Tables 2/3 do CNH (Table 3 é a própria Table 28 "reproduzida", conferido
número a número; a Table de raça do CNH pra Dwarf/Halfling também bate
exatamente com a Table 27 do PHB — daí o Ninja reaproveitar as duas
tabelas do Thief em vez de duplicar dado). O ajuste de ARMADURA (Table
29/Table 5 do CNH) ficou de FORA do cálculo automático — o campo "Armor"
da ficha só guarda o valor de AC, nunca o tipo de armadura vestida, então
não dá pra saber com segurança qual coluna aplicar; fica como tabela de
consulta na página de referência, pro jogador aplicar à mão (mesma
decisão já tomada pra o Non-proficiency Penalty do Warrior). Pontos de
distribuição por nível (60 iniciais / 30 por nível, PHB e CNH) também
ficam manuais — é escolha do jogador, não dado fixo. Criada
`Store/RuleEngine/CoreRuleset/ThievingSkillsTable.swift` com todas as
tabelas-fonte.

**4) Backstab — Thief e Ninja.** O CNH diz explicitamente "the ninja has
the same backstab ability as the thief" (a Table 4 dele é cópia idêntica
da Table 30 do PHB). Mostrado como referência (multiplicador atual
destacado pelo nível do personagem) na seção Thieving Skills e na nova
página de referência — sem multiplicar dano sozinho, mesma filosofia de
nunca auto-simular resultado de combate que já vale pro resto da ficha.

**5) Bardic Abilities.** As 4 habilidades do bardo (Climb Walls, Detect
Noise, Pick Pockets, Read Languages — Table 33 do PHB) entram pela MESMA
seção Thieving Skills (`ThievingSkillsTable.skills(for: .bard)`), já que
mecanicamente são tratadas como thieving skills "do jeito do ladrão"
(PHB: "Bard abilities are subject to modifiers... as per the thief"). O
resto das habilidades de bardo (Legend Lore, Charming Music, Countersong,
influência de reação em grupo etc., do próprio capítulo "Bard" do PHB e
do CBH cap. 5/7) fica como texto consultável na Rules Reference, como
prometido — não virou mecânica ativa nesta rodada (nem a progressão de
magia do bardo, Table 32, que só está na página de referência como
consulta, sem ficha de magia própria ainda).

**6) Nova página "Rogue Reference Tables".** `CharacterClass.hasReferencePage`
estendido pro grupo Rogue — `Views/RogueReferenceView.swift` mostra: Base
Score por classe, Armor Adjustment completo (Table 29 ou Table 5 do CNH,
conforme a classe), Backstab (Thief/Ninja) e Bard Spell Progression
(Bard), todos com botão "?" linkando pro texto fonte.

Pendente pras próximas rodadas: Kits de Bard/Thief/Ninja (bloqueado no
JSON que o usuário vai mandar); resto das habilidades de Bardo como
mecânica ativa (hoje só consulta); ficha de magia do Bardo (Table 32
funcionando de verdade, como a do Clérigo/Mago).

## AJUSTE v1.95 (2026-09-30) — Bard Spell Sheet de verdade (fase 4 de paridade Priest/Wizard/Bard)

Usuário, depois de ver a v1.94 ("Rogue: Thieving Skills/Backstab/Bardic
Abilities"): "Boa! Mas não encontrei nada para controlar as magias de
bardo. Onde estão?" — correto: a v1.94 só tinha colocado a Bard Spell
Progression (Table 32) como TABELA DE CONSULTA na página de referência,
sem ficha de magia de verdade por trás, e o changelog daquela versão já
dizia isso explicitamente. Perguntado (1) se implementar agora ou
deixar pra depois, e (2) como tratar a regra do PHB de que o bardo não
escolhe magia livremente (ganha 1-4 ao acaso/critério do mestre no 2º
nível, nunca mais automaticamente) — usuário escolheu "Implementar
agora" e "Grimório manual, igual o do Mago" (o jogador anota à mão o que
o personagem encontra em jogo, sem simular rolagem de "chance to learn").

Achado bom, igual ao que já tinha acontecido com a v1.88 (Wizard Spell
Sheet): quase toda a infraestrutura do livro de magias do Mago
(`PlayerCharacter.wizardSpellbook`/`wizardKnows`/`wizardSpellbookSpells`/
`wizardSpellbookFreeNames`/`wizardMaxKnowableCircle`, e a restrição real
de memorização em `SpellSheetView.SlotEditorSheet`) já era genérica por
`CasterType.arcane`, nunca travada em `characterClass == .mage` por
dentro — só a CAMADA DE UI é que checava `== .mage` em vários lugares.
Como um personagem só tem uma classe por vez, reaproveitar os mesmos
campos pro Bardo (em vez de duplicar em `bardSpellbook`/`bardSchool`) é
seguro: eles já significam "as magias arcanas que este personagem
conhece", não "as magias do Mago especificamente".

O que precisou de verdade:
- **`CharacterClass.isArcaneCaster`** (novo, `Models/Character.swift`) —
  `true` pra `.mage` e `.bard`, centraliza o que antes era `== .mage`
  espalhado pelas views.
- **`CharacterClass.hasSpellSheet`** passou a incluir `.bard`.
- **`BardTables`** (novo enum, espelhando `WizardTables`) — Tabela 32 do
  PHB ("Bard Spell Progression"), teto natural de 6º círculo (a própria
  tabela já para ali, ao contrário do Mago que vai até o 9º), SEM bônus
  de especialização (PHB: "In no case can a bard choose to specialize in
  a school of magic" — por isso `computedSpellSlotAllotments` não soma
  bônus nenhum no novo `case .bard`, diferente do `case .mage`). Os
  números já tinham sido transcritos uma vez em `RogueReferenceView.swift`
  (v1.94, só consulta) — viraram a cópia CANÔNICA aqui, e a view de
  referência foi ajustada pra ler de `BardTables.spellProgressionRows`
  em vez de manter uma segunda cópia que um dia poderia divergir.
- **`PlayerCharacter.computedSpellSlotAllotments`** ganhou `case .bard:`
  (usa `BardTables.spellProgression(level:intelligence:)`, `.arcane`).
- **`PlayerCharacter.spellSheetAbilityScoreAtCreation`** trocou o teste
  `== .mage` por `characterClass.isArcaneCaster` — Bardo também usa
  Inteligência (PHB: bardo lança magia de mago, mesmo atributo-chave).
- **`WizardSpellbookEditorSheet.swift`** ("My Spellbook"): a seção
  "Specialization" (Table 22, escolas opostas) agora só aparece pra
  `== .mage` — regra do PHB citada acima. O rodapé ("add spells straight
  from the Mage Grimoire") virou dinâmico (`grimoireLabel`), mostrando
  "Bard Grimoire" quando for o caso.
- **`SpellbookView.swift`** (o Grimório, tela de navegar a base inteira):
  `wizardSpellbookMaxCircle` (o que decide se aparece o botão "+"/"✓" de
  livro pessoal numa magia) trocou `== .mage` por `.isArcaneCaster`; o
  título do cabeçalho virou "Mage Grimoire"/"Bard Grimoire"/"Priest
  Spellbook" conforme a classe (`grimoireTitle`).
- **`SpellSheetView.swift`** (a folha de "Game Day" em si): o cabeçalho
  trocou o antigo `isWizard: Bool` por `isArcane: Bool` (agora
  `isArcaneCaster`) + `casterTitle: String` (3 vias: "Wizard"/"Bard"/
  "Priest") — a restrição de memorização em si (`SlotEditorSheet`) já não
  precisou de NENHUMA mudança: já era `slot.caster == .arcane`, nunca
  `characterClass == .mage`.
- **`CharacterSheetView.swift`** (várias checagens de UI, todas trocadas
  de `== .mage` pra `.isArcaneCaster`): o redirecionamento de
  `.mySpellbook` ao trocar de classe, o botão "My Spellbook" no menu ☰, e
  o `caster:` passado pro Grimório ao abrir `.spellbook`. O rótulo do
  Grimório no menu ☰ virou uma função de três vias (`grimoireMenuLabel`),
  mesmo padrão do `SpellbookView`. A 4ª página de referência (`.mage` →
  `WizardReferencePage`, senão Warrior/Rogue) e o botão "Spheres" do
  cabeçalho (`== .cleric`, já explícito desde a v1.88 por causa exatamente
  deste tipo de problema) não precisaram de NADA — já estavam corretos.
- **`BardSpellSlotsProvider`** (novo, Motor de Consequências, espelhando
  `WizardSpellSlotsProvider`) — registrado em `CoreRuleset.swift`.
- Criação de personagem/primeira folha (`ClassPicker.select`,
  `CharacterLibrary.seedFirstSpellSheetIfNeeded`) não precisaram de NADA —
  já eram genéricos por `hasSpellSheet`/`spellSheetAbilityScoreAtCreation`/
  `freshSlotBoard()`.

Continua igual ao Mago: sem simular "chance to learn" nenhuma — o jogador
adiciona à mão o que encontra em jogo (ou, se quiser, direto do Grimório
já restrito ao círculo alcançável). O bardo nasce com o livro VAZIO (ao
contrário do mago, que ganha "Read Magic" de graça) — o PHB não garante
nenhuma magia inicial ao bardo, e `seedWizardSpellbookIfNeeded` continua
travado em `characterClass == .mage`, de propósito, sem mudança.

Pendente pras próximas rodadas: Kits de Bard/Thief/Ninja (bloqueado no
JSON que o usuário vai mandar); resto das habilidades de Bardo como
mecânica ativa fora de Thieving Skills (Legend Lore, Charming Music,
Countersong, influência de reação em grupo — hoje só consulta na Rules
Reference).

`Package.swift`: `displayVersion` "1.94"→"1.95", `bundleVersion`
"199"→"200".

## AJUSTE v1.96 (2026-09-30) — Weapon Proficiency Slots: contador de verdade (Tabela 34 + bônus de Int)

Usuário pediu propostas pra refletir a mecânica de Weapon Proficiencies
(slots que geram bônus de ataques/acerto/dano) além do que já existia
(Weapon Specialization, v1.92). No meio da conversa, contra-propôs algo
melhor do que eu tinha esboçado: em vez de um contador solto e digitado à
parte, fazer a própria ★ de especialização (que já existe) "gastar" o
slot de verdade, e mostrar o total batendo contra a Tabela 34.

Implementado exatamente assim — nada novo pra digitar, só leitura do que
já está na ficha:

- **`IntelligenceTable.bonusLanguages(forScore:)`** (novo,
  `AbilityTables.swift`) — a coluna "Languages" da Tabela 4 como `Int`.
- **`ProficiencySlotsTable.totalWeaponSlots(for:level:intelligence:)`**
  (novo) — fórmula tirada letra por letra do texto do PHB
  (`phb_ch05_proficiencies`): "A new proficiency slot is gained at every
  experience level that is evenly divisible by [#Levels]" → `Inicial +
  nível ÷ #Levels` (divisão inteira). Passando `intelligence`, soma o
  bônus opcional do Complete Fighter's Handbook cap. 4 ("Intelligence and
  Proficiencies": os idiomas extras de Inteligência alta, Tabela 4,
  podem virar proficiências extras "divided as the player chooses
  between Weapon Proficiencies and Nonweapon Proficiencies" — escolhido
  pelo usuário nas perguntas de esclarecimento). Esse bônus é de CRIAÇÃO
  (não escala com nível) e é escolha do jogador — o total calculado
  assume que TUDO foi pra arma, então é um TETO informativo, não uma
  trava; se o jogador tiver dividido parte pra proficiência não-marcial,
  o número real é menor (documentado no código, não escondido).
- **`WeaponCombatForm`** (`CharacterSheetView.swift`) ganhou o contador
  "Weapon Proficiency Slots: X/Y used", visível pra QUALQUER classe (toda
  classe tem Tabela 34, não só Fighter):
  - **X (gasto)**: soma 1 por arma com nome preenchido na tabela (regra
    de sempre: toda arma listada JÁ é uma proficiência) + 1 extra por ★
    especializada em arma corpo-a-corpo/besta, + 2 extra por ★
    especializada em ARCO (não-besta).
  - Achado no caminho: o texto do CFH diz que especializar custa 2 slots
    no total (1 extra) pra "any sort of melee weapon or **crossbow**", e
    só 3 no total (2 extra) pra "any **bow** (other than a crossbow)" —
    ou seja, besta custa o MESMO que arma corpo-a-corpo, só arco de
    verdade custa mais. A checagem de "arma à distância" que já existia
    (`WeaponFormRow.isRangedWeapon`, usada pro bônus de acerto point-
    blank) junta besta e arco porque os dois ganham o mesmo bônus ali —
    mas usar essa MESMA checagem aqui cobraria 2 slots de uma besta que
    na verdade só custa 1. Por isso o contador tem sua própria checagem
    (`isTrueBow`, só "bow" sem "crossbow" no nome).
  - **Y (total)**: `ProficiencySlotsTable.totalWeaponSlots`, acima.
  - Fica vermelho se X passar de Y — nunca trava nada (mesma filosofia
    do resto da ficha: avisa, não impede).
- A nota de Weapon Specialization que já existia (só pro Fighter) ficou
  mais precisa no mesmo processo — "bow/crossbow point-blank +2 (2
  slots)" virou "melee/crossbow +1/+2 dmg (1 slot extra) · bow point-
  blank +2 (2 slots extra)", corrigindo o mesmo erro besta-vira-arco que
  o contador evita.

`Package.swift`: `displayVersion` "1.95"→"1.96", `bundleVersion`
"200"→"201".

## AJUSTE v1.97 (2026-10-01) — Warrior Kits e Rogue Kits (fecha o pendente da v1.92/v1.94)

O usuário forneceu `warrior_kits.json` (114 kits) e `rogue_kits.json` (73
kits) — o JSON estruturado que faltava desde a v1.92 ("Warrior Kits fica
pendente até lá") e a v1.94 (mesmo acordo pro Rogue). Diferente do
`wizard_kits.json` bruto (wiki-scrape cru), estes dois já vieram no
esquema praticamente idêntico ao de `Resources/kits.json` — mesmas chaves
de topo, `features`/`description` já com `rawWikitext`.

**1) `Scripts/convert_warrior_rogue_kits.py`** (novo, mesma filosofia dos
outros dois conversores: tratar diferença de esquema em Python, não em
Swift). Três ajustes de esquema: `requirements.alignment` singular →
`alignments` lista; `weapons` ganha `forbidden: []` (chave que não existe
no bruto); `armor`/`turnUndead` sintetizados com os mesmos valores
neutros do mago (dado de armadura dessas classes só existe como prosa em
`features.specialHindrances`/`equipment`, sem estrutura pra extrair).
`weaponSlots` só vira campo quando tem conteúdo (39/114 kits de Warrior,
14/73 de Rogue) — mesmo `Optional` que `Kit.swift` já suporta.

Caso especial: Barbarian (14 dos 114 kits de Warrior) vem do arquivo
bruto marcado como se fosse uma classe própria (`subclass: "Barbarian"`,
`allowedClasses: ["Barbarian"]`) — mas a regra confirmada com o usuário
antes do Warrior inteiro (v1.92) é que Barbarian é KIT de Fighter, não
`CharacterClass`. Sem remapear isso, esses 14 kits ficariam invisíveis
pra sempre em `KitDatabase.kits(allowedFor:)` (nenhuma classe jogável
chamada "Barbarian" existe pra casar o filtro) — resolvido na conversão
(`allowedClasses` vira `["Fighter"]`, `subclass` continua "Barbarian"
como rótulo exibido) em vez de mais um caso especial em Swift, mesmo
espírito do mago sintetizando `allowedClasses: ["Mage"]` direto.

Rodado uma vez por grupo, cada um anexando ao `kits.json` da rodada
anterior: 132 kits (Priest 91 + Wizard 41) → +114 Warrior → +73 Rogue =
**319 kits no total**. Zero colisão de id, zero "Create Your Own" nos
dois arquivos (diferente do mago, que tinha 9). Validado campo a campo em
Python contra o schema exato de `Kit.swift` antes de ir pro app (tipos de
`mechanics.requirements.abilities`, `weaponSlots.initial/additional`,
etc.) — sem Swift disponível neste ambiente pra compilar de verdade, mas
o histórico do bug de decode original (`KitDatabase.swift`) tornou essa
checagem manual criteriosa, não opcional.

**2) `Views/KitCompendiumView.swift`.** `groupOrder` (usado pelo
compêndio de folhear, agrupado por subclasse) só sabia de `"Priest"` e
"qualquer outra coisa" → `["Wizard"]` — teria mostrado o compêndio de
Warrior/Rogue vazio mesmo com os kits carregados (`bySubclass["Wizard"]`
nunca bate com "Fighter"/"Thief"/etc.). Ganhou `warriorGroupOrder`
(`["Fighter", "Paladin", "Ranger", "Barbarian"]`) e `rogueGroupOrder`
(`["Thief", "Bard", "Ninja"]`), com `switch` no lugar do ternário.
`KitPickerSheet.emptyMessage` perdeu o branch especial do grupo Warrior
("kits ainda não estão na base...") — virou morto na prática, já que
`kits(allowedFor:)` não fica mais vazio pra Fighter/Paladin/Ranger/Thief/
Bard/Ninja; a mensagem genérica ("\(className) has no kits in the
compendium yet.") cobre qualquer classe futura sem kit.

**3) `Views/CompendiumHubView.swift`.** Dois tiles novos no Hub, mesmo
padrão de "Priest Kits"/"Wizard Kits" — "Warrior Kits" (`icon_warrior_kits`,
sem asset ainda, cai no fallback `shield.fill`/badge raio crimson) e
"Rogue Kits" (`icon_rogue_kits`, fallback `eye.slash.fill`/badge estrela
verde-escuro), cada um navegando pro `KitCompendiumScreen(classGroup:)`
já genérico.

Nenhuma mudança em `Models/Kit.swift`/`KitDatabase.swift` além de
comentário (doc-comment do topo atualizado pra citar os quatro grupos) —
confirma a aposta de projeto desde o mago: `classEligibility` genérico
dispensa qualquer mudança de modelo pra um grupo de classe novo.

Pendente: ícones de verdade pra "Warrior Kits"/"Rogue Kits" (hoje no
fallback de SF Symbol, igual todo tile sem arte própria) — cosmético, não
bloqueia uso.

`Package.swift`: `displayVersion` "1.96"→"1.97", `bundleVersion`
"201"→"202".

## AJUSTE v1.99 (2026-10-04) — causa do "Build Failed" sem mensagem: o ícone do app

**Causa achada.** O Swift Playgrounds 4.7 (build 2088) no iPad trava
internamente (crash do próprio Playgrounds — `_assertionFailure` numa Task
da main thread, mesmo ponto nos 6 crash logs do dia, inclusive antes de
qualquer mudança) ao montar o asset catalog do ícone (`Assets.xcassets` +
`appIcon: .asset("AppIcon")`) num build do zero. Não é memória (sem
JetsamEvent do Playgrounds) nem tamanho de código. Bisseção no iPad, cada
pacote como projeto novo: v1.96 com ícone → falha; v1.98 sem os JSON (com
ícone) → falha; v1.98 sem o ícone → **roda**. O mesmo ícone compila normal
no Xcode (CI), então é defeito do Playgrounds, não do PNG (1024×1024 RGB,
formato padrão). Provável motivo de "funcionava antes": o build incremental
do projeto original reaproveitava o ícone já montado; qualquer coisa que
forçasse build do zero quebrava — inclusive o rollback da v1.52, que nunca
tirou o ícone.

**Correção.** `appIcon` removido do `Package.swift`; `Assets.xcassets`
removido do target; arte guardada em `Docs/app-icon/AppIcon.png`. O app usa
o ícone padrão do Playgrounds. Pendente (opcional): recolocar o ícone pela
tela de configurações do próprio Playgrounds numa cópia e trazer pro repo o
formato que ele gerar.

**CI (`.github/workflows/typecheck.yml`).** A cada push que mexe em
`THAC0berry.swiftpm/**`, um Mac do GitHub roda `swiftc -typecheck` contra o
SDK do iOS 17 (erros com arquivo:linha + ranking de funções lentas) e
`xcodebuild` do `.swiftpm` completo. Resultado sai como anotações no
commit. Alerta (não bloqueia): arquivo > 1500 linhas ou função > 1s. Base
na v1.98-p2b2: 0 erros, 27.9k linhas, 310 MB / 57 s, função mais lenta
0,68 s. Limite conhecido: não reproduz bugs do Playgrounds no iPad (este
do ícone passou no CI).

**Fora do target.** `THAC0berry.swiftpm/Scripts/*.py` e
`THAC0berry.swiftpm/Docs/data-schemas.md` foram pra `Scripts/` e `Docs/` na
raiz (`path: "."` punha tudo dentro do `.swiftpm` no target).
`validate_data.py` ajustado pro novo caminho.

**Pacotes de teste.** Gerar o zip a partir dos blobs do git (bytes iguais
ao repo), não com `git archive` — neste PC o `core.autocrlf=true` faz o
`git archive` converter os textos pra CRLF.

`Package.swift`: `displayVersion` "1.98-p2b2"→"1.99", `bundleVersion` "209"→"210".

## AJUSTE v1.99.1 (2026-10-04) — contrato de dados (JSON Schema), CLAUDE.md, limpeza de legados

**Contrato dos dados de referência.** `schemas/*.schema.json` (13 schemas,
JSON Schema 2020-12) cobrem todos os JSON de `Resources/`, escritos a partir
do decode de cada modelo Swift (obrigatório = o Swift falha sem o campo).
`Scripts/validate_schemas.py` valida tudo (JSON sem schema, id duplicado,
campos ignorados pelo app como aviso; `--strict` vira erro). CI novo
`.github/workflows/data.yml` (Linux). Resultado: 41 arquivos OK, nenhum
campo ignorado. Regra: mudou modelo decodificável → muda o schema no mesmo
commit (ver `schemas/README.md`).

**CLAUDE.md** na raiz: regras do projeto e armadilhas conhecidas (ambiente
sem Mac, Playgrounds/ícone, Codable, dados do usuário, CI, empacotamento,
versão, direção backend/web). **README.md** reescrito para o estado atual
(o antigo descrevia a v1).

**Removidos.** `Resources/spells.json` (não era carregado pelo app desde que
as magias foram para `sample_spells`/`priest_*`/`wizard_*`; nem decodificava
mais no formato atual de `SpellDamage`) e `Scripts/validate_data.py`
(substituído pelo validador de schemas). Pendente cosmético: o texto
placeholder em `SpellSheetView.swift` ("Once the entry exists in
spells.json…") ainda cita o arquivo antigo.

`Package.swift`: `displayVersion` "1.99"→"1.99.1", `bundleVersion` "210"→"211".

## AJUSTE v1.99.2 (2026-10-04) — versão no library.json, inventário de regras nas telas, texto do placeholder

**`schemaVersion` no `library.json`** (`Store/CharacterLibrary.swift`). Este
build grava `schemaVersion: 1` (`CharacterLibrary.currentSchemaVersion`);
arquivo sem o campo é lido como 0 (tudo que existia antes) e regravado como
1 no próximo salvamento, sem perder nada. Proteção nova: se o arquivo (ou um
backup importado) vier de um formato MAIOR que o deste build, a biblioteca
abre só pra leitura (`isReadOnly`, aviso em `lastError`) e nada é gravado —
antes, um personagem que não decodificasse seria descartado pelo
`LossyArray` e sumiria de vez no próximo save. Importar um backup legível
libera a gravação de novo (o jogador já confirmou substituir tudo).

**Inventário** em `Docs/inventario-regras-nas-telas.md`: 11 regras de jogo
dentro de Views (A1–A11), 6 gatilhos (B1–B6), migração/preenchimento feitos
pela tela (C1–C2), estado de UI persistido no modelo (D), e a proposta de
5 lotes. Achado principal: a regra "criar folha de magia do dia" existe em
5 cópias, e uma delas (`SpellSheetBeadRow.newSheet`) se comporta diferente.

**Texto.** Placeholder de magia fora da base (`SpellSheetView`) não cita
mais o `spells.json` (removido na v1.99.1).

`Package.swift`: `displayVersion` "1.99.1"→"1.99.2", `bundleVersion` "211"→"212".

## AJUSTE v1.99.3 (2026-10-04) — Lote 1: regra única de "dia novo de magias"

Item A3 de `Docs/inventario-regras-nas-telas.md`. A criação da folha de um
dia novo existia em 5 cópias nas telas (`CampaignIndexView.createSession`,
`SessionGroup.open`, `SheetTabs.selectSession`, `SpellSheetBeadRow.newSheet`,
`ClassPicker.select`) e só o "+" herdava as magias preparadas do dia
anterior. Agora é uma função só, `PlayerCharacter.startSpellSheet(...)` em
`Store/SpellSheetRules.swift` (Foundation pura, sem SwiftUI), e
`SpellSlotBoard.reconciled(with:)` saiu de `CharacterSheetView` pra lá.

**Mudança de comportamento (decisão do usuário):** todo dia novo herda do
dia anterior — magias memorizadas, slots desmarcados, registro vazio, itens
mágicos com cargas zeradas, grade ajustada à tabela de slots atual. "Dia
anterior" = a folha mais recente do personagem com data até a do dia novo;
sem folha anterior (primeira folha do personagem), nasce em branco como
antes. O "+" dentro de uma sessão continua herdando do último dia DAQUELA
sessão, idêntico ao que era.

`Package.swift`: `displayVersion` "1.99.2"→"1.99.3", `bundleVersion` "212"→"213".
