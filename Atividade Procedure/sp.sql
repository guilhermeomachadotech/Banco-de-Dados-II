USE bdConfeitariaSonho

--a)Criar uma Stored Procedure para inserir as categorias de produto conforme abaixo:
--Ao inserir uma categoria de produto, confirmar pelo seu nome se o mesmo j� existe no banco de dados. Nesse caso, enviar uma mensagem com essa situa��o ao usu�rio.
CREATE PROCEDURE spInsereCategoria
	@nomeCategoriaProduto VARCHAR (100)
	AS
	IF EXISTS (SELECT nomeCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE @nomeCategoriaProduto)
		BEGIN
			PRINT ('Esta categoria de produto j� existe!')
		END
	ELSE
		BEGIN
			INSERT INTO tbCategoriaProduto (nomeCategoriaProduto)
				VALUES (@nomeCategoriaProduto)
			PRINT ('Categoria inserida com sucesso!')
		END

EXEC spInsereCategoria 'Bolo Festa'
EXEC spInsereCategoria 'Bolo Simples'
EXEC spInsereCategoria 'Torta'
EXEC spInsereCategoria 'Salgado'
EXEC spInsereCategoria 'Cuscuz'

--EXEC spInsereCategoria 'Salgado'
/*UPDATE tbCategoriaProduto
SET nomeCategoriaProduto='Bolo Festa'
WHERE idCategoriaProduto=1*/
SELECT * FROM tbCategoriaProduto

--Criar  uma  Stored Procedure  para  inserir os  produtos abaixo,  sendo  que,  a  procedure  dever� antes de inserir verificar se o nome do produto j� existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE spInsereProduto
	@nomeProduto VARCHAR (100)
	,@precoKiloProduto SMALLMONEY
	,@idCategoriaProduto INT
	AS
	IF EXISTS (SELECT nomeProduto FROM tbProduto WHERE nomeProduto LIKE @nomeProduto)
		BEGIN
			PRINT ('Este produto j� existe!')
		END
	ELSE
		BEGIN 
			IF EXISTS(SELECT @idCategoriaProduto FROM tbCategoriaProduto WHERE idCategoriaProduto =@idCategoriaProduto)
				BEGIN
					INSERT INTO tbProduto (nomeProduto, precoKiloProduto, idCategoriaProduto)
						VALUES (@nomeProduto, @precoKiloProduto, @idCategoriaProduto)
					PRINT ('Produto inserido com sucesso!')
				END
			ELSE
				BEGIN 
					PRINT('C�digo '+CONVERT(VARCHAR(5),@idCategoriaProduto) +' da categoria produto n�o est� registrado na tabela')
				END
		END
EXEC spInsereProduto 'Bolo Floresta Negra', 42.00, 1
EXEC spInsereProduto 'Bolo Prestigio', 43.00, 1
EXEC spInsereProduto 'Bolo Nutella', 44.00, 1
EXEC spInsereProduto 'Bolo Formigueiro', 17.00, 2
EXEC spInsereProduto 'Bolo de cenoura', 19.00, 2
EXEC spInsereProduto 'Torta de Palmito', 45.00, 3
EXEC spInsereProduto 'Torta de frango e catupiry', 47.00, 3
EXEC spInsereProduto 'Torta de Escarola', 44.00, 3
EXEC spInsereProduto 'Coxinha frango', 25.00, 4
EXEC spInsereProduto 'Esfiha carne', 27.00, 4
EXEC spInsereProduto 'Folhado queijo', 31.00, 4
EXEC spInsereProduto 'Risoles palmito', 29.00, 44

SELECT * FROM tbProduto

