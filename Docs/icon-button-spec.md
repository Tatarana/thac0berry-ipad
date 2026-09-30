# THAC0berry — spec de ícones e botões pra geração de imagem

Documento de referência pra levar pra uma LLM de imagem. Cobre: os tokens visuais do app (cor, tipografia), a única arte ilustrada que já existe hoje, e cada ícone/botão que hoje é só um SF Symbol (glifo do sistema da Apple) dentro de uma forma desenhada em código — candidatos a virar imagem de verdade. Pra cada um: onde aparece, tamanho exato, cores exatas, e uma sugestão do que desenhar.

## 1. Linguagem visual do app

Duas "peles" convivem:

- **Pergaminho** (`Paper`) — dentro da Ficha, da Priest Spell Sheet, do Caderno, do Grimório. Fundo bege de papel envelhecido, tinta escura, valores escritos à mão em "caneta azul".
- **Couro & brasa** (`Ember`) — a navegação por fora das folhas: a nova Tela Principal, Campaigns, Characters, Compendium. Couro escuro quase preto com brilho de fogo vindo de cima e um segundo tom vinho por baixo.

Qualquer arte nova pros ícones grandes de navegação (Tela Principal) deve vestir a pele **couro & brasa**; ícones que vivem dentro de uma folha (ex.: dentro da Ficha) vestem **pergaminho**.

### Paleta — Couro & brasa (`Ember`)

| Token | Hex | Uso |
|---|---|---|
| `obsidian` | `#1B140F` | fundo base |
| `obsidianDeep` | `#100B08` | fundo mais escuro, cantos |
| `obsidianRaise` | `#251C15` | cartões (junto com `obsidianHighlight`) |
| `obsidianHighlight` | `#37312C` (aprox.) | face "de luz" dos cartões |
| `glow` | `#E0581E` | brasa/laranja principal |
| `glowBright` | `#FFB23C` | brasa mais clara, destaque |
| `brass` | `#C9A227` | latão/dourado, título, contorno |
| `brassDim` | `#8A712A` | latão apagado, linhas divisórias |
| `onObsidian` | `#EFE4D3` | texto claro sobre couro |
| `onObsidianSoft` | `#B8A690` | texto secundário sobre couro |
| `wine` | `#6B161A` | segundo tom, vinho profundo |
| `crimson` | `#CC3829` (aprox., 0.80/0.22/0.16) | tarja de personagem/HP |
| `amberAccent` | `#DB9E33` (aprox., 0.86/0.62/0.20) | tarja de campanha/contagem |
| `teal` | `#2E8C7A` (aprox., 0.18/0.55/0.48) | tarja de caderno/páginas/arcano |

### Paleta — Pergaminho (`Paper`)

| Token | Hex | Uso |
|---|---|---|
| `sheet` | `#E9DCBE` | fundo de página |
| `sheetDeep` | `#DBCAA5` | sombra/mancha do papel |
| `ink` | `#2F271C` | tinta escura, tarjas de título |
| `inkSoft` | `#6B5C46` | rótulos secundários |
| `penInk` | `#1E3557` | "caneta azul" — valores escritos |
| `redInk` | `#8C2F22` | correções, marcado como gasto |
| `chrome` | `#2D2119` | capa de couro ao redor da folha |
| `chromeDeep` | `#211712` | capa mais escura |

### Tipografia

- **Impresso** (rótulos, títulos de tarja): Baskerville / Palatino / Georgia (serifada).
- **Escrito à mão** (nomes, valores, magias): Bradley Hand / Noteworthy / Marker Felt.

Se a LLM de imagem gerar qualquer rótulo de texto dentro do ícone (evitar quando possível — ver seção 4), usar uma dessas duas famílias, nunca uma fonte de sistema genérica (Helvetica/Arial), que quebraria a identidade "ficha física".

## 2. Arte ilustrada já existente (referência de estilo)

`Resources/main_badge.png` — 793×559px, PNG com fundo transparente. Um dragão vermelho antropomórfico fardado de policial/xerife (boné azul com distintivo "2ed", óculos escuros dourados, farda azul-marinho com brasão dourado de dragão no peito), segurando uma espada numa mão e um revólver na outra, emoldurado por um brasão/medalhão dourado ornamentado com uma águia no topo. É o mascote do app, hoje usado como marca d'água grande (opacidade 10%) atrás da Tela Principal e da tela de Campaigns.

