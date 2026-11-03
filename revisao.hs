-- =====================================================
-- PIF - Aula 12 | Desafio 5: revisao de codigo
-- O estagiario da PontoCerto escreveu este arquivo, mas ele NAO CARREGA.
-- Ha exatamente 4 erros. Corrija cada um e explique em RESPOSTAS.md.
-- Nao altere o bloco main nem as funcoes marcadas como (correta).
-- =====================================================

-- (correta) Fabrica de campanhas de bonus.
campanhaBonus :: Int -> (Int -> Int)
campanhaBonus b = \p -> p + b

-- (correta) Pontos em dobro.
pontosEmDobro :: Int -> Int
pontosEmDobro = \p -> p * 2

-- Aplica a mesma regra duas vezes seguidas sobre o valor.
aplicaRegraDuasVezes :: Int -> Int -> Int
aplicaRegraDuasVezes regra valor = regra (regra valor)

-- Fim de semana: pontos multiplicados por 4.
fimDeSemana :: Int -> Int
fimDeSemana = \p => p * 4

-- Natal: bonus de 300 pontos.
natal :: Int -> Int
natal = campanhaBonus

-- A promocao atual da loja e a de pontos em dobro.
promocaoAtual :: Int -> Int
promocaoAtual = pontosEmDobro 100

main :: IO ()
main = do
  print (aplicaRegraDuasVezes pontosEmDobro 10)  -- esperado: 40
  print (fimDeSemana 25)                         -- esperado: 100
  print (natal 100)                              -- esperado: 400
  print (promocaoAtual 100)                      -- esperado: 200
