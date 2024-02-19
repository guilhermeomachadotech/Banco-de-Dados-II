CREATE DATABASE bd2Estoque

GO

USE bd2Estoque

CREATE TABLE tbFornecedor (
	codFornecedor INT PRIMARY KEY IDENTITY (1,1)
	,nomeFornecedor VARCHAR (30) NOT NULL
	,contatoFornecedor VARCHAR (50) NOT NULL
)

CREATE TABLE tbFabricante (
	codFabricante INT PRIMARY KEY IDENTITY (1,1)
	,nomeFabricante VARCHAR (50) NOT NULL
)
--DROP TABLE tbProduto
CREATE TABLE tbProduto (
	codProduto INT PRIMARY KEY IDENTITY (1,1)
	,descricaoProduto VARCHAR (50) NOT NULL UNIQUE
	,valorProduto SMALLMONEY NOT NULL
	,quantidadeProduto SMALLINT NOT NULL
	,codFabricante INT FOREIGN KEY REFERENCES tbFabricante (codFabricante)
	,codFornecedor INT FOREIGN KEY REFERENCES tbFornecedor (codFornecedor)
)
--DROP TABLE tbCliente
CREATE TABLE tbCliente (
	codCliente INT PRIMARY KEY IDENTITY (1,1)
	,nomeCliente VARCHAR (50) NOT NULL 
	,cpfCliente CHAR (11) NOT NULL UNIQUE
	,emailCliente VARCHAR (40) UNIQUE
	,sexoCliente CHAR (1) NOT NULL
	,dataNascimentoCliente SMALLDATETIME NOT NULL
)

CREATE TABLE tbVenda (
	codVenda INT PRIMARY KEY IDENTITY (1,1)
	,dataVenda DATE NOT NULL
	,valorTotalVenda SMALLMONEY NOT NULL
	,codCliente INT FOREIGN KEY REFERENCES tbCliente (codCliente)
)

CREATE TABLE tbItensVenda (
	codItemVenda INT PRIMARY KEY IDENTITY (1,1)
	,codVenda INT FOREIGN KEY REFERENCES tbVenda (codVenda)
	,codProduto INT FOREIGN KEY REFERENCES tbProduto (codProduto)
	,quantidadeItensVenda SMALLINT NOT NULL
	,subTotalItensVenda SMALLMONEY NOT NULL
)