USE bdEscolaIdiomas2

--1)Apresentar os nomes dos alunos ao lado do nome dos cursos que eles fazem;
SELECT nomeAluno AS 'Nomes dos alunos', nomeCurso AS 'Nome do curso' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbMatricula.codTurma=tbTurma.codTurma
INNER JOIN tbCurso ON tbTurma.codCurso=tbCurso.codCurso

--2)Apresentar a quantidade de alunos matriculados por nome do curso;
SELECT COUNT (DISTINCT codAluno)  AS 'Quantidade de alunos matriculados',nomeCurso AS 'Nome do curso' FROM tbMatricula
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso ON tbTurma.codCurso=tbCurso.codCurso
GROUP BY nomeCurso

--3)Apresentar a quantidade de alunos matriculados por nome da turma;
SELECT COUNT (codAluno)AS 'Quantidade de alunos', nomeTurma AS 'Nome da turma' FROM tbMatricula
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
GROUP BY nomeTurma

--4)Apresentar a quantidade de alunos que fizeram matricula em maio de 2016;
SELECT COUNT (nomeAluno) AS 'Quantidades de alunos' FROM tbAluno
INNER JOIN tbMatricula ON tbAluno.codAluno=tbMatricula.codAluno
WHERE DATEPART(MONTH,dataMatricula)=5 AND DATEPART(YEAR, dataMatricula)=2016

--5)Apresentar o nome dos alunos em ordem alfabética ao lado do nome das turmas e os nomes dos cursos em que estão matriculados;
SELECT nomeAluno AS 'Nome do aluno', nomeTurma AS 'Nome da turma', nomeCurso 'Nome do curso' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbMatricula.codTurma=tbTurma.codTurma
INNER JOIN tbCurso ON tbTurma.codCurso=tbCurso.codCurso
ORDER BY nomeAluno
 
--6)Apresentar o nome dos cursos e os horários em que eles são oferecidos;
SELECT nomeCurso AS'Nome do curso', CONVERT(VARCHAR(12), horarioTurma, 114) AS 'Horarios disponibilizados por turma' FROM tbCurso
INNER JOIN tbTurma ON tbTurma.codCurso=tbCurso.codCurso

--7)Apresentar a quantidade dos alunos nascidos por estados que estejam matriculados no curso de inglês;
SELECT COUNT (DISTINCT nomeAluno) AS 'Quantidades de alunos', naturalidadeAluno AS 'Estado do aluno' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso=tbTurma.codCurso
WHERE nomeCurso LIKE 'Inglês'
GROUP BY naturalidadeAluno

--8)Apresentar o nome dos alunos ao lado da data de matrícula no formato dd/mm/aaaa
SELECT nomeAluno AS 'Nome dos alunos', CONVERT (VARCHAR(10), dataMatricula, 103) AS 'Data de matrcula' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno

--9)Apresentar os alunos cujo nome comece com A e que estejam matriculados no curso de Inglês;
SELECT nomeAluno AS 'Nomes de alunos que começem com A' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso=tbTurma.codCurso
WHERE nomeAluno LIKE 'A%' AND nomeCurso LIKE 'Inglês'

--10)Apresentar a quantidade de matriculas feitas no ano de 2016
SELECT COUNT(dataMatricula) AS 'Quantidade de matrículas feitas em 2016' FROM tbMatricula
WHERE DATEPART(YEAR, dataMatricula)=2016

--11)Apresentar a quantidade de matriculas por nome do curso
SELECT COUNT(dataMatricula) AS 'Quantidade de matriculas', nomeCurso AS 'Nome do curso' FROM tbMatricula
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso On tbCurso.codCurso=tbTurma.codCurso
GROUP BY nomeCurso

--12) Apresentar a quantidade de alunos que fazem os cursos que custam mais de R$ 300,00
SELECT  COUNT (DISTINCT nomeAluno) AS 'Quantidade de alunos que fazem cursos que custam mais de R$ 300,00' FROM tbAluno
INNER JOIN  tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso=tbTurma.codCurso
WHERE  valorCurso >300.00

--13) Apresentar os nomes do alunos que fazem o curso de alemão
SELECT nomeAluno AS 'Nomes de alunos que fazem o curso de Alemão' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso=tbTurma.codCurso
WHERE nomeCurso LIKE 'Alemão'