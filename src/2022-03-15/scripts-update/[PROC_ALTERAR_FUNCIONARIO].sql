USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ALTERAR_FUNCIONARIO] (
											  @pIdUsuario		INT
											, @pIdFuncionario	INT
											, @pNmFuncionario	VARCHAR(50)
											, @pCpf				CHAR(11)		
											, @pRg				CHAR(9)
											, @pTelefone		CHAR(10)		
											, @pCelular			CHAR(11)
											, @pSexo			CHAR(1)			
											, @pEmail			VARCHAR(60)		
											, @pDtNascimento	DATE			
											, @pDtAdmissao		DATE			
											, @pIdCargo			INT				
											, @pSalario			DECIMAL(10,2)
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

		IF NOT EXISTS(SELECT * FROM tbl_funcionario WHERE IdFuncionario = @pIdFuncionario)
		BEGIN
			RAISERROR('404;Funcionário não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_cargo WHERE IdCargo = @pIdCargo)
		BEGIN
			RAISERROR('404;Cargo não encontrado', 0, 1)
		END

		
		BEGIN TRANSACTION

		--BLOCO DE CÓDIGO
		UPDATE tbl_funcionario SET
			  NmFuncionario		= @pNmFuncionario
			, Cpf				= @pCpf
			, Rg				= @pRg
			, Telefone			= @pTelefone
			, Celular			= @pCelular
			, Sexo				= @pSexo
			, Email				= @pEmail
			, DtNascimento		= @pDtNascimento
			, DtAdmissao		= @pDtAdmissao
			, IdCargo			= @pIdCargo
			, Salario			= @pSalario
			, Situacao			= @pSalario
			, Cep				= @pCep
			, Uf				= @pUf
			, Cidade			= @pCidade
			, Bairro			= @pBairro
			, Endereco			= @pEndereco
			, NumeroEndereco	= @pNumeroEndereco
			, Complemento		= @pComplemento
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