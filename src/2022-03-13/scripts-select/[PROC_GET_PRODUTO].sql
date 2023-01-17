USE [DBT001]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_GET_PRODUTO] AS

BEGIN
	SET NOCOUNT ON

	DECLARE   @ErrorMessage		VARCHAR(4000)
			, @ErrorSeverity	INT
			, @ErrorState		INT


	BEGIN TRY

		
		BEGIN TRANSACTION

		SELECT 
				  IdProduto
				, CodBarras			
				, NmProduto			
				, GeneroProduto		
				, ValorCompra		
				, ValorVenda		
				, EstoqueMaximo		
				, EstoqueMinimo		
				, Descricao			
				, tbl_produto.Situacao	
				, FotoProduto		
				, tbl_fornecedor.NmFantasia		
				, tbl_categoria.NmCategoria		
				, tbl_sub_categoria.NmSubCategoria	
				, Quantidade		
		FROM tbl_produto
			JOIN tbl_fornecedor ON tbl_fornecedor.IdFornecedor = tbl_produto.IdFornecedor
			JOIN tbl_categoria ON tbl_categoria.IdCategoria = tbl_produto.IdCategoria
			JOIN tbl_sub_categoria ON tbl_sub_categoria.IdSubCategoria = tbl_produto.IdSubCategoria

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