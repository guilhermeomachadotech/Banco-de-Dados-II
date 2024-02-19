--use bdEscolaIdioma
--Crie uma visão "Preço_Baixo que exiba o código, nome do curso, carga horária e o valor do curso de todos os cursos que tenha preço inferior ao preço médio"
CREATE VIEW vwPrecoBaixo AS
	SELECT nomeCurso AS'Nome do curso', codCurso AS 'Código do curso', cargaHorarioCurso AS 'Carga', valorCurso AS 'Valor' FROM tbCurso

SELECT * FROM vwPrecoBaixo
WHERE [Valor] < (SELECT AVG([Valor]) FROM vwPrecoBaixo)

--Usando a visão "Preço_Baixo", mostre todos os cursos ordenados por carga horaria
SELECT*FROM vwPrecoBaixo
ORDER BY Carga Desc

--Crie uma visão "Alunos Turma" que exiba o curso e a quantidade de alunos por turma

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

--Usando a visão "Alunos_Turma" exiba a turma com mais número de alunos
SELECT*FROM vwAlunosTurma
WHERE [Quantidades de alunos]=(SELECT MAX([Quantidades de alunos]) FROM vwAlunosTurma)

--Crie uma visão "Turma_Curso" que exiba o curso e a quantidade de turmas.
CREATE VIEW vwTurmaCurso AS
	SELECT nomeCurso AS 'Nome do Curso', COUNT (codTurma) AS 'Quantidades de turmas' FROM tbCurso
	INNER JOIN tbTurma ON tbTurma.codCurso=tbCurso.codCurso
	GROUP BY nomeCurso

SELECT*FROM vwTurmaCurso

--Usando a visão "Turma_Curso" exiba o curso com o menor número de turmas
SELECT*FROM vwTurmaCurso
WHERE [Quantidades de turmas]=(SELECT MIN([Quantidades de turmas])FROM vwTurmaCurso)