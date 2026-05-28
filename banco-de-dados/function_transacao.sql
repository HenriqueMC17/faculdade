-- Transações
	-- begin tran, ROLLBACK TRAN, COMMIT TRAN
	-- sp_who2 active (saber os processos que estão rodando)
	-- Kill <<processo>> (mata o processo)
-- Function
	-- Scalar Function


select * from Cliente
select * 
from Condicao_Pagamento

BEGIN TRAN
update Cliente set nome = 'Edson'
insert into Condicao_Pagamento values
( 'teste', 'teste')

ROLLBACK TRAN
COMMIT TRAN

-- descobrir o processo que está travando e matar
sp_who2 active

kill 56
-------------------
-- Scalar Function
select valor, dbo.desconto(valor, 0.1) desconto
from Item_Pedido

alter function desconto
(
	@valor numeric(10,2),
	@valorDesconto numeric(10,2)
) returns numeric(10,2) as
begin
	declare @total numeric(10,2)
	if (@valor < @valorDesconto)
		set @total = 0
	else
		set @total = @valor - @valorDesconto
	return @total
end