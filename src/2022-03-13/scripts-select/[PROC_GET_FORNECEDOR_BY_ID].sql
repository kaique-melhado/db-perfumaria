USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_FORNECEDOR_BY_ID] (
											  @pIdFornecedor			INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_fornecedor WHERE IdFornecedor = @pIdFornecedor)
		BEGIN
			RAISERROR('404;Fornecedor não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		SELECT
			  RazaoSocial		
			, NmFantasia		
			, Telefone		
			, Representante	
			, Email			
			, Site			
			, Cnpj			
			, Situacao		
			, Cep				
			, Uf				
			, Cidade			
			, Bairro			
			, Endereco		
			, NumeroEndereco	
		FROM tbl_fornecedor
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