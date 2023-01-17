USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_REMOVER_CATEGORIA] (
											  @pIdUsuario	INT
											, @pIdCategoria	INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_usuario WHERE IdUsuario = @pIdUsuario)
		BEGIN
			RAISERROR('404;Usuário de Atualização não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_categoria WHERE IdCategoria = @pIdCategoria)
		BEGIN
			RAISERROR('404;Categoria não encontrada', 0, 1)
		END

		
		BEGIN TRANSACTION

		UPDATE tbl_categoria
		SET Situacao = 'Inativo'
		WHERE IdCategoria = @pIdCategoria

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