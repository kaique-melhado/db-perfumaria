USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_INSERIR_USUARIO] (
											  @pIdUsuario		INT
											, @pNmUsuario		VARCHAR(30)
											, @pSenha			VARCHAR(30)	
											, @pIdCargo			INT			
											, @pIdFuncionario	INT			
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

		IF NOT EXISTS(SELECT * FROM tbl_cargo WHERE IdCargo = @pIdCargo)
		BEGIN
			RAISERROR('404;Cargo não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_funcionario WHERE IdFuncionario = @pIdFuncionario)
		BEGIN
			RAISERROR('404;Funcionário não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		INSERT INTO tbl_usuario (
			  NmUsuario		
			, Senha			
			, IdCargo			
			, IdFuncionario	
		)
		VALUES (
			  @pNmUsuario		
			, @pSenha			
			, @pIdCargo			
			, @pIdFuncionario	
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