# THAC0berry

Ficha de personagem de **AD&D 2ª edição** para iPad, pensada para a Apple Pencil.
Substitui a ficha de papel no que ela é pior: controlar slots de magia dia após dia
e registrar o que foi conjurado sem parar o jogo.

Projeto irmão do [Just Pencil It](https://github.com/Tatarana/Justpencilit) — apps
separados, com a base técnica (canvas PencilKit, proteção de dados) clonada de lá.

## Duas folhas, não uma tela

O app é uma pasta de folhas, como a de mesa:

**Folha 1 — a ficha do personagem**, no arranjo da ficha oficial de AD&D 2e:
atributos com os ajustes derivados ao lado (acerto e dano da Força, defesa da
Destreza, choque e ressurreição da Constituição, magias bônus da Sabedoria…),
tabela de armas com THAC0 e dano P/M e G, jogadas de proteção, equipamento com
peso, proficiências, perícias, idiomas, itens mágicos, aliados e tesouro em
moedas.

**Folha 2 em diante — uma folha de magias por dia de jogo.** Esta é a diferença
que muda o modelo de dados: em 2e os slots zeram no repouso, então a memorização
não é um atributo permanente do personagem — é o preenchimento de um dia. Cada
folha tem seus próprios slots e seu próprio registro, no formato do registro
oficial: um quadro por círculo, bolinhas de slot no cabeçalho e a tabela do que
está memorizado com iniciativa, alcance, duração, resistência e componentes.
Começar uma folha nova herda a mesma quantidade de slots do dia anterior, já
zerados — que é o que o repouso faz na regra. As folhas antigas ficam guardadas:
dá para folhear a campanha inteira e ver o que o clérigo levava preparado no dia
da emboscada.

As abas de papel no alto trocam de folha.

## Como a ficha se parece

O app não usa `Form`, `List` nem controles padrão do iOS: a tela **é** a folha.
Pergaminho com grão, tarjas de título em tinta escura, rótulos em versalete
serifado e todos os valores em letra de mão, caneta azul. Slots de magia são
bolinhas que ganham um ✕ vermelho quando gastas; pontos de vida são caixinhas
que se preenchem ao toque; magias já conjuradas aparecem riscadas na lista.
Tocar em qualquer valor abre um balão pequeno onde a Apple Pencil escreve por
cima — nunca uma célula de formulário.

Em paisagem, as três colunas da ficha impressa; em retrato, a mesma folha
rolando de cima para baixo.

Na primeira execução a pasta já vem com **Kelmon**, clérigo humano de 11º nível,
com a ficha preenchida e duas folhas de magia (o 2º e o 3º dia em Elturel) — dá
para ver o app cheio antes de criar sua ficha.

## O que a v1 faz

**Ficha** — atributos (com força excepcional), PV atual/máximo, CA, THAC0,
movimento, equipamento, as cinco categorias de jogada de proteção, nível e XP.

**Slots de magia** — por círculo, dentro da folha do dia, separados entre mago e
sacerdote. Cada slot guarda uma magia específica; um toque na bolinha risca o
slot, e tocar no nome troca a magia memorizada.

**Registro do dia** — você escreve o nome da magia com a Apple Pencil, o app
reconhece, sugere candidatos da base embutida e, depois da sua confirmação, grava
a linha e risca sozinho o slot correspondente. Cada linha aceita uma anotação
livre e um valor de XP.

## Como o reconhecimento funciona

O app **não** roda OCR em cima da tinta. Ele usa o Scribble nativo do iPadOS: a linha
de escrita é um campo de texto onde você escreve com a caneta e o sistema converte
com o mesmo motor de reconhecimento da Apple — mais preciso que qualquer OCR
próprio, principalmente com nomes que não são palavras comuns. O teclado de software
fica desligado por padrão (há um botão para ligá-lo).

O texto reconhecido passa por um casamento aproximado (`Utils/Fuzzy.swift`):
distância de edição, bônus para prefixo e reconhecimento de iniciais — "mm" acha
*Magic Missile*. O app **nunca** grava sem confirmação: ele lista candidatos com um
selo de confiança e você escolhe.

## Base de magias

`Resources/spells.json` traz 62 magias: mago nos círculos 1 a 3 e sacerdote nos
círculos 1 a 6, com os dados mecânicos do cabeçalho de cada descrição.

⚠️ **Confira os valores contra o seu PHB antes de usar em mesa.** Os dados foram
montados de memória, sem acesso ao livro — o dano de *Burning Hands* em especial
merece uma olhada. O arquivo é JSON puro: para corrigir ou adicionar magias, basta
editá-lo mantendo as mesmas chaves.

Círculos de mago acima do 3º e de sacerdote acima do 6º funcionam na grade de
slots, mas ainda não têm magias na base — nesses, use o nome livre.

## Rodando no iPad

1. Abra o **Swift Playgrounds** e importe `THAC0berry.swiftpm`.
2. Rode. Requer iPadOS 17 ou superior.

Não precisa de Mac. Para publicar na App Store depois, será preciso o Apple
Developer Program.

## Estrutura

```
THAC0berry.swiftpm/
├── Package.swift            App Playground, produto .iOSApplication
├── App.swift                ponto de entrada, injeta os dois stores
├── Models/
│   ├── Character.swift      personagem, atributos, saves, armas, tesouro
│   ├── SpellSheet.swift     a folha de magias de um dia e o registro
│   ├── SampleCharacter.swift  Kelmon, clérigo 11 de exemplo
│   └── Spell.swift          magia da base
├── Store/
│   ├── CharacterLibrary.swift  persistência em JSON com Data Protection
│   └── SpellDatabase.swift     carga do spells.json e busca aproximada
├── Views/
│   ├── PaperTheme.swift           pergaminho, tinta, tipografia, peças da ficha
│   ├── PaperFields.swift          valores editáveis em letra de mão
│   ├── CharacterListView.swift    a pasta de fichas
│   ├── CharacterSheetView.swift   abas de papel + a ficha oficial
│   ├── SpellSheetView.swift       a folha de magias de um dia
│   ├── HandwritingField.swift     campo Scribble para a caneta
│   └── InkCanvasView.swift        canvas PencilKit
├── Utils/
│   └── Fuzzy.swift          normalização e casamento aproximado
└── Resources/
    └── spells.json
```

## Dados e segurança

Tudo fica local, em `characters.json` no diretório Documents do app, gravado com a
proteção de dados nativa do iOS na classe `.completeUnlessOpen` — mesma decisão do
Just Pencil It, sem criptografia própria por cima.

Sincronização via iCloud ainda não está ligada nesta versão.

## Próximos passos

- Regra de cálculo automático de XP (a definir com a mesa).
- Sincronização iCloud/CloudKit.
- Modo do mestre: campanha com vários personagens.
- Encerrar a folha do dia com um "repouso" que já cria a próxima.
- Completar a base de magias (mago 4-9).
- Encumbrance e ataques por rodada.
