USE bdEstoque

CREATE TRIGGER tgVendaAtualizaProduto
ON tbItensVenda
AFTER INSERT
AS
	BEGIN
		DECLARE @codProduto INT, @qtddProdutoVenda SMALLINT, @codItensVenda INT
		SELECT @codProduto=codProduto FROM INSERTED
		SELECT @qtddProdutoVenda=quantidadeItensVenda FROM INSERTED
		SELECT @codItensVenda= codItemVenda FROM INSERTED
		UPDATE tbProduto
		SET quantidadeProduto=quantidadeProduto-@qtddProdutoVenda
		WHERE codProduto=@codProduto
		PRINT ('Venda de código '+CONVERT(VARCHAR(5),@codItensVenda)+' e atualização da quantidade de produto de código '+CONVERT(VARCHAR(5),@codProduto)+ ' inserida com sucesso')
	END
SELECT*FROM tbProduto

CREATE TRIGGER tgEntradaAtualizaProduto
ON tbEntradaProduto
FOR INSERT 
AS
	BEGIN
		DECLARE @codProduto INT, @qtddEntradaProduto SMALLINT
		SELECT @codProduto=codProduto FROM INSERTED
		SELECT @qtddEntradaProduto=quantidadeEntradaProduto FROM INSERTED
		UPDATE tbProduto
		SET quantidadeProduto=quantidadeProduto+@qtddEntradaProduto
		WHERE codProduto=@codProduto
		PRINT ('Entrada de produto inserida com sucesso e atualização da quatidade de produto '+CONVERT(VARCHAR(5),@codProduto)+' atualizada com sucesso!')
	END

SELECT*FROM tbProduto

CREATE TRIGGER tgVendaAtualizaSaida
ON tbItensVenda
AFTER INSERT
AS
	BEGIN
		DECLARE @codProduto INT, @qtddSaidaProduto SMALLINT, @codSaidaProduto INT
		SELECT @codProduto=codProduto FROM INSERTED
		SELECT @qtddSaidaProduto=quantidadeItensVenda FROM INSERTED
		INSERT INTO tbSaidaProduto (dataSaidaProduto, codProduto, quantidadeSaidaProduto)
		VALUES (GETDATE(), @codProduto, @qtddSaidaProduto)
		SET @codSaidaProduto=(SELECT MAX(codSaidaProduto) FROM tbSaidaProduto)
		PRINT('Venda feita com sucesso e inserção da saída de produto de código '+CONVERT(VARCHAR(5),@codSaidaProduto))
	END
SELECT*FROM tbSaidaProduto