USE bdEstoque

--1)Criar uma consultanque retorne o c�digo de produto, o nome do produto e o nome do fabricante somente daqueles produtos que custam igual ao valor mais alto;
SELECT codProduto, descricaoProduto, nomeFabricante FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante=tbProduto.codFabricante
WHERE valorProduto IN (SELECT MAX(valorProduto) FROM tbProduto)

--2)Criar uma consulta que retorne o nome do produto e o nome do fabricante e o valor somente dos produtos que custem acima do valor m�dio dos produtos do estoque
SELECT descricaoProduto, nomefabricante, valorProduto FROM tbProduto
INNER JOIN tbFabricante ON tbFabricante.codFabricante=tbProduto.codFabricante
WHERE valorProduto>(SELECT AVG(valorProduto) FROM tbProduto)

--3)Criar uma consulta que retorne o nome dos clientes que tiveram vendas com valor acima do valor m�dio das vendas
SELECT DISTINCT nomeCliente FROM tbCliente
INNER JOIN tbVenda ON tbVenda.codCliente=tbCliente.codCliente
WHERE valorTotalVenda> (SELECT AVG(valorTotalVenda) FROM tbVenda)

--4)Criar uma consulta que retorne o nome e o pre�o dos produtos mais caros
SELECT descricaoProduto, valorProduto FROM tbProduto
WHERE valorProduto IN (SELECT MAX(valorProduto) FROM tbProduto)

--5)Criar uma consulta que retorne o nome e o pre�o do produto mais barato
SELECT descricaoProduto, valorProduto FROM tbProduto
WHERE valorProduto IN (SELECT MIN(valorProduto) FROM tbProduto)