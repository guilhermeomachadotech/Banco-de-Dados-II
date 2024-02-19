USE bdEstoqueBD2

SELECT descricaoProduto,nomeFabricante FROM tbProduto
INNER JOIN tbFabricante ON tbProduto.codFabricante=tbFabricante.codFabricante

SELECT descricaoProduto, nomeFornecedor FROM tbProduto
INNER JOIN tbFornecedor ON tbProduto.codFornecedor=tbFornecedor.codFornecedor

SELECT SUM(quantidadeProduto) AS 'Soma das quantidades do produtos', nomeFabricante AS 'Nome do fabricante' FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante=tbProduto.codFabricante
GROUP BY nomeFabricante

SELECT valorTotalVenda AS 'Total de venda', nomeCliente AS 'Nome do cliente' FROM tbVenda
INNER JOIN tbCliente ON tbCliente.codCliente=tbVenda.codCliente

SELECT AVG(valorProduto) AS 'Média dos preços do produto', nomeFornecedor AS 'Nome do fornecedor' FROM tbProduto
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor=tbProduto.codFornecedor
GROUP BY nomeFornecedor

SELECT SUM(valorTotalVenda) AS 'Soma das vendas', nomeCliente AS 'Nome do Cliente' FROM tbVenda
INNER JOIN tbCliente ON tbCliente.codCliente=tbVenda.codCliente
GROUP BY nomeCliente
ORDER BY nomeCliente

SELECT SUM(valorProduto) AS 'Soma dos preços do produto', nomeFabricante AS 'Nome do fabricante' FROM tbProduto
INNER JOIN tbFabricante ON tbfabricante.codfabricante=tbProduto.codfabricante
GROUP BY nomefabricante

SELECT AVG (valorProduto) AS 'Média dos preços dos produtos', nomeFornecedor FROM tbProduto
INNER JOIN tbFornecedor ON tbFornecedor.codFornecedor=tbproduto.codFornecedor
GROUP BY nomeFornecedor

SELECT SUM(valorTotalVenda) AS 'Somas das vendas', descricaoProduto FROM tbVenda
INNER JOIN tbItensVenda ON tbVenda.codVenda=tbItensVenda.codVenda
INNER JOIN tbProduto ON tbItensVenda.codProduto=tbProduto.codProduto
GROUP BY descricaoProduto

SELECT SUM(valorTotalVenda) AS 'Soma das venda', nomeCliente FROM tbVenda
INNER JOIN tbCliente ON tbCliente.codCliente=tbVenda.codCliente
WHERE DATEPART(MONTH, dataVenda)=2 AND DATEPART(YEAR,dataVenda)=2014
GROUP BY nomeCliente