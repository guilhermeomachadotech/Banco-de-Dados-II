USE bdEscolaIdioma

--a)Criar uma consulta que retorne o nome e o preço dos cursos que custem abaixo do valor médio
SELECT nomeCurso AS'Nome do curso', valorCurso AS 'Preços dos cursos' FROM tbCurso
WHERE valorCurso <(SELECT AVG(valorCurso) FROM tbCurso)

--b)Criar uma consulta que retorne o nome e o rg do aluno mais novo
SELECT nomeAluno AS'Nome do aluno mais novo', rgAluno AS 'RG do aluno' FROM tbAluno
WHERE dataNascimento IN (SELECT MAX(dataNascimento) FROM tbAluno)

--c)Criar uma consulta que retorne o nome do aluno mais velho
SELECT nomeAluno AS 'Nome o aluno' FROM tbAluno
WHERE dataNascimento IN (SELECT MIN(dataNascimento)n FROM tbAluno)

--d)Criar uma consulta que retorne o nome e o valor do curso mais caro
SELECT nomeCurso AS 'Nome do curso', valorCurso AS 'Valor do curso' FROM tbCurso
WHERE valorCurso IN (SELECT MAX(valorCurso) FROM tbCurso)

--e)Criar uma consulta que retorne o nome do aluno e o nome do curso, do aluno que fez a última matrícula
SELECT nomeAluno AS 'Nome do aluno', nomeCurso AS 'Nome do curso' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
INNER JOIN tbTurma ON tbTurma.codTurma=tbMatricula.codTurma
INNER JOIN tbCurso ON tbCurso.codCurso=tbTurma.codCurso
WHERE tbMatricula.dataMatricula IN (SELECT MAX(dataMatricula) FROM tbMatricula)

--f)Criar uma consulta que retorne o nome do primeiro aluno a ser matriculado na escola de Idiomas
SELECT nomeAluno AS 'Nome do aluno' FROM tbAluno
INNER JOIN tbMatricula ON tbMatricula.codAluno=tbAluno.codAluno
WHERE dataMatricula IN (SELECT MIN (dataMatricula) FROM tbMatricula)

--g)Criar uma consulta que retorne o nome, rg e data de nascimento de todos os alunos que estejam matriculados no curso de inglês
SELECT nomeAluno AS 'Nome do aluno', rgAluno AS 'Rg do aluno', dataNascimento AS 'Data de nascimento' FROM tbAluno
WHERE EXISTS (SELECT codAluno FROM tbMatricula 
WHERE tbAluno.codAluno=tbMatricula.codAluno AND EXISTS(SELECT codTurma FROM tbTurma
WHERE tbTurma.codTurma=tbMatricula.codTurma AND EXISTS (SELECT codCurso FROM tbCurso
WHERE tbCurso.codCurso=tbTurma.codCurso AND nomeCurso LIKE 'INGLÊS')
)
)