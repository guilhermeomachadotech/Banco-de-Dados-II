USE bdLivrariaBrasileira
--a) O total de livros que começam com a letra P
SELECT COUNT (codLivro)AS 'Total de livros que começam com a letra P' FROM tbLivro
WHERE nomeLivro LIKE 'P%'

--b) O maior número de páginas entre todos os livros
SELECT MAX (numPaginas)AS 'Maior número de páginas de todos os livros' FROM tbLivro

--c) O menor número de páginas entre todos os livros
SELECT MIN (numPaginas) AS 'Menor número de páginas entre todos os livros' FROM tbLivro

--d) A média de páginas entre todos os livros
SELECT AVG (numPaginas) AS 'Média de páginas' FROM tbLivro

--e) A soma do número de páginas dos livros de editora código 01
SELECT SUM (numPaginas) AS 'Soma do número de páginas dos livros da editora'FROM tbLivro
WHERE codEditora=1

--f) A soma dos números de páginas dos livros que começam com a letra A
SELECT SUM (numPaginas) AS 'Soma dos números dos livros que começam com a letra A'FROM tbLivro
WHERE nomeLivro LIKE 'A%'

--g) A média dos números de páginas dos livros que sejam do autor código 03
SELECT AVG (numPaginas) AS 'Média dos números de páginas dos livros do autor de código 03' FROM tbLivro
WHERE codAutor=3

--h) A quantidade de livros da editora de código 04
SELECT COUNT (codLivro) AS 'Quantidade de livros da editora de código 04' FROM tbLivro
WHERE codEditora=4

--i) A média do número de páginas dos livros que tenham a palavra “estrela” em seu nome
SELECT AVG (numPaginas) AS 'Média do número de páginas dos livros com a palavra "estrela" em seu nome'FROM tbLivro
WHERE nomeLivro LIKE '%estrela%'

--j) A quantidade de livros que tenham a palavra “poema” em seu nome
SELECT COUNT (codLivro) AS 'Quantidade de livros que tenham a palavra "poema" em seu nome' FROM tbLivro
WHERE nomeLivro LIKE '%poema%'

--k) A quantidade de livros agrupado pelo nome do gênero
SELECT COUNT (codLivro) AS 'Quantidades de livros', nomeGenero AS 'Nome do gênero'FROM tbLivro
INNER JOIN tbGenero ON tbGenero.codGenero=tbLivro.codGenero
GROUP BY nomeGenero

--l) A soma das páginas agrupadas pelo nome do autor
SELECT SUM(numPaginas) AS 'Soma das páginas', nomeAutor AS 'Nome do autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor=tbLivro.codAutor
GROUP BY nomeAutor

--m)A média de páginas agrupada pelo nome do autor em ordem alfabética(de A a Z)
SELECT AVG (numPaginas) AS 'Média de páginas', nomeAutor 'Nome do autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor=tbLivro.codAutor
GROUP BY nomeAutor
ORDER BY nomeAutor

--n)A quantidade de livros agrupada pelo nome da editora em ordem alfabética inversa (de Z a A)
SELECT COUNT (codLivro) AS 'Quantidades de livros', nomeEditora 'Nome da editora' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora=tbLivro.codEditora 
GROUP BY nomeEditora
ORDER BY nomeEditora DESC

--o) A soma das páginas dos livros agrupados pelo nome do autor que sejam de autores cujo nome comece com a letra "C"
SELECT SUM (numPaginas) As 'Soma das páginas', nomeAutor AS 'Nome do autor'FROM TbLivro
INNER JOIN tbAutor ON tbAutor.codAutor=tbLivro.codAutor
WHERE nomeAutor LIKE 'C%'
GROUP BY nomeAutor