**Este arquivo não precisa ser refeito** — é a peça mais trabalhada que já existe e define o estilo: ilustração digital semi-realista, traço de história em quadrinhos/pulp americano, paleta quente (vermelho do dragão, dourado do brasão, azul-marinho da farda), acabamento de metal e couro gravado nos brasões. **Qualquer ícone novo pedido abaixo deve conversar com esse estilo** — mesma família de traço, mesmo peso de linha, mesma paleta dourado/vermelho/azul-marinho sobre fundo escuro — em vez de inventar uma linguagem visual nova.

## 3. Formato de entrega (pra todos os ícones abaixo)

- **PNG com fundo transparente**, sem moldura/círculo de fundo própria — o app já desenha o círculo/fundo/contorno/sombra em código ao redor da imagem (ver `RoundIconBadge`/`HomeIconTile`/`CompendiumTile` no código); a arte entregue é só o desenho central que vai DENTRO dessa moldura.
- **Canvas quadrado**, arte centralizada, com uma margem de respiro de uns 10-15% ao redor (o app pode aplicar seu próprio `padding`/recorte, mas centralizado facilita).
- **Resolução**: entregar no maior tamanho útil de cada grupo abaixo — o app photos redimensiona pra baixo sem perda visível; não vale a pena pedir em várias resoluções (@1x/@2x/@3x) pra um app só de iPad rodando local — um PNG grande (ex.: 512×512 pra ícones grandes, 256×256 pra médios) resolve.
- **Estilo**: ilustração colorida (não line art monocromático, não emoji, não flat design corporativo) — mesma linguagem do `main_badge.png` (seção 2).
- **Sem texto embutido na imagem** — todo rótulo (nome do ícone, contagem) já é desenhado em código por cima/ao lado; pedir a imagem SEM letras evita ficar ilegível em miniatura e problemas de fonte errada.

## 4. Inventário — o que pode virar imagem de verdade

Hoje cada um destes é um **SF Symbol** (glifo vetorial do sistema, sem cor própria — só herda uma cor sólida) dentro de uma forma desenhada em código (círculo, contorno). São os candidatos reais a virar ilustração — o resto do app (grades de círculo de slot, linhas pontilhadas, tarjas de texto) é desenho geométrico simples que não ganha nada virando imagem.

### 4.1 — Os três ícones grandes da Tela Principal (prioridade alta)

Maior peso visual do app — primeira coisa que a pessoa vê ao abrir. Hoje: círculo de 96×96pt, fundo `Paper.ink` (`#2F271C`), contorno `Paper.chromeDeep` 1.8pt, SF Symbol branco (`Paper.sheet`) de 46pt centralizado, sombra suave preta.

| Ícone | SF Symbol atual | O que desenhar |
|---|---|---|
| **Campaigns** | `map.fill` | Um mapa de campanha dobrado/enrolado, ou uma bússola sobre pergaminho — algo que fale "jornada/aventura em andamento", no mesmo dourado/vermelho-escuro do brasão do mascote. |
| **Characters** | `person.2.fill` | Um elenco de personagens — sugestão: um medalhão oval dourado (como um camafeu/broche) com a silhueta de um herói de fantasia dentro (capacete, ou um punho erguido com espada), não um personagem específico. |
| **Compendium** | `books.vertical.fill` | Uma pilha de grimórios/livros antigos amarrados com fita de couro, um deles entreaberto brilhando — ecoa o ícone do Grimório do Clérigo (4.3) só que com mais de um livro. |

### 4.2 — Ícone de Configurações (prioridade baixa — de propósito menor)

Hoje: `RoundIconBadge` estilo `.badge`, círculo 42×42pt, fundo `Paper.ink`, contorno `Paper.chromeDeep` 1.5pt, SF Symbol `gearshape.fill` branco 18pt.

Sugestão: uma engrenagem estilizada em latão gravado (mesma textura metálica dos brasões do mascote) — ou pode ficar como está; é um ícone secundário, sem urgência.

