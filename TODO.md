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
- [ ] Estrela de favoritar direto na lista do `SlotEditorSheet` (por ora só
      dá pra favoritar em `SpellDetailSheet` e no Grimório) — falta se
      quiser.
- [ ] Favoritar magias de item mágico (`ItemSpellRow`) — deixado de fora
      por ora.

## 3. Ordenar por "mais usadas" (sem precisar marcar nada)

- [x] `spellUsageCounts()` em `PlayerCharacter`, calculado direto do
      histórico existente (`spellSheets` → `slotBoard.slots`).
- [x] Ordem final na lista de candidatos: favoritos → mais usadas → resto
      em ordem alfabética.

## 4. Esferas de acesso (fase 2 — mais escopo, avaliar depois)

- [ ] Já temos `spheres: [String]` estruturado no modelo (item 1) — falta
      modelar lista de esferas acessíveis por personagem.
- [ ] Filtrar candidatos por essas esferas antes do nível.
- [ ] Decidir só depois de ver o tamanho real do problema por círculo com a
      base completa carregada.

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
- [ ] Reaproveitar componente de lista com `SlotEditorSheet` — por ora são
      duas implementações separadas (`SpellPaperRow` de um lado,
      `SpellbookRow` do outro); avaliar se vale unificar depois.

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
- [ ] Simplificação assumida em Jogadas de Proteção: o PDF tem colunas
      Start/Mod/Total pra cada jogada, o app guarda só um número (o
      alvo do d20). Revisitar só se o usuário pedir a conta separada.
- [ ] Proficiências: por ora é uma lista nova (`proficiencies`),
      separada das listas antigas "Weapon Proficiencies"/"Skills" (que
      continuam na aba Equipment) — ainda não decidido se vale unificar.

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

## Ordem sugerida de execução

1. ~~Importar a base~~ — feito, item 1 completo.
2. ~~Favoritos + mais usadas~~ — feito, itens 2 e 3 completos (faltam só os
   dois retoques marcados acima no item 2).
3. ~~Navegação em seções + Grimório~~ — feito, itens 5 e 6 completos.
4. Ver tamanho real por círculo com a base carregada e decidir sobre
   esferas de acesso (item 4) — próximo passo.
5. ~~Tela Principal + ícones ilustrados~~ — feito, item 8 completo (falta só
   decidir o destino do selo "Session-active", sem pressa).
