--use bdEscolaIdioma
--Crie uma vis�o "Pre�o_Baixo que exiba o c�digo, nome do curso, carga hor�ria e o valor do curso de todos os cursos que tenha pre�o inferior ao pre�o m�dio"
CREATE VIEW vwPrecoBaixo AS
	SELECT nomeCurso AS'Nome do curso', codCurso AS 'C�digo do curso', cargaHorarioCurso AS 'Carga', valorCurso AS 'Valor' FROM tbCurso

SELECT * FROM vwPrecoBaixo
WHERE [Valor] < (SELECT AVG([Valor]) FROM vwPrecoBaixo)

--Usando a vis�o "Pre�o_Baixo", mostre todos os cursos ordenados por carga horaria
SELECT*FROM vwPrecoBaixo
ORDER BY Carga Desc

--Crie uma vis�o "Alunos Turma" que exiba o curso e a quantidade de alunos por turma

CREATE VIEW vwAlunosTurma AS
	SELECT nomeCurso AS 'Nome do Curso', COUNT (codAluno) AS'Quantidades de alunos', descricaoTurma AS 'Turma' FROM tbCurso
	INNER JOIN tbTurma ON tbTurma.codCurso=tbCurso.codCurso
	INNER JOIN tbMatricula ON tbMatricula.codTurma=tbTurma.codTurma
	GROUP BY nomeCurso, descricaoTurma

/*ALTER VIEW vwAlunosTurma AS
	SELECT nomeCurso AS 'Nome do Curso', COUNT (codAluno) AS'Quantidades de alunos', descricaoTurma AS 'Turma' FROM tbCurso
	INNER JOIN tbTurma ON tbTurma.codCurso=tbCurso.codCurso
	INNER JOIN tbMatricula ON tbMatricula.codTurma=tbTurma.codTurma
	GROUP BY nomeCurso, descricaoTurma
*/
SELECT*FROM vwAlunosTurma

--Usando a vis�o "Alunos_Turma" exiba a turma com mais n�mero de alunos
SELECT*FROM vwAlunosTurma
WHERE [Quantidades de alunos]=(SELECT MAX([Quantidades de alunos]) FROM vwAlunosTurma)

--Crie uma vis�o "Turma_Curso" que exiba o curso e a quantidade de turmas.
CREATE VIEW vwTurmaCurso AS
	SELECT nomeCurso AS 'Nome do Curso', COUNT (codTurma) AS 'Quantidades de turmas' FROM tbCurso
	INNER JOIN tbTurma ON tbTurma.codCurso=tbCurso.codCurso
	GROUP BY nomeCurso

SELECT*FROM vwTurmaCurso

--Usando a vis�o "Turma_Curso" exiba o curso com o menor n�mero de turmas
SELECT*FROM vwTurmaCurso
WHERE [Quantidades de turmas]=(SELECT MIN([Quantidades de turmas])FROM vwTurmaCurso)