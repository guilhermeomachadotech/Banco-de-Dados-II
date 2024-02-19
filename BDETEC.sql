--drop database bdEtec
CREATE DATABASE bdEtec
GO
USE master

CREATE TABLE tb2A(
	rmAluno INT PRIMARY KEY 
	,nomeAluno VARCHAR (225) NOT NULL
	,statusAluno VARCHAR (100) NOT NULL
)
CREATE TABLE tb2B(
	rmAluno INT PRIMARY KEY
	,nomeAluno VARCHAR (225) NOT NULL
	,statusAluno VARCHAR (100) NOT NULL
)
CREATE TABLE tb3(
	rmAluno INT PRIMARY KEY
	,nomeAluno VARCHAR (225) NOT NULL
	,statusAluno VARCHAR (100) NOT NULL
)