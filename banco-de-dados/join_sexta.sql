-- DML
	-- Select (Inner join)
	-- Insert
	-- Update
	-- Delete
	-- Algumas funções para trabalhar com string
	-- Algumas funções para trabalhar com Datas

-- Select (Inner join)
select COUNT(*) clientes from Cliente
select COUNT(*) pedidos from Pedido

select *
from Cliente, Pedido
where cliente.cod_cliente = pedido.cod_cliente

-- Quando o cliente Edson realizou os seus pedidos?
select Pedido.data
from Cliente, Pedido
where cliente.cod_cliente = pedido.cod_cliente
and Cliente.nome like 'Edson%'

select Pedido.data
from Cliente inner join
Pedido on Cliente.cod_cliente = Pedido.cod_cliente
where cliente.nome like 'Edson%'

-- Qual é a data do pedido e o nome do vendedor
-- que atendeu o cliente Edson
select c.nome as nomeCliente, data, 
	   v.nome as nomeVendedor
from Cliente c inner join
Pedido p on c.cod_cliente = p.cod_cliente inner join
Vendedor v on v.cod_vendedor = p.cod_vendedor
where c.nome like 'Edson%'

-- Insert - Inserir registros
-- Insert into <<NomeTabela>> values (<<valores>>)

-- Insert into <<NomeTabela>> (<<colunas>>)
-- values (<<valores>>)

select * from Condicao_Pagamento
insert into Condicao_Pagamento values
('Pix parcelado', 'pagamento em pix parcelado')

insert into Condicao_Pagamento values
('Pix parcelado', null)

select * from produto

insert into Produto (nome) values ('lousa')
insert into Produto (cod_marca, nome)
values (7, 'notebook')

-- Inserir um cliente com as suas informações (atividade)

-- Update - Atualizar dados de um ou mais registros
select *
from Cliente

-- update <<NomeTabela>> set <<coluna>> = <<valor>>
-- <<condições>>
update Cliente set email = 'daniela@gmail.com'

update Cliente set email = 'edson.feitosa@facens.br'
where cod_cliente = 1

update Cliente set 
	email = 'victor@gmail.com',
	cidade = 'Sorocaba',
	estado = 'SP'
where cod_cliente = 5

-- Delete - Excluir registros
-- delete from <<NomeTabela>> <<condições>>
select * 
-- delete
from Condicao_Pagamento
where cod_condicao_pagto > 6

-- integridade referencial
delete from Item_Pedido
delete from Pedido
delete from Cliente

-- Algumas funções para trabalhar com string
	-- Charindex, substring, reverse, replace

-- Crie o e-mail padrão para todos os clientes
-- no padrão primeiro.ultimoNome@facens.br
select nome, SUBSTRING(nome, 0, 7) pedaço
from Cliente

select nome, reverse(nome) from Cliente

select nome, CHARINDEX(' ', nome) posEspaco,
 SUBSTRING(nome, 0, CHARINDEX(' ', nome)) primeiroNome,
reverse(nome) nomeInvertido,
SUBSTRING(reverse(nome), 0, CHARINDEX(' ', reverse(nome))) sobrenomeInvertido,
reverse(SUBSTRING(reverse(nome), 0, CHARINDEX(' ', reverse(nome)))) sobrenome,

SUBSTRING(nome, 0, CHARINDEX(' ', nome)) + '.' +
reverse(SUBSTRING(reverse(nome), 0, CHARINDEX(' ', reverse(nome)))) +
'@facens.br'
from Cliente

