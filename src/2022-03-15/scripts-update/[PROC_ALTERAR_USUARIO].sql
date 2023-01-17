USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ALTERAR_USUARIO] (
											  @pIdUsuarioAtualizacao	INT
											, @pIdUsuario				INT
											, @pNmUsuario				VARCHAR(30)
											, @pSenha					VARCHAR(30)	
											, @pIdCargo					INT			
											, @pIdFuncionario			INT			
											, @pSituacao				VARCHAR(7)
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

		IF NOT EXISTS(SELECT * FROM tbl_usuario WHERE IdUsuario = @pIdUsuario)
		BEGIN
			RAISERROR('404;Usuário não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_funcionario WHERE IdFuncionario = @pIdFuncionario)
		BEGIN
			RAISERROR('404;Funcionário não encontrado', 0, 1)
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

		--BLOCO DE CÓDIGO
		UPDATE tbl_usuario SET
			  NmUsuario			= @pNmUsuario
			, Senha				= @pSenha
			, IdCargo			= @pIdCargo
			, IdFuncionario		= @pIdFuncionario
			, Situacao			= @pSituacao
		WHERE IdUsuario = @pIdUsuario

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