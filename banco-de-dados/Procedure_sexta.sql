-- DDL
	-- Programação no BD
		-- variável
		-- condicional
		-- Estrutura de repetição
		-- Storage Procedures
-- Variável
declare @nome varchar(100)
set @nome = 'Edson'
print('Meu nome é ' + @nome)
--select @nome
declare @numero int = 10
print('o número é ' + cast(@numero as varchar))

-- condicional
declare @num int = 20
if (@num > 15)
begin
	print('O número é maior que 15')
end
else
begin
	print('O número é menor ou igual a 15')
end

-- Passe um nome e o sexo e responda:
	-- senhor <<Nome>> ou senhorita <<nome>>
create procedure ola
(
	@nome varchar(100),
	@sexo varchar(1)
) as
if (@sexo = 'F')
	print('Olá senhorita ' +@nome)
else	
	print('Olá senhor ' + @nome)

-- executa uma procedure
ola 'Maria', 'F'

-- Estrutura de repetição
declare @i int = 1

while(@i <= 10)
begin
	print(@i)
	set @i = @i + 1
end
-----------
-- Faça uma procedure chamada tabuada_10
-- deve passar o número e retornará a tabuada
-- desse número
create procedure tabuada_10 
(
  @num int
) as
declare @cont int = 1
print('Tabuada do '+cast(@num as varchar))
while (@cont <= 10)
begin
	print(cast(@num as varchar) + ' X ' + 
		 cast(@cont as varchar) + ' = ' + 
		 cast((@cont * @num) as varchar))
	set @cont = @cont + 1
end

exec tabuada_10 135

-- excluir uma procedure
drop procedure tabuada_10

-- recuperar o código da procedure
sp_helptext tabuada_10