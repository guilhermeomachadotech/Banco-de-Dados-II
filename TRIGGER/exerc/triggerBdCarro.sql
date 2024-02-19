USE bdCarro
GO
--Exerc�cio 1 Criar um trigger que ao ve�culo tomar uma multa os pontos da multa sejam  atualizados na tabela do motorista no campo pontuacaoAcumulada.
CREATE TRIGGER tgMultaAtualizaMotorista ON tbMulta FOR INSERT 
AS
	BEGIN
		DECLARE @numPontos INT, @codVeiculo INT, @codMotorista INT
		SELECT @numPontos=numPontos FROM INSERTED
		SELECT @codVeiculo=codVeiculo FROM INSERTED
		SET @codMotorista =(SELECT codMotorista FROM tbVeiculo WHERE codVeiculo=@codVeiculo )
		UPDATE tbMotorista
		SET pontuacaoAcumulada=pontuacaoAcumulada+@numPontos
		WHERE codMotorista = @codMotorista
		PRINT ('Atualiza��o de pontos acumulados (com '+CONVERT(VARCHAR(5),@numPontos)+' pontos adicionados) para o motorista de c�digo '+CONVERT(VARCHAR(5),@codMotorista)+ ' realizada com sucesso!')
	END
GO
--Exerc�cio 2 Criar um trigger que todas as vezes que o motorista atinja 20 pontos ou mais no campo pontuacaoAcumulada, sua situa��o seja alterada para SUSPENSO e o mesmo seja informado via mensagem
CREATE TRIGGER tgPontosSuspensos ON tbMotorista FOR UPDATE 
AS
	BEGIN
		DECLARE @pontuacao INT, @codMotorista INT
		SELECT @codMotorista=codMotorista FROM INSERTED
		SELECT @pontuacao=pontuacaoAcumulada FROM INSERTED
		IF (@pontuacao>= 20)
			BEGIN
				UPDATE tbMotorista
				SET situacao = 'SUSPENSO'
				WHERE codMotorista=@codMotorista
				PRINT ('Motorista de c�digo '+CONVERT(VARCHAR(5),@codMotorista)+' est� SUSPENSO devido a '+CONVERT(VARCHAR(5), @pontuacao)+' pontos acumulados')
			END
	END
GO