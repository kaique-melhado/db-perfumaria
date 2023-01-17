USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_INSERIR_PRODUTO] (
											  @pIdUsuario		INT
											, @pCodBarras		VARCHAR(15)
											, @pNmProduto		VARCHAR(50)		
											, @pGeneroProduto	VARCHAR(10)		
											, @pValorCompra		DECIMAL(10,2)   
											, @pValorVenda		DECIMAL(10,2)   
											, @pEstoqueMaximo	INT				
											, @pEstoqueMinimo	INT				
											, @pDescricao		TEXT
											, @pFotoProduto		VARCHAR(MAX)
											, @pIdFornecedor	INT				
											, @pIdCategoria		INT				
											, @pIdSubCategoria	INT				
											, @pQuantidade		INT
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

		IF NOT EXISTS(SELECT * FROM tbl_fornecedor WHERE IdFornecedor = @pIdFornecedor)
		BEGIN
			RAISERROR('404;Fornecedor não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_categoria WHERE IdCategoria = @pIdCategoria)
		BEGIN
			RAISERROR('404;Categoria não encontrada', 0, 1)
		END

		
		BEGIN TRANSACTION

		INSERT INTO tbl_produto (
				  CodBarras		
				, NmProduto		
				, GeneroProduto	
				, ValorCompra		
				, ValorVenda		
				, EstoqueMaximo	
				, EstoqueMinimo	
				, Descricao		
				, FotoProduto		
				, IdFornecedor	
				, IdCategoria		
				, IdSubCategoria	
				, Quantidade		
		)
		VALUES (
			    @pCodBarras		
			  , @pNmProduto		
			  , @pGeneroProduto	
			  , @pValorCompra		
			  , @pValorVenda		
			  , @pEstoqueMaximo	
			  , @pEstoqueMinimo	
			  , @pDescricao		
			  , @pFotoProduto		
			  , @pIdFornecedor	
			  , @pIdCategoria		
			  , @pIdSubCategoria	
			  , @pQuantidade		
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