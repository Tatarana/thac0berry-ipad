# Inventário: regras de jogo dentro das telas (Views)

Levantamento de 2026-10-04 (v1.99.1). O objetivo é saber o que hoje só existe dentro de
uma tela SwiftUI e que a versão web teria que reimplementar para a ficha ficar igual.
**Nenhum código foi mudado.** Cada movimentação proposta aqui precisa de aprovação e
sai em lote pequeno, com teste no iPad.

## Critério

- **Regra de jogo:** a tela decide um valor ou uma consequência que não foi digitada
  pelo jogador (cálculo, preenchimento automático, efeito colateral). Se a web não
  repetir isso, a mesma ficha fica diferente nos dois apps. **Deve sair da tela.**
- **Gatilho:** a regra já está fora da tela (no modelo ou no `ConsequenceEngine`), mas
  é a tela que decide **quando** ela roda (`.onChange`, `.onAppear`). A web teria que
  descobrir e copiar esses momentos. **O gatilho deve ir junto com a mudança no modelo.**
- **Edição simples:** a tela só grava o que o jogador escolheu (texto, toggle, adicionar
  ou remover linha). **Fica na tela.**

Método: busca por escritas em `character.*`, `campaign.*` e `sheet.*` em `Views/*.swift`,
mais as chamadas a tabelas e motores de regra. Os 92 pontos encontrados se agrupam nas
funções abaixo. Escritas feitas via binding (`$character.x` passado a um campo) são
edição simples por definição e não foram listadas.

## A. Regras de jogo nas telas (mover)

| # | Onde | O que faz | Destino proposto |
|---|---|---|---|
| A1 | `CharacterSheetView.swift`: `RecordHeaderForm.addBonusProficiencies` (~2181) | Ao escolher um kit, acha as proficiências bônus dele na base, casa por nome aproximado e preenche linhas vazias ou acrescenta novas; marca "mudança automática". | `PlayerCharacter.applyKitBonusProficiencies(kit:proficiencies:)` |
| A2 | Mesmo arquivo: `ClassPicker.select` (~2280) | Trocar a classe recalcula XP do próximo nível, tipo de dado de vida, tabela de mudanças de nível, semeia o grimório do mago e cria a primeira folha de magia. | `PlayerCharacter.changeClass(to:registry:spellbook:session:)` |
| A3 | **5 cópias** da regra "nova folha de magia do dia": `CampaignIndexView.createSession` (~66), `SessionGroup.open` (~165), `SheetTabs.selectSession` (~555), `SpellSheetBeadRow.newSheet` (~804), `ClassPicker.select` (~2300) | Cria a folha com slots zerados (repouso), a Sabedoria do momento e o título do dia. **A `newSheet` difere das outras quatro:** herda as preparações do dia anterior (`nextDay`) e reconcilia os slots com `computedSpellSlotAllotments`; as outras usam `freshSlotBoard()`. Pode ser intencional (primeiro dia vs. dia seguinte), mas hoje a regra está espalhada e pode divergir sem ninguém notar. | `PlayerCharacter.startSpellSheet(session:title:continuingFrom:)`, uma função só |
| A4 | `CharacterSheetView.swift`: `ThievingSkillsForm.seedIfNeeded` (~3659) | Preenche as perícias de ladrão com o valor base da tabela + raça + Destreza, remove as que não valem para a classe e ordena. Roda ao abrir e ao trocar de classe. | `PlayerCharacter.seedThievingSkills()` (já usa `ThievingSkillsTable`) |
| A5 | `WizardSpellbookEditorSheet.swift`: `setSchool` (~152) | Ao escolher a escola de especialização, **remove do grimório** as magias de escolas opostas. | `PlayerCharacter.setWizardSchool(_:spellbook:)` |
| A6 | `CharacterSheetView.swift`: `EncumbranceForm` `.onAppear` (~1576) | Preenche a tabela de carga com as penalidades fixas do livro (acerto, CA, movimento por faixa). | Valor inicial definido no modelo (`EncumbranceTable.phbDefault`), não na tela |
| A7 | `CharacterSheetView.swift`: `WoundsBlock.commit` (~2856) | Aplica dano (`applyDamage`, já no modelo) **e** registra o ferimento na lista `combat.wounds`. A segunda parte só existe na tela. | `PlayerCharacter.recordWound(_:)` fazendo as duas coisas |
| A8 | `ActiveEffectsView.swift`: `ActiveEffectCard` (~206 e ~211) | Cura "em reserva" de efeito ativo: cada uso soma 1 PV (limitado ao máximo); desfazer tira 1 PV. | `PlayerCharacter.useBankedHeal(effect:component:)` / `undoBankedHeal` |
| A9 | `SpellSheetView.swift`: `AdditionalSpellsBlock.logCast` (~1562) | Registra uma conjuração: se a magia já está no registro do dia, soma 1; senão cria a linha com id e círculo casados. | `SpellSheet.logCast(name:spell:rawText:)` |
| A10 | `SpellSheetView.swift`: `CircleBlock.assign` (~351) | Memorizar magia num slot: grava id ou nome livre e **desmarca o slot como gasto**. | `SpellSlotBoard.assign(_:toSlot:)` |
| A11 | `CharacterSheetView.swift`: `CombatModifiersForm` (~3082) | Usa `ProficiencySlotsTable.nonProficiencyPenalty` como penalidade padrão quando o kit não define uma. | Propriedade calculada no modelo (`effectiveNonProficiencyPenalty`) |

