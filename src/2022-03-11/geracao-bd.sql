CREATE DATABASE DBT001
GO
USE DBT001

CREATE TABLE tbl_cep (
    num_cep		   INT			NOT NULL
  , uf_cep		   CHAR(2)  
  , cidade_cep	   VARCHAR(50)
  , bairro_cep	   VARCHAR(50)
  , logradouro_cep VARCHAR(255)
  , PRIMARY KEY (num_cep)
)


CREATE TABLE tbl_forma_pagamento (
    IdFormaPagamento	INT			NOT NULL	IDENTITY
  , NmFormaPagamento	VARCHAR(30)
  , PRIMARY KEY (IdFormaPagamento)
)


CREATE TABLE tbl_cargo (
    IdCargo		INT				NOT NULL			IDENTITY
  , NmCargo		VARCHAR(30)		NOT NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , PRIMARY KEY (IdCargo)
)


CREATE TABLE tbl_categoria (
    IdCategoria		INT				NOT NULL			IDENTITY
  , NmCategoria		VARCHAR(50)		NOT NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , PRIMARY KEY (IdCategoria)
)


CREATE TABLE tbl_sub_categoria (
    IdSubCategoria	INT				NOT NULL			IDENTITY
  , NmSubCategoria	VARCHAR(50)		NOT NULL
  , IdCategoria		INT				NOT NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , PRIMARY KEY (IdSubCategoria)
  , FOREIGN KEY (IdCategoria)		REFERENCES tbl_categoria (IdCategoria)
)


CREATE TABLE tbl_funcionario (
    IdFuncionario	INT				NOT NULL			IDENTITY
  , NmFuncionario	VARCHAR(60)		NOT NULL
  , Cpf				CHAR(11)		NOT NULL			UNIQUE
  , Rg				CHAR(9)
  , Telefone		CHAR(10)		NOT NULL
  , Celular			CHAR(11)
  , Sexo			CHAR(1)			CHECK(Sexo = 'M' OR Sexo = 'F')
  , Email			VARCHAR(60)		NOT NULL			UNIQUE
  , DtNascimento	DATE			NOT NULL
  , DtAdmissao		DATE			NOT NULL
  , IdCargo			INT				NOT NULL
  , Salario			DECIMAL(10,2)
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , Cep				CHAR(8)			NOT NULL
  , Uf				CHAR(2)			NOT NULL
  , Cidade			VARCHAR(50)		NOT NULL
  , Bairro			VARCHAR(50)		NOT NULL
  , Endereco		VARCHAR(60)		NOT NULL
  , NumeroEndereco	INT				NOT NULL
  , Complemento		VARCHAR(50)
  , DtDemissao		DATE
  , PRIMARY KEY (IdFuncionario)
  , FOREIGN KEY (IdCargo)		REFERENCES tbl_cargo (IdCargo)
)


CREATE TABLE tbl_usuario (
    IdUsuario		INT				NOT NULL			IDENTITY
  , NmUsuario		VARCHAR(30)
  , Senha			VARCHAR(30)		DEFAULT '123'
  , IdCargo			INT				NOT NULL
  , IdFuncionario	INT				NOT NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , PRIMARY KEY(IdUsuario)
  , FOREIGN KEY(IdFuncionario)		REFERENCES tbl_funcionario	(IdFuncionario)
  , FOREIGN KEY(IdCargo)			REFERENCES tbl_cargo		(IdCargo)
)


CREATE TABLE tbl_fornecedor (
    IdFornecedor			INT				NOT NULL			IDENTITY
  , RazaoSocial				VARCHAR(60)		NOT NULL
  , NmFantasia				VARCHAR(60)		NOT NULL
  , Telefone				CHAR(10)		NOT NULL
  , Representante			VARCHAR(60)
  , Email					VARCHAR(60)		NOT NULL
  , Site					VARCHAR(60)
  , Cnpj					CHAR(14)		NOT NULL			UNIQUE
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , Cep						CHAR(8)			NOT NULL
  , Uf						CHAR(2)			NOT NULL
  , Cidade					VARCHAR(50)		NOT NULL
  , Bairro					VARCHAR(50)		NOT NULL
  , Endereco				VARCHAR(60)		NOT NULL
  , NumeroEndereco			INT				NOT NULL
  , PRIMARY KEY (IdFornecedor)
)


CREATE TABLE tbl_cliente (
    IdCliente		INT				NOT NULL			IDENTITY
  , NmCliente		VARCHAR(60)		NOT NULL
  , Cpf				CHAR(11)		NOT NULL			UNIQUE
  , Celular			CHAR(11)		NOT NULL
  , Telefone		CHAR(10)
  , Sexo			CHAR(1)			CHECK(Sexo = 'M' OR Sexo = 'F')
  , Email			VARCHAR(60)		NOT NULL
  , DtNascimento	DATE
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , Cep				CHAR(8)			NOT NULL
  , Uf				CHAR(2)			NOT NULL
  , Cidade			VARCHAR(50)		NOT NULL
  , Bairro			VARCHAR(50)		NOT NULL
  , Endereco		VARCHAR(60)		NOT NULL
  , NumeroEndereco	INT				NOT NULL
  , Complemento		VARCHAR(50)
  , PRIMARY KEY (IdCliente)
)


