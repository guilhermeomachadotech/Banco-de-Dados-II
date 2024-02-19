--DROP DATABASE bdConfeitariaSonho
CREATE DATABASE bdConfeitariaSonho

GO
USE bdConfeitariaSonho

CREATE TABLE tbCliente(
	idCliente INT PRIMARY KEY IDENTITY (1,1)
	,nomeCliente VARCHAR (100) NOT NULL
	,dataNascCliente SMALLDATETIME NOT NULL
	,ruaCliente VARCHAR (100) NOT NULL
	,numCasaCliente VARCHAR (6) NOT NULL
	,cepCliente CHAR (10) NOT NULL
	,bairroCliente VARCHAR (100) NOT NULL
	,cidadeCliente VARCHAR (100) NOT NULL
	,estadoCliente VARCHAR (100) NOT NULL
	,cpfCliente CHAR (11) NOT NULL
	,sexoCliente CHAR (1) NOT NULL
)

CREATE TABLE tbCategoriaProduto(
	idCategoriaProduto INT PRIMARY KEY IDENTITY (1,1)
	,nomeCategoriaProduto VARCHAR (100) NOT NULL
)

CREATE TABLE tbProduto(
	idProduto INT PRIMARY KEY IDENTITY (1,1)
	,nomeProduto VARCHAR (100) NOT NULL
	,precoKiloProduto SMALLMONEY NOT NULL
	,idCategoriaProduto INT FOREIGN KEY REFERENCES tbCategoriaProduto (idCategoriaProduto)
)

CREATE TABLE tbEncomenda(
	idEncomenda INT PRIMARY KEY IDENTITY (1,1)
	,dataEncomenda SMALLDATETIME NOT NULL
	,idCliente INT FOREIGN KEY REFERENCES tbCliente (idCliente)
	,valortotalEncomenda SMALLMONEY NOT NULL
	,dataEntregaEncomenda SMALLDATETIME NOT NULL
)

CREATE TABLE tbItensEncomenda(
	idItensEncomenda INT PRIMARY KEY IDENTITY (1,1)
	,idEncomenda INT FOREIGN KEY REFERENCES tbEncomenda (idEncomenda)
	,idProduto INT FOREIGN KEY REFERENCES tbProduto (idProduto)
	,qtdeKilos DECIMAL NOT NULL
	,subTotal SMALLMONEY NOT NULL
)
--ALTER TABLE tbCliente DROP COLUMN cepCliente
--ALTER TABLE tbCliente ADD cepCliente CHAR(10) NOT NULL