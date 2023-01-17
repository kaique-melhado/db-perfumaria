USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_REMOVER_PRODUTO] (
											  @pIdUsuarioAtualizacao	INT
											, @pIdProduto				INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_usuario WHERE IdUsuario = @pIdUsuarioAtualizacao)
		BEGIN
			RAISERROR('404;Usu�rio de Atualiza��o n�o encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_produto WHERE IdProduto = @pIdProduto)
		BEGIN
			RAISERROR('404;Produto n�o encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		--BLOCO DE C�DIGO
		UPDATE tbl_produto
		SET Situacao = 'Inativo'
		WHERE IdProduto = @pIdProduto

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