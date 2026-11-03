# Programa de Pontos PontoCerto: regras que viram valores

**Programação Imperativa e Funcional · Aula 12 · Funções de primeira classe e lambdas**
Bacharelado em Sistemas de Informação · 2º período · Prof. Roni Maciel

| Valor | Duração | Formato | Entrega |
|---|---|---|---|
| **1,0 ponto** | cerca de 65 minutos | Em duplas (*pair programming*) | Pelo seu **fork** deste repositório, até **21h50** |

## 1. Contextualização

A **PontoCerto** é uma startup que desenvolve o sistema de fidelidade de uma rede de supermercados. A regra básica é simples: **cada R$ 1,00 gasto vale 1 ponto**.

O problema é o setor de marketing. Toda semana surge uma campanha nova: "pontos em dobro", "ganhe 50 pontos de bônus", "Black Friday com pontos multiplicados por 5"... Hoje, cada campanha exige que alguém escreva uma função nova de cálculo, quase igual à anterior. O código está cheio de repetição, e cada mudança leva dias.

A equipe técnica decidiu mudar a estratégia: **a regra da campanha passará a ser um valor**. Ela será guardada em variáveis, entregue a uma função genérica de cálculo e até fabricada por outras funções. Vocês foram contratados para construir esse núcleo do sistema, revisar o código de um estagiário e adaptar a ideia ao módulo antigo, escrito em C.

> Lembre da analogia da aula: em vez de entregar só o bolo pronto (os pontos calculados), vocês vão passar a **própria receita** (a regra) de mão em mão.

## 2. Objetivo

Ao final da atividade, a dupla deverá ser capaz de:

1. **guardar** funções em variáveis, inclusive lambdas;
2. **passar** uma função como argumento para outra função;
3. **escrever funções que devolvem funções** ("fábricas de funções");
4. **ler, escrever e corrigir assinaturas de tipo** como `(Int -> Int) -> Int -> Int`;
5. **reconhecer a mesma ideia em C**, com ponteiros para função;
6. **explicar** por que tratar comportamento como dado evita repetição de código.

## 3. Antes de começar (10 min)

### 3.1 Fork e dupla no GitHub

1. **Integrante 1** abre https://github.com/0x03c1/pif-aula12-pontocerto, clica em **Fork** e depois em **Create fork**. O fork fica em `https://github.com/SEU-USUARIO/pif-aula12-pontocerto`.
2. No fork, o integrante 1 vai em **Settings → Collaborators → Add people** e adiciona o usuário do **integrante 2**.
3. O **integrante 2** aceita o convite pelo e-mail ou em `https://github.com/notifications`.
4. Preencham a tabela "Dupla" do arquivo `RESPOSTAS.md` e façam o primeiro commit, com a mensagem `Dupla: nomes dos integrantes`.

Não é preciso abrir *Pull Request*. O professor acompanha os forks diretamente.

### 3.2 Como editar e salvar (commit)

Escolham **uma** das opções.

| Opção | Precisa instalar? | Como fazer |
|---|---|---|
| **A. Pelo navegador** (mais simples) | Nada | No fork, abram o arquivo, cliquem no **lápis** (*Edit this file*), editem e cliquem em **Commit changes**. Escrevam a mensagem do commit e confirmem. |
| **B. Pelo terminal** | Git | `git clone https://github.com/SEU-USUARIO/pif-aula12-pontocerto.git`, editem os arquivos e rodem `git add .`, `git commit -m "D1: regras em variaveis"` e `git push`. |

Se o `git push` pedir usuário e senha e não funcionar, usem a opção A. O GitHub não aceita a senha da conta no terminal.

### 3.3 Como executar o código

| Linguagem | Sem internet | Online |
|---|---|---|
| Haskell (`fidelidade.hs`, `revisao.hs`) | `ghci fidelidade.hs`. Dentro do `ghci`: `main` roda os testes, `:r` recarrega depois de salvar, `:t expr` mostra o tipo, `:q` sai | `https://play.haskell.org`: colem o arquivo **inteiro** e cliquem em **Run** |
| C (`pontocerto.c`) | `cc pontocerto.c -o pontocerto` e depois `./pontocerto` (ou `gcc` no lugar de `cc`) | `https://www.onlinegdb.com`: escolham a linguagem **C**, colem o arquivo e cliquem em **Run** |

> O bloco `main` dos arquivos Haskell serve apenas para rodar os testes. Vocês não precisam entender `main`, `do`, `print` ou `putStrLn` agora.

### 3.4 Regras de trabalho e de commit

- **Escrevam a assinatura de tipo de todas as funções Haskell.** Ela faz parte da avaliação.
- Façam os desafios **na ordem**, testando cada função assim que terminarem.
- Façam **pelo menos um commit por desafio**, com a mensagem começando pelo número: `D1: ...`, `D2: ...`, até `D6: ...`.
- **Troquem de papel a cada desafio:** quem digita em um desafio revisa no seguinte. Os **dois integrantes** devem aparecer como autores de commits.
- Os forks são públicos, e o histórico mostra quem escreveu cada parte. Cada integrante vai explicar o próprio código ao professor.