--c)Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que dever�o ser feitas duas valida��es:-Verificar pelo CPF se o cliente j� existe. Caso j� existaemitir a mensagem: �Cliente cpf XXXXX j� cadastrado�-Verificar  se  o  cliente  �  morador  de  Itaquera  ou  Guaianases,  pois  a  confeitaria  n�o  realiza entregas para clientes que residam fora desses bairros. Caso o cliente n�o seja morador desses bairros enviar a mensagem �N�o foi poss�vel cadastrar o cliente XXXX pois o bairro XXXX n�o � atendido pela confeitaria�
CREATE PROCEDURE spInsereCliente 
	@nomeCliente VARCHAR (100)
	,@dataNascCliente SMALLDATETIME 
	,@ruaCliente VARCHAR (100)
	,@numCasaCliente VARCHAR (6)
	,@cepCliente CHAR (10)
	,@bairroCliente VARCHAR (100)
	,@cidadeCliente VARCHAR (100)
	,@estadoCliente VARCHAR (100)
	,@cpfCliente CHAR (11)
	,@sexoCliente CHAR (1)
	AS
		IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
			BEGIN 
				PRINT ('Cliente de cpf '+@cpfCliente+' j� cadastrado')
			END
		ELSE
			BEGIN 
				IF (@bairroCliente LIKE 'Itaquera' OR @bairroCliente LIKE 'Guaianases')
					BEGIN
						INSERT INTO tbCliente (nomeCliente,dataNascCliente,ruaCliente,numCasaCliente,cepCliente,bairroCliente,cidadeCliente,estadoCliente,cpfCliente,sexoCliente)
							VALUES (@nomeCliente,@dataNascCliente,@ruaCliente,@numCasaCliente,@cepCliente,@bairroCliente,@cidadeCliente,@estadoCliente,@cpfCliente,@sexoCliente)
						PRINT ('Cliente cadastrado com sucesso!')
					END
				ELSE
					BEGIN
						PRINT ('N�o foi poss�vel cadastrar o cliente '+@nomeCliente+' pois o bairro '+@bairroCliente+' n�o � atendido pela confeitaria')
					END
			END
