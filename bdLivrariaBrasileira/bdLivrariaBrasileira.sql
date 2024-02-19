CREATE DATABASE bdLivrariaBrasileira
GO 
USE bdLivrariaBrasileira

CREATE TABLE tbEditora (
	codEditora INT PRIMARY KEY IDENTITY (1,1)
	,nomeEditora VARCHAR (30) NOT NULL
)

CREATE TABLE tbAutor (
	codAutor INT PRIMARY KEY IDENTITY (1,1)
	,nomeAutor VARCHAR (30) NOT NULL
)

CREATE TABLE tbGenero (
	codGenero INT PRIMARY KEY IDENTITY (1,1)
	,nomeGenero VARCHAR (10) NOT NULL
)

CREATE TABLE tbLivro (
	codLivro INT PRIMARY KEY IDENTITY (1,1)
	,nomeLivro VARCHAR (50)
	,numPaginas SMALLINT NOT NULL
	,codGenero INT FOREIGN KEY REFERENCES tbGenero (codGenero)
	,codAutor INT FOREIGN KEY REFERENCES tbAutor (codAutor)
	,codEditora INT FOREIGN KEY REFERENCES tbEditora (codEditora)
)