## B. Gatilhos nas telas (a regra está fora; o "quando" está na tela)

| # | Onde | Gatilho | Proposta |
|---|---|---|---|
| B1 | `RecordHeaderForm` `.onChange(of: character.level)` (~2113) | Subir ou descer de nível → `refreshXPNeededNextLevel` + `ConsequenceEngine.refreshLevelChanges`. | `PlayerCharacter.setLevel(_:registry:)` |
| B2 | `RecordHeaderForm` `.onChange(of: character.kit)` (~2124) | Trocar o kit → A1. | Junto com A1: `setKit(_:kits:proficiencies:)` |
| B3 | `RecordHeaderForm` `.onAppear` (~2127) | Abrir a ficha → `ensureConsequenceSnapshotInitialized` + `refreshLevelChanges`. | Rodar ao carregar ou decodificar o personagem, não ao abrir a tela |
| B4 | Armadura/escudo `.onChange(of: armorRating / shieldRating)` (~3719, ~3722) e itens mágicos `.onChange(of: page2MagicItems)` (~1143) | Recalcula a CA (`ConsequenceEngine.recalculateArmorClass`). | `setArmor(_:)`, `setShield(_:)`, `setMagicItems(_:)` que recalculam |
| B5 | `ThievingSkillsForm` `.onAppear` / `.onChange(of: characterClass)` (~3655) | Dispara A4. | Junto com A2 e A4 |
| B6 | `ConsequencePreviewSheet` (~200, ~208) | Calcula a diferença e aplica as consequências automáticas. | Já está no `ConsequenceEngine`; só a orquestração fica na tela. É aceitável, mas vale revisar junto com B1 |

## C. Preenchimento inicial e migração de dados feitos pela tela

| # | Onde | O que faz | Problema e proposta |
|---|---|---|---|
| C1 | `RecordSheetPageTwo.migrateFromOldEquipmentTab` (~1147) | Converte o equipamento e os itens mágicos do formato antigo para o da página 2 da ficha. | **Migração de dados salvos dentro de uma tela**: só acontece se alguém abrir essa página. Deve rodar ao carregar o `library.json` (com o novo `schemaVersion`). |
| C2 | `Page2EquipmentForm` (~1452), `CombatModifiersForm` (~3088–3094), `ProficienciesForm` (~3581) | Gravam linhas vazias padrão (10 de equipamento, 3 de modificadores, 6 de proficiências) na ficha ao abrir. | Linhas vazias são formato de tela, mas vão parar no JSON salvo. Proposta: a tela mostra as linhas em branco sem gravá-las. Risco baixo, ganho pequeno; **prioridade baixa**. |

## D. Estado de interface gravado no modelo

| Campo | Onde é escrito | Problema |
|---|---|---|
| `PlayerCharacter.lastChangedField` (`Character.swift:1478`) | `AbilityScoresForm` (~2461–2466), `RecordHeaderForm`, `ClassPicker` | Serve para destacar na tela o último campo alterado. Fica salvo no `library.json` e, no futuro, seria sincronizado entre aparelhos. |
| `PlayerCharacter.recentAutoChanges` (`Character.swift:1498`) | `markRecentAutoChange` (A1 e outros) | Mesmo caso: destaque visual persistido. |

Proposta: decidir antes do backend se esses campos saem do formato salvo (passam a ser
estado da tela) ou ficam documentados como "locais, não sincronizar". Não precisa mudar
agora.

## E. Edições simples (ficam na tela)

Arquivar/desarquivar campanha e sessão; criar, renomear e apagar sessão
(`CampaignIndexView`); ambientações da campanha (`CampaignSettingsEditorSheet`); retrato
(`CharacterDescriptionView`); restaurar PV ao máximo (`CombatForm`, ~2679); experiência
digitada (`ExperienceForm`); adicionar ou remover arma (`WeaponCombatForm`); contador de
Expulsar Mortos-Vivos, itens e linhas extras da folha de magia; marcar slot como gasto
(`SpellSheetView`); páginas do caderno (`NotebookView`); acesso a esferas
(`SphereAccessEditorSheet`, que aplica sugestões já calculadas em
`KitSphereSuggestions`); adicionar ou remover magia do grimório do mago
(`SpellbookView`, `WizardSpellbookEditorSheet`, exceto `setSchool`, que é a A5).

As telas de referência (`ClericReferenceView`, `WizardReferenceView`,
`RogueReferenceView`, `WarriorReferenceView`) só **leem** tabelas para exibir. Ficam.

## Proposta de execução (cada lote = uma versão, CI verde + teste no iPad)

1. **Lote 1: folha de magia do dia (A3).** Unifica as 5 cópias numa função. Antes,
   confirmar com o usuário se a diferença da `newSheet` (herdar preparações) é o
   comportamento desejado. Maior risco de divergência hoje; mudança pequena.
2. **Lote 2: troca de classe, nível e kit (A1, A2, A4, B1, B2, B5).** Funções de mutação
   no modelo; as telas passam a chamá-las.
3. **Lote 3: CA e equipamento (B4, A6, A11).**
4. **Lote 4: folha de magia e combate (A7–A10).**
5. **Lote 5: migração C1 no carregamento**, usando o `schemaVersion`.
6. Itens C2 e D: decidir junto com o desenho do backend.

Destino de todas as funções: por ora, extensões de `PlayerCharacter`/`SpellSheet` em
`Models/` ou `Store/` (Foundation pura, sem SwiftUI). É o primeiro passo para um módulo
de regras separado, qualquer que seja a linguagem do backend.
