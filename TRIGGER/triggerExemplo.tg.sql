USE bdCaixa

alter TRIGGER tgVendasAtualizaCaixa
ON tbVendas
FOR INSERT
AS
BEGIN
	DECLARE @valor DECIMAL(10,2)
	DECLARE @data DATETIME

	SELECT @data=dataVenda, @valor=valor FROM INSERTED

	UPDATE tbCaixa
	SET saldo_final=saldo_final+@valor
	WHERE dataCaixa=@data

	PRINT('Funcionou e a tabela caixa foi atualizada!')
END
GO