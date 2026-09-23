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

## Ordem sugerida de execução

1. ~~Importar a base~~ — feito, item 1 completo.
2. ~~Favoritos + mais usadas~~ — feito, itens 2 e 3 completos (faltam só os
   dois retoques marcados acima no item 2).
3. ~~Navegação em seções + Grimório~~ — feito, itens 5 e 6 completos.
4. ~~Esferas de acesso~~ — feito, item 16 completo (falta só verificar num
   iPad de verdade, sem simulador aqui — ver ressalva no próprio item).
5. ~~Tela Principal + ícones ilustrados~~ — feito, item 8 completo (falta só
   decidir o destino do selo "Session-active", sem pressa).
