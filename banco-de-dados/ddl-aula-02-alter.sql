-- Aula 02 - DDL
	-- Alterar o esquema do banco de dados (Alter)
	-- Alterar a tabela
		-- Inserir colunas
		alter table Passageiro
			add cpf varchar(15) not null

		-- Alterar colunas existentes
		alter table Motorista
			alter column telefone varchar(20) not null

		-- Excluir colunas
			alter table Carga 
			drop constraint DF__Carga__quantidad__2A4B4B5E
			alter table Carga drop column quantidade

	-- Alterar o nome da coluna
		sp_rename 'Viagem.valor', 'valor_viagem', 'column'

	-- Alterar o nome da tabela
		sp_rename 'Passageiro_Viagem', 'Viagem_Passageiro'

	-- Alterar o nome do BD
		alter database TransporteSex
			modify name = TransporteSexta