USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ALTERAR_CLIENTE] (
											  @pIdUsuario		INT
											, @pIdCliente		INT
											, @pNmCliente		VARCHAR(60)	
											, @pCpf				CHAR(11)	
											, @pCelular			CHAR(11)	
											, @pTelefone		CHAR(10)
											, @pSexo			CHAR(1)		
											, @pEmail			VARCHAR(60)	
											, @pDtNascimento	DATE
											, @pSituacao		VARCHAR(7)	
											, @pCep				CHAR(8)		
											, @pUf				CHAR(2)		
											, @pCidade			VARCHAR(50)	
											, @pBairro			VARCHAR(50)	
											, @pEndereco		VARCHAR(60)	
											, @pNumeroEndereco	INT			
											, @pComplemento		VARCHAR(50)
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_usuario WHERE IdUsuario = @pIdUsuario)
		BEGIN
			RAISERROR('404;Usuário não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_cliente WHERE IdCliente = @pIdCliente)
		BEGIN
			RAISERROR('404;Cliente não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		--BLOCO DE CÓDIGO
		UPDATE tbl_cliente SET
				  NmCliente			= @pNmCliente
				, Cpf				= @pCpf
				, Celular			= @pCelular
				, Telefone			= @pTelefone
				, Sexo				= @pSexo
				, Email				= @pEmail
				, DtNascimento		= @pDtNascimento
				, Situacao			= @pSituacao
				, Cep				= @pCep
				, Uf				= @pUf
				, Cidade			= @pCidade
				, Bairro			= @pBairro
				, Endereco			= @pEndereco
				, NumeroEndereco	= @pNumeroEndereco
				, Complemento		= @pComplemento
		WHERE IdCliente = @pIdCliente

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