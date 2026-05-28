-- DML - Ling. Manipulação de Dados
	-- Select simples (de uma tabela)
		-- Definição de colunas
		-- Condições de consulta
		-- Coringas do Like
		-- Ordenação de dados
		-- Nulo
		-- Funções simples (Sum, Count, Min, Max, Avg)
		-- Agrupamento de Dados

-- Definição de colunas
-- Quem são os meus clientes?
select * -- mostra todas as colunas
from Cliente

-- Quais os nomes, telefones e e-mail
-- dos meus clientes?
select nome, telefone, email
from Cliente

-- Condições de consulta
-- Quais são os clientes do sexo feminino?
select *
from Cliente
where sexo = 'F'

-- Tabela com critérios de comparação
-- = igual
-- != diferente
-- <> diferente
-- > Maior
-- < Menor
-- >= Maior ou Igual
-- <= Menor ou Igual

-- Elementos da Tabela Verdade
-- E -> AND
-- OU -> OR
-- NÃO -> NOT

--Mostre todas as mulheres da cidade de Sorocaba
select *
from Cliente
where sexo = 'F'
and cidade = 'Sorocaba'

--Mostre todas as mulheres 
-- da cidade de Sorocaba ou Votorantim
select *
from Cliente
where sexo = 'F'
and (cidade = 'Sorocaba'
or cidade = 'Votorantim')

select * 
from Cliente
where sexo = 'F'
and cidade in ('Sorocaba', 'Votorantim')

-- -- Coringas do Like
	-- % (significa qualquer coisa)
-- Mostre os dados dos clientes com o nome Edson
select *
from Cliente
where nome like 'Edson%'

-- Coringa _ (qualquer letra)
--Mostre o nome dos clientes onde a segunda letra
-- é a letra A
select *
from Cliente
where nome like '_a%'

-- Quem são os clientes com o e-mail errado?
select nome, email 
from Cliente
where email not like '_%@_%._%'

-- Coringa [] - conjunto
-- Mostre o nome dos clientes onde a segunda
-- letra vai do A até o D
select * 
from Cliente
where nome like '_[a-d]%'

-- Mostre os telefones válidos dos clientes
select telefone
from Cliente
where telefone 
like '([0-9][0-9])[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'

-- Coringa ^ (Negação)
-- Mostre o nome dos clientes que não possui
-- a letra N até o Z na primeira letra
select nome
from Cliente
where nome like '[^n-z]%'

-- Ordenação de dados
select *
from Cliente
order by nome desc

-- Ordene os clientes por cidade ascendente e depois
-- por nome decrescente
select cidade, nome
from Cliente
order by cidade asc, nome desc

-- Nulo
select email from Cliente
where email is not null

-- Quem são os clientes com o e-mail errado?
select nome, email 
from Cliente
where email not like '_%@_%._%'
or email is null

-- Funções simples (Sum, Count, Min, Max, Avg)
-- Sum -> Somar
select sum(valor) total
from Item_Pedido

-- Count -> Contar
select count(*) as quantidade
from Cliente

select 2 + 4 as soma

select min(valor) minimo from Item_Compra
select max(valor) maximo from Item_Compra
select avg(valor) media from Item_Compra

-- Agrupamento de Dados
--Quantos clientes homens e mulheres eu 
-- tenho cadastrado?
select sexo, count(*) as quantidade
from Cliente
group by sexo

-- Quantos clientes por cidade e sexo
select cidade, sexo, count(*) as quantidade
from Cliente
group by cidade, sexo
order by cidade 

