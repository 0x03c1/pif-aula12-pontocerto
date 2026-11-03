# Revisão da Aula 12 — Funções de primeira classe e lambdas

Resumo do que vimos em sala, para consultar durante a atividade.

## 1. O que é "primeira classe"

Uma função é **cidadã de primeira classe** quando tem os mesmos direitos de qualquer outro valor, como um `Int` ou uma string. Ela pode ser:

1. guardada numa variável;
2. passada como argumento para outra função;
3. retornada como resultado de outra função;
4. colocada dentro de uma lista ou estrutura.

## 2. Guardar uma função numa variável

```haskell
dobro :: Int -> Int
dobro x = x * 2

minhaOperacao :: Int -> Int
minhaOperacao = dobro      -- a variável guarda a PRÓPRIA função
```

`minhaOperacao 5` dá `10`. Atenção: `minhaOperacao = dobro 5` guardaria o **número** 10, não a função.

## 3. Passar uma função como argumento

```haskell
aplica :: (Int -> Int) -> Int -> Int
aplica f x = f x

aplica dobro 5            -- 10
```

A mesma `aplica` funciona com qualquer operação que você passar. Isso elimina repetição.

## 4. Ler uma assinatura de ordem superior

```text
(Int -> Int)   ->   Int    ->   Int
 1º argumento      2º arg.      retorno
 (uma função)      (um Int)     (um Int)
```

- O **último** tipo é sempre o retorno. Os anteriores são os argumentos.
- **Parênteses agrupam uma função** recebida como argumento.

## 5. Retornar uma função

```haskell
multiplicador :: Int -> (Int -> Int)
multiplicador n = \x -> x * n

dobra = multiplicador 2      -- dobra é uma FUNÇÃO
triplica = multiplicador 3

dobra 10      -- 20
triplica 10   -- 30
```

`multiplicador 2` não devolve um número: devolve uma **nova função** que multiplica por 2.

## 6. Lambdas (funções anônimas)

```haskell
-- função nomeada:
dobro x = x * 2

-- a mesma coisa, anônima (lambda):
\x -> x * 2

-- usando direto (a lambda vai entre parênteses):
aplica (\x -> x * 2) 5     -- 10
```

Lê-se "recebe x, devolve x * 2". A `\` lembra a letra grega λ.

Em outras linguagens: `lambda x: x*2` em Python, `x => x*2` em JavaScript e `x -> x*2` em Java. **Em Haskell é `\x -> x * 2`.**

## 7. Nomeada ou lambda?

| Use função nomeada quando... | Use lambda quando... |
|---|---|
| é usada em vários lugares | é usada uma única vez |
| a lógica é mais longa | é curta e óbvia |
| merece um nome que explique | é passada direto a outra função |

Se a lambda ficou longa ou você precisa parar para entendê-la, ela provavelmente merece um nome.

## 8. E em C? Ponteiros para função

```c
int aplica(int (*f)(int), int x) {
    return f(x);              // chama a função apontada
}

int dobro(int x) { return x * 2; }

int main(void) {
    printf("%d\n", aplica(dobro, 5));   // 10
}
```

`int (*f)(int)` é "ponteiro para função que recebe `int` e devolve `int`". É assim que C implementa *callbacks*. C clássico não tem lambdas.

## 9. Ache o bug (exemplo da aula)

```haskell
aplicaDuasVezes :: Int -> Int -> Int      -- ERRADO
aplicaDuasVezes f x = f (f x)
```

A assinatura diz que o primeiro argumento é um `Int`, mas o código usa `f` como função. O correto é `(Int -> Int) -> Int -> Int`.

## 10. Erros comuns

- Escrever `Int` onde o argumento é uma função (`(Int -> Int)`).
- Esquecer os parênteses ao agrupar a função na assinatura.
- Confundir `multiplicador 2` (uma função) com um número.
- Escrever lambdas longas e ilegíveis em vez de dar um nome.
- Em C: errar a sintaxe do ponteiro para função (`int (*f)(int)`).

## 11. Boas práticas

- Sempre escreva a assinatura de tipo: ela documenta e evita confusão.
- Leia assinaturas da direita para a esquerda: o último tipo é o retorno.
- Use lambdas para o que é curto e descartável. Dê nome ao resto.
- Pense em "funções que fabricam funções" para eliminar repetição.
- Teste no `ghci` passo a passo, conferindo o tipo com `:t`.

## 12. Comandos do ghci

| Comando | O que faz |
|---|---|
| `ghci arquivo.hs` | Abre o ghci carregando o arquivo |
| `:r` | Recarrega depois de salvar |
| `:t expr` | Mostra o tipo de uma expressão |
| `main` | Roda os testes do arquivo |
| `:q` | Sai |
