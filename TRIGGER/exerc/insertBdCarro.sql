--USE bdCarro
GO
CREATE PROCEDURE spInsertTbMotorista @nomeMotorista VARCHAR(100), @cpfMotorista CHAR (11)
AS
	BEGIN
		IF EXISTS (SELECT cpfMotorista FROM tbMotorista WHERE cpfMotorista LIKE @cpfMotorista)
			BEGIN
				PRINT ('O motorista de cpf '+@cpfMotorista+' já está cadastrado!')
			END
		ELSE
			BEGIN
				DECLARE @codMotorista INT
				INSERT INTO tbMotorista (nomeMotorista, cpfMotorista)
				VALUES (@nomeMotorista , @cpfMotorista)
				SET @codMotorista =(SELECT MAX(codMotorista) FROM tbMotorista)
				PRINT('Motorista de código '+CONVERT(VARCHAR(5),@codMotorista)+ ' inserido com sucesso!')
			END
	END
GO
EXEC spInsertTbMotorista 'Guilherme Pascareli', '10284629017' 
EXEC spInsertTbMotorista 'Carlos Eduardo', '10286590262' 
EXEC spInsertTbMotorista 'Thais Silva', '10367849026'  
EXEC spInsertTbMotorista 'Kailanny Fereira', '27891026729' 
EXEC spInsertTbMotorista 'Lauro Basto', '27902038461'  
EXEC spInsertTbMotorista 'Victor Santana', '24815620916'  
GO
--SELECT*FROM tbMotorista

CREATE PROCEDURE spInsertTbVeiculo  @placaVeiculo CHAR (7), @renavam CHAR (10), @anoFabricacao INT, @codMotorista INT
AS
	BEGIN
		IF EXISTS (SELECT placaVeiculo FROM tbVeiculo WHERE placaVeiculo LIKE @placaVeiculo)
			BEGIN
				PRINT ('Veiculo de placa '+@placaVeiculo+' já está cadastrado!')
			END
		ELSE
			BEGIN
				IF EXISTS (SELECT renavam FROM tbVeiculo WHERE renavam LIKE @renavam)
				BEGIN
					PRINT ('Renavam de código '+@renavam+' já está cadastrado!')
				END
			
				ELSE 
					BEGIN
						IF NOT EXISTS (SELECT codMotorista FROM tbMotorista WHERE codMotorista = @codMotorista)
							BEGIN
								PRINT ('Não existe motorista de código '+CONVERT(VARCHAR(5),@codMotorista)+'!')
							END
						ELSE
							BEGIN
								DECLARE @codVeiculo INT
								INSERT INTO tbVeiculo (placaVeiculo, renavam, anoFabricacao, codMotorista)
									VALUES (@placaVeiculo , @renavam, @anoFabricacao, @codMotorista)
								SET @codVeiculo =(SELECT MAX(codVeiculo) FROM tbVeiculo)
								PRINT('Veiculo de código '+CONVERT(VARCHAR(5),@codVeiculo)+ ' inserido com sucesso!')
							END
					END
			END
	END
GO

EXEC spInsertTbVeiculo 'BTY2E08', '02B0783902', 2014, 1
EXEC spInsertTbVeiculo 'GBK2905', '027H03782K', 2014, 1
EXEC spInsertTbVeiculo 'NSP29I5', '027I03782P', 2014, 2
EXEC spInsertTbVeiculo 'DHP290O','023MDH039O',2014, 2
EXEC spInsertTbVeiculo 'PEH206D','932MS936P1',2014, 3
EXEC spInsertTbVeiculo 'DFG26D7','936MD82578',2014, 3
EXEC spInsertTbVeiculo 'TPW268D','827DTH12I3',2014, 4
EXEC spInsertTbVeiculo 'GU926J9','837MD62YU1',2014, 5
EXEC spInsertTbVeiculo 'DFG1783','9278HDMS71',2014, 6
GO
--SELECT*FROM tbVeiculo
CREATE PROCEDURE spInsertTbMulta @numPontos INT, @codVeiculo INT
AS
	BEGIN
		IF NOT EXISTS (SELECT codVeiculo FROM tbVeiculo WHERE codVeiculo = @codVeiculo)
			BEGIN
				PRINT ('Não existe um veiculo de código '+CONVERT(VARCHAR(5),@codVeiculo)+' cadastrado!')
			END
		ELSE
			BEGIN
				DECLARE @codMulta INT
				INSERT INTO tbMulta (dataMulta, numPontos, codVeiculo)
				VALUES (GETDATE(), @numPontos, @codVeiculo)
				SET @codMulta =(SELECT MAX(codMulta) FROM tbMulta)
				PRINT('Multa de código '+CONVERT(VARCHAR(5),@codMulta)+ ' inserido com sucesso!')
			END
	END
GO

EXEC spInsertTbMulta 15, 1
EXEC spInsertTbMulta 5, 1
EXEC spInsertTbMulta 10, 2
EXEC spInsertTbMulta 10, 2
EXEC spInsertTbMulta 15, 3
EXEC spInsertTbMulta 20, 3
EXEC spInsertTbMulta 5, 4
EXEC spInsertTbMulta 5, 4
EXEC spInsertTbMulta 1, 5
EXEC spInsertTbMulta 3, 5
EXEC spInsertTbMulta 10, 6
EXEC spInsertTbMulta 2, 6
EXEC spInsertTbMulta 2, 7
EXEC spInsertTbMulta 2, 7
EXEC spInsertTbMulta 4, 8
EXEC spInsertTbMulta 10, 9
GO
--SELECT*FROM tbMulta 
--SELECT*FROM tbMotorista