CREATE VIEW VW_FUNCIONARIOS
AS
SELECT
	 funcionario.IdFuncionario
	,funcionario.NmFuncionario
	,funcionario.Cpf
	,funcionario.Telefone
	,funcionario.Email
	,funcionario.Ativo
	,funcionario.Rg
	,funcionario.Celular
	,funcionario.Sexo
	,funcionario.DtNascimento
	,funcionario.DtAdmissao
	,cargo.NmCargo
	,funcionario.Salario
	,funcionario.Cep
	,funcionario.Uf
	,funcionario.Cidade
	,funcionario.Bairro
	,funcionario.Endereco
	,funcionario.NumeroEndereco
	,funcionario.Complemento
FROM tbl_funcionario funcionario
JOIN tbl_cargo cargo ON funcionario.IdCargo = cargo.IdCargo