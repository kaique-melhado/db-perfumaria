USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_USUARIO] AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		
		BEGIN TRANSACTION

		SELECT 
			  IdUsuario
			, NmUsuario			
			, tbl_cargo.NmCargo			
			, tbl_funcionario.NmFuncionario		
			, tbl_usuario.Situacao			
		FROM tbl_usuario
		JOIN tbl_cargo ON tbl_usuario.IdCargo = tbl_cargo.IdCargo
		JOIN tbl_funcionario ON tbl_usuario.IdFuncionario = tbl_funcionario.IdFuncionario

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