## 4. Desafios práticos

Tempo sugerido: D1 (5 min) · D2 (7 min) · D3 (8 min) · D4 (8 min) · D5 (12 min) · D6 (10 min) · entrega (5 min).

### Desafio 1 — Regras guardadas em variáveis (`fidelidade.hs`)

O marketing tem três regras. Cada uma recebe os pontos base (`Int`) e devolve os pontos finais (`Int`).

| Nome | Regra | Como deve ser escrita |
|---|---|---|
| `semCampanha` | Os pontos ficam iguais ao valor da compra | Função nomeada comum, com parâmetro |
| `pontosEmDobro` | Os pontos dobram | **Uma lambda guardada em uma variável** |
| `bonus50` | Somam-se 50 pontos de bônus | **Uma lambda guardada em uma variável** |

Depois, criem a variável **`campanhaDaSemana`**, que deve **ser** a regra `pontosEmDobro`. Não escrevam nenhuma conta nova nela: atribuam a função que já existe.

As três regras e `campanhaDaSemana` têm a assinatura `Int -> Int`. Exemplo do formato esperado, com uma regra que não faz parte do desafio:

```haskell
menos10 :: Int -> Int
menos10 = \p -> p - 10
```

Confiram com `:t campanhaDaSemana`. A resposta deve ser `campanhaDaSemana :: Int -> Int`.

### Desafio 2 — Uma função que recebe a regra (`fidelidade.hs`)

Em vez de uma função de cálculo para cada campanha, o sistema terá **uma só**: `calculaPontos`.

- Ela recebe **dois argumentos**: a regra da campanha (uma função) e o valor da compra (um `Int`).
- Ela devolve os pontos que o cliente ganha, aplicando a regra ao valor.
- **Vocês devem escrever a assinatura.** Qual é o tipo do primeiro argumento?

Depois de testar `calculaPontos` com as regras do Desafio 1, simulem duas promoções que **só vão durar um dia** usando **lambdas passadas direto** para `calculaPontos`, sem criar funções nomeadas. Escrevam as duas chamadas no bloco `main`.

1. **Promoção Relâmpago:** pontos triplicados. Compra de R$ 80.
2. **Quarta Verde:** pontos em dobro **e mais** 10 pontos. Compra de R$ 80.

**Pergunta D2 (em `RESPOSTAS.md`):** por que, nessas promoções, faz sentido usar uma lambda em vez de criar uma função nomeada?

### Desafio 3 — Fábrica de campanhas (`fidelidade.hs`)

O marketing sempre pede variações: "multiplica por 3", "multiplica por 5", "bônus de 100", "bônus de 200"... Em vez de escrever uma função para cada número, criem **funções que fabricam regras**:

1. **`campanhaMultiplicadora`**: recebe um fator `n` (`Int`) e **devolve uma regra** que multiplica os pontos por `n`.
2. **`campanhaBonus`**: recebe uma quantidade `b` (`Int`) e **devolve uma regra** que soma `b` aos pontos.

Usem as fábricas para criar e guardar em variáveis:

- **`blackFriday`**: pontos multiplicados por 5;
- **`aniversarioCliente`**: bônus de 200 pontos.

Escrevam as assinaturas de todas elas e testem as regras fabricadas com `calculaPontos`. No `ghci`, verifiquem `:t campanhaMultiplicadora 5` e `:t blackFriday`.

**Pergunta D3:** o que `campanhaMultiplicadora 5` devolve? Um número ou outra coisa? Como o `:t` confirma isso?

### Desafio 4 — Campanhas acumuladas (`fidelidade.hs`)

Na Black Friday, a cliente Ana fez uma compra de **R$ 150**, e hoje também é o **aniversário** dela. As duas campanhas valem ao mesmo tempo.

Escrevam **`acumula`**, com assinatura. A função recebe **duas regras** e o **valor da compra**, aplica a primeira regra ao valor e, em seguida, aplica a segunda regra ao resultado. Depois:

1. calculem os pontos de Ana aplicando primeiro `blackFriday` e depois `aniversarioCliente`;
2. calculem de novo, invertendo a ordem;
3. simulem a **Semana do Cliente** (pontos triplicados e depois bônus de 100) para uma compra de R$ 60, usando `acumula` com **uma regra fabricada no Desafio 3 e uma lambda**. Escrevam essa chamada no `main`.

**Perguntas D4:**

- **a)** Por que os itens 1 e 2 dão resultados diferentes?
- **b)** O marketing decidiu que o bônus de aniversário **não pode ser multiplicado**. Qual ordem o sistema deve usar? Por quê?

### Desafio 5 — Revisão de código (`revisao.hs`)

O estagiário da PontoCerto escreveu `revisao.hs`, mas o arquivo **não carrega**. Há **exatamente 4 erros**, parecidos com os do slide "Ache o bug" e com a lista de erros comuns da aula. O comentário acima de cada função diz o que ela deveria fazer.

