USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_ALTERAR_PRODUTO] (
											  @pIdUsuario		INT
											, @pIdProduto		INT
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
			RAISERROR('404;Usuário não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_produto WHERE IdProduto = @pIdProduto)
		BEGIN
			RAISERROR('404;Produto não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_fornecedor WHERE IdFornecedor = @pIdFornecedor)
		BEGIN
			RAISERROR('404;Fornecedor não encontrado', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_categoria WHERE IdCategoria = @pIdCategoria)
		BEGIN
			RAISERROR('404;Categoria não encontrada', 0, 1)
		END

		IF NOT EXISTS(SELECT * FROM tbl_sub_categoria WHERE IdSubCategoria = @pIdSubCategoria)
		BEGIN
			RAISERROR('404;Sub Categoria não encontrada', 0, 1)
		END

		
		BEGIN TRANSACTION

		--BLOCO DE CÓDIGO
		UPDATE tbl_produto SET
				  CodBarras			= @pCodBarras
				, NmProduto			= @pNmProduto
				, GeneroProduto		= @pGeneroProduto
				, ValorCompra		= @pValorCompra
				, ValorVenda		= @pValorVenda
				, EstoqueMaximo		= @pEstoqueMaximo
				, EstoqueMinimo		= @pEstoqueMinimo
				, Descricao			= @pDescricao
				, FotoProduto		= @pFotoProduto
				, IdFornecedor		= @pIdFornecedor
				, IdCategoria		= @pIdCategoria
				, IdSubCategoria	= @pIdCategoria
				, Quantidade		= @pQuantidade
		WHERE IdProduto = @pIdProduto

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