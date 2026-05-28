create database RHAula;

use RHAula;

create table Setor
(
	cod_setor int auto_increment primary key,
    nome varchar(100) not null,
    ramal varchar(4) not null
);

create table Cargo
(
	cod_cargo int auto_increment primary key,
    salario decimal(10,2) not null,
    nome varchar(100) not null
);

create table Funcionario
(
	cod_funcionario int auto_increment primary key,
    nome varchar(200) not null,
    data_admissao datetime,
    cod_cargo int not null,
    cod_setor int not null,
    foreign key(cod_cargo) references Cargo(cod_cargo),
    foreign key(cod_setor) references Setor(cod_setor)
);