1. Abram o arquivo no `ghci` e leiam a mensagem de erro com calma.
2. Corrijam **um erro por vez**. Recarreguem com `:r` e vejam a próxima mensagem.
3. Não alterem o bloco `main` nem as funções marcadas como `(correta)`.
4. Quando o arquivo carregar, rodem `main` e confiram as saídas esperadas que aparecem nos comentários.
5. Preencham a tabela do Desafio 5 em `RESPOSTAS.md`.

### Desafio 6 — O módulo legado em C (`pontocerto.c`)

Parte do sistema antigo é escrita em C. Reescrevam a ideia usando **ponteiros para função**, como no slide "E em C? Ponteiros para função":

1. `int pontosEmDobro(int p)` e `int bonus50(int p)`;
2. `int calculaPontos(int (*regra)(int), int valor)`, que aplica a regra ao valor;
3. `int acumula(...)`, que recebe **dois** ponteiros para função e o valor. Ela aplica a primeira regra e depois a segunda. Vocês devem escrever os parâmetros.

Descomentem as linhas do `main` e confiram as saídas.

**Pergunta D6:** citem duas diferenças entre o `calculaPontos` em Haskell e em C.

## 5. Testes

| Desafio | Expressão | Resultado esperado |
|---|---|---|
| 1 | `semCampanha 120` | `120` |
| 1 | `pontosEmDobro 120` | `240` |
| 1 | `bonus50 120` | `170` |
| 1 | `campanhaDaSemana 120` | `240` |
| 2 | `calculaPontos semCampanha 80` | `80` |
| 2 | `calculaPontos pontosEmDobro 80` | `160` |
| 2 | `calculaPontos bonus50 80` | `130` |
| 2 | Promoção Relâmpago, compra de 80 | `240` |
| 2 | Quarta Verde, compra de 80 | `170` |
| 3 | `calculaPontos blackFriday 150` | `750` |
| 3 | `calculaPontos aniversarioCliente 150` | `350` |
| 3 | `calculaPontos (campanhaMultiplicadora 4) 25` | `100` |
| 3 | `calculaPontos (campanhaBonus 30) 25` | `55` |
| 3 | `:t blackFriday` | `blackFriday :: Int -> Int` |
| 4 | `acumula blackFriday aniversarioCliente 150` | `950` |
| 4 | `acumula aniversarioCliente blackFriday 150` | `1750` |
| 4 | Semana do Cliente, compra de 60 | `280` |
| 5 | `main` de `revisao.hs` | `40`, `100`, `400` e `200`, um por linha |
| 6 | Saída de `pontocerto.c` | `160`, `130`, `250` e `300`, um por linha |

> Obter a saída certa não basta. O professor vai pedir que vocês expliquem **como** o código chega a esse resultado.

## 6. Entrega (até 21h50)

Antes do horário, confiram no **seu fork**, pelo navegador:

- [ ] `fidelidade.hs` com os Desafios 1 a 4, assinaturas em todas as funções e os testes descomentados;
- [ ] `revisao.hs` corrigido e carregando sem erros;
- [ ] `pontocerto.c` compilando e imprimindo os valores esperados;
- [ ] `RESPOSTAS.md` completo: dupla, explicação, respostas D2 a D6 e as três saídas coladas em "Evidência de execução";
- [ ] pelo menos um commit por desafio (`D1:` a `D6:`), com os **dois integrantes** como autores;
- [ ] o último commit enviado (*push*) até **21h50**. Commits depois desse horário não serão considerados.

Durante a atividade, o professor passará pelas duplas e pedirá que **cada integrante** explique uma parte do código, em 1 a 2 minutos.

## 7. Critérios de avaliação (1,0 ponto)

| Critério | O que será observado | Valor |
|---|---|---|
| Compreensão dos conceitos | `RESPOSTAS.md`: explicação da solução e respostas D2 a D6, incluindo a tabela de erros do D5 | 0,2 |
| Aplicação de funções de primeira classe | Haskell (D1 a D4): funções em variáveis, como argumento e como retorno, com assinaturas corretas (0,2). C (D6): ponteiros para função (0,1) | 0,3 |
| Uso adequado de lambdas | Lambdas guardadas em variáveis (D1), passadas direto (D2 e D4) e devolvidas pelas fábricas (D3), curtas e legíveis | 0,2 |
| Funcionamento da solução | Os três arquivos carregam ou compilam e produzem os resultados da seção 5 | 0,15 |
| Explicação oral (individual) | Explicação de uma parte do código escolhida pelo professor | 0,1 |
| Entrega pelo GitHub | Fork com `RESPOSTAS.md` preenchido, um commit por desafio, commits dos dois integrantes, prazo respeitado | 0,05 |
| **Total** | | **1,0** |

A explicação oral é individual. Os demais critérios valem para a dupla.

Bom trabalho!
