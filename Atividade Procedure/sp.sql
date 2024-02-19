USE bdConfeitariaSonho

--a)Criar uma Stored Procedure para inserir as categorias de produto conforme abaixo:
--Ao inserir uma categoria de produto, confirmar pelo seu nome se o mesmo já existe no banco de dados. Nesse caso, enviar uma mensagem com essa situação ao usuário.
CREATE PROCEDURE spInsereCategoria
	@nomeCategoriaProduto VARCHAR (100)
	AS
	IF EXISTS (SELECT nomeCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE @nomeCategoriaProduto)
		BEGIN
			PRINT ('Esta categoria de produto já existe!')
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

--Criar  uma  Stored Procedure  para  inserir os  produtos abaixo,  sendo  que,  a  procedure  deverá antes de inserir verificar se o nome do produto já existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE spInsereProduto
	@nomeProduto VARCHAR (100)
	,@precoKiloProduto SMALLMONEY
	,@idCategoriaProduto INT
	AS
	IF EXISTS (SELECT nomeProduto FROM tbProduto WHERE nomeProduto LIKE @nomeProduto)
		BEGIN
			PRINT ('Este produto já existe!')
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
					PRINT('Código '+CONVERT(VARCHAR(5),@idCategoriaProduto) +' da categoria produto não está registrado na tabela')
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

--c)Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que deverão ser feitas duas validações:-Verificar pelo CPF se o cliente já existe. Caso já existaemitir a mensagem: “Cliente cpf XXXXX já cadastrado”-Verificar  se  o  cliente  é  morador  de  Itaquera  ou  Guaianases,  pois  a  confeitaria  não  realiza entregas para clientes que residam fora desses bairros. Caso o cliente não seja morador desses bairros enviar a mensagem “Não foi possível cadastrar o cliente XXXX pois o bairro XXXX não é atendido pela confeitaria”
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
				PRINT ('Cliente de cpf '+@cpfCliente+' já cadastrado')
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
						PRINT ('Não foi possível cadastrar o cliente '+@nomeCliente+' pois o bairro '+@bairroCliente+' não é atendido pela confeitaria')
					END
			END
EXEC spInsereCliente 'Samira Fatah', '05/05/1990','Rua Aguapeí','1000', '08.090-000','Guaianases','São Paulo','São Paulo', '82902649080','F'
EXEC spInsereCliente 'Celia Nogueira', '06/06/1992','Rua Andes','234', '08.456-090','Guaianases','São Paulo','São Paulo', '38462905729','F'
EXEC spInsereCliente 'Paulo Cesar Siqueira', '04/04/1984','Rua Castelo do Piauí','232', '08.109-000','Itaquera','São Paulo','São Paulo', '93672815473','M'
EXEC spInsereCliente 'Rodrigo Favaroni', '09/04/1991','Rua Sansão Castelo Branco','10', '08.431-090','Guaianases','São Paulo','São Paulo', '84726729042','M'
EXEC spInsereCliente 'Flávia Regina Brito', '22/04/1992','Rua Mariano Moro','300', '08.200-123','Penha','São Paulo','São Paulo', '2856720889','F'
--EXEC spInsereCliente 'Flávia Regina Brito', '22/04/1992','Rua Mariano Moro','300', '08.200-123','Itaquera','São Paulo','São Paulo', '28567209157','F'
SELECT*FROM tbCliente
/*d) Criar via stored procedure as encomendas abaixo relacionadas, fazendo as verificações abaixo
- No momento da encomenda o cliente irá fornecer o seu cpf. Caso ele não tenha sido 
cadastrado enviar a mensagem “não foi possível efetivar a encomenda pois o cliente xxxx não 
está cadastrado”
- Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: “Encomenda XXX para 
o cliente YYY efetuada com sucesso” sendo que no lugar de XXX deverá aparecer o número da 
encomenda e no YYY deverá aparecer o nome do cliente
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
				PRINT ('Não foi possível efetivar a encomenda pois o cliente '+@cpfCliente+' não está cadastrado')
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
						PRINT('Produto de código '+CONVERT(VARCHAR(5),@idProduto)+' não está cadastrado no banco de dados')
					END
			END
		ELSE
			BEGIN
				PRINT('Encomenda de código '+CONVERT(VARCHAR(5),@idEncomenda)+' não está cadastrado no banco de dados.')
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
/*f) Após todos os cadastros, criar Stored procedures para alterar o que se pede:
1- O preço dos produtos da categoria “Bolo festa” sofreram um aumento de 10%*/
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
--2-O preço dos produtos categorias "Bolo Simples" estão em promoção e terão um desconto de 20%
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
--3)O preço dos produtos da categoria "Torta" aumentaram 20%
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
--4)O preço dos produtos da categoria "Salgado", com exceção da esfiha de carne, sofreram um aumento de 20%
CREATE PROCEDURE spAumentoPrecoSalgado
	AS 
		DECLARE @idCategoriaProduto INT
		SET @idCategoriaProduto=(SELECT idCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE 'Salgado')
		UPDATE tbProduto
		SET precoKiloProduto=precoKiloProduto+((precoKiloProduto*20)/100)
		WHERE idCategoriaProduto=@idCategoriaProduto AND nomeProduto NOT LIKE 'Esfiha carne'
		PRINT('Aumento de 20% dos preços dos salgados, exceto a esfiha de carne, aplicado com sucesso!')

