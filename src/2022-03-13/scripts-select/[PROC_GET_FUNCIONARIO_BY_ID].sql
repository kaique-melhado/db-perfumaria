USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_FUNCIONARIO_BY_ID] (
											  @pIdFuncionario		INT
) AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		IF NOT EXISTS(SELECT * FROM tbl_funcionario WHERE IdFuncionario = @pIdFuncionario)
		BEGIN
			RAISERROR('404;Funcionário não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		--BLOCO DE CÓDIGO
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
		WHERE IdFuncionario = @pIdFuncionario

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