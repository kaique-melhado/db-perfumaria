CREATE TRIGGER TGR_ATUALIZA_ESTOQUE_VENDA ON tbl_item_venda AFTER INSERT AS
	BEGIN
		UPDATE tbl_produto SET Quantidade = Quantidade - (SELECT Quantidade FROM inserted) WHERE IdProduto = (SELECT IdProduto FROM inserted);
	END

GO
