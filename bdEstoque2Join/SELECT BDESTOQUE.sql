USE bd2Estoque

--1 Questão
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
INNER JOIN tbProduto ON tbProduto.codFornecedor=tbFornecedor.codFornecedor

--2 Questão
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
LEFT JOIN tbProduto On tbProduto.codFornecedor=tbFornecedor.codFornecedor

SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
RIGHT JOIN tbProduto On tbProduto.codFornecedor=tbFornecedor.codFornecedor

--3 Questão
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
FULL JOIN tbProduto ON tbProduto.codFornecedor=tbFornecedor.codFornecedor

--4 Questão
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
CROSS JOIN tbProduto
--R: Foram 78 registros. Ela distribuiu todos os produtos para cada fornecedor, até aqueles que não forneceram produtos.

--Questões de subQueries

--1 Questão

Select codProduto, descricaoProduto, nomeFabricante, MAX(valorProduto) AS' Valor Maximo' From tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante=tbProduto.codFabricante
WHERE valorProduto='Valor Maximo'
GROUP BY codProduto, descricaoProduto, nomeFabricante