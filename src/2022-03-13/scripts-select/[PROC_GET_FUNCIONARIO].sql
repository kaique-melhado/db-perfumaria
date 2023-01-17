USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_FUNCIONARIO]  AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		
		BEGIN TRANSACTION

		SELECT
			  NmFuncionario	
			, Cpf				
			, Rg				
			, Telefone		
			, Celular			
			, Sexo			
			, Email			
			, DtNascimento	
			, DtAdmissao		
			, tbl_cargo.NmCargo			
			, Salario			
			, tbl_funcionario.Situacao		
			, Cep				
			, Uf				
			, Cidade			
			, Bairro			
			, Endereco		
			, NumeroEndereco	
			, Complemento		
		FROM tbl_funcionario
			JOIN tbl_cargo ON tbl_funcionario.IdCargo = tbl_cargo.IdCargo

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