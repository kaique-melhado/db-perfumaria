USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_INSERIR_VENDA] (
											  @pIdUsuario		INT
											, @pIdFuncionario	INT				
											, @pIdCliente		INT				
											, @pDesconto		DECIMAL(10,2)
											, @pDtVenda			DATE			
											, @pValorTotal		DECIMAL			
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

		IF NOT EXISTS(SELECT * FROM tbl_funcionario WHERE IdFuncionario = @pIdFuncionario)
		BEGIN
			RAISERROR('404;Funcionário não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_cliente WHERE IdCliente = @pIdCliente)
		BEGIN
			RAISERROR('404;Cliente não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		INSERT INTO tbl_venda (
				    IdFuncionario	
				  , IdCliente		
				  , Desconto		
				  , DtVenda			
				  , ValorTotal		
		)
		VALUES (
			        @pIdFuncionario	
				  , @pIdCliente		
				  , @pDesconto		
				  , @pDtVenda			
				  , @pValorTotal		
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