EXEC spInsereCliente 'Samira Fatah', '05/05/1990','Rua Aguape�','1000', '08.090-000','Guaianases','S�o Paulo','S�o Paulo', '82902649080','F'
EXEC spInsereCliente 'Celia Nogueira', '06/06/1992','Rua Andes','234', '08.456-090','Guaianases','S�o Paulo','S�o Paulo', '38462905729','F'
EXEC spInsereCliente 'Paulo Cesar Siqueira', '04/04/1984','Rua Castelo do Piau�','232', '08.109-000','Itaquera','S�o Paulo','S�o Paulo', '93672815473','M'
EXEC spInsereCliente 'Rodrigo Favaroni', '09/04/1991','Rua Sans�o Castelo Branco','10', '08.431-090','Guaianases','S�o Paulo','S�o Paulo', '84726729042','M'
EXEC spInsereCliente 'Fl�via Regina Brito', '22/04/1992','Rua Mariano Moro','300', '08.200-123','Penha','S�o Paulo','S�o Paulo', '2856720889','F'
--EXEC spInsereCliente 'Fl�via Regina Brito', '22/04/1992','Rua Mariano Moro','300', '08.200-123','Itaquera','S�o Paulo','S�o Paulo', '28567209157','F'
SELECT*FROM tbCliente
/*d) Criar via stored procedure as encomendas abaixo relacionadas, fazendo as verifica��es abaixo
- No momento da encomenda o cliente ir� fornecer o seu cpf. Caso ele n�o tenha sido 
cadastrado enviar a mensagem �n�o foi poss�vel efetivar a encomenda pois o cliente xxxx n�o 
est� cadastrado�
- Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: �Encomenda XXX para 
o cliente YYY efetuada com sucesso� sendo que no lugar de XXX dever� aparecer o n�mero da 
encomenda e no YYY dever� aparecer o nome do cliente
*/ --olhei ate a	ui
CREATE PROCEDURE spCriarEncomenda
	@dataEncomenda SMALlDATETIME
	,@cpfCliente CHAR (11)
	,@valorTotalEncomenda SMALLMONEY
	,@dataEntregaEncomenda SMALLDATETIME
	AS
		DECLARE @codEncomenda INT
		DECLARE @codCliente INT
		DECLARE @nomeCliente VARCHAR(100)
		IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
			BEGIN
				SET @codCliente=(SELECT idCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
				SET @nomeCliente=(SELECT nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
				INSERT INTO tbEncomenda (dataEncomenda,idCliente,valortotalEncomenda,dataEntregaEncomenda)
					VALUES (@dataEncomenda,@codCliente,@valorTotalEncomenda,@dataEntregaEncomenda)
				SET @codEncomenda=(SELECT MAX(idEncomenda)FROM tbEncomenda)
				PRINT ('Encomenda '+CONVERT(VARCHAR(5),@codEncomenda)+' para o cliente '+@nomeCliente+' efetuada com sucesso')
			END
		ELSE
			BEGIN 
				PRINT ('N�o foi poss�vel efetivar a encomenda pois o cliente '+@cpfCliente+' n�o est� cadastrado')
			END

EXEC spCriarEncomenda '08/08/2015', '829026',450.00, '15/08/2015'
EXEC spCriarEncomenda '10/10/2015', '38462905729',200.00, '15/10/2015'
EXEC spCriarEncomenda '10/10/2015', '93672815473',150.00, '10/12/2015'
EXEC spCriarEncomenda '06/10/2015', '82902649080',250.00, '12/10/2015'
EXEC spCriarEncomenda '05/10/2015', '84726729042',150.00, '12/10/2015'

/*DELETE tbEncomenda
WHERE idEncomenda=1*/
SELECT*FROM tbEncomenda

/*e)Ao adicionar a encomenda, criar uma Stored procedure, para que sejam inseridos os itens da 
encomenda conforme tabela a seguir.*/
CREATE PROCEDURE spInsereItensEncomenda
	@idEncomenda INT
	,@idProduto INT
	,@quantidadesKilos DECIMAL
	,@subTotal SMALLMONEY 
	AS
	DECLARE @codItensEncomenda INT
		IF EXISTS (SELECT idEncomenda FROM tbEncomenda WHERE idEncomenda = @idEncomenda)
			BEGIN
				IF EXISTS (SELECT idProduto FROM tbProduto WHERE idProduto=@idProduto)
					BEGIN
						INSERT INTO tbItensEncomenda (idEncomenda, idProduto, qtdeKilos, subTotal)
						VALUES (@idEncomenda, @idProduto, @quantidadesKilos,@subTotal)
						SET @codItensEncomenda=(SELECT MAX(idItensEncomenda) FROM tbItensEncomenda)
						PRINT ('Item da encomenda '+CONVERT(VARCHAR(5),@codItensEncomenda)+' inserida com sucesso')
					END
				ELSE
					BEGIN
						PRINT('Produto de c�digo '+CONVERT(VARCHAR(5),@idProduto)+' n�o est� cadastrado no banco de dados')
					END
			END
		ELSE
			BEGIN
				PRINT('Encomenda de c�digo '+CONVERT(VARCHAR(5),@idEncomenda)+' n�o est� cadastrado no banco de dados.')
			END
		

EXEC spInsereItensEncomenda 1,1, 2.5,105.00
EXEC spInsereItensEncomenda 1,10, 2.6,70.00
EXEC spInsereItensEncomenda 1,9, 6,150.00
EXEC spInsereItensEncomenda 1,12, 4.3,125.00
EXEC spInsereItensEncomenda 2,9, 8,200.00
EXEC spInsereItensEncomenda 3,11, 3.2,100.00
EXEC spInsereItensEncomenda 3,9, 2,50.00
EXEC spInsereItensEncomenda 4,2, 3.5,150.00
EXEC spInsereItensEncomenda 4,3, 2.2,100.00
EXEC spInsereItensEncomenda 5,68, 3.4,150.00

SELECT*FROM tbItensEncomenda
/*f) Ap�s todos os cadastros, criar Stored procedures para alterar o que se pede:
1- O pre�o dos produtos da categoria �Bolo festa� sofreram um aumento de 10%*/
CREATE PROCEDURE spAumentoPrecoBoloFesta
	AS 
		DECLARE @idCategoriaProduto INT
		SET @idCategoriaProduto=(SELECT idCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE 'Bolo Festa')
		UPDATE tbProduto
		SET precoKiloProduto=precoKiloProduto+((precoKiloProduto*10)/100)
		WHERE idCategoriaProduto=@idCategoriaProduto
		PRINT('Desconto de 10% nos produtos de categoria "Bolo Festa" aplicado com sucesso')
EXEC spAumentoPrecoBoloFesta
SELECT*FROM tbProduto
--2-O pre�o dos produtos categorias "Bolo Simples" est�o em promo��o e ter�o um desconto de 20%
CREATE PROCEDURE spDescontoProdutosBoloSimples 
	AS 
		DECLARE @idCategoriaProduto INT
		SET @idCategoriaProduto=(SELECT idCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE 'Bolo Simples')
		UPDATE tbProduto
		SET precoKiloProduto=precoKiloProduto-((precoKiloProduto*20)/100)
		WHERE idCategoriaProduto= @idCategoriaProduto
		PRINT('Desconto de 20% nos produtos de categoria "Bolo Simples" aplicado com sucesso')
EXEC spDescontoProdutosBoloSimples
SELECT*FROM tbProduto
--3)O pre�o dos produtos da categoria "Torta" aumentaram 20%
CREATE PROCEDURE spAumentoProdutoTorta
	AS 
		DECLARE @idCategoriaProduto INT
		SET @idCategoriaProduto=(SELECT idCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE 'Torta')
		UPDATE tbProduto
		SET precoKiloProduto=precoKiloProduto+((precoKiloProduto*25)/100)
		WHERE idCategoriaProduto=@idCategoriaProduto
		PRINT('Aumento de 25% nos produtos de categoria "Torta" aplicado com sucesso')

EXEC spAumentoProdutoTorta
SELECT*FROM tbProduto
--4)O pre�o dos produtos da categoria "Salgado", com exce��o da esfiha de carne, sofreram um aumento de 20%
CREATE PROCEDURE spAumentoPrecoSalgado
	AS 
		DECLARE @idCategoriaProduto INT
		SET @idCategoriaProduto=(SELECT idCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE 'Salgado')
		UPDATE tbProduto
		SET precoKiloProduto=precoKiloProduto+((precoKiloProduto*20)/100)
		WHERE idCategoriaProduto=@idCategoriaProduto AND nomeProduto NOT LIKE 'Esfiha carne'
		PRINT('Aumento de 20% dos pre�os dos salgados, exceto a esfiha de carne, aplicado com sucesso!')

