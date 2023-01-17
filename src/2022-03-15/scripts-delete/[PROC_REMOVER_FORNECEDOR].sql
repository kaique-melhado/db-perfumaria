USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_REMOVER_FORNECEDOR] (
											  @pIdUsuarioAtualizacao	INT
											, @pIdFornecedor			INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_usuario WHERE IdUsuario = @pIdUsuarioAtualizacao)
		BEGIN
			RAISERROR('404;Usuário de Atualização não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_fornecedor WHERE IdFornecedor = @pIdFornecedor)
		BEGIN
			RAISERROR('404;Fornecedor não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		UPDATE tbl_fornecedor
		SET Situacao = 'Inativo'
		WHERE IdFornecedor = @pIdFornecedor

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