USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_CLIENTE_BY_ID] (
											  @pIdCliente		INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_cliente WHERE IdCliente = @pIdCliente)
		BEGIN
			RAISERROR('404;Cliente não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		SELECT 
				  NmCliente			
				, Cpf				
				, Celular			
				, Telefone			
				, Sexo				
				, Email				
				, DtNascimento		
				, Situacao			
				, Cep				
				, Uf				
				, Cidade			
				, Bairro			
				, Endereco			
				, NumeroEndereco	
				, Complemento		
		FROM tbl_cliente
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