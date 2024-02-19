--Drop database bdCaixa
CREATE DATABASE bdCaixa

GO

USE bdCaixa

CREATE TABLE tbCaixa(
	codCaixa INT PRIMARY KEY IDENTITY(1,1),
	dataCaixa DATETIME DEFAULT CONVERT(VARCHAR(12), GETDATE(),103),
	saldo_inicial DECIMAL (10,2),
	saldo_final DECIMAL (10,2),
)
GO 

INSERT INTO tbCaixa (dataCaixa, saldo_inicial, saldo_final)
VALUES ('20/05/2023',100,100)
GO

CREATE TABLE tbVendas(
	dataVenda DATETIME,
	codigo INT PRIMARY KEY IDENTITY (1,1),
	valor DECIMAL (10,2),
)
GO

INSERT INTO tbVendas (dataVenda, valor)
VALUES 
	('20/05/2023', 50)

SELECT*FROM tbCaixa

