USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_INSERIR_PAGAMENTO_VENDA] (
											  @pIdUsuario				INT
											, @pIdFormaPagamento		INT				
											, @pIdVenda					INT				
											, @pParcelas				INT
											, @pValorPagamentoVenda		DECIMAL(10,2)
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_usuario WHERE IdUsuario = @pIdUsuario)
		BEGIN
			RAISERROR('404;Usuário de atualização não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_venda WHERE IdVenda = @pIdVenda)
		BEGIN
			RAISERROR('404;Venda não encontrada', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_forma_pagamento WHERE IdFormaPagamento = @pIdFormaPagamento)
		BEGIN
			RAISERROR('404;Forma de pagamento não encontrada', 0, 1)
		END

		
		BEGIN TRANSACTION

		INSERT INTO tbl_pagamento_venda(
				    IdFormaPagamento	
				  , IdVenda				
				  , Parcelas			
				  , ValorPagamentoVenda	
		)
		VALUES (
			        @pIdFormaPagamento	
				  , @pIdVenda				
				  , @pParcelas			
				  , @pValorPagamentoVenda	
		)

		COMMIT


	END TRY
	BEGIN CATCH
		SELECT	  @ErrorMessage		= ERROR_MESSAGE()	+ ' - Rollback executado!'
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE()
		
		ROLLBACK
		RAISERROR(
			  @ErrorMessage
			, @ErrorSeverity
			, @ErrorState
		)
		RETURN
	END CATCH

END