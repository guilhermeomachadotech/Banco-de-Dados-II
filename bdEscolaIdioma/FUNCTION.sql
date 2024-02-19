USE bdEscolaIdiomas2

-- 1- CRIE UMA FUNÇÃO QUE INFORMADA UMA DATA DA MATRICULA, RETORNE O DIA DA SEMANA

CREATE FUNCTION funcDiaSemana (@dataMatricula SMALLDATETIME)
RETURNS VARCHAR(40) AS
BEGIN

	declare @DiaSemana VARCHAR (40)
	Declare @Dia INT
	SET @Dia=DatePart(dw,@dataMatricula)

	IF @Dia=1
		BEGIN
			SET @DiaSemana='DOMINGO'
			 END
	IF @Dia=2
		BEGIN
			SET @DiaSemana='SEGUNDA-FEIRA'
			 END
	IF @Dia=3
		BEGIN
			SET @DiaSemana='TERÇA-FEIRA'
			 END
	IF @Dia=4
		BEGIN
			SET @DiaSemana='QUARTA-FEIRA'
			 END
	IF @Dia=5
		BEGIN
			SET @DiaSemana= 'QUINTA-FEIRA'
			 END
	IF @Dia=6
		 BEGIN
			SET @DiaSemana= 'SEXTA-FEIRA'
			 END
	IF @Dia=7
		BEGIN
			SET @DiaSemana= 'SÁBADO'
			 END

			RETURN @DiaSemana
END

SELECT dataMatricula AS 'Data da matricula',
DiaDaSemana=dbo.funcDiaSemana(dataMatricula)
FROM tbMatricula

--2)Crie uma função que de acordo com a carga horária do curso exiba curso rápido ou curso extenso. Rápido menos de 1000 horas
CREATE FUNCTION funcCursoRapidoOuExtenso(@cargaHoraria SMALLINT)
RETURNS VARCHAR(100)
AS
	BEGIN
		DECLARE @resultado VARCHAR(100)
		IF (@cargaHoraria<1000)
			BEGIN
				SET @resultado='Curso rápido'
			END
		ELSE
			BEGIN
				SET @resultado='Curso extenso'
			END
		RETURN @resultado
	END

SELECT cargaHorariaCurso FROM tbCurso 
SELECT nomeCurso AS 'Nome do curso','Duração do Curso'=dbo.funcCursoRapidoOuExtenso(cargaHorariaCurso) FROM tbCurso
--3)Crie uma função que de acordo com o valor do curso exiba o curso caro ou curso barato. (Curso caro acima de 400)
CREATE FUNCTION funcCursoBaratoOuCaro(@valorCurso SMALLMONEY)
RETURNS VARCHAR(12)
AS
	BEGIN
		DECLARE @message VARCHAR(12)
		IF (@valorCurso>=400)
			BEGIN
				SET @message='Curso Caro'
			END
		ELSE
			BEGIN
				SET @message='Curso Barato'
			END
		RETURN @message
	END

SELECT nomeCurso AS 'Nome do Curso', valorCurso AS 'Valor do Curso', cursoBaratoOuCaro=dbo.funcCursoBaratoOuCaro(valorCurso) FROM tbCurso

--4)Crie uma função que iformada a data da matricula converta-a no formato (dd/mm/aaaa)

CREATE FUNCTION funcConversaoData (@dataMatricula SMALLDATETIME)
RETURNS CHAR(10)
AS
	BEGIN
		DECLARE @dia CHAR(2), @mes CHAR(2), @ano CHAR(4), @dataConvertida CHAR(10)

		SET @dia=DATEPART(DAY,@dataMatricula)
		SET @mes=DATEPART(MONTH,@dataMatricula)
		SET @ano=DATEPART(YEAR,@dataMatricula)

		IF(@dia=1 OR @dia=2 OR @dia=3 OR @dia=4 OR @dia=5 OR @dia=6 OR @dia=7 OR @dia=8 OR @dia=9)
			BEGIN
				SET @dia='0'+@dia
			END

		IF (@mes=1 OR @mes=2 OR @mes=3 OR @mes=4 OR @mes=5 OR @mes=6 OR @mes=7 OR @mes=8 OR @mes=9)
			BEGIN
				SET @mes='0'+@mes
			END

		SET @dataConvertida=@dia+'/'+@mes+'/'+@ano

		RETURN @dataConvertida
	END

SELECT codAluno AS 'Código do Aluno', codTurma AS 'Código da Turma', DataMatricula=dbo.funcConversaoData(dataMatricula) FROM tbMatricula