EXEC spAumentoPrecoSalgado
SELECT*FROM tbProduto

/*G)Criar uma procedure para excluir clientes pelo CPF sendo que:
1-Caso  o  cliente  possua  encomendas emitir a mensagem �Imposs�vel  remover  esse  cliente  pois  o cliente XXXXX possui encomendas; onde XXXXX � o nome do cliente.
2-Caso o cliente n�o possua encomendas realizar a remo��o e emitir a mensagem �Cliente XXXX removido com sucesso�, onde XXXX � o nome do cliente;
*/
CREATE PROCEDURE spExcluirCliente
	@cpfCliente CHAR (11)
	AS
	DECLARE @nomeCliente VARCHAR(100)
	DECLARE @idCliente INT
	SET @idCliente=(SELECT idCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	SET @nomeCliente=(SELECT nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	IF EXISTS(SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
		BEGIN
				
			IF EXISTS(SELECT idCliente FROM tbEncomenda WHERE idCliente=@idCliente)
				BEGIN
					PRINT('Imposs�vel remover esse cliente pois o cliente '+@nomeCliente+' possui encomendas')
				END
			ELSE
				BEGIN
						
					DELETE tbCliente
					WHERE cpfCliente LIKE @cpfCliente
					PRINT('Cliente '+@nomeCliente+' removido com sucesso')
				END
		END
	ELSE
		BEGIN
			PRINT('Cliente de CPF '+CONVERT(VARCHAR(11),@cpfCliente)+' n�o est� cadastrado no banco de dados')
		END
		
		

EXEC spExcluirCliente '82902649080'
SELECT*FROM tbCliente

--H)Criar uma procedure que permita excluir qualquer item de uma encomenda que exista. 
/*Para tal o cliente dever� fornecer o c�digo da encomenda e o c�digo do produto que ser� exclu�do da encomenda.
A procedure dever� remover o item e atualizar o valor total da encomenda, do qual dever� ser subtra�do o valor do item a ser removido. 
A procedure poder� remover apenas um item da encomenda de cada vez.*/
CREATE PROCEDURE spExcuirItensEncomenda
	@idEncomenda INT
	,@idProduto INT
	AS 
		DECLARE @precoItenEncomenda SMALLMONEY
		IF EXISTS(SELECT idEncomenda FROM tbEncomenda WHERE idEncomenda=@idEncomenda)
			BEGIN
				IF EXISTS(SELECT idProduto FROM tbProduto WHERE idProduto=@idProduto)
					BEGIN
						IF EXISTS (SELECT idItensEncomenda FROM tbItensEncomenda WHERE idEncomenda = @idEncomenda AND idProduto=@idProduto)
							BEGIN
								SET @precoItenEncomenda=(SELECT subTotal FROM tbItensEncomenda WHERE idProduto =@idProduto AND idEncomenda=@idEncomenda)
								DELETE tbItensEncomenda
								WHERE idProduto=@idProduto AND idEncomenda=@idEncomenda

								UPDATE tbEncomenda
								SET valorTotalEncomenda=valorTotalEncomenda-@precoItenEncomenda
								WHERE idEncomenda=@idEncomenda
								PRINT('Exclus�o do iten da encomenda e atualiza��o do valor total da encomenda de c�digo '+CONVERT(VARCHAR(5),@idEncomenda)+' realizada com sucesso!')
							END
						ELSE
							BEGIN
								PRINT ('N�o existe itens de encomenda com encomenda de c�digo '+CONVERT(VARCHAR(5),@idEncomenda)+' ou de produto de c�digo '+CONVERT(VARCHAR(5),@idProduto))
							END
					END
				ELSE
					BEGIN
						PRINT('Produto de c�digo '+CONVERT(VARCHAR(5),@idProduto)+' n�o est� cadastrado no banco de dados.')
					END
			END
		ELSE
			BEGIN
				PRINT('Encomenda de c�digo '+CONVERT(VARCHAR(5),@idEncomenda)+' n�o est� cadastrado no banco de dados.')
			END

EXEC spExcuirItensEncomenda 1,1
SELECT*FROM tbItensEncomenda
--i)Criar  uma  stored  procedure  que  receba  o  cpf  de  um  cliente  e  a  data  de  entrega  de  uma encomenda e exclua essa encomenda feita para esse cliente. Para tal a stored procedure ter� que:
--a.Verificar se o cliente existe no banco de dados
--b.Verificar se o cliente possui encomenda na data solicitada
--c.Em caso negativo (n�o existe cliente ou n�o existe encomenda) para ambos os casos enviar mensagem informando a situa��o
--d.Em caso positivo (existe cliente e existe encomenda) excluir a encomenda e todos os seus itens do banco de dados
CREATE PROCEDURE spExcluirEncomenda
	@cpfCliente CHAR (11)
	,@dataEntregaEncomenda SMALLDATETIME
	AS
		DECLARE @idCliente INT
		DECLARE @idEncomenda INT
		DECLARE @idItensEncomenda INT
		DECLARE @nomeCliente VARCHAR(100)
		
		IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
			BEGIN
				SET @idCliente=(SELECT idCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
				SET @nomeCliente=(SELECT nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
				
				IF EXISTS (SELECT dataEntregaEncomenda FROM tbEncomenda WHERE dataEntregaEncomenda LIKE @dataEntregaEncomenda AND idCliente=@idCliente)
					BEGIN
						SET @idEncomenda=(SELECT idEncomenda FROM tbEncomenda WHERE idCliente=@idCliente AND dataEntregaEncomenda LIKE @dataEntregaEncomenda )
						DELETE tbItensEncomenda
						WHERE idEncomenda=@idEncomenda

						DELETE tbEncomenda
						WHERE idCliente=@idCliente AND dataEntregaEncomenda LIKE @dataEntregaEncomenda
								
						PRINT('Encomenda de c�digo '+CONVERT(VARCHAR(5),@idEncomenda)+' e  item de encomenda marcado para o dia '+CONVERT(VARCHAR(100),@dataEntregaEncomenda)+' exclu�da com sucesso')
					END
				ELSE
					BEGIN
						PRINT('O cliente '+@nomeCliente +' n�o possui encomenda com data de entrega marcada para '+CONVERT(VARCHAR(20),@dataEntregaEncomenda))
					END
				
			END
		ELSE
			BEGIN
				PRINT ('N�o h� cliente de cpf '+@cpfCliente+' registrado no banco de dados')
			END
		
EXEC spExcluirEncomenda '82902649080', '12/10/2015'
SELECT*FROM tbEncomenda
SELECT*FROM tbItensEncomenda
SELECT*FROM tbCliente

--j)Criar uma stored procedure que receba uma data de entrega e que liste todas as encomendas e itens que dever�o ser entregues na referida data
CREATE PROCEDURE spExibirEncomendaItensPorData
	@dataEntregaEncomenda SMALLDATETIME
	AS
		IF EXISTS (SELECT dataEntregaEncomenda FROM tbEncomenda WHERE dataEntregaEncomenda LIKE @dataEntregaEncomenda)
			BEGIN
				SELECT tbEncomenda.idEncomenda, idItensEncomenda, dataEncomenda, idCliente, nomeProduto, qtdeKilos, dataEntregaEncomenda, subTotal, valortotalEncomenda FROM tbEncomenda
				INNER JOIN tbItensEncomenda ON tbItensEncomenda.idEncomenda=tbEncomenda.idEncomenda
				INNER JOIN tbProduto ON tbProduto.idProduto=tbItensEncomenda.idProduto
				WHERE dataEntregaEncomenda LIKE @dataEntregaEncomenda
			END
		ELSE
			BEGIN
				PRINT('N�o h� encomendas e itens com data de entrega marcada no dia '+CONVERT(VARCHAR(100),@dataEntregaEncomenda))
			END
EXEC spExibirEncomendaItensPorData '15/08/2023'
SELECT*FROM tbEncomenda
SELECT*FROM tbItensEncomenda