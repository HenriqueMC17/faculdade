-- SQL - Ling. de Consulta Estruturada
	-- DDL - Ling. de Definição de Dados
		-- Create | Alter | Drop
	-- DML - Ling. de Manipulação de Dados
		-- Select | Insert | Update | Delete
	-- DCL - Ling. de Controle de Dados
		-- Grant | Revoke
----------------

create database TransporteSex
go
use TransporteSex

create table Veiculo
(
	placa varchar(10) primary key,
	modelo varchar(100) not null,
	ano int not null,
	cor varchar(50) null
)
go

create table Motorista
(
	cod_motorista int identity(1,1) primary key,
	nome varchar(150) not null,
	email varchar(50) not null,
	telefone varchar(15) null,
	cnh varchar(50) not null
)
go
create table Passageiro
(
	cod_passageiro int identity(1,1) primary key,
	nome varchar(150) not null,
	rg varchar(15) not null,
	email varchar(150),
	telefone varchar(15)
)
go
create table Carga
(
	cod_carga int identity(1,1),
	quantidade int default(0),
	nome varchar(200) not null,
	primary key(cod_carga)
)
go
create table Manutencao
(
	cod_manutencao int identity(1,1) primary key,
	nome varchar(200) not null,
	valor numeric(10,2) not null,
	placa varchar(10) not null 
		references Veiculo(placa),
)
go

create table Viagem
(
	cod_viagem int identity(1,1) primary key,
	rua_origem varchar(150) not null,
	numero_origem varchar(20) not null,
	bairro_origem varchar(150) not null,
	cidade_origem varchar(150) not null,
	estado_origem varchar(2) not null,
	rua_destino varchar(150) not null,
	numero_destino varchar(20) not null,
	bairro_destino varchar(150) not null,
	cidade_destino varchar(150) not null,
	estado_destino varchar(2) not null,
	valor numeric(10,2) not null,
	data_saida datetime not null,
	data_retorno datetime,
	placa varchar(10) not null
		references Veiculo (placa),
	cod_motorista int not null
		references Motorista (cod_motorista)
)
go

create table Passageiro_Viagem
(
	cod_viagem int not null 
		references Viagem (cod_viagem),
	cod_passageiro int not null
		references Passageiro (cod_passageiro),
	primary key (cod_viagem, cod_passageiro)
)
go

create table Carga_Viagem
(
	cod_carga int not null,
	cod_viagem int not null,
	quantidade int not null,
	primary key (cod_carga, cod_viagem),
	foreign key (cod_carga) 
		references Carga (cod_carga),
	foreign key (cod_viagem)
		references Viagem (cod_viagem)
)
