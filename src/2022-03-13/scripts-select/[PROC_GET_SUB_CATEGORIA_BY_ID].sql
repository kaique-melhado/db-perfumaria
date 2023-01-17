USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_SUB_CATEGORIA_BY_ID] (
											  @pIdSubCategoria	INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_sub_categoria WHERE IdSubCategoria = @pIdSubCategoria)
		BEGIN
			RAISERROR('404;Sub Categoria não encontrada', 0, 1)
		END

		
		BEGIN TRANSACTION

		SELECT 
			  IdSubCategoria
			, NmSubCategoria
			, tbl_categoria.IdCategoria
			, tbl_sub_categoria.Situacao
		FROM tbl_sub_categoria
			JOIN tbl_categoria ON tbl_categoria.IdCategoria = tbl_sub_categoria.IdCategoria
		WHERE IdSubCategoria = @pIdSubCategoria

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