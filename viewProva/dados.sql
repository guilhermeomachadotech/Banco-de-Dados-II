USE bdProva4

INSERT INTO tbMusica(nomeMusica, duracaoMusica, dataComposicao, valorDireitoAutoral)
VALUES
	('Não sei', 10, '03/10/1999', 22)
	,('Boca de 99',5, '03/10/2000', 15)
	,('olá',5, '03/10/2000', 15)

INSERT INTO tbAutor(nomeAutor)
VALUES
	('Alex')
	,('Boca')

INSERT INTO tbAutoria (idAutor, idMusica)
VALUES
	(1,2)
	,(1,3)
	,(2,1)


	