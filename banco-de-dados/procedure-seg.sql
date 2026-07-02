-- Programação em Banco de Dados
	-- Declaração de variáveis
	-- Estrutura condicional
	-- Estrutura de repetição
	-- Storage Procedure

-- Declaração de variáveis

declare @nome varchar(100)
set @nome = 'Edson'
print('Olá '+@nome)

declare @num int = 30
print('Número: ' + cast(@num as varchar))

--Estrutura condicional - SE
declare @numero int = 8
if (@numero > 10)
begin
	print('Número maior que 10')
end
else
begin
	print('Número menor ou igual a 10')
end

-- Procedure (armazenar a programação dentro do 
-- banco de dados)

-- Vou passar o nome e o sexo e a proc.
-- vai chamar de senhor ou senhorita
create procedure cumprimento
(
	@nome varchar(100),
	@sexo varchar(1)
) as
if (@sexo = 'M')
	print('Olá senhor '+@nome)
else
	print('Olá senhorita '+@nome)

-- executar uma procedure
exec cumprimento 'Edson', 'm'

-- estrutura de repetição
declare @i int = 1
while (@i <= 10)
begin
	print(@i)
	set @i = @i + 1
end
------------------------
-- Criar uma procedure chamada tabuada que 
-- recebe o número e mostra a tab. até o 10
alter procedure tabuada(@num int)
as
declare @cont int = 1
--set @num = 2
while (@cont <= 10)
begin
	print(cast(@num as varchar) + ' X ' + 
		  cast(@cont as varchar) + ' = ' +
		  cast((@num * @cont) as varchar))
	set @cont = @cont + 1
end

tabuada 36

-- faça uma proc que recebe o cod_pedido e um
-- percentual de desconto e retorna o total do pedido
-- com o Desconto
alter procedure descontoNoPedido
(
	@cod_pedido int,
	@perc_desconto float
) as
set @perc_desconto = @perc_desconto /100
select cod_pedido, 
    sum(quantidade * valor) total,
sum(quantidade * valor) * (1 - @perc_desconto) desconto
from Item_Pedido
where cod_pedido = @cod_pedido
group by cod_pedido

descontoNoPedido 1, 10