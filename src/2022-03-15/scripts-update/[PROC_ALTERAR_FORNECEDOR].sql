USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ALTERAR_FORNECEDOR] (
											  @pIdUsuario				INT
											, @pIdFornecedor			INT
											, @pRazaoSocial				VARCHAR(60)	
											, @pNmFantasia				VARCHAR(60)	
											, @pTelefone				CHAR(10)	
											, @pRepresentante			VARCHAR(60)
											, @pEmail					VARCHAR(60)	
											, @pSite					VARCHAR(60)
											, @pCnpj					CHAR(14)	
											, @pSituacao				VARCHAR(7)	
											, @pCep						CHAR(8)		
											, @pUf						CHAR(2)		
											, @pCidade					VARCHAR(50)	
											, @pBairro					VARCHAR(50)	
											, @pEndereco				VARCHAR(60)	
											, @pNumeroEndereco			INT		
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

		IF NOT EXISTS(SELECT * FROM tbl_fornecedor WHERE IdFornecedor = @pIdFornecedor)
		BEGIN
			RAISERROR('404;Fornecedor não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		--BLOCO DE CÓDIGO
		UPDATE tbl_fornecedor SET
			  RazaoSocial		= @pRazaoSocial
			, NmFantasia		= @pNmFantasia
			, Telefone			= @pTelefone
			, Representante		= @pRepresentante
			, Email				= @pEmail
			, Site				= @pSite
			, Cnpj				= @pCnpj
			, Situacao			= @pSituacao
			, Cep				= @pCep
			, Uf				= @pUf
			, Cidade			= @pCidade
			, Bairro			= @pBairro
			, Endereco			= @pEndereco
			, NumeroEndereco	= @pNumeroEndereco
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