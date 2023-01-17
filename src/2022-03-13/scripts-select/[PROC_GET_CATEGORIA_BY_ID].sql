USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_CATEGORIA_BY_ID] (
											  @pIdCategoria	INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_categoria WHERE IdCategoria = @pIdCategoria)
		BEGIN
			RAISERROR('404;Categoria não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		SELECT 
			  IdCategoria
			, NmCategoria
			, Situacao
		FROM tbl_categoria
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