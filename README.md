# THAC0berry

Ficha de personagem de **AD&D 2ª edição** para iPad, pensada para a Apple Pencil.
Substitui a ficha de papel no que ela é pior: controlar magias dia após dia,
consultar regras e itens sem parar o jogo, e manter o histórico da campanha.

Projeto irmão do [Just Pencil It](https://github.com/Tatarana/Justpencilit): apps
separados, com a base técnica (canvas PencilKit, proteção de dados) clonada de lá.

> Agentes de IA e quem for mexer no código: leia primeiro o [`CLAUDE.md`](CLAUDE.md).
> Ele tem as regras do projeto e as armadilhas conhecidas do Swift Playgrounds.

## A tela é a folha

O app não usa `Form`, `List` nem controles padrão do iOS: cada tela imita a ficha
impressa. Pergaminho, tarjas em tinta escura, rótulos em versalete, valores em letra
de mão com caneta azul. Tocar num valor abre um balão onde a Pencil escreve por cima.
O texto é reconhecido pelo Scribble do próprio iPadOS, e não por OCR próprio; o
teclado de software fica desligado por padrão.

## O que o app faz

**Campanhas e personagens.** A Home leva a Campanhas, Personagens e Compêndio. Uma
campanha tem elenco, sessões datadas, ambientação (Forgotten Realms, Dark Sun,
Ravenloft…) e um **caderno compartilhado**, folheado como livro, com páginas pautadas,
quadriculadas ou de desenho livre. Personagens podem ser arquivados ou marcados como
mortos ("Fallen Heroes").

**Ficha do personagem**, no arranjo da ficha oficial de AD&D 2e:
- atributos com os ajustes derivados;
- THAC0 e tabela de acerto por CA;
- jogadas de proteção, armas, armadura com CA automática, proficiências (com contagem
  de slots), perícias de ladrão, equipamento, tesouro e descrição do personagem;
- raça, classe e kit vêm do compêndio.

Ao subir de nível ou trocar atributo ou classe, a **janela de consequências** mostra o
que muda (THAC0, saves, slots…) antes de aplicar.

**Folhas de magia por dia.** Em 2e os slots zeram no repouso, então a memorização é o
preenchimento de um dia, não um atributo do personagem. Cada dia de jogo tem a sua
folha, para sacerdote, mago e bardo:
- slots por círculo;
- magias memorizadas;
- registro do que foi conjurado: escreva o nome com a Pencil, o app sugere candidatos
  por casamento aproximado (`Utils/Fuzzy.swift`) e só grava com a sua confirmação.

As folhas antigas ficam guardadas e se folheiam como páginas, cronologicamente. O mago
tem ainda o **grimório pessoal** (as magias que conhece) e a escola de especialização.

**Efeitos ativos.** Magias e itens com duração (bônus de CA, de acerto, de saves,
dano…) aplicados sobre a ficha, com desfazer.

**Relatório de sessão.** Magias conjuradas por círculo e cargas de itens gastas,
somadas por sessão.

**Compêndio** (todo embutido, sem internet):
- grimórios de sacerdote e de mago;
- kits de sacerdote, mago, guerreiro e ladino;
- divindades e regras (PHB, DMG e Complete Handbooks);
- proficiências, armas, armaduras, equipamento, itens mágicos e poderes psiônicos;
- telas de referência por classe.

## Rodando no iPad

1. Abra a pasta `THAC0berry.swiftpm` no **Swift Playgrounds** (iPadOS 17 ou superior).
2. Aperte Play.

Não precisa de Mac. O app aparece com o ícone padrão do Playgrounds: o ícone próprio
está fora por suspeita de causar falhas de build no Playgrounds (detalhes no `CLAUDE.md`).

Se o Play falhar com "Build Failed" sem mensagem, feche o Playgrounds de vez (deslizando
o app para cima no seletor de apps) e tente de novo: é uma falha intermitente do próprio
Playgrounds.

**Antes de abrir uma versão nova como projeto novo, exporte um backup** (Settings →
Backup). Cada cópia de projeto no Playgrounds tem o seu próprio armazenamento: uma
cópia nova começa vazia. Depois é só importar o backup nela.

## Dados

- **Seus dados:** tudo fica local, em `Documents/library.json` (campanhas, personagens
  e preferências), gravado com a proteção de dados nativa do iOS
  (`.completeUnlessOpen`). Não há sincronização com a nuvem nesta versão.
- **Dados de referência** (magias, kits, regras, itens): a fonte única e o contrato
  (JSON Schema) estão no repo [`thac0berry-data`](https://github.com/Tatarana/thac0berry-data).
  `THAC0berry.swiftpm/Resources/*.json` é uma cópia, atualizada com
  `python Scripts/sync_data.py`.

## Estrutura

```
THAC0berry.swiftpm/          o app (tudo aqui dentro entra no build)
├── Package.swift            App Playground, produto .iOSApplication, iPad, iOS 17+
├── App.swift                ponto de entrada; injeta os stores
├── Models/                  personagem, campanha, folha de magia, magia, kit, item…
│   └── RuleEngine/          tipos do motor de regras (RuleProvider, RuleValue…)
├── Store/                   persistência (CharacterLibrary), bases do compêndio
│   │                        (*Database), ConsequenceEngine
│   └── RuleEngine/          tabelas e cálculos do livro (THAC0, saves, slots…)
├── Views/                   telas; PaperTheme/PaperFields = visual de papel
├── Utils/Fuzzy.swift        casamento aproximado de nomes
└── Resources/               JSON de dados e imagens

Scripts/                     sync_data.py (dados do thac0berry-data) e conversores antigos
Docs/                        documentação de apoio (ícones, dados, arte do ícone)
.github/workflows/           CI: typecheck/build iOS (macOS) e sincronia dos dados (Linux)
CLAUDE.md                    regras do projeto para agentes e desenvolvedores
TODO.md                      histórico detalhado de cada versão
```

## Desenvolvimento

Não há Mac no fluxo. A cada push, o CI no GitHub compila o app contra o SDK do iOS e
valida os dados. O teste final é no Swift Playgrounds do iPad. O ciclo completo
(branch, CI, pacote de teste, merge) está no `CLAUDE.md`.

## Próximos passos

- Backend e versão web compartilhando os dados de referência. A linguagem e a
  hospedagem ainda estão em avaliação.
- Versão (`schemaVersion`) no formato salvo das fichas.
- Tirar as regras de jogo das telas, para que possam ser reaproveitadas fora do iPad.
