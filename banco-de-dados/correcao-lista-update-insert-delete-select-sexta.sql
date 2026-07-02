-- Correção de exercícios
-- 5.	Criar na tabela cliente a coluna número e colocar o 
-- número da casa do cliente definida no final da coluna 
-- endereço.

alter table cliente add numero varchar(200)

select endereco, CHARINDEX(',', endereco) posicaoVirgula
, SUBSTRING(endereco, CHARINDEX(',', endereco)+2, len(endereco))
from Cliente
where endereco is not null
and endereco like '%,%'

update Cliente set
numero = SUBSTRING(endereco, CHARINDEX(',', endereco)+2, len(endereco))
where endereco is not null
and endereco like '%,%'


-- 6.	Retirar o número da casa do campo endereço.
select endereco, CHARINDEX(',', endereco) posicaoVirgula,
SUBSTRING(endereco, 0, CHARINDEX(',', endereco))
from Cliente
where endereco is not null
and endereco like '%,%'

update Cliente set
endereco = SUBSTRING(endereco, 0, CHARINDEX(',', endereco))
where endereco is not null
and endereco like '%,%'

select endereco, numero
from Cliente



--9.	Selecione os itens de compra da empresa cuja 
-- razão social chama-se “BlaBla Ltda” e a 
--condição de pagamento foi realizada com pagamento em cheque, 
-- deve-se acrescentar um campo a mais na consulta que 
--tem o valor dos itens da compra com um desconto de R$0,10 
--e esse novo campo deve-se chamar desconto.
select ic.*, ic.valor - 0.10 desconto
from Item_Compra ic inner join
	 Compra c on ic.cod_compra = c.cod_compra inner join
	 Fornecedor f on f.cod_fornecedor = c.cod_fornecedor inner join
	 Condicao_Pagamento cp on cp.cod_condicao_pagto = c.cod_condicao_pagto
where f.razao = 'BlaBla Ltda'
and cp.nome = 'cheque'

select * from Condicao_Pagamento