CREATE TABLE tbl_produto (
    IdProduto		INT				 NOT NULL			IDENTITY
  , CodBarras		VARCHAR(15)
  , NmProduto		VARCHAR(50)		 NOT NULL
  , GeneroProduto	VARCHAR(10)		 NOT NULL
  , ValorCompra		DECIMAL(10,2)    NOT NULL
  , ValorVenda		DECIMAL(10,2)    NOT NULL
  , EstoqueMaximo	INT				 DEFAULT	'100'
  , EstoqueMinimo	INT				 DEFAULT	'20'
  , Descricao		TEXT
  , FotoProduto		VARCHAR(MAX)
  , IdFornecedor	INT				NOT NULL
  , IdCategoria		INT				NOT NULL
  , IdSubCategoria	INT				NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , Quantidade		INT
  , PRIMARY KEY (IdProduto)
  , FOREIGN KEY (IdSubCategoria)	REFERENCES tbl_sub_categoria	(IdSubCategoria)
  , FOREIGN KEY (IdCategoria)		REFERENCES tbl_categoria		(IdCategoria)
  , FOREIGN KEY (IdFornecedor)		REFERENCES tbl_fornecedor		(IdFornecedor)
)


CREATE TABLE tbl_compra (
    IdCompra		INT				NOT NULL			IDENTITY
  , IdFuncionario	INT				NOT NULL
  , DtCompra		DATE			NOT NULL
  , ValorCompra		DECIMAL(10,2)	NOT NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , PRIMARY KEY (IdCompra)
  , FOREIGN KEY (IdFuncionario)		REFERENCES tbl_funcionario	(IdFuncionario)
)


CREATE TABLE tbl_item_compra (
    IdItemCompra	INT				NOT NULL	IDENTITY
  , IdCompra		INT				NOT NULL
  , IdProduto		INT				NOT NULL
  , Quantidade		INT				NOT NULL
  , Valor			DECIMAL(10,2)	NOT NULL
  , PRIMARY KEY (IdItemCompra)
  , FOREIGN KEY (IdProduto)			REFERENCES tbl_produto	(IdProduto)
  , FOREIGN KEY (IdCompra)			REFERENCES tbl_compra	(IdCompra)
)


CREATE TABLE tbl_venda (
    IdVenda			INT				NOT NULL			IDENTITY
  , IdFuncionario	INT				NOT NULL
  , IdCliente		INT				NOT NULL
  , Desconto		DECIMAL(10,2)
  , DtVenda			DATE			NOT NULL
  , ValorTotal		DECIMAL			NOT NULL
  , Ativo			BIT				DEFAULT 0		CHECK(Ativo = 0 OR Ativo = 1)
  , PRIMARY KEY(IdVenda)
  , FOREIGN KEY(IdCliente)			REFERENCES tbl_cliente		(IdCliente)
  , FOREIGN KEY(IdFuncionario)		REFERENCES tbl_funcionario	(IdFuncionario)
)


CREATE TABLE tbl_item_venda (
    IdItemVenda		INT			NOT NULL  IDENTITY
  , IdVenda			INT			NOT NULL
  , IdProduto		INT			NOT NULL
  , Quantidade		INT			NOT NULL
  , Valor			DECIMAL		NOT NULL
  , PRIMARY KEY (IdItemVenda)
  , FOREIGN KEY (IdVenda)		REFERENCES tbl_venda	(IdVenda)
  , FOREIGN KEY (IdProduto)		REFERENCES tbl_produto	(IdProduto)
)


CREATE TABLE tbl_pagamento_venda (
    IdPagamentoVenda	INT				NOT NULL   IDENTITY
  , IdFormaPagamento	INT				NOT NULL
  , IdVenda				INT				NOT NULL
  , Parcelas			INT
  , ValorPagamentoVenda	DECIMAL(10,2)
  , PRIMARY KEY(IdPagamentoVenda)
  , FOREIGN KEY(IdVenda)				REFERENCES tbl_venda			(IdVenda)
  , FOREIGN KEY(IdFormaPagamento)		REFERENCES tbl_forma_pagamento	(IdFormaPagamento)
)


INSERT INTO tbl_cargo (NmCargo) VALUES ('Gerente') , ('Vendedor') , ('Atendente');
INSERT INTO tbl_forma_pagamento	(NmFormaPagamento) VALUES ('Dinheiro'),('Débito'),('Crédito');

INSERT INTO tbl_categoria VALUES ('Perfumaria', 1),('Maquiagem', 1),('Corpo', 1),('Rosto', 1);

INSERT INTO tbl_sub_categoria VALUES ('Masculino', '1', 1),('Feminino', '1', 1),('Infantil','1', 1);
INSERT INTO tbl_sub_categoria VALUES ('Pele', '2', 1),('Olhos', '2', 1),('Lábios','2', 1),('Unhas','2', 1);
INSERT INTO tbl_sub_categoria VALUES ('Creme', '3', 1),('Esfoliante', '3', 1),('Hidratante','3', 1),('Massagem','3', 1);
INSERT INTO tbl_sub_categoria VALUES ('Gel de Limpeza', '4', 1),('Gel Esfoliante', '4', 1),('Sérum','4', 1),('Máscara Facial','4', 1);

INSERT INTO tbl_funcionario VALUES ('Kaique de Souza','47829991863','398194178','1126802151','11974413709','M','kaique16souza@hotmail.com','1999-04-15',GETDATE(),1,6.200,1,'06420190','SP','Barueri','Jardim Belval','Rua Getúlio Vargas',0,'Casa 2',NULL)
INSERT INTO tbl_usuario VALUES ('Kaique de Souza','123',1,1,1)