--drop database bdCarro 
CREATE DATABASE bdCarro
GO
USE bdCarro

CREATE TABLE tbMotorista(
	codMotorista INT PRIMARY KEY IDENTITY(1,1),
	nomeMotorista VARCHAR(50) NOT NULL,
	cpfMotorista CHAR(14) NOT NULL,
	pontuacaoAcumuladaMotorista INT DEFAULT 0,
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
	dataMulta SMALLDATETIME,
	numPontos INT,
	codVeiculo INT FOREIGN KEY REFERENCES tbVeiculo (codVeiculo),
)