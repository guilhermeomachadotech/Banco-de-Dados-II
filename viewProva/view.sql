
CREATE VIEW vwMusica AS
	SELECT COUNT(nomeMusica) AS 'Quantidade de Músicas', nomeAutor AS 'Nome Autor'  FROM tbMusica
	INNER JOIN tbAutoria ON tbAutoria.idMusica=tbMusica.idMusica
	INNER JOIN tbAutor ON tbAutor.idAutor=tbAutoria.idAutor
	GROUP BY nomeAutor
Select*from vwMusica

CREATE VIEW vwMaiorCompositor AS
	SELECT*from vwMusica
	WHERE [Quantidade de Músicas]=(SELECT MAX([Quantidade de Músicas]) FROM vwMusica)
Select*from vwMaiorCompositor

CREATE VIEW vwAutoria AS
	SELECT nomeMusica AS 'Nome da Musica', nomeAutor AS 'Nome Autor' FROM tbMusica
	INNER JOIN tbAutoria ON tbAutoria.idMusica=tbMusica.idMusica
	INNER JOIN tbAutor ON tbAutor.idAutor=tbAutoria.idAutor
	WHERE DATEPART(MONTH,dataComposicao)=5 AND DATEPART(YEAR, dataComposicao)=2023
Select*from vwAutoria

CREATE VIEW vwMusicaLonga AS 
	SELECT nomeMusica AS 'Nome da Musica' FROM tbMusica
	WHERE duracaoMusica= (SELECT MAX (duracaoMusica)FROM tbMusica) 
Select*from vwMusicaLonga

CREATE VIEW vwGrana AS
	SELECT nomeAutor  AS 'Nome do Autor' FROM tbAutor
	INNER JOIN tbAutoria ON tbAutoria.idAutor=tbAutor.idAutor
	INNER JOIN tbMusica ON tbMusica.idMusica=tbAutoria.idMusica
	WHERE valorDireitoAutoral= (SELECT MAX (valorDireitoAutoral)FROM tbMusica)
Select*from vwGrana