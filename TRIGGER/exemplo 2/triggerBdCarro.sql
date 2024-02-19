USE bdCarro

create TRIGGER tgAtualizaCarro
ON tbMulta 
AFTER INSERT
AS
	BEGIN
		DECLARE @codMotorista INT, @codVeiculo INT, @numPontos INT
		SET @codVeiculo =(SELECT @codVeiculo FROM INSERTED)
		SELECT @numPontos=numPontos FROM inserted
		SET @codMotorista=(SELECT codMotorista FROM tbVeiculo WHERE codVeiculo=@codVeiculo)
		UPDATE tbMotorista
		SET pontuacaoAcumuladaMotorista=pontuacaoAcumuladaMotorista+@numPontos
		WHERE codMotorista = @codMotorista
		PRINT ('Atualização da pontuação do motorista devido a multa executada com sucesso!')
	END

SELECT*FROM tbMulta
SELECT*FROM tbMotorista
SELECT*FROM tbVeiculo

INSERT INTO tbMotorista (nomeMotorista, cpfMotorista)
VALUES
	('Guilherme', '10284629017')

INSERT INTO tbVeiculo(placaVeiculo,renavam, anoFabricacao,codMotorista)
VALUES
	('1028735', '0297580279', 2023, 1)

INSERT INTO tbMulta (dataMulta, numPontos, codVeiculo)
VALUES
	(GETDATE(),5,1)