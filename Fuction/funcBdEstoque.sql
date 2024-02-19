USE bdEstoqueFunction


--1)Criar uma função que retorne o dia da semana da venda (no formato segunda, terça, etc) ao lado do código da venda, valor totalda venda e sua data
CREATE FUNCTION funcDiaSemana (@data SMALLDATETIME)
RETURNS VARCHAR(60)
AS
	BEGIN
		DECLARE @dia INT, @diaSemana VARCHAR (60)
		SET @dia=DATEPART(DW,@data)
		IF (@dia=1)
			BEGIN
				SET @diaSemana='DOMINGO'
			END
		IF (@dia=2)
			BEGIN
				SET @diaSemana='SEGUNDA-FEIRA'
			END
		IF (@dia=3)
			BEGIN
				SET @diaSemana='TERÇA-FEIRA'
			END
		IF (@dia=4)
			BEGIN
				SET @diaSemana='QUARTA-FEIRA'
			END
		IF (@dia=5)
			BEGIN
				SET @diaSemana='QUINTA-FEIRA'
			END
		IF (@dia=6)
			BEGIN
				SET @diaSemana='SEXTA-FEIRA'
			END
		IF (@dia=7)
			BEGIN
				SET @diaSemana='SÁBADO'
			END
		RETURN @diaSemana
	END

SELECT codVenda AS 'ID da Venda', dataVenda AS 'Data da venda', 'Dia da Semana'=dbo.funcDiaSemana(dataVenda), valorTotalVenda AS 'Valor Total da venda' FROM tbVenda

--2)Criar uma função que receba o código do cliente e retorne o total de vendas que o cliente já realizou

CREATE FUNCTION funcTotalVendasCliente (@codCliente INT)
RETURNS INT
AS
	BEGIN 
		DECLARE @totalVendasCliente INT
		SET @totalVendasCliente=(SELECT COUNT(codVenda) FROM tbVenda WHERE codCliente=@codCliente)
		RETURN @totalVendasCliente 
	END
SELECT 'Vendas Realizada pelo cliente'=dbo.funcTotalVendasCliente(1) 
--3)Criar uma função que receba o código de um vendedor e o mês e informe o total de vendas do vendedor no mês informado

CREATE FUNCTION funcVendasTotalVendedor (@codVendedor INT, @mesVenda INT)
RETURNS SMALLMONEY 
AS
	BEGIN
		DECLARE  @totalVenda SMALLMONEY
		SET @totalVenda = (SELECT SUM(valorTotalVenda) FROM tbVenda WHERE codVendedor=@codVendedor AND @mesVenda=DATEPART(MONTH,dataVenda))
		RETURN @totalVenda
	END
SELECT*FROM tbVendedor
SELECT*FROM tbVenda
SELECT 'Total Vendido'=dbo.funcVendasTotalVendedor (4,5) 

--4)Criar uma função que usando o bdEstoque diga se o cpf do cliente é válido ou não

create FUNCTION funcValidarCPF (@cpf CHAR (11))
RETURNS VARCHAR(70)
AS
	BEGIN
		DECLARE @indice INT, @soma INT, @dig1 INT, @dig2 INT, @cpfTemp CHAR(11), @digitosIguais CHAR(1), @resultado CHAR(1)
		SET @resultado = 'N'
		SET @cpfTemp=SUBSTRING(@cpf,1,1)
		SET @indice=1
		SET @digitosIguais='S'

		WHILE (@indice<=11)
			BEGIN
				IF SUBSTRING(@cpf,@indice,1)<>@cpfTemp
					BEGIN 
						SET @digitosIguais='N'
						SET @indice=@indice+1
					END
			END
		IF @digitosIguais LIKE 'N'
			BEGIN
				SET @soma=0
				SET @indice=1
				WHILE (@indice<=9)
					BEGIN
						SET @soma=@soma+CONVERT (INT, SUBSTRING(@cpf,@indice,1))*(11-@indice)
						SET @indice=@indice+1
					END
				SET @dig1=11-(@soma%11)

				IF @dig1>9
					BEGIN
						SET @dig1=0
					END
				SET @soma=0
				SET @indice=1
				WHILE (@indice<10)
					BEGIN
						SET @soma=@soma+CONVERT(INT,SUBSTRING(@cpf,@indice,1))*(11-@indice)
						SET @indice=@indice+1
					END
				SET @dig2=11-(@soma%11)
				IF @dig2>9
					BEGIN
						SET @dig2=0
					END
				IF (@dig1=SUBSTRING(@cpf,LEN(@cpf)-1,1)) AND (@dig2=SUBSTRING(@cpf,LEN(@cpf),1))
					BEGIN
						SET @resultado='Válido'
					END
				ELSE
					BEGIN
						SET @resultado='Não Válido'
					END
			END
			RETURN @resultado
	END

SELECT codCliente AS 'ID do Cliente', cpfCliente AS 'CPF', 'VALIDAÇÂO DO CPF'=dbo.funcValidarCPF(cpfCliente) FROM tbCliente