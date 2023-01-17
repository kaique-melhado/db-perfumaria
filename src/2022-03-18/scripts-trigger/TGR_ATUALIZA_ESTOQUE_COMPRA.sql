CREATE TRIGGER TGR_ATUALIZA_ESTOQUE_COMPRA ON tbl_item_compra AFTER INSERT AS
	BEGIN
		UPDATE tbl_produto SET Quantidade = Quantidade + (SELECT Quantidade FROM inserted) WHERE IdProduto = (SELECT IdProduto FROM inserted);
	END

GO

