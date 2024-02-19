--Criação do banco de dados --
--DROP DATABASE bdOrganizacao
 CREATE DATABASE bdOrganizacao
 GO
 --------------------------------
--Criando as tabelas ----
USE bdOrganizacao
CREATE TABLE tbStatus (
	idStatus INT PRIMARY KEY IDENTITY(1,1)
	,descStatus VARCHAR(20) NOT NULL
)
------------Já EXECUTADO ATÉ AQUI------------
 
 CREATE TABLE tbSexo(
	idSexo INT PRIMARY KEY IDENTITY (1,1)
	,descSexo VARCHAR(20) NOT NULL
	)
CREATE TABLE tbCrianca(
	idCrianca INT PRIMARY KEY IDENTITY(1,1)
	,nomeCrianca VARCHAR (100) NOT NULL
	,dtNascCrianca SMALLDATETIME NOT NULL
	,idStatus INT FOREIGN KEY REFERENCES tbStatus(idStatus)
	,idSexo INT FOREIGN KEY REFERENCES tbSexo (idSexo)
	)

CREATE TABLE tbResponsavel(
	idResponsavel INT PRIMARY KEY IDENTITY(1,1)
	,nomeResponsavel VARCHAR (100) NOT NULL
	,cpfResponsavel CHAR (11) NOT NULL UNIQUE 
	)

CREATE TABLE tbFiliacao(
	idFiliacao INT PRIMARY KEY IDENTITY(1,1)
	,idResponsavel INT FOREIGN KEY REFERENCES tbResponsavel (idResponsavel)
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca (idCrianca)
	,dtFiliacao SMALLDATETIME NOT NULL
)

CREATE TABLE tbPadrinhoMadrinha(
	idPadrinhoMadrinha INT PRIMARY KEY IDENTITY (1,1)
	,nomePadrinhoMadrinha VARCHAR (100)
	,cpfPadrinhoMadrinha CHAR (11) UNIQUE
)
CREATE TABLE tbApadrinhamento(
	idApadrinhamento INT PRIMARY KEY IDENTITY (1,1)
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca (idCrianca)
	,idPadrinhoMadrinha INT FOREIGN KEY REFERENCES tbPadrinhoMadrinha (idPadrinhoMadrinha)
	,dtApadrinhamento SMALLDATETIME 
)

CREATE TABLE tbHistorico(
	idHistorico INT PRIMARY KEY IDENTITY (1,1)
	,dataHistorico SMALLDATETIME NOT NULL
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca (idCrianca)
)

CREATE TABLE tbDoenca(
	idDoenca INT PRIMARY KEY IDENTITY (1,1)
	,nomeDoenca VARCHAR (80) NOT NULL
	,cid VARCHAR (20) NOT NULL
)

CREATE TABLE tbRegistroProntuario (
	idRegistroProntuario INT PRIMARY KEY IDENTITY (1,1)
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca (idCrianca)
	,idDoenca INT FOREIGN KEY REFERENCES tbDoenca (idDoenca)
	,dtRegistroProntuario SMALLDATETIME NOT NULL 
)