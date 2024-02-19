--DROP DATABASE bdCarro

CREATE DATABASE bdCarro
GO
USE bdCarro

CREATE TABLE tbMotorista(
	codMotorista INT PRIMARY KEY IDENTITY (1,1)
	,nomeMotorista VARCHAR (100) NOT NULL
	,cpfMotorista CHAR (11) NOT NULL
	,pontuacaoAcumulada INT DEFAULT 0
	,situacao VARCHAR (50) DEFAULT 'ATIVO'
)
CREATE TABLE tbVeiculo(
	codVeiculo INT PRIMARY KEY IDENTITY (1,1),
	placaVeiculo CHAR (7) NOT NULL,
	renavam CHAR (10) NOT NULL,
	anoFabricacao INT NOT NULL,
	codMotorista INT FOREIGN KEY REFERENCES tbMotorista (codMotorista),
)

CREATE TABLE tbMulta(
	codMulta INT PRIMARY KEY IDENTITY (1,1),
	dataMulta SMALLDATETIME NOT NULL,
	numPontos INT NOT NULL,
	codVeiculo INT FOREIGN KEY REFERENCES tbVeiculo (codVeiculo),
)