--USE bdEscolaIdioma2
--1)Criar uma stored procedure "Busca_Aluno" que receba o código do aluno e retorne seu nome e data de nascimento.
CREATE PROCEDURE spBuscaAluno
	@codAluno int
	AS 
		SELECT nomeAluno, dataNascimento FROM tbAluno
		WHERE codAluno=@codAluno
--SELECT*FROM tbAluno
EXEC spBuscaAluno 4

--2)Criar uma stored procedure "Insere_Aluno" que insira um registro na tabela de alunos.
CREATE PROCEDURE spInsereAluno 
	@nomeAluno VARCHAR(100)
	,@rgAluno CHAR (15)
	,@cpfAluno CHAR (11)
	,@logradouro VARCHAR(100)
	,@numero CHAR(10)
	,@complemento VARCHAR(80)
	,@cep CHAR (8)
	,@bairro VARCHAR (30)
	,@cidade VARCHAR (30)
	,@dataNascimento SMALLDATETIME
	AS
		INSERT INTO tbAluno (nomeAluno,rgAluno,cpfAluno,logradouro,numero,complemento,cep,bairro,cidade,dataNascimento)
			VALUES (@nomeAluno, @rgAluno, @cpfAluno, @logradouro,@numero, @complemento, @cep, @bairro, @cidade, @dataNascimento)
--SELECT *FROM tbAluno
EXEC spInsereAluno 'Guilherme','222222222222222','33333333333','Rua fulano', '222', 'B', '44444444','Guaianazes','não sei','06/06/2023'

--3) Criar uma stored procedure "Aumenta_Preco" que, dados o nome do curso e um percentual, aumente o valor do curso com a porcentagem informada
CREATE PROCEDURE spAumentaPreco 
	@nomeCurso VARCHAR(100)
	,@percentual TINYINT
	AS
		UPDATE tbCurso
		SET valorCurso =valorCurso+((valorCurso*@percentual)/100)
		WHERE nomeCurso LIKE @nomeCurso

		SELECT nomeCurso, valorCurso FROM tbCurso
EXEC spAumentaPreco 'INGLÊS', 20

--4)Criar uma stored procedure "Exibe_Turma" que, dado o nome da turma exiba todas as informações
CREATE PROCEDURE spExibeTurma 
	@descricaoTurma VARCHAR (100)
	AS 
		SELECT*FROM tbTurma
		WHERE descricaoTurma LIKE '%'+@descricaoTurma+'%'
EXEC spExibeTurma 'INGLÊS 1A'

--5)Criar uma stored procedure "Exibe-AlunosdaTurma" que, dado o nome da turma exiba os seus alunos.
CREATE PROCEDURE spExibeAlunosdaTurma
	@descricaoTurma VARCHAR (100)
	AS
		SELECT nomeAluno FROM tbAluno
		INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
		INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
		WHERE descricaoTurma LIKE '%'+@descricaoTurma+'%'
EXEC spExibeAlunosdaTurma 'INGLÊS 1A'

--6)Criar uma stored procedure para inserir alunos, verificando pelo cpf se o aluno existe ou não, e informar essa condição via mensagem
Create PROCEDURE spInsereAlunoPorCpf
	@nomeAluno VARCHAR(100)
	,@rgAluno CHAR (15)
	,@cpfAluno CHAR (11)
	,@logradouro VARCHAR(100)
	,@numero CHAR(10)
	,@complemento VARCHAR(80)
	,@cep CHAR (8)
	,@bairro VARCHAR (30)
	,@cidade VARCHAR (30)
	,@dataNascimento SMALLDATETIME
	AS
	DECLARE @cod INT
	IF EXISTS (SELECT codAluno FROM tbAluno WHERE cpfAluno LIKE @cpfAluno)
	BEGIN 
		PRINT ('Esse aluno já existe! Insere outro aluno!')
	END
	ELSE
	BEGIN
		INSERT INTO tbAluno (nomeAluno,rgAluno,cpfAluno,logradouro,numero,complemento,cep,bairro,cidade,dataNascimento)
			VALUES (@nomeAluno, @rgAluno, @cpfAluno, @logradouro,@numero, @complemento, @cep, @bairro, @cidade, @dataNascimento)
		SET @cod=(SELECT MAX(codAluno) FROM tbAluno)
		PRINT ('Aluno de código '+CONVERT(VARCHAR(5),@cod)+' cadastrado!')
	END

EXEC spInsereAlunoPorCpf 'Guilherme','222222222222222','33333333334','Rua fulano', '222', 'B', '44444444','Guaianazes','não sei','06/06/2023'
SELECT*FROM tbAluno

--7)Criar uma stored procedure que receba o nome do curso e o nome do aluno e matricule o mesmo no curso pretendido
ALTER PROCEDURE spMatricularAluno 
	@nomeAluno VARCHAR (100)
	,@nomeCurso VARCHAR (100)
	,@dataMatricula SMALLDATETIME 
	AS
	DECLARE @codAluno INT
	DECLARE @codCurso INT
	DECLARE @codTurma INT
	IF EXISTS (SELECT nomeAluno FROM tbAluno WHERE nomeAluno LIKE @nomeAluno) AND EXISTS (SELECT nomeCurso FROM tbCurso WHERE nomeCurso LIKE @nomeCurso)
		BEGIN
			SET @codAluno=(SELECT codAluno FROM tbAluno WHERE nomeAluno LIKE @nomeAluno)
			SET @codCurso=(SELECT codCurso FROM tbCurso WHERE nomeCurso LIKE @nomeCurso)
			SET @codTurma=(SELECT codTurma FROM tbTurma WHERE codCurso=@codCurso) 
			INSERT INTO tbMatricula (dataMatricula,codAluno,codTurma)
				VALUES (@dataMatricula, @codAluno, @codTurma)
			PRINT ('Aluno de código '+CONVERT (VARCHAR(5),@codAluno)+' matriculado no curso '+@nomeCurso)
		END
	ELSE 
		BEGIN
			PRINT ('Não existe esse aluno ou curso! Matricule um aluno em curso, ambos existentes!')
		END
EXEC spMatricularAluno 'Edson Bruno Alves', 'INGLÊS', '20/05/2023'
/*DELETE FROM  tbMatricula
WHERE codMatricula=6 OR codMatricula=5
*/
SELECT*FROM tbMatricula