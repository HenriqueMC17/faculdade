-- DML
	-- Algumas funções para trabalhar com Datas
		--Getdate, Datediff, year, month, day

-- Getdate
select getdate()

-- Datediff
select DATEDIFF(MINUTE, '1982-11-30', getdate())

-- Year, Month, Day
select data, YEAR(data) ano,
MONTH(data) mes, day(data) dia
from Pedido
--where day(data) = 30

-- Quem são os clientes que NÃO fizeram pedidos?
select distinct c.*
from Cliente c inner join
	 Pedido p on c.cod_cliente = p.cod_cliente

-- Outros tipos de Join
	-- Inner, Left, Right, Full, Cross
-- Subselect
-- Teoria dos conjuntos

select c.*
from Cliente c left join
	 Pedido p on c.cod_cliente = p.cod_cliente
where p.cod_pedido is null

select c.*
from Cliente c full join
	 Pedido p on c.cod_cliente = p.cod_cliente
where p.cod_pedido is null

-- Subselect
select *
from Cliente
where cod_cliente not in
(
	select distinct c.cod_cliente
	from Cliente c inner join
		 Pedido p on c.cod_cliente = p.cod_cliente
)

select *
from Cliente
where not exists
(
	select null
	from Cliente c inner join
		 Pedido p on c.cod_cliente = p.cod_cliente
	where Cliente.cod_cliente = c.cod_cliente
)

-- Teoria dos conjuntos
-- União
select *
from Cliente
where sexo = 'F'
union
select *
from Cliente
where cidade = 'Sorocaba'

-- Intersecção
select *
from Cliente
where sexo = 'F'
intersect
select *
from Cliente
where cidade = 'Sorocaba'

-- menos
select *
from Cliente
where sexo = 'F'
except
select *
from Cliente
where cidade = 'Sorocaba'

----- Resolver o problema
select *
from Cliente
except
select distinct c.*
from Cliente c inner join
	 Pedido p on c.cod_cliente = p.cod_cliente