# TODO — Base de magias real + navegação

Registro do que ficou combinado na conversa sobre trocar a base de exemplo
(poucas dezenas de magias) pela base real de Priest (**1.598 magias**). Nada
disto está implementado ainda — é só o plano, pra não perder o fio.

## 1. Importar a base real de magias

- [ ] Usuário fornece os dados em **JSON**, quebrado em **um arquivo por
      nível de magia** (1 a 7) — nomes de arquivo ainda a combinar.
- [ ] Conferir se os nomes de campo da fonte batem com `Spell`
      (`Models/Spell.swift`): `name`, `level`, `caster`, `school`,
      `castingTime`, `range`, `components`, `duration`, `areaOfEffect`,
      `savingThrow`, `damage`, `summary`. Se não baterem, escrever script de
      conversão (não pedir pro usuário reformatar na mão).
- [ ] Gerar `id` (slug tipo `pri3-prayer`) a partir do nome + nível,
      evitando colisão com as poucas magias de exemplo que já existem
      (personagem Kelmon, `SampleCharacter.swift`).
- [ ] Tentar estruturar `damageDice` a partir do texto livre de `damage`
      quando der pra reconhecer o padrão (ex.: "1d8 per level, max 10d8");
      o que não der, fica só como texto solto em `damage` — sem travar a
      importação.
- [ ] Adaptar `SpellDatabase.load()` (`Store/SpellDatabase.swift`), que hoje
      só lê um `Resources/spells.json` fixo, pra ler os 7 arquivos por nível
      e juntar tudo num array só na memória. Mecânica de busca/filtro
      (`matches`, `spells(caster:level:)`) não muda.
- [ ] Validar depois de importar: contagem por nível bate com o esperado,
      nenhum `id` duplicado, nenhum `level`/`caster` fora do intervalo que a
      folha usa pra filtrar por círculo.

## 2. Favoritos por personagem

- [ ] Guardar um `Set<String>` de ids de magia favoritadas dentro de
      `PlayerCharacter` (por personagem, não global — cada clérigo/druida
      favorita coisas diferentes).
- [ ] Estrela pra marcar/desmarcar em `SpellDetailSheet`.
- [ ] Na lista de candidatos pra memorizar (`SlotEditorSheet`), favoritos do
      círculo aparecem primeiro, antes da lista completa.

## 3. Ordenar por "mais usadas" (sem precisar marcar nada)

- [ ] Calcular direto do histórico já existente
      (`character.spellSheets`, contar quantas vezes cada `preparedSpellID`
      apareceu memorizado) — não precisa guardar contador novo.
- [ ] Ordem final na lista de candidatos: favoritos → mais usadas → resto
      em ordem alfabética.

## 4. Esferas de acesso (fase 2 — mais escopo, avaliar depois)

- [ ] Modelar esfera de cada magia de forma estruturada (`school` hoje é
      texto solto).
- [ ] Modelar lista de esferas acessíveis por personagem (Major/Minor,
      conforme divindade/classe — regra de 2e).
- [ ] Filtrar a lista de candidatos por essas esferas antes mesmo do nível
      — o corte mais forte de todos, de 1598 pro que aquele personagem
      específico pode preparar.
- [ ] Decidir só depois de ver o tamanho real do problema por círculo com a
      base completa carregada.

## 5. Navegação em seções na lista completa

- [ ] Quando o jogador quer folhear em vez de buscar, agrupar a lista
      completa por esfera com títulos recolhíveis (mesmo padrão do "old
      sessions" em `CampaignIndexView`) em vez de uma lista corrida de
      150+ itens.

## 6. Grimório — tela de consulta separada

Ideia: uma tela própria pra navegar a base inteira de magias, sem estar
presa ao fluxo de "memorizar num slot" — pra folhear em busca de opções,
tipo consultando o livro na mesa.

- [ ] Nova página/aba acessível a partir da ficha (mesmo padrão de acesso
      do Índice de Campanha).
- [ ] Lista agrupada por esfera e nível, com o mesmo agrupamento
      recolhível do item 5.
- [ ] Campo de busca no topo reaproveitando `SpellDatabase.matches` (a
      mesma busca aproximada que já existe pra escrita à mão).
- [ ] Filtro rápido "só favoritas".
- [ ] Toque numa magia abre `SpellDetailSheet` (já existe) em modo consulta
      — sem ação de atribuir a um slot, já que não necessariamente tem uma
      folha aberta.
- [ ] Estrela de favoritar disponível direto na lista, não só dentro do
      detalhe.
- [ ] Avaliar se dá pra reaproveitar o mesmo componente de lista dentro do
      `SlotEditorSheet`, em vez de duas implementações separadas.

## Ordem sugerida de execução

1. Importar a base (item 1) — sem isso não dá pra testar nada do resto.
2. Favoritos + mais usadas (itens 2 e 3) — resolvem a maior parte do
   problema de achar magia rápido, sem exigir dado novo sobre esferas.
3. Ver o tamanho real do problema por círculo com a base completa e decidir
   se esferas de acesso (item 4) valem o escopo extra.
4. Navegação em seções (item 5) e Grimório (item 6) — a essa altura já dá
   pra reaproveitar o componente de lista agrupada nos dois lugares.
