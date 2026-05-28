-- View

-- Mostre o cliente, os pedidos, os vendedores
-- e a condição de pagamento do pedido
create view vw_PedidosCliente as
select c.cod_cliente, c.nome nomeCliente,
	   p.cod_pedido, p.data,
	   v.cod_vendedor, v.nome nomeVendedor,
	   cp.cod_condicao_pagto, cp.nome cond_pagto
from Cliente c inner join
Pedido p on c.cod_cliente = p.cod_cliente inner join
Vendedor v on v.cod_vendedor = p.cod_vendedor inner join
Condicao_Pagamento cp on cp.cod_condicao_pagto = p.cod_condicao_pagto

--Como executar uma view
--Quando o cliente Edson realizou os seus pedidos
-- e como ele pagou?
select nomeCliente, data, cond_pagto 
from vw_PedidosCliente
where nomeCliente like 'Edson%'

--Quanto o cliente Edson gastou por pedido e
-- qual foi a forma de pagamento
create view totais_pedidos as
select pc.cod_pedido, nomeCliente, pc.cond_pagto, 
	sum(it.quantidade * it.valor) total
from vw_PedidosCliente pc inner join
 Item_Pedido it on pc.cod_pedido = it.cod_pedido

group by nomeCliente, cond_pagto, pc.cod_pedido

-- Quanto foi gasto com cartão de crédito?
select sum(total) 
from totais_pedidos
where cond_pagto = 'cartão'

-- Como alterar uma view
select * 
from vw_PedidosCliente

--recupera do código-fonte da view
sp_helptext vw_PedidosCliente

alter view vw_PedidosCliente as  
select c.cod_cliente, c.nome nomeCliente,  
    p.cod_pedido, p.data,  
    v.cod_vendedor, v.nome nomeVendedor,  
    cp.cod_condicao_pagto, cp.nome cond_pagto  
from Cliente c inner join  
Pedido p on c.cod_cliente = p.cod_cliente inner join  
Vendedor v on v.cod_vendedor = p.cod_vendedor inner join  
Condicao_Pagamento cp on cp.cod_condicao_pagto = p.cod_condicao_pagto

--Excluir uma view
drop view totais_pedidos