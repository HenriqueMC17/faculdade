-- Correção dos Exercícios
--5.	Criar na tabela cliente a coluna número e colocar o 
--número da casa do cliente definida no final da coluna endereço.
alter table cliente add numero varchar(10)

select endereco, CHARINDEX(',', endereco) posVirgula,
SUBSTRING(endereco, CHARINDEX(',', endereco)+1, 
			LEN(endereco)) numero
from Cliente
where endereco like '%,%'

update Cliente set
	numero = SUBSTRING(endereco, CHARINDEX(',', endereco)+1, 
			LEN(endereco))
where endereco like '%,%'

--6.	Retirar o número da casa do campo endereço.
select  endereco, CHARINDEX(',', endereco) posVirgula,
SUBSTRING(endereco, 1, CHARINDEX(',', endereco)-1)
from Cliente
where endereco like '%,%'

update Cliente set
	endereco = SUBSTRING(endereco, 1, CHARINDEX(',', endereco)-1)
where endereco like '%,%'

select * from Cliente

-- 10.	Quantos produtos a empresa possui atualmente em estoque, 
--para casos de estoque negativo deve ser 
-- mostrado o valor 0(zero).

create view Estoque as
--tudo que comprei de cada produto
select compra.cod_produto, 
	compra.quantidade - venda.quantidade as total_estoque
from
(
	select p.cod_produto, p.nome, sum(quantidade) quantidade
	from Item_Compra ic inner join
		 Produto p on ic.cod_produto = p.cod_produto
	group by p.cod_produto, p.nome
) compra full join
(
	-- tudo que vendi de cada produto
	select p.cod_produto, p.nome, sum(quantidade) quantidade
	from Item_Pedido it inner join
		 Produto p on it.cod_produto = p.cod_produto
	group by p.cod_produto, p.nome
) venda on compra.cod_produto = venda.cod_produto

select * 
from Estoque