--p)A quantidade de livros agrupados pelo nome do autor, cujo nome do autor seja "Machado de Assis" ou "Cora Coralina" ou "Graciliano Ramos" ou "Clarice Lispector"
SELECT COUNT (codLivro) AS 'Quantidades de livros', nomeAutor AS 'Nome do autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor=tbLIvro.codAutor
WHERE nomeAutor LIKE 'Machado de Assis' OR nomeAutor LIKE 'Cora Coralina' OR nomeAutor LIKE 'Graciliano Ramos' OR nomeAutor LIKE 'Clarice Lispector'
GROUP BY nomeAutor

--q)A soma das páginas dos livros agrupadas pelo nome da editora cujo número de páginas esteja entre 200 e 500 (inclusive)
SELECT SUM(numPaginas) AS 'Soma das páginas', nomeEditora AS 'Nome da editora' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora=tbLivro.codEditora
WHERE numPaginas BETWEEN 200 AND 500
GROUP BY nomeEditora

--r)Os nomes dos livros ao lado do nome das editoras e do nome dos autores
SELECT nomeLivro AS 'Nomes dos livros', nomeEditora AS 'Nomes das editoras', nomeAutor AS 'Nomes dos autores' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora=tbLivro.codEditora
INNER JOIN tbAutor ON tbAutor.codAutor=tbLivro.codAutor

--s)O nome dos livros ao lado do nome do autor somente daqueles cujo nome da editora for "Cia das Letras"
SELECT nomeLivro AS 'Nome do Livro', nomeAutor AS 'Nome do autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor=tbLivro.codAutor
INNER JOIN tbEditora ON tbEditora.codEditora=tbLivro.codEditora
WHERE nomeEditora LIKE 'Cia das Letras'

--t)O nome dos livros ao lado dos nomes dos autores, somente dos livros que não forem do autor 'Érico Veríssimo'
SELECT nomeLivro AS 'Nome dos livros', nomeAutor AS 'Nome dos autores' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor=tbLivro.codAutor
WHERE nomeAutor NOT LIKE 'Érico Veríssimo'

--u)Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles autores que não tem livros cadastrados
SELECT nomeAutor AS 'Nomes dos autores', nomeLivro AS 'Nome dos livros' FROM tbAutor
LEFT JOIN tbLivro ON tbLivro.codAutor=tbAutor.codAutor

--v)Os nomes dos autores ao lado dos nomes dos livros inclusive daqueles livros que não tem autores cadastrados
SELECT nomeAutor AS 'Nomes dos autores', nomeLivro AS 'Nomes dos livros' FROM tbAutor
RIGHT JOIN tbLivro ON tbLivro.codAutor=tbAutor.codAutor

--w)O nome dos autores ao lado dos nomes dos livros, indiferente do autor ter ou não livro publicado, e indiferente do livro pertencer a algum autor
SELECT nomeAutor AS 'Nomes dos autores', nomeLivro AS 'Nomes dos livros' FROM tbAutor
FULL OUTER JOIN tbLivro ON tbLivro.codAutor=tbAutor.codAutor

--x)A editora Ática irá publicar todos os títulos dessa livraria.Criar um select que associe os nomes de todos os livros ao lado do nome da editora Ática.
SELECT nomeLivro AS 'Nomes dos livros', nomeEditora AS 'Nome da editora' FROM tbLivro
CROSS JOIN tbEditora
WHERE tbEditora.codEditora=3

--y)Somente os nomes dos autores que não tem livros cadastrados
SELECT nomeAutor AS 'Nomes dos autores', codLivro AS 'Livro cadastrado' FROM tbAutor
LEFT JOIN tbLivro ON tbLivro.codAutor=tbAutor.codAutor
WHERE tbLivro.codAutor is NULL

--z)Os nomes dos gêneros que não possuem nenhum livro cadastrado
SELECT nomeGenero AS 'Nome do Gênero', codLivro AS 'Livro cadastrado' FROM tbGenero
LEFT JOIN tbLivro ON tbLivro.codGenero=tbGenero.codGenero
WHERE tbLivro.codGenero IS NULL