EXEC spAumentoPrecoSalgado
SELECT*FROM tbProduto

/*G)Criar uma procedure para excluir clientes pelo CPF sendo que:
1-Caso  o  cliente  possua  encomendas emitir a mensagem “Impossível  remover  esse  cliente  pois  o cliente XXXXX possui encomendas; onde XXXXX é o nome do cliente.
2-Caso o cliente não possua encomendas realizar a remoção e emitir a mensagem “Cliente XXXX removido com sucesso”, onde XXXX é o nome do cliente;
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
					PRINT('Impossível remover esse cliente pois o cliente '+@nomeCliente+' possui encomendas')
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
			PRINT('Cliente de CPF '+CONVERT(VARCHAR(11),@cpfCliente)+' não está cadastrado no banco de dados')
		END
		
		

EXEC spExcluirCliente '82902649080'
SELECT*FROM tbCliente

--H)Criar uma procedure que permita excluir qualquer item de uma encomenda que exista. 
/*Para tal o cliente deverá fornecer o código da encomenda e o código do produto que será excluído da encomenda.
A procedure deverá remover o item e atualizar o valor total da encomenda, do qual deverá ser subtraído o valor do item a ser removido. 
A procedure poderá remover apenas um item da encomenda de cada vez.*/
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
								PRINT('Exclusão do iten da encomenda e atualização do valor total da encomenda de código '+CONVERT(VARCHAR(5),@idEncomenda)+' realizada com sucesso!')
							END
						ELSE
							BEGIN
								PRINT ('Não existe itens de encomenda com encomenda de código '+CONVERT(VARCHAR(5),@idEncomenda)+' ou de produto de código '+CONVERT(VARCHAR(5),@idProduto))
							END
					END
				ELSE
					BEGIN
						PRINT('Produto de código '+CONVERT(VARCHAR(5),@idProduto)+' não está cadastrado no banco de dados.')
					END
			END
		ELSE
			BEGIN
				PRINT('Encomenda de código '+CONVERT(VARCHAR(5),@idEncomenda)+' não está cadastrado no banco de dados.')
			END

EXEC spExcuirItensEncomenda 1,1
SELECT*FROM tbItensEncomenda
--i)Criar  uma  stored  procedure  que  receba  o  cpf  de  um  cliente  e  a  data  de  entrega  de  uma encomenda e exclua essa encomenda feita para esse cliente. Para tal a stored procedure terá que:
--a.Verificar se o cliente existe no banco de dados
--b.Verificar se o cliente possui encomenda na data solicitada
--c.Em caso negativo (não existe cliente ou não existe encomenda) para ambos os casos enviar mensagem informando a situação
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
								
						PRINT('Encomenda de código '+CONVERT(VARCHAR(5),@idEncomenda)+' e  item de encomenda marcado para o dia '+CONVERT(VARCHAR(100),@dataEntregaEncomenda)+' excluída com sucesso')
					END
				ELSE
					BEGIN
						PRINT('O cliente '+@nomeCliente +' não possui encomenda com data de entrega marcada para '+CONVERT(VARCHAR(20),@dataEntregaEncomenda))
					END
				
			END
		ELSE
			BEGIN
				PRINT ('Não há cliente de cpf '+@cpfCliente+' registrado no banco de dados')
			END
		
EXEC spExcluirEncomenda '82902649080', '12/10/2015'
SELECT*FROM tbEncomenda
SELECT*FROM tbItensEncomenda
SELECT*FROM tbCliente

--j)Criar uma stored procedure que receba uma data de entrega e que liste todas as encomendas e itens que deverão ser entregues na referida data
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
				PRINT('Não há encomendas e itens com data de entrega marcada no dia '+CONVERT(VARCHAR(100),@dataEntregaEncomenda))
			END
EXEC spExibirEncomendaItensPorData '15/08/2023'
SELECT*FROM tbEncomenda
SELECT*FROM tbItensEncomenda