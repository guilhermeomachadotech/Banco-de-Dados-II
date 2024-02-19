CREATE DATABASE bdFamilia

GO

USE bdFamilia

CREATE TABLE tbPai(
	codPai INT PRIMARY KEY IDENTITY (1,1)
	,nomePai VARCHAR (30) NOT NULL
	,idadePai TINYINT NOT NULL
)

CREATE TABLE tbFilho(
	codFilho INT PRIMARY KEY IDENTITY (1,1)
	,codPai INT FOREIGN KEY REFERENCES tbPai (codPai)
	,nomeFilho VARCHAR (30) NOT NULL
	,sexoFilho CHAR (1) NOT NULL CHECK(sexoFilho IN ('F', 'M'))
)