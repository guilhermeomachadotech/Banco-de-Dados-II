CREATE DATABASE bdProva4

GO

USE bdProva4

CREATE TABLE tbAutor(
	idAutor INT PRIMARY KEY IDENTITY (1,1)
	,nomeAutor VARCHAR (20) NOT NULL
 )

CREATE TABLE tbMusica (
	idMusica INT PRIMARY KEY IDENTITY (1,1)
	,nomeMusica VARCHAR (10) NOT NULL
	,duracaoMusica INT NOT NULL
	,dataComposicao SMALLDATETIME NOT NULL
	,valorDireitoAutoral INT NOT NULL
)

CREATE TABLE tbAutoria(
	idAutoria INT PRIMARY KEY IDENTITY (1,1)
	,idAutor INT FOREIGN KEY REFERENCES tbAutor (idAutor)
	,idMusica INT FOREIGN KEY REFERENCES tbMusica (idMusica)
 )