### 4.3 — Grimórios (dentro da tela Compendium)

Hoje: círculo 60×60pt, fundo `Paper.ink`, SF Symbol `book.closed.fill` branco 30pt, com um selo pequeno sobreposto (22×22pt) no canto inferior direito:

- **Priest Grimoire** — selo com `flame.fill` sobre fundo `Ember.glow` (`#E0581E`) — vela/chama, remete a clérigo/oração.
- **Mage Grimoire** (ainda "Coming soon", desabilitado) — selo com `sparkles` sobre fundo `Ember.teal` (`#2E8C7A`).

Sugestão: dois livros diferentes entre si (lombadas, cores de capa diferentes — o do Clérigo mais vermelho/dourado, o do Mago mais azul/arcano), cada um com seu próprio selo pequeno já embutido na ilustração (chama pro Clérigo, um símbolo arcano tipo runas/estrela pro Mago) — dispensaria o selo sobreposto em código.

### 4.4 — Botões de ação redondos (`RoundIconBadge`/`RoundIconButton`, prioridade baixa)

Família usada em vários cantos: "+" de nova campanha/personagem, voltar, arquivar. Dois estilos:

- **`.badge`** — círculo 42×42pt, fundo `Paper.ink`, ícone `Paper.sheet` 18pt, contorno `Paper.chromeDeep` 1.5pt, sombra leve.
- **`.paper`** — círculo 34×34pt, fundo branco 16% opaco, ícone `Paper.ink` 14pt, contorno `Paper.ink` 1.2pt, sem sombra.

São ações utilitárias repetidas dezenas de vezes na tela (cada linha de lista pode ter um "+"); **não são boas candidatas a ilustração única** — o valor de um SF Symbol aqui é justamente ficar pequeno e neutro sem chamar atenção. Deixar como está.

### 4.5 — Selo de sessão ativa (`SessionBadge`, prioridade média)

Hoje: círculo de 26pt (32pt quando selecionado), preenchido com a cor da sessão (uma de seis tons pastéis fixos), contorno `Paper.sheet` 85% opaco, SF Symbol `flag.fill` no centro.

Sugestão: um selo de cera (como os que fecham cartas antigas), na mesma cor da sessão, com uma bandeirinha ou runa simples gravada — mais "AD&D", menos ícone de app genérico.

### 4.6 — Selos de status de personagem (prioridade baixa)

Hoje são emoji de texto puro (não SF Symbol, não têm forma própria): 🩸 (morto) e 🔒 (arquivado/inativo), ao lado do nome no `CharacterCard`/`CampaignRow`.

Sugestão, se quiser trocar: dois selinhos pequenos (~16×16pt) no mesmo estilo de cera/metal do resto — uma caveira/gota de sangue gravada em vermelho-escuro pro morto, um cadeado gravado em latão pro arquivado — mas como aparecem bem pequenos ao lado de um nome escrito à mão, o ganho visual aqui é o menor de toda a lista.

## 5. O que **não** precisa de imagem nova

- **`DiceIconBadge`** (bolinhas de HP, contagem de sessões/páginas) — já passou por três rodadas de tentativa de virar ilustração de dado (contorno vetorial → faces sombreadas → PNG facetado) e todas leram como "lápide/caixão" em vez de dado sobre o fundo escuro. Hoje é só um círculo colorido com o número — funciona bem, não pedir arte nova aqui.
- **Grade de círculos de slot de magia** (`SlotCircle`/`SlotDot`), **linhas pontilhadas**, **tarjas de título** — desenho geométrico simples, não ganham nada virando imagem.
- **Abas pequenas da ficha** (`PaperTabIcon` — Sheet/Notebook/voltar, 38×30pt) — pequenas demais pra ilustração render, ficariam ilegíveis.

## 6. Ordem de prioridade sugerida

1. Os três ícones grandes da Tela Principal (4.1) — maior impacto visual, primeira tela do app.
2. Os dois grimórios do hub de Compendium (4.3) — segunda tela mais visitada.
3. Selo de sessão ativa (4.5).
4. Ícone de Configurações (4.2).
5. Selos de status de personagem (4.6) e botões de ação redondos (4.4) — opcional, baixo retorno visual.
