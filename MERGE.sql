USE bdEtec

--Faz a inser��o dos dados da tabela do 2� A na tabela do 3�
MERGE tb3 dest
USING tb2A ori
ON ori.rmAluno = dest.rmAluno
WHEN NOT MATCHED AND ori.statusAluno LIKE 'APROVADO' THEN
INSERT VALUES (ori.rmAluno, ori.nomeAluno, ori.statusAluno);

SELECT *FROM tb3

--Faz a inserc�o da tabela da turma 2� B na tabela do 3�
MERGE tb3 dest
USING  tb2B ori
ON ori.rmAluno = dest.rmAluno
WHEN NOT MATCHED AND ori.statusAluno LIKE 'APROVADO' THEN
INSERT values (ori.rmAluno,
ori.nomeAluno, ori.statusAluno);