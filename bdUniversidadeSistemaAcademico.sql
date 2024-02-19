--DROP DATABASE bdUniversidadeSistemaAcademico
CREATE DATABASE bdUniversidadeSistemaAcademico

GO

USE bdUniversidadeSistemaAcademico

CREATE TABLE tbCurso (
	idCurso INT PRIMARY KEY IDENTITY (1,1)
	,nomeCurso VARCHAR (100) NOT NULL
	,cargaHorariaCurso SMALLDATETIME NOT NULL
)

CREATE TABLE tbCampo(
	idCampo INT PRIMARY KEY IDENTITY (1,1)
	,nomeCampo VARCHAR (70) NOT NULL
)

CREATE TABLE tbSexoAluno (
	idSexoAluno INT PRIMARY KEY IDENTITY (1,1)
	,descSexoAluno VARCHAR (50) NOT NULL
)

CREATE TABLE tbAluno(
	idAluno INT PRIMARY KEY IDENTITY (1,1)
	,nomeAluno VARCHAR (100) NOT NULL
	,dtNascAluno SMALLDATETIME NOT NULL 
	,logAluno VARCHAR (100) NOT NULL
	,numResidenciaAluno SMALLINT NOT NULL
	,compAluno VARCHAR (60) 
	,cepAluno CHAR (8) NOT NULL 
	,bairroAluno VARCHAR (100) NOT NULL
	,cidadeAluno VARCHAR (80) NOT NULL
	,estadoAluno VARCHAR (50) NOT NULL
	,cpfAluno CHAR (11) NOT NULL UNIQUE
	,numRgAluno CHAR (9) NOT NULL UNIQUE
	,idSexoAluno INT FOREIGN KEY REFERENCES tbSexoAluno (idSexoAluno)
)

CREATE TABLE tbFoneAluno (
	idFoneAluno INT PRIMARY KEY IDENTITY (1,1)
	,numFoneAluno CHAR (11) 
	,idAluno INT FOREIGN KEY REFERENCES tbAluno (idAluno)
)

CREATE TABLE tbTurma(
	idTurma INT PRIMARY KEY IDENTITY (1,1)
	,nomeTurma VARCHAR (30) NOT NULL
	,numSalaTurma TINYINT NOT NULL
	,anoFormTurma SMALLDATETIME NOT NULL
	,idCurso INT FOREIGN KEY REFERENCES tbCurso (idCurso)
	,idCampo INT FOREIGN KEY REFERENCES tbCampo (idCampo)
)

CREATE TABLE tbSexoProf (
	idSexoProf INT PRIMARY KEY IDENTITY (1,1)
	,descSexoProf VARCHAR (50) NOT NULL
)

CREATE TABLE tbProfessor(
	idProfessor INT PRIMARY KEY IDENTITY (1,1)
	,nomeProfessor VARCHAR (100) NOT NULL
	,dtNascProfessor SMALLDATETIME NOT NULL
	,numRgProfessor CHAR (9) NOT NULL UNIQUE
	,cpfProfessor CHAR (11) NOT NULL UNIQUE
	,logProfessor VARCHAR (100) NOT NULL
	,numResidenciaProfessor SMALLINT NOT NULL
	,compProfessor VARCHAR (70)
	,cidadeProfessor VARCHAR (70) NOT NULL
	,bairroProfessor VARCHAR (70) NOT NULL
	,estadoProfessor VARCHAR (50) NOT NULL
	,idSexoProf INT FOREIGN KEY REFERENCES tbSexoProf (idSexoProf)
)

CREATE TABLE tbFoneProf(
	idFoneProf INT PRIMARY KEY IDENTITY (1,1)
	,numFoneProf CHAR (11)
	,idProfessor INT FOREIGN KEY REFERENCES tbProfessor (idProfessor)
)

CREATE TABLE tbDisciplina (
	idDisciplina INT PRIMARY KEY IDENTITY (1,1)
	,nomeDisciplina VARCHAR (70) NOT NULL
	,cargaHorariaDisciplina SMALLDATETIME NOT NULL
)

CREATE TABLE tbMatricula (
	idMatricula INT PRIMARY KEY IDENTITY (1,1)
	,dtRealizacaoMatricula SMALLDATETIME NOT NULL 
	,horaRealizacaoMatricula SMALLDATETIME NOT NULL
	,idAluno INT FOREIGN KEY REFERENCES tbAluno (idAluno)
	,idTurma INT FOREIGN KEY REFERENCES tbTurma (idTurma)
)

CREATE TABLE tbAtribuicao(
	idAtribuicao INT PRIMARY KEY IDENTITY (1,1)
	,dtRealizacaoAtribuicao SMALLDATETIME NOT NULL
	,horarioAtribuicao SMALLDATETIME NOT NULL 
	,idDisciplina INT FOREIGN KEY REFERENCES tbDisciplina (idDisciplina)
	,idProfessor INT FOREIGN KEY REFERENCES tbProfessor (idProfessor)
	,idTurma INT FOREIGN KEY REFERENCES  tbTurma (idTurma)
)