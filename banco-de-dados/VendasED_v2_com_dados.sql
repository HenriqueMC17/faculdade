use master
go

if exists(select name from sys.databases where name = 'VendasED')
	drop database VendasED
go

create database VendasED
go
use VendasED

create table Cliente
(
	cod_cliente int identity(1,1) primary key,
	nome varchar(100) not null,
	telefone varchar(15) null,
	rg varchar(10) null,
	cpf varchar(15) not null,
	email varchar(50) null,
	sexo varchar(1), 
	endereco varchar(50),
	bairro varchar(30),
	cidade varchar(30),
	estado varchar(2),

)
go

create table Pedido
(
	cod_pedido int identity(1,1) primary key,
	cod_cliente int not null,
	cod_vendedor int not null,
	cod_condicao_pagto int not null,
	data datetime not null
)
go

create table Item_Pedido
(
	cod_pedido int not null,
	cod_produto int not null,
	quantidade int,
	valor numeric(10,2) not null,
	constraint pk_item_pedido primary key (cod_pedido, cod_produto)
)
go

create table Vendedor
(
	cod_vendedor int identity(1,1) primary key,
	nome varchar(30) not null,
	telefone varchar(15) null,
	rg varchar(10) null,
	cpf varchar(15) not null,
	email varchar(50) null,
	sexo char(1)
)
go

create table Condicao_Pagamento
(
	cod_condicao_pagto int identity(1,1) primary key,
	nome varchar(40) not null,
	descricao varchar(300)
)
go

create table Marca
(
	cod_marca int identity(1,1) primary key,
	nome varchar(50) not null
)
go

create table Produto
(
	cod_produto int identity(1,1) primary key,
	nome varchar(50) not null,
	descricao varchar(300),
	cod_marca int references marca(cod_marca)
)
go


create table Produto_Fornecedor
(
	cod_produto_fornecedor int identity(1,1) primary key,
	cod_produto int not null,
	cod_fornecedor int not null,
	valor numeric(10, 2) not null
)
go

create table Item_Compra
(
	cod_item_compra int identity(1,1) primary key,
	cod_compra int not null,
	cod_produto int not null,
	quantidade int not null,
	valor numeric(10,2) not null
)
go

create table Fornecedor
(
	cod_fornecedor int identity(1,1) primary key,
	cpf varchar(15) null,
	nome varchar(30) null,
	telefone varchar(15) not null,
	cnpj varchar(30) null,
	razao varchar(50) null
)
go

create table Compra
(
	cod_compra int identity(1,1) primary key,
	cod_fornecedor int not null,
	cod_condicao_pagto int not null,
	data datetime not null
)
go


--relacionamentos
alter table pedido add constraint fk_pedido_cliente foreign key(cod_cliente) references cliente (cod_cliente) 
alter table pedido add constraint fk_pedido_condicao_pagto foreign key (cod_condicao_pagto) references condicao_pagamento (cod_condicao_pagto)
alter table pedido add constraint fk_pedido_vendedor foreign key (cod_vendedor) references vendedor (cod_vendedor)

alter table item_pedido add constraint fk_item_pedido_pedido foreign key (cod_pedido) references pedido (cod_pedido)
alter table item_pedido add constraint fk_item_pedido_produto foreign key (cod_produto) references produto (cod_produto)

alter table produto_fornecedor add constraint fk_produto_fornecedor_produto foreign key (cod_produto) references produto (cod_produto)
alter table produto_fornecedor add constraint fk_produto_fornecedor_fornecedor foreign key (cod_fornecedor) references fornecedor (cod_fornecedor)

alter table item_compra add constraint fk_item_compra_produto foreign key (cod_produto) references produto (cod_produto)
alter table item_compra add constraint fk_item_compra_compra foreign key (cod_compra) references compra (cod_compra)

alter table compra add constraint fk_compra_condicao_pagto foreign key (cod_condicao_pagto) references condicao_pagamento (cod_condicao_pagto)
alter table compra add constraint fk_compra_fornecedor foreign key (cod_fornecedor) references fornecedor (cod_fornecedor)
go

--inserção de dados
insert into cliente values('edson martin feitosa', '(15)1234-5678', '12234565', '222.222.333-50', 'edsonfeitosa@ig.com.br', 'M', 'Rua Orlando Alvagenga, 1', 'Jd. Vera Cruz', 'Sorocaba', 'SP')
insert into cliente values('rafael moreno', '(15)0000-0000', null, '222.622.332-50', 'rafael@terra.com.br', 'M', 'Rua Mario Quintana, 123', 'Jd. Vera Cruz', 'São Roque', 'SP')
insert into cliente values('daniela martin feitosa', null, null, '222.622.332-50', null, 'F', 'Rua Guilherme Oliveira, 12', 'Jd. Vera das Acássicas', 'Votorantim', 'SP')
insert into cliente values('renata cristina scudeler', '(15)0001-0300', '246886', '111.622.332-50', 'renatacristina@uol.com', 'F', 'Rua Orlando Alvagenga, 1', 'Jd. Vera Cruz', 'Sorocaba', 'SP')
insert into cliente(nome, telefone, rg, cpf, email, sexo ) values('victor gabriel', '', '2847574', '222.622.332-xx', 'victor_gabriel@gmail.com', 'M')
insert into cliente values('maria chiquinha', '(15)1001-0320', '246886', '111.622.332-50', 'maria@uol', 'F', 'Jd. Vera Cruz', 'Sorocaba', NULL, NULL)
insert into cliente values('Vanessa Oliveira', '01-0300', '246886', '111.622.332-50', 'vanessa', 'F', 'Rua Orlando Alvagenga, 1', 'Jd. Vera Cruz', 'Sorocaba', 'SP')
insert into cliente values('Dom Pedro de Alcantara Albuquerque', '(11)1245-0300', '2225885', '122.445.786-50', 'pedro@hotmail.com', 'M', 'Rua Pedro José Sanger, 34', 'Jd. Novo Mundo', 'Sorocaba', 'SP')

insert into Vendedor values('Joãozinho', '123454', '2475766', '123.123-12', 'joaozinho@ig.com.br', 'M')
insert into Vendedor values('Maria', '333586', '5846585', '124578963', 'maria@aol.com.br', 'M')

insert into fornecedor values('222.555.888-80', 'Joaquim Silva', '(011)2344-6644', NULL, NULL)
insert into fornecedor values(null, null, '(19)7447-6685', '2746563863', 'XPTO Ltda')
insert into fornecedor values(null, null, '(16)3388-1123', '4568524', 'BlaBla Ltda')

insert into marca values('faber castell')
insert into marca values('labra')
insert into marca values('reggg')
insert into marca values('bic')
insert into marca values ('compactor 07')
insert into marca values ('Caderno Brasil')

insert into produto values('caneta', null, 4)
insert into produto values('caneta', null, 5)
insert into produto values('caderno', '10 matérias', 6)
insert into produto values('lápis', null, 1)
insert into produto values('régua', '30 centímetros', 3)

insert into Condicao_Pagamento values('Dinheiro', 'pagamento a vista')
insert into Condicao_Pagamento values('Cheque', 'pagamento em cheque')
insert into Condicao_Pagamento values('cartão', 'pagamento em cartão')

insert into pedido values(1, 2, 1, getdate())
insert into pedido values(1, 1, 2, getdate() + 1)
insert into pedido values(2, 2, 2, getdate() + 1)
insert into pedido values(3, 2, 1, getdate() + 2)
insert into pedido values(4, 1, 1, getdate())
insert into pedido values(5, 1, 1, getdate() - 1)
insert into pedido values(5, 1, 1, getdate() - 10) 

insert into Item_Pedido values(1, 1, 3, 1.5)
insert into Item_Pedido values(1, 3, 1, 10.0)
insert into Item_Pedido values(1, 4, 5, 1)
insert into Item_Pedido values(2, 5, 1, 2.5)
insert into Item_Pedido values(2, 1, 2, 1.6)
insert into Item_Pedido values(2, 4, 2, 0.95)
insert into Item_Pedido values(2, 3, 1, 10.50)
insert into Item_Pedido values(3, 1, 1, 1.5)
insert into Item_Pedido values(4, 3, 100, 9.55)
insert into Item_Pedido values(4, 1, 250, 1.45)
insert into Item_Pedido values(5, 4, 3, 0.95)

--produto_fornecedor

insert into Produto_Fornecedor values(1, 2,  0.45)
insert into Produto_Fornecedor values(1, 2, 0.4)
insert into Produto_Fornecedor values(2, 1,  0.55)
insert into Produto_Fornecedor values (3, 1,  9)
insert into Produto_Fornecedor values (3, 1,  8.95)
insert into Produto_Fornecedor values (3, 1,  9.15)
insert into Produto_Fornecedor values (4, 1,  0.15)
insert into Produto_Fornecedor values (4, 2,   0.15)
insert into Produto_Fornecedor values (5, 3,  0.40)

insert into Compra values (3, 2, getdate() -3)
insert into Compra values (3, 3, GETDATE())
insert into Compra values (2, 1, getdate()-1)

insert into item_compra values(1, 1, 20, 2)
insert into item_compra values(1, 2, 5, 1.90)
insert into item_compra values(2, 2, 3, 2 )
insert into item_compra values(2, 4, 5, 1.1)
insert into item_compra values(3, 5, 6, 1.25)

GO

IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Faber-Castell') INSERT INTO Marca (nome) VALUES ('Faber-Castell');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Bic') INSERT INTO Marca (nome) VALUES ('Bic');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Tilibra') INSERT INTO Marca (nome) VALUES ('Tilibra');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Compactor') INSERT INTO Marca (nome) VALUES ('Compactor');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Pilot') INSERT INTO Marca (nome) VALUES ('Pilot');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Staedtler') INSERT INTO Marca (nome) VALUES ('Staedtler');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Chamex') INSERT INTO Marca (nome) VALUES ('Chamex');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Foroni') INSERT INTO Marca (nome) VALUES ('Foroni');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Canson') INSERT INTO Marca (nome) VALUES ('Canson');
IF NOT EXISTS (SELECT 1 FROM Marca WHERE nome = 'Companhia Papelaria') INSERT INTO Marca (nome) VALUES ('Companhia Papelaria');
GO

IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Faber-Castell Brasil') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Faber-Castell Brasil', '(11)4000-1111', '61.123.456/0001-11', 'Faber-Castell Brasil LTDA');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'BIC Brasil') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'BIC Brasil', '(11)4000-2222', '62.234.567/0001-22', 'BIC BRASIL LTDA');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Tilibra') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Tilibra', '(19)4000-3333', '63.345.678/0001-33', 'TILIBRA LTDA');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Compactor') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Compactor', '(11)4000-4444', '64.456.789/0001-44', 'COMPRACTOR IND LTDA');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Pilot Pen') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Pilot Pen', '(11)4000-5555', '65.567.890/0001-55', 'PILOT PEN BRASIL');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Staedtler do Brasil') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Staedtler do Brasil', '(11)4000-6666', '66.678.901/0001-66', 'STAEDTLER BRASIL');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Chamex') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Chamex', '(11)4000-7777', '67.789.012/0001-77', 'CHAMEX BRASIL');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Foroni') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Foroni', '(11)4000-8888', '68.890.123/0001-88', 'FORONI PAPELARIA');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Canson Brasil') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Canson Brasil', '(11)4000-9999', '69.901.234/0001-99', 'CANSON BRASIL');
IF NOT EXISTS (SELECT 1 FROM Fornecedor WHERE nome = 'Distribuidora Papelaria ABC') INSERT INTO Fornecedor (cpf, nome, telefone, cnpj, razao) VALUES (NULL, 'Distribuidora Papelaria ABC', '(19)4000-1010', '70.012.345/0001-10', 'DISTRIBUIDORA ABC LTDA');
GO

IF NOT EXISTS (SELECT 1 FROM Condicao_Pagamento WHERE nome = 'Pix') INSERT INTO Condicao_Pagamento (nome, descricao) VALUES ('Pix', 'Pagamento via Pix');
IF NOT EXISTS (SELECT 1 FROM Condicao_Pagamento WHERE nome = 'Transferência') INSERT INTO Condicao_Pagamento (nome, descricao) VALUES ('Transferência', 'Transferência bancária');
GO

IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '101.202.303-44' OR email = 'igor.mendes@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Igor Mendes','(11)98702-0011','2230001','101.202.303-44','igor.mendes@loja.com','M');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '202.303.404-55' OR email = 'beatriz.santos@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Beatriz Santos','(11)98702-0012','2230002','202.303.404-55','beatriz.santos@loja.com','F');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '303.404.505-66' OR email = 'henrique.rocha@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Henrique Rocha','(11)98702-0013','2230003','303.404.505-66','henrique.rocha@loja.com','M');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '404.505.606-77' OR email = 'marcos.paulo@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Marcos Paulo','(11)98702-0014','2230004','404.505.606-77','marcos.paulo@loja.com','M');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '505.606.707-88' OR email = 'renata.alves@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Renata Alves','(11)98702-0015','2230005','505.606.707-88','renata.alves@loja.com','F');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '606.707.808-99' OR email = 'sergio.lima@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Sergio Lima','(11)98702-0016','2230006','606.707.808-99','sergio.lima@loja.com','M');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '707.808.909-00' OR email = 'elisa.costa@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Elisa Costa','(11)98702-0017','2230007','707.808.909-00','elisa.costa@loja.com','F');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '808.909.010-11' OR email = 'fabio.duarte@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Fábio Duarte','(11)98702-0018','2230008','808.909.010-11','fabio.duarte@loja.com','M');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '909.010.111-22' OR email = 'tatiana.moreira@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Tatiana Moreira','(11)98702-0019','2230009','909.010.111-22','tatiana.moreira@loja.com','F');
IF NOT EXISTS (SELECT 1 FROM Vendedor WHERE cpf = '010.111.222-33' OR email = 'vitor.carvalho@loja.com') INSERT INTO Vendedor (nome, telefone, rg, cpf, email, sexo) VALUES ('Vitor Carvalho','(11)98702-0020','2230010','010.111.222-33','vitor.carvalho@loja.com','M');
GO

IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 1') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 1','Caneta esferográfica, ponta média',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 2') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 2','Caneta gel suave',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 3') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 3','Caderno brochura 100 folhas',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 4') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 4','Caderno espiral 200 folhas',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 5') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 5','Lápis grafite HB',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 6') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 6','Borracha macia',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 7') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 7','Régua plástica 30cm',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 8') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 8','Apontador simples',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 9') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 9','Marcador permanente ponta fina',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 10') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 10','Fichário 4 argolas',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 11') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 11','Papel sulfite A4 500 folhas',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 12') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 12','Envelope oficio 100g pacote',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 13') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 13','Caneta esferográfica, ponta média',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 14') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 14','Caneta gel suave',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 15') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 15','Caderno brochura 100 folhas',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 16') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 16','Caderno espiral 200 folhas',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 17') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 17','Lápis grafite HB',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 18') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 18','Borracha macia',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 19') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 19','Régua plástica 30cm',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 20') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 20','Apontador simples',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 21') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 21','Marcador permanente ponta fina',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 22') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 22','Fichário 4 argolas',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 23') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 23','Papel sulfite A4 500 folhas',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 24') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 24','Envelope oficio 100g pacote',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 25') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 25','Caneta esferográfica, ponta média',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 26') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 26','Caneta gel suave',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 27') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 27','Caderno brochura 100 folhas',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 28') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 28','Caderno espiral 200 folhas',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 29') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 29','Lápis grafite HB',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 30') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 30','Borracha macia',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 31') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 31','Régua plástica 30cm',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 32') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 32','Apontador simples',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 33') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 33','Marcador permanente ponta fina',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 34') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 34','Fichário 4 argolas',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 35') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 35','Papel sulfite A4 500 folhas',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 36') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 36','Envelope oficio 100g pacote',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 37') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 37','Caneta esferográfica, ponta média',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 38') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 38','Caneta gel suave',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 39') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 39','Caderno brochura 100 folhas',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 40') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 40','Caderno espiral 200 folhas',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 41') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 41','Lápis grafite HB',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 42') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 42','Borracha macia',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 43') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 43','Régua plástica 30cm',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 44') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 44','Apontador simples',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 45') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 45','Marcador permanente ponta fina',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 46') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 46','Fichário 4 argolas',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 47') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 47','Papel sulfite A4 500 folhas',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 48') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 48','Envelope oficio 100g pacote',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 49') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 49','Caneta esferográfica, ponta média',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 50') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 50','Caneta gel suave',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 51') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 51','Caderno brochura 100 folhas',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 52') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 52','Caderno espiral 200 folhas',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 53') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 53','Lápis grafite HB',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 54') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 54','Borracha macia',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 55') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 55','Régua plástica 30cm',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 56') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 56','Apontador simples',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 57') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 57','Marcador permanente ponta fina',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 58') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 58','Fichário 4 argolas',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 59') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 59','Papel sulfite A4 500 folhas',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 60') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 60','Envelope oficio 100g pacote',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 61') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 61','Caneta esferográfica, ponta média',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 62') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 62','Caneta gel suave',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 63') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 63','Caderno brochura 100 folhas',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 64') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 64','Caderno espiral 200 folhas',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 65') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 65','Lápis grafite HB',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 66') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 66','Borracha macia',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 67') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 67','Régua plástica 30cm',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 68') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 68','Apontador simples',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 69') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 69','Marcador permanente ponta fina',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 70') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 70','Fichário 4 argolas',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 71') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 71','Papel sulfite A4 500 folhas',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 72') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 72','Envelope oficio 100g pacote',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 73') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 73','Caneta esferográfica, ponta média',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 74') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 74','Caneta gel suave',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 75') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 75','Caderno brochura 100 folhas',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 76') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 76','Caderno espiral 200 folhas',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 77') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 77','Lápis grafite HB',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 78') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 78','Borracha macia',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 79') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 79','Régua plástica 30cm',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 80') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 80','Apontador simples',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 81') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 81','Marcador permanente ponta fina',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 82') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 82','Fichário 4 argolas',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 83') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 83','Papel sulfite A4 500 folhas',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 84') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 84','Envelope oficio 100g pacote',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 85') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 85','Caneta esferográfica, ponta média',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 86') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 86','Caneta gel suave',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 87') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 87','Caderno brochura 100 folhas',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 88') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 88','Caderno espiral 200 folhas',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 89') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 89','Lápis grafite HB',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 90') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 90','Borracha macia',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 91') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 91','Régua plástica 30cm',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 92') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 92','Apontador simples',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 93') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 93','Marcador permanente ponta fina',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 94') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 94','Fichário 4 argolas',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 95') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 95','Papel sulfite A4 500 folhas',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 96') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 96','Envelope oficio 100g pacote',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 97') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 97','Caneta esferográfica, ponta média',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 98') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 98','Caneta gel suave',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 99') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 99','Caderno brochura 100 folhas',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 100') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 100','Caderno espiral 200 folhas',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 101') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 101','Lápis grafite HB',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 102') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 102','Borracha macia',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 103') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 103','Régua plástica 30cm',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 104') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 104','Apontador simples',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 105') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 105','Marcador permanente ponta fina',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 106') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 106','Fichário 4 argolas',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 107') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 107','Papel sulfite A4 500 folhas',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 108') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 108','Envelope oficio 100g pacote',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta esferográfica 109') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta esferográfica 109','Caneta esferográfica, ponta média',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caneta gel 110') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caneta gel 110','Caneta gel suave',10);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno brochura 111') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno brochura 111','Caderno brochura 100 folhas',1);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Caderno espiral 112') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Caderno espiral 112','Caderno espiral 200 folhas',2);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Lápis HB 113') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Lápis HB 113','Lápis grafite HB',3);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Borracha 114') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Borracha 114','Borracha macia',4);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Régua 30cm 115') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Régua 30cm 115','Régua plástica 30cm',5);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Apontador 116') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Apontador 116','Apontador simples',6);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Marcador permanente 117') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Marcador permanente 117','Marcador permanente ponta fina',7);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Fichário 118') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Fichário 118','Fichário 4 argolas',8);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Papel A4 500fls 119') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Papel A4 500fls 119','Papel sulfite A4 500 folhas',9);
IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = 'Envelope 100g 120') INSERT INTO Produto (nome, descricao, cod_marca) VALUES ('Envelope 100g 120','Envelope oficio 100g pacote',10);
GO

IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 1 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (1, 1, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 2 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (2, 2, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 3 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (3, 3, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 4 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (4, 4, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 5 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (5, 5, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 6 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (6, 6, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 7 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (7, 7, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 8 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (8, 8, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 9 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (9, 9, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 10 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (10, 10, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 11 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (11, 1, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 12 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (12, 2, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 13 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (13, 3, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 14 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (14, 4, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 15 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (15, 5, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 16 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (16, 6, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 17 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (17, 7, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 18 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (18, 8, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 19 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (19, 9, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 20 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (20, 10, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 21 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (21, 1, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 22 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (22, 2, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 23 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (23, 3, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 24 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (24, 4, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 25 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (25, 5, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 26 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (26, 6, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 27 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (27, 7, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 28 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (28, 8, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 29 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (29, 9, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 30 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (30, 10, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 31 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (31, 1, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 32 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (32, 2, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 33 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (33, 3, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 34 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (34, 4, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 35 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (35, 5, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 36 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (36, 6, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 37 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (37, 7, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 38 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (38, 8, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 39 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (39, 9, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 40 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (40, 10, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 41 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (41, 1, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 42 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (42, 2, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 43 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (43, 3, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 44 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (44, 4, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 45 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (45, 5, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 46 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (46, 6, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 47 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (47, 7, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 48 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (48, 8, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 49 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (49, 9, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 50 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (50, 10, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 51 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (51, 1, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 52 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (52, 2, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 53 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (53, 3, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 54 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (54, 4, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 55 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (55, 5, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 56 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (56, 6, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 57 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (57, 7, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 58 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (58, 8, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 59 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (59, 9, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 60 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (60, 10, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 61 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (61, 1, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 62 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (62, 2, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 63 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (63, 3, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 64 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (64, 4, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 65 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (65, 5, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 66 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (66, 6, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 67 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (67, 7, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 68 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (68, 8, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 69 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (69, 9, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 70 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (70, 10, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 71 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (71, 1, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 72 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (72, 2, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 73 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (73, 3, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 74 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (74, 4, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 75 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (75, 5, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 76 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (76, 6, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 77 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (77, 7, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 78 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (78, 8, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 79 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (79, 9, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 80 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (80, 10, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 81 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (81, 1, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 82 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (82, 2, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 83 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (83, 3, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 84 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (84, 4, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 85 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (85, 5, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 86 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (86, 6, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 87 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (87, 7, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 88 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (88, 8, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 89 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (89, 9, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 90 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (90, 10, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 91 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (91, 1, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 92 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (92, 2, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 93 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (93, 3, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 94 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (94, 4, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 95 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (95, 5, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 96 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (96, 6, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 97 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (97, 7, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 98 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (98, 8, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 99 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (99, 9, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 100 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (100, 10, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 101 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (101, 1, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 102 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (102, 2, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 103 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (103, 3, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 104 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (104, 4, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 105 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (105, 5, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 106 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (106, 6, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 107 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (107, 7, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 108 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (108, 8, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 109 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (109, 9, 3.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 110 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (110, 10, 4.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 111 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (111, 1, 12.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 112 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (112, 2, 18.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 113 AND cod_fornecedor = 3) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (113, 3, 1.2);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 114 AND cod_fornecedor = 4) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (114, 4, 0.8);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 115 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (115, 5, 2.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 116 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (116, 6, 1.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 117 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (117, 7, 6.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 118 AND cod_fornecedor = 8) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (118, 8, 22.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 119 AND cod_fornecedor = 9) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (119, 9, 45.0);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 120 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (120, 10, 5.5);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 1 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (1, 5, 3.32);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 2 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (2, 6, 4.66);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 3 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (3, 7, 11.4);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 6 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (6, 10, 0.76);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 7 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (7, 1, 2.38);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 8 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (8, 2, 1.04);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 11 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (11, 5, 42.75);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 12 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (12, 6, 5.22);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 13 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (13, 7, 3.32);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 16 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (16, 10, 17.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 17 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (17, 1, 1.14);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 18 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (18, 2, 0.76);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 21 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (21, 5, 6.17);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 22 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (22, 6, 20.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 23 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (23, 7, 42.75);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 26 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (26, 10, 4.66);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 27 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (27, 1, 11.4);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 28 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (28, 2, 17.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 31 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (31, 5, 2.38);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 32 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (32, 6, 1.04);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 33 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (33, 7, 6.17);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 36 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (36, 10, 5.22);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 37 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (37, 1, 3.32);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 38 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (38, 2, 4.66);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 41 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (41, 5, 1.14);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 42 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (42, 6, 0.76);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 43 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (43, 7, 2.38);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 46 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (46, 10, 20.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 47 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (47, 1, 42.75);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 48 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (48, 2, 5.22);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 51 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (51, 5, 11.4);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 52 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (52, 6, 17.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 53 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (53, 7, 1.14);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 56 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (56, 10, 1.04);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 57 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (57, 1, 6.17);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 58 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (58, 2, 20.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 61 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (61, 5, 3.32);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 62 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (62, 6, 4.66);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 63 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (63, 7, 11.4);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 66 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (66, 10, 0.76);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 67 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (67, 1, 2.38);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 68 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (68, 2, 1.04);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 71 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (71, 5, 42.75);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 72 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (72, 6, 5.22);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 73 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (73, 7, 3.32);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 76 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (76, 10, 17.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 77 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (77, 1, 1.14);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 78 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (78, 2, 0.76);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 81 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (81, 5, 6.17);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 82 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (82, 6, 20.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 83 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (83, 7, 42.75);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 86 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (86, 10, 4.66);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 87 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (87, 1, 11.4);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 88 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (88, 2, 17.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 91 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (91, 5, 2.38);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 92 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (92, 6, 1.04);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 93 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (93, 7, 6.17);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 96 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (96, 10, 5.22);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 97 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (97, 1, 3.32);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 98 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (98, 2, 4.66);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 101 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (101, 5, 1.14);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 102 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (102, 6, 0.76);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 103 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (103, 7, 2.38);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 106 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (106, 10, 20.9);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 107 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (107, 1, 42.75);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 108 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (108, 2, 5.22);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 111 AND cod_fornecedor = 5) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (111, 5, 11.4);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 112 AND cod_fornecedor = 6) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (112, 6, 17.1);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 113 AND cod_fornecedor = 7) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (113, 7, 1.14);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 116 AND cod_fornecedor = 10) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (116, 10, 1.04);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 117 AND cod_fornecedor = 1) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (117, 1, 6.17);
IF NOT EXISTS (SELECT 1 FROM Produto_Fornecedor WHERE cod_produto = 118 AND cod_fornecedor = 2) INSERT INTO Produto_Fornecedor (cod_produto, cod_fornecedor, valor) VALUES (118, 2, 20.9);
GO

IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000001') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Souza 1','(15)910000001','1000001','00700000001','fernando.souza1@exemplo.com','M','Rua Exemplo 1, 2','Jd. Bela Vista','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000002') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Silva 2','(15)910000002','1000002','00700000002','mariana.silva2@exemplo.com','F','Rua Exemplo 2, 3','Centro','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000003') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Oliveira 3','(15)910000003','1000003','00700000003','gustavo.oliveira3@exemplo.com','M','Rua Exemplo 3, 4','Vila Rica','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000004') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Pereira 4','(15)910000004','1000004','00700000004','camila.pereira4@exemplo.com','F','Rua Exemplo 4, 5','Jd. Primavera','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000005') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Costa 5','(15)910000005','1000005','00700000005','ricardo.costa5@exemplo.com','M','Rua Exemplo 5, 6','Vila Nova','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000006') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Ribeiro 6','(15)910000006','1000006','00700000006','patricia.ribeiro6@exemplo.com','F','Rua Exemplo 6, 7','Santa Maria','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000007') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Almeida 7','(15)910000007','1000007','00700000007','bruno.almeida7@exemplo.com','M','Rua Exemplo 7, 8','Jd. Florida','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000008') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Fernandes 8','(15)910000008','1000008','00700000008','juliana.fernandes8@exemplo.com','F','Rua Exemplo 8, 9','Vila São Jorge','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000009') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Gomes 9','(15)910000009','1000009','00700000009','eduardo.gomes9@exemplo.com','M','Rua Exemplo 9, 10','B. da Saude','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000010') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Martins 10','(15)910000010','1000010','00700000010','aline.martins10@exemplo.com','F','Rua Exemplo 10, 11','Jd. Paulista','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000011') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Souza 11','(15)910000011','1000011','00700000011','lucas.souza11@exemplo.com','M','Rua Exemplo 11, 12','Vila Industrial','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000012') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Silva 12','(15)910000012','1000012','00700000012','larissa.silva12@exemplo.com','F','Rua Exemplo 12, 13','B. Novo','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000013') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Oliveira 13','(15)910000013','1000013','00700000013','fernando.oliveira13@exemplo.com','M','Rua Exemplo 13, 14','Jd. Bela Vista','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000014') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Pereira 14','(15)910000014','1000014','00700000014','mariana.pereira14@exemplo.com','F','Rua Exemplo 14, 15','Centro','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000015') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Costa 15','(15)910000015','1000015','00700000015','gustavo.costa15@exemplo.com','M','Rua Exemplo 15, 16','Vila Rica','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000016') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Ribeiro 16','(15)910000016','1000016','00700000016','camila.ribeiro16@exemplo.com','F','Rua Exemplo 16, 17','Jd. Primavera','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000017') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Almeida 17','(15)910000017','1000017','00700000017','ricardo.almeida17@exemplo.com','M','Rua Exemplo 17, 18','Vila Nova','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000018') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Fernandes 18','(15)910000018','1000018','00700000018','patricia.fernandes18@exemplo.com','F','Rua Exemplo 18, 19','Santa Maria','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000019') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Gomes 19','(15)910000019','1000019','00700000019','bruno.gomes19@exemplo.com','M','Rua Exemplo 19, 20','Jd. Florida','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000020') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Martins 20','(15)910000020','1000020','00700000020','juliana.martins20@exemplo.com','F','Rua Exemplo 20, 21','Vila São Jorge','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000021') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Souza 21','(15)910000021','1000021','00700000021','eduardo.souza21@exemplo.com','M','Rua Exemplo 21, 22','B. da Saude','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000022') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Silva 22','(15)910000022','1000022','00700000022','aline.silva22@exemplo.com','F','Rua Exemplo 22, 23','Jd. Paulista','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000023') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Oliveira 23','(15)910000023','1000023','00700000023','lucas.oliveira23@exemplo.com','M','Rua Exemplo 23, 24','Vila Industrial','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000024') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Pereira 24','(15)910000024','1000024','00700000024','larissa.pereira24@exemplo.com','F','Rua Exemplo 24, 25','B. Novo','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000025') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Costa 25','(15)910000025','1000025','00700000025','fernando.costa25@exemplo.com','M','Rua Exemplo 25, 26','Jd. Bela Vista','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000026') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Ribeiro 26','(15)910000026','1000026','00700000026','mariana.ribeiro26@exemplo.com','F','Rua Exemplo 26, 27','Centro','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000027') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Almeida 27','(15)910000027','1000027','00700000027','gustavo.almeida27@exemplo.com','M','Rua Exemplo 27, 28','Vila Rica','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000028') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Fernandes 28','(15)910000028','1000028','00700000028','camila.fernandes28@exemplo.com','F','Rua Exemplo 28, 29','Jd. Primavera','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000029') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Gomes 29','(15)910000029','1000029','00700000029','ricardo.gomes29@exemplo.com','M','Rua Exemplo 29, 30','Vila Nova','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000030') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Martins 30','(15)910000030','1000030','00700000030','patricia.martins30@exemplo.com','F','Rua Exemplo 30, 31','Santa Maria','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000031') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Souza 31','(15)910000031','1000031','00700000031','bruno.souza31@exemplo.com','M','Rua Exemplo 31, 32','Jd. Florida','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000032') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Silva 32','(15)910000032','1000032','00700000032','juliana.silva32@exemplo.com','F','Rua Exemplo 32, 33','Vila São Jorge','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000033') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Oliveira 33','(15)910000033','1000033','00700000033','eduardo.oliveira33@exemplo.com','M','Rua Exemplo 33, 34','B. da Saude','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000034') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Pereira 34','(15)910000034','1000034','00700000034','aline.pereira34@exemplo.com','F','Rua Exemplo 34, 35','Jd. Paulista','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000035') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Costa 35','(15)910000035','1000035','00700000035','lucas.costa35@exemplo.com','M','Rua Exemplo 35, 36','Vila Industrial','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000036') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Ribeiro 36','(15)910000036','1000036','00700000036','larissa.ribeiro36@exemplo.com','F','Rua Exemplo 36, 37','B. Novo','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000037') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Almeida 37','(15)910000037','1000037','00700000037','fernando.almeida37@exemplo.com','M','Rua Exemplo 37, 38','Jd. Bela Vista','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000038') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Fernandes 38','(15)910000038','1000038','00700000038','mariana.fernandes38@exemplo.com','F','Rua Exemplo 38, 39','Centro','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000039') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Gomes 39','(15)910000039','1000039','00700000039','gustavo.gomes39@exemplo.com','M','Rua Exemplo 39, 40','Vila Rica','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000040') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Martins 40','(15)910000040','1000040','00700000040','camila.martins40@exemplo.com','F','Rua Exemplo 40, 41','Jd. Primavera','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000041') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Souza 41','(15)910000041','1000041','00700000041','ricardo.souza41@exemplo.com','M','Rua Exemplo 41, 42','Vila Nova','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000042') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Silva 42','(15)910000042','1000042','00700000042','patricia.silva42@exemplo.com','F','Rua Exemplo 42, 43','Santa Maria','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000043') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Oliveira 43','(15)910000043','1000043','00700000043','bruno.oliveira43@exemplo.com','M','Rua Exemplo 43, 44','Jd. Florida','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000044') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Pereira 44','(15)910000044','1000044','00700000044','juliana.pereira44@exemplo.com','F','Rua Exemplo 44, 45','Vila São Jorge','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000045') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Costa 45','(15)910000045','1000045','00700000045','eduardo.costa45@exemplo.com','M','Rua Exemplo 45, 46','B. da Saude','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000046') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Ribeiro 46','(15)910000046','1000046','00700000046','aline.ribeiro46@exemplo.com','F','Rua Exemplo 46, 47','Jd. Paulista','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000047') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Almeida 47','(15)910000047','1000047','00700000047','lucas.almeida47@exemplo.com','M','Rua Exemplo 47, 48','Vila Industrial','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000048') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Fernandes 48','(15)910000048','1000048','00700000048','larissa.fernandes48@exemplo.com','F','Rua Exemplo 48, 49','B. Novo','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000049') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Gomes 49','(15)910000049','1000049','00700000049','fernando.gomes49@exemplo.com','M','Rua Exemplo 49, 50','Jd. Bela Vista','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000050') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Martins 50','(15)910000050','1000050','00700000050','mariana.martins50@exemplo.com','F','Rua Exemplo 50, 51','Centro','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000051') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Souza 51','(15)910000051','1000051','00700000051','gustavo.souza51@exemplo.com','M','Rua Exemplo 51, 52','Vila Rica','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000052') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Silva 52','(15)910000052','1000052','00700000052','camila.silva52@exemplo.com','F','Rua Exemplo 52, 53','Jd. Primavera','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000053') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Oliveira 53','(15)910000053','1000053','00700000053','ricardo.oliveira53@exemplo.com','M','Rua Exemplo 53, 54','Vila Nova','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000054') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Pereira 54','(15)910000054','1000054','00700000054','patricia.pereira54@exemplo.com','F','Rua Exemplo 54, 55','Santa Maria','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000055') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Costa 55','(15)910000055','1000055','00700000055','bruno.costa55@exemplo.com','M','Rua Exemplo 55, 56','Jd. Florida','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000056') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Ribeiro 56','(15)910000056','1000056','00700000056','juliana.ribeiro56@exemplo.com','F','Rua Exemplo 56, 57','Vila São Jorge','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000057') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Almeida 57','(15)910000057','1000057','00700000057','eduardo.almeida57@exemplo.com','M','Rua Exemplo 57, 58','B. da Saude','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000058') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Fernandes 58','(15)910000058','1000058','00700000058','aline.fernandes58@exemplo.com','F','Rua Exemplo 58, 59','Jd. Paulista','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000059') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Gomes 59','(15)910000059','1000059','00700000059','lucas.gomes59@exemplo.com','M','Rua Exemplo 59, 60','Vila Industrial','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000060') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Martins 60','(15)910000060','1000060','00700000060','larissa.martins60@exemplo.com','F','Rua Exemplo 60, 61','B. Novo','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000061') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Souza 61','(15)910000061','1000061','00700000061','fernando.souza61@exemplo.com','M','Rua Exemplo 61, 62','Jd. Bela Vista','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000062') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Silva 62','(15)910000062','1000062','00700000062','mariana.silva62@exemplo.com','F','Rua Exemplo 62, 63','Centro','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000063') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Oliveira 63','(15)910000063','1000063','00700000063','gustavo.oliveira63@exemplo.com','M','Rua Exemplo 63, 64','Vila Rica','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000064') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Pereira 64','(15)910000064','1000064','00700000064','camila.pereira64@exemplo.com','F','Rua Exemplo 64, 65','Jd. Primavera','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000065') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Costa 65','(15)910000065','1000065','00700000065','ricardo.costa65@exemplo.com','M','Rua Exemplo 65, 66','Vila Nova','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000066') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Ribeiro 66','(15)910000066','1000066','00700000066','patricia.ribeiro66@exemplo.com','F','Rua Exemplo 66, 67','Santa Maria','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000067') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Almeida 67','(15)910000067','1000067','00700000067','bruno.almeida67@exemplo.com','M','Rua Exemplo 67, 68','Jd. Florida','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000068') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Fernandes 68','(15)910000068','1000068','00700000068','juliana.fernandes68@exemplo.com','F','Rua Exemplo 68, 69','Vila São Jorge','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000069') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Gomes 69','(15)910000069','1000069','00700000069','eduardo.gomes69@exemplo.com','M','Rua Exemplo 69, 70','B. da Saude','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000070') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Martins 70','(15)910000070','1000070','00700000070','aline.martins70@exemplo.com','F','Rua Exemplo 70, 71','Jd. Paulista','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000071') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Souza 71','(15)910000071','1000071','00700000071','lucas.souza71@exemplo.com','M','Rua Exemplo 71, 72','Vila Industrial','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000072') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Silva 72','(15)910000072','1000072','00700000072','larissa.silva72@exemplo.com','F','Rua Exemplo 72, 73','B. Novo','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000073') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Oliveira 73','(15)910000073','1000073','00700000073','fernando.oliveira73@exemplo.com','M','Rua Exemplo 73, 74','Jd. Bela Vista','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000074') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Pereira 74','(15)910000074','1000074','00700000074','mariana.pereira74@exemplo.com','F','Rua Exemplo 74, 75','Centro','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000075') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Costa 75','(15)910000075','1000075','00700000075','gustavo.costa75@exemplo.com','M','Rua Exemplo 75, 76','Vila Rica','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000076') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Ribeiro 76','(15)910000076','1000076','00700000076','camila.ribeiro76@exemplo.com','F','Rua Exemplo 76, 77','Jd. Primavera','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000077') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Almeida 77','(15)910000077','1000077','00700000077','ricardo.almeida77@exemplo.com','M','Rua Exemplo 77, 78','Vila Nova','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000078') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Fernandes 78','(15)910000078','1000078','00700000078','patricia.fernandes78@exemplo.com','F','Rua Exemplo 78, 79','Santa Maria','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000079') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Gomes 79','(15)910000079','1000079','00700000079','bruno.gomes79@exemplo.com','M','Rua Exemplo 79, 80','Jd. Florida','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000080') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Martins 80','(15)910000080','1000080','00700000080','juliana.martins80@exemplo.com','F','Rua Exemplo 80, 81','Vila São Jorge','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000081') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Souza 81','(15)910000081','1000081','00700000081','eduardo.souza81@exemplo.com','M','Rua Exemplo 81, 82','B. da Saude','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000082') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Silva 82','(15)910000082','1000082','00700000082','aline.silva82@exemplo.com','F','Rua Exemplo 82, 83','Jd. Paulista','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000083') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Oliveira 83','(15)910000083','1000083','00700000083','lucas.oliveira83@exemplo.com','M','Rua Exemplo 83, 84','Vila Industrial','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000084') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Pereira 84','(15)910000084','1000084','00700000084','larissa.pereira84@exemplo.com','F','Rua Exemplo 84, 85','B. Novo','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000085') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Costa 85','(15)910000085','1000085','00700000085','fernando.costa85@exemplo.com','M','Rua Exemplo 85, 86','Jd. Bela Vista','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000086') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Ribeiro 86','(15)910000086','1000086','00700000086','mariana.ribeiro86@exemplo.com','F','Rua Exemplo 86, 87','Centro','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000087') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Almeida 87','(15)910000087','1000087','00700000087','gustavo.almeida87@exemplo.com','M','Rua Exemplo 87, 88','Vila Rica','Ribeirão Preto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000088') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Fernandes 88','(15)910000088','1000088','00700000088','camila.fernandes88@exemplo.com','F','Rua Exemplo 88, 89','Jd. Primavera','Limeira','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000089') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Ricardo Gomes 89','(15)910000089','1000089','00700000089','ricardo.gomes89@exemplo.com','M','Rua Exemplo 89, 90','Vila Nova','Atibaia','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000090') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Patricia Martins 90','(15)910000090','1000090','00700000090','patricia.martins90@exemplo.com','F','Rua Exemplo 90, 91','Santa Maria','Santos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000091') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Bruno Souza 91','(15)910000091','1000091','00700000091','bruno.souza91@exemplo.com','M','Rua Exemplo 91, 92','Jd. Florida','Guarulhos','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000092') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Juliana Silva 92','(15)910000092','1000092','00700000092','juliana.silva92@exemplo.com','F','Rua Exemplo 92, 93','Vila São Jorge','Sorocaba','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000093') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Eduardo Oliveira 93','(15)910000093','1000093','00700000093','eduardo.oliveira93@exemplo.com','M','Rua Exemplo 93, 94','B. da Saude','São Paulo','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000094') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Aline Pereira 94','(15)910000094','1000094','00700000094','aline.pereira94@exemplo.com','F','Rua Exemplo 94, 95','Jd. Paulista','Campinas','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000095') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Lucas Costa 95','(15)910000095','1000095','00700000095','lucas.costa95@exemplo.com','M','Rua Exemplo 95, 96','Vila Industrial','Votorantim','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000096') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Larissa Ribeiro 96','(15)910000096','1000096','00700000096','larissa.ribeiro96@exemplo.com','F','Rua Exemplo 96, 97','B. Novo','São Roque','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000097') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Fernando Almeida 97','(15)910000097','1000097','00700000097','fernando.almeida97@exemplo.com','M','Rua Exemplo 97, 98','Jd. Bela Vista','Itu','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000098') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Mariana Fernandes 98','(15)910000098','1000098','00700000098','mariana.fernandes98@exemplo.com','F','Rua Exemplo 98, 99','Centro','Salto','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000099') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Gustavo Gomes 99','(15)910000099','1000099','00700000099','gustavo.gomes99@exemplo.com','M','Rua Exemplo 99, 100','Vila Rica','Jundiaí','SP');
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cpf = '00700000100') INSERT INTO Cliente (nome, telefone, rg, cpf, email, sexo, endereco, bairro, cidade, estado) VALUES ('Camila Martins 100','(15)910000100','1000100','00700000100','camila.martins100@exemplo.com','F','Rua Exemplo 100, 101','Jd. Primavera','Ribeirão Preto','SP');
GO

INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -7, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -14, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -21, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -28, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -35, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -42, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -49, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -56, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -63, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -70, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -77, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -84, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -91, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -98, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -105, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -112, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -119, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -126, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -133, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -140, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -147, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -154, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -161, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -168, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -175, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -182, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -189, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -196, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -203, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -210, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -217, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -224, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -231, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -238, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -245, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -252, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -259, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -266, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -273, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -280, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -287, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -294, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -301, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -308, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -315, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -322, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -329, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -336, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -343, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -350, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -357, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -364, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -371, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -378, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -385, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -392, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -399, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -406, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -413, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -420, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -427, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -434, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -441, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -448, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -455, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -462, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -469, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -476, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -483, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -490, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -497, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -504, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -511, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -518, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -525, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -532, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -539, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -546, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -553, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -560, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -567, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -574, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -581, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -588, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -595, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -602, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -609, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -616, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -623, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -630, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -637, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -644, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -651, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -658, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -665, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -672, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -679, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -686, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -693, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -700, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -707, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -714, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -721, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -728, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -735, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -742, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -749, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -756, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -763, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -770, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -777, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -784, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -791, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -798, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -805, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -812, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -819, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -826, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -833, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -840, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -847, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -854, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -861, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -868, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -875, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -882, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -889, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -896, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -903, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -910, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -917, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -924, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -931, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -938, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -945, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -952, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -959, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -966, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -973, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -980, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -987, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -994, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -1001, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -1008, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -1015, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -1022, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -1029, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -1036, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -1043, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -1050, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -1057, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -1064, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -1071, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -1078, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -1085, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -1092, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -1099, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -1106, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -1113, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -1120, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -1127, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -1134, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -1141, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -1148, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -1155, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -1162, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -1169, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -1176, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -1183, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -1190, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -1197, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -1204, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -1211, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -1218, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -1225, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -1232, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -1239, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -1246, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -1253, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -1260, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -1267, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -1274, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -1281, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -1288, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -1295, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -1302, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -1309, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -1316, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -1323, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -1330, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (1, 1, DATEADD(day, -1337, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (2, 2, DATEADD(day, -1344, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (3, 3, DATEADD(day, -1351, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (4, 4, DATEADD(day, -1358, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (5, 5, DATEADD(day, -1365, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (6, 1, DATEADD(day, -1372, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (7, 2, DATEADD(day, -1379, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (8, 3, DATEADD(day, -1386, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (9, 4, DATEADD(day, -1393, GETDATE()));
INSERT INTO Compra (cod_fornecedor, cod_condicao_pagto, data) VALUES (10, 5, DATEADD(day, -0, GETDATE()));
GO

INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (1, 2, 24, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (1, 3, 25, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (1, 4, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (2, 3, 37, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (2, 5, 38, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (2, 7, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (3, 4, 50, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (3, 7, 51, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (3, 10, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (4, 5, 63, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (4, 9, 64, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (4, 13, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (5, 6, 76, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (5, 11, 77, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (5, 16, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (6, 7, 89, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (6, 13, 90, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (6, 19, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (7, 8, 11, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (7, 15, 12, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (7, 22, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (8, 9, 24, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (8, 17, 25, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (8, 25, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (9, 10, 37, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (9, 19, 38, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (9, 28, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (10, 11, 50, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (10, 21, 51, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (10, 31, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (11, 12, 63, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (11, 23, 64, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (11, 34, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (12, 13, 76, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (12, 25, 77, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (12, 37, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (13, 14, 89, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (13, 27, 90, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (13, 40, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (14, 15, 11, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (14, 29, 12, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (14, 43, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (15, 16, 24, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (15, 31, 25, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (15, 46, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (16, 17, 37, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (16, 33, 38, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (16, 49, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (17, 18, 50, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (17, 35, 51, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (17, 52, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (18, 19, 63, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (18, 37, 64, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (18, 55, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (19, 20, 76, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (19, 39, 77, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (19, 58, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (20, 21, 89, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (20, 41, 90, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (20, 61, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (21, 22, 11, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (21, 43, 12, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (21, 64, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (22, 23, 24, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (22, 45, 25, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (22, 67, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (23, 24, 37, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (23, 47, 38, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (23, 70, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (24, 25, 50, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (24, 49, 51, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (24, 73, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (25, 26, 63, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (25, 51, 64, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (25, 76, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (26, 27, 76, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (26, 53, 77, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (26, 79, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (27, 28, 89, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (27, 55, 90, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (27, 82, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (28, 29, 11, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (28, 57, 12, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (28, 85, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (29, 30, 24, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (29, 59, 25, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (29, 88, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (30, 31, 37, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (30, 61, 38, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (30, 91, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (31, 32, 50, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (31, 63, 51, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (31, 94, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (32, 33, 63, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (32, 65, 64, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (32, 97, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (33, 34, 76, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (33, 67, 77, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (33, 100, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (34, 35, 89, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (34, 69, 90, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (34, 103, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (35, 36, 11, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (35, 71, 12, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (35, 106, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (36, 37, 24, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (36, 73, 25, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (36, 109, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (37, 38, 37, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (37, 75, 38, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (37, 112, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (38, 39, 50, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (38, 77, 51, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (38, 115, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (39, 40, 63, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (39, 79, 64, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (39, 118, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (40, 41, 76, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (40, 81, 77, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (40, 1, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (41, 42, 89, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (41, 83, 90, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (41, 4, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (42, 43, 11, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (42, 85, 12, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (42, 7, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (43, 44, 24, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (43, 87, 25, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (43, 10, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (44, 45, 37, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (44, 89, 38, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (44, 13, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (45, 46, 50, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (45, 91, 51, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (45, 16, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (46, 47, 63, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (46, 93, 64, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (46, 19, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (47, 48, 76, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (47, 95, 77, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (47, 22, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (48, 49, 89, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (48, 97, 90, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (48, 25, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (49, 50, 11, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (49, 99, 12, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (49, 28, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (50, 51, 24, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (50, 101, 25, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (50, 31, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (51, 52, 37, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (51, 103, 38, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (51, 34, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (52, 53, 50, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (52, 105, 51, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (52, 37, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (53, 54, 63, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (53, 107, 64, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (53, 40, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (54, 55, 76, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (54, 109, 77, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (54, 43, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (55, 56, 89, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (55, 111, 90, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (55, 46, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (56, 57, 11, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (56, 113, 12, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (56, 49, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (57, 58, 24, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (57, 115, 25, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (57, 52, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (58, 59, 37, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (58, 117, 38, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (58, 55, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (59, 60, 50, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (59, 119, 51, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (59, 58, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (60, 61, 63, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (60, 1, 64, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (60, 61, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (61, 62, 76, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (61, 3, 77, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (61, 64, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (62, 63, 89, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (62, 5, 90, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (62, 67, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (63, 64, 11, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (63, 7, 12, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (63, 70, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (64, 65, 24, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (64, 9, 25, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (64, 73, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (65, 66, 37, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (65, 11, 38, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (65, 76, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (66, 67, 50, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (66, 13, 51, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (66, 79, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (67, 68, 63, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (67, 15, 64, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (67, 82, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (68, 69, 76, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (68, 17, 77, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (68, 85, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (69, 70, 89, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (69, 19, 90, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (69, 88, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (70, 71, 11, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (70, 21, 12, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (70, 91, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (71, 72, 24, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (71, 23, 25, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (71, 94, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (72, 73, 37, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (72, 25, 38, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (72, 97, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (73, 74, 50, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (73, 27, 51, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (73, 100, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (74, 75, 63, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (74, 29, 64, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (74, 103, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (75, 76, 76, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (75, 31, 77, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (75, 106, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (76, 77, 89, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (76, 33, 90, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (76, 109, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (77, 78, 11, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (77, 35, 12, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (77, 112, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (78, 79, 24, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (78, 37, 25, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (78, 115, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (79, 80, 37, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (79, 39, 38, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (79, 118, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (80, 81, 50, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (80, 41, 51, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (80, 1, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (81, 82, 63, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (81, 43, 64, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (81, 4, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (82, 83, 76, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (82, 45, 77, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (82, 7, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (83, 84, 89, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (83, 47, 90, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (83, 10, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (84, 85, 11, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (84, 49, 12, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (84, 13, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (85, 86, 24, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (85, 51, 25, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (85, 16, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (86, 87, 37, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (86, 53, 38, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (86, 19, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (87, 88, 50, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (87, 55, 51, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (87, 22, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (88, 89, 63, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (88, 57, 64, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (88, 25, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (89, 90, 76, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (89, 59, 77, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (89, 28, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (90, 91, 89, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (90, 61, 90, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (90, 31, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (91, 92, 11, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (91, 63, 12, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (91, 34, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (92, 93, 24, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (92, 65, 25, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (92, 37, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (93, 94, 37, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (93, 67, 38, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (93, 40, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (94, 95, 50, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (94, 69, 51, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (94, 43, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (95, 96, 63, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (95, 71, 64, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (95, 46, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (96, 97, 76, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (96, 73, 77, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (96, 49, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (97, 98, 89, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (97, 75, 90, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (97, 52, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (98, 99, 11, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (98, 77, 12, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (98, 55, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (99, 100, 24, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (99, 79, 25, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (99, 58, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (100, 101, 37, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (100, 81, 38, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (100, 61, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (101, 102, 50, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (101, 83, 51, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (101, 64, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (102, 103, 63, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (102, 85, 64, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (102, 67, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (103, 104, 76, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (103, 87, 77, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (103, 70, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (104, 105, 89, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (104, 89, 90, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (104, 73, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (105, 106, 11, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (105, 91, 12, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (105, 76, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (106, 107, 24, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (106, 93, 25, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (106, 79, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (107, 108, 37, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (107, 95, 38, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (107, 82, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (108, 109, 50, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (108, 97, 51, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (108, 85, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (109, 110, 63, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (109, 99, 64, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (109, 88, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (110, 111, 76, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (110, 101, 77, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (110, 91, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (111, 112, 89, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (111, 103, 90, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (111, 94, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (112, 113, 11, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (112, 105, 12, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (112, 97, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (113, 114, 24, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (113, 107, 25, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (113, 100, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (114, 115, 37, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (114, 109, 38, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (114, 103, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (115, 116, 50, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (115, 111, 51, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (115, 106, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (116, 117, 63, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (116, 113, 64, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (116, 109, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (117, 118, 76, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (117, 115, 77, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (117, 112, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (118, 119, 89, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (118, 117, 90, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (118, 115, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (119, 120, 11, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (119, 119, 12, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (119, 118, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (120, 1, 24, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (120, 1, 25, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (120, 1, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (121, 2, 37, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (121, 3, 38, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (121, 4, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (122, 3, 50, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (122, 5, 51, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (122, 7, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (123, 4, 63, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (123, 7, 64, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (123, 10, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (124, 5, 76, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (124, 9, 77, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (124, 13, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (125, 6, 89, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (125, 11, 90, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (125, 16, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (126, 7, 11, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (126, 13, 12, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (126, 19, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (127, 8, 24, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (127, 15, 25, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (127, 22, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (128, 9, 37, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (128, 17, 38, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (128, 25, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (129, 10, 50, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (129, 19, 51, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (129, 28, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (130, 11, 63, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (130, 21, 64, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (130, 31, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (131, 12, 76, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (131, 23, 77, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (131, 34, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (132, 13, 89, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (132, 25, 90, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (132, 37, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (133, 14, 11, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (133, 27, 12, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (133, 40, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (134, 15, 24, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (134, 29, 25, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (134, 43, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (135, 16, 37, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (135, 31, 38, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (135, 46, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (136, 17, 50, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (136, 33, 51, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (136, 49, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (137, 18, 63, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (137, 35, 64, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (137, 52, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (138, 19, 76, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (138, 37, 77, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (138, 55, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (139, 20, 89, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (139, 39, 90, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (139, 58, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (140, 21, 11, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (140, 41, 12, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (140, 61, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (141, 22, 24, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (141, 43, 25, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (141, 64, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (142, 23, 37, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (142, 45, 38, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (142, 67, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (143, 24, 50, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (143, 47, 51, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (143, 70, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (144, 25, 63, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (144, 49, 64, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (144, 73, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (145, 26, 76, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (145, 51, 77, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (145, 76, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (146, 27, 89, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (146, 53, 90, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (146, 79, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (147, 28, 11, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (147, 55, 12, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (147, 82, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (148, 29, 24, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (148, 57, 25, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (148, 85, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (149, 30, 37, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (149, 59, 38, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (149, 88, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (150, 31, 50, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (150, 61, 51, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (150, 91, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (151, 32, 63, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (151, 63, 64, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (151, 94, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (152, 33, 76, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (152, 65, 77, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (152, 97, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (153, 34, 89, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (153, 67, 90, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (153, 100, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (154, 35, 11, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (154, 69, 12, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (154, 103, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (155, 36, 24, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (155, 71, 25, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (155, 106, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (156, 37, 37, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (156, 73, 38, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (156, 109, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (157, 38, 50, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (157, 75, 51, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (157, 112, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (158, 39, 63, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (158, 77, 64, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (158, 115, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (159, 40, 76, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (159, 79, 77, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (159, 118, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (160, 41, 89, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (160, 81, 90, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (160, 1, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (161, 42, 11, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (161, 83, 12, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (161, 4, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (162, 43, 24, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (162, 85, 25, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (162, 7, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (163, 44, 37, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (163, 87, 38, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (163, 10, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (164, 45, 50, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (164, 89, 51, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (164, 13, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (165, 46, 63, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (165, 91, 64, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (165, 16, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (166, 47, 76, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (166, 93, 77, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (166, 19, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (167, 48, 89, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (167, 95, 90, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (167, 22, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (168, 49, 11, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (168, 97, 12, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (168, 25, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (169, 50, 24, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (169, 99, 25, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (169, 28, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (170, 51, 37, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (170, 101, 38, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (170, 31, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (171, 52, 50, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (171, 103, 51, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (171, 34, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (172, 53, 63, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (172, 105, 64, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (172, 37, 65, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (173, 54, 76, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (173, 107, 77, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (173, 40, 78, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (174, 55, 89, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (174, 109, 90, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (174, 43, 91, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (175, 56, 11, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (175, 111, 12, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (175, 46, 13, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (176, 57, 24, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (176, 113, 25, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (176, 49, 26, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (177, 58, 37, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (177, 115, 38, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (177, 52, 39, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (178, 59, 50, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (178, 117, 51, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (178, 55, 52, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (179, 60, 63, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (179, 119, 64, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (179, 58, 65, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (180, 61, 76, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (180, 1, 77, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (180, 61, 78, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (181, 62, 89, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (181, 3, 90, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (181, 64, 91, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (182, 63, 11, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (182, 5, 12, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (182, 67, 13, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (183, 64, 24, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (183, 7, 25, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (183, 70, 26, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (184, 65, 37, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (184, 9, 38, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (184, 73, 39, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (185, 66, 50, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (185, 11, 51, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (185, 76, 52, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (186, 67, 63, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (186, 13, 64, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (186, 79, 65, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (187, 68, 76, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (187, 15, 77, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (187, 82, 78, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (188, 69, 89, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (188, 17, 90, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (188, 85, 91, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (189, 70, 11, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (189, 19, 12, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (189, 88, 13, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (190, 71, 24, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (190, 21, 25, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (190, 91, 26, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (191, 72, 37, 5.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (191, 23, 38, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (191, 94, 39, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (192, 73, 50, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (192, 25, 51, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (192, 97, 52, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (193, 74, 63, 4.9);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (193, 27, 64, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (193, 100, 65, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (194, 75, 76, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (194, 29, 77, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (194, 103, 78, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (195, 76, 89, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (195, 31, 90, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (195, 106, 91, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (196, 77, 11, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (196, 33, 12, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (196, 109, 13, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (197, 78, 24, 0.8);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (197, 35, 25, 45.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (197, 112, 26, 18.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (198, 79, 37, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (198, 37, 38, 3.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (198, 115, 39, 2.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (199, 80, 50, 1.1);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (199, 39, 51, 12.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (199, 118, 52, 22.0);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (200, 81, 63, 6.5);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (200, 41, 64, 1.2);
INSERT INTO Item_Compra (cod_compra, cod_produto, quantidade, valor) VALUES (200, 1, 65, 3.5);
GO

INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (1, 1, 1, DATEADD(day, -3, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (2, 2, 2, DATEADD(day, -6, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (3, 3, 3, DATEADD(day, -9, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (4, 4, 4, DATEADD(day, -12, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (5, 5, 5, DATEADD(day, -15, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (6, 6, 1, DATEADD(day, -18, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (7, 7, 2, DATEADD(day, -21, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (8, 8, 3, DATEADD(day, -24, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (9, 9, 4, DATEADD(day, -27, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (10, 10, 5, DATEADD(day, -30, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (11, 1, 1, DATEADD(day, -33, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (12, 2, 2, DATEADD(day, -36, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (13, 3, 3, DATEADD(day, -39, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (14, 4, 4, DATEADD(day, -42, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (15, 5, 5, DATEADD(day, -45, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (16, 6, 1, DATEADD(day, -48, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (17, 7, 2, DATEADD(day, -51, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (18, 8, 3, DATEADD(day, -54, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (19, 9, 4, DATEADD(day, -57, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (20, 10, 5, DATEADD(day, -60, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (21, 1, 1, DATEADD(day, -63, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (22, 2, 2, DATEADD(day, -66, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (23, 3, 3, DATEADD(day, -69, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (24, 4, 4, DATEADD(day, -72, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (25, 5, 5, DATEADD(day, -75, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (26, 6, 1, DATEADD(day, -78, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (27, 7, 2, DATEADD(day, -81, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (28, 8, 3, DATEADD(day, -84, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (29, 9, 4, DATEADD(day, -87, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (30, 10, 5, DATEADD(day, -90, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (31, 1, 1, DATEADD(day, -93, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (32, 2, 2, DATEADD(day, -96, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (33, 3, 3, DATEADD(day, -99, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (34, 4, 4, DATEADD(day, -102, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (35, 5, 5, DATEADD(day, -105, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (36, 6, 1, DATEADD(day, -108, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (37, 7, 2, DATEADD(day, -111, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (38, 8, 3, DATEADD(day, -114, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (39, 9, 4, DATEADD(day, -117, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (40, 10, 5, DATEADD(day, -120, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (41, 1, 1, DATEADD(day, -123, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (42, 2, 2, DATEADD(day, -126, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (43, 3, 3, DATEADD(day, -129, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (44, 4, 4, DATEADD(day, -132, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (45, 5, 5, DATEADD(day, -135, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (46, 6, 1, DATEADD(day, -138, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (47, 7, 2, DATEADD(day, -141, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (48, 8, 3, DATEADD(day, -144, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (49, 9, 4, DATEADD(day, -147, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (50, 10, 5, DATEADD(day, -150, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (51, 1, 1, DATEADD(day, -153, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (52, 2, 2, DATEADD(day, -156, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (53, 3, 3, DATEADD(day, -159, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (54, 4, 4, DATEADD(day, -162, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (55, 5, 5, DATEADD(day, -165, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (56, 6, 1, DATEADD(day, -168, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (57, 7, 2, DATEADD(day, -171, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (58, 8, 3, DATEADD(day, -174, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (59, 9, 4, DATEADD(day, -177, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (60, 10, 5, DATEADD(day, -180, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (61, 1, 1, DATEADD(day, -183, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (62, 2, 2, DATEADD(day, -186, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (63, 3, 3, DATEADD(day, -189, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (64, 4, 4, DATEADD(day, -192, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (65, 5, 5, DATEADD(day, -195, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (66, 6, 1, DATEADD(day, -198, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (67, 7, 2, DATEADD(day, -201, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (68, 8, 3, DATEADD(day, -204, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (69, 9, 4, DATEADD(day, -207, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (70, 10, 5, DATEADD(day, -210, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (71, 1, 1, DATEADD(day, -213, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (72, 2, 2, DATEADD(day, -216, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (73, 3, 3, DATEADD(day, -219, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (74, 4, 4, DATEADD(day, -222, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (75, 5, 5, DATEADD(day, -225, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (76, 6, 1, DATEADD(day, -228, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (77, 7, 2, DATEADD(day, -231, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (78, 8, 3, DATEADD(day, -234, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (79, 9, 4, DATEADD(day, -237, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (80, 10, 5, DATEADD(day, -240, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (81, 1, 1, DATEADD(day, -243, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (82, 2, 2, DATEADD(day, -246, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (83, 3, 3, DATEADD(day, -249, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (84, 4, 4, DATEADD(day, -252, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (85, 5, 5, DATEADD(day, -255, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (86, 6, 1, DATEADD(day, -258, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (87, 7, 2, DATEADD(day, -261, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (88, 8, 3, DATEADD(day, -264, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (89, 9, 4, DATEADD(day, -267, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (90, 10, 5, DATEADD(day, -270, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (91, 1, 1, DATEADD(day, -273, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (92, 2, 2, DATEADD(day, -276, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (93, 3, 3, DATEADD(day, -279, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (94, 4, 4, DATEADD(day, -282, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (95, 5, 5, DATEADD(day, -285, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (96, 6, 1, DATEADD(day, -288, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (97, 7, 2, DATEADD(day, -291, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (98, 8, 3, DATEADD(day, -294, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (99, 9, 4, DATEADD(day, -297, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (100, 10, 5, DATEADD(day, -300, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (1, 1, 1, DATEADD(day, -303, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (2, 2, 2, DATEADD(day, -306, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (3, 3, 3, DATEADD(day, -309, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (4, 4, 4, DATEADD(day, -312, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (5, 5, 5, DATEADD(day, -315, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (6, 6, 1, DATEADD(day, -318, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (7, 7, 2, DATEADD(day, -321, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (8, 8, 3, DATEADD(day, -324, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (9, 9, 4, DATEADD(day, -327, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (10, 10, 5, DATEADD(day, -330, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (11, 1, 1, DATEADD(day, -333, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (12, 2, 2, DATEADD(day, -336, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (13, 3, 3, DATEADD(day, -339, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (14, 4, 4, DATEADD(day, -342, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (15, 5, 5, DATEADD(day, -345, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (16, 6, 1, DATEADD(day, -348, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (17, 7, 2, DATEADD(day, -351, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (18, 8, 3, DATEADD(day, -354, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (19, 9, 4, DATEADD(day, -357, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (20, 10, 5, DATEADD(day, -360, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (21, 1, 1, DATEADD(day, -363, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (22, 2, 2, DATEADD(day, -366, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (23, 3, 3, DATEADD(day, -369, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (24, 4, 4, DATEADD(day, -372, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (25, 5, 5, DATEADD(day, -375, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (26, 6, 1, DATEADD(day, -378, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (27, 7, 2, DATEADD(day, -381, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (28, 8, 3, DATEADD(day, -384, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (29, 9, 4, DATEADD(day, -387, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (30, 10, 5, DATEADD(day, -390, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (31, 1, 1, DATEADD(day, -393, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (32, 2, 2, DATEADD(day, -396, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (33, 3, 3, DATEADD(day, -399, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (34, 4, 4, DATEADD(day, -402, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (35, 5, 5, DATEADD(day, -405, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (36, 6, 1, DATEADD(day, -408, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (37, 7, 2, DATEADD(day, -411, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (38, 8, 3, DATEADD(day, -414, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (39, 9, 4, DATEADD(day, -417, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (40, 10, 5, DATEADD(day, -420, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (41, 1, 1, DATEADD(day, -423, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (42, 2, 2, DATEADD(day, -426, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (43, 3, 3, DATEADD(day, -429, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (44, 4, 4, DATEADD(day, -432, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (45, 5, 5, DATEADD(day, -435, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (46, 6, 1, DATEADD(day, -438, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (47, 7, 2, DATEADD(day, -441, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (48, 8, 3, DATEADD(day, -444, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (49, 9, 4, DATEADD(day, -447, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (50, 10, 5, DATEADD(day, -450, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (51, 1, 1, DATEADD(day, -453, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (52, 2, 2, DATEADD(day, -456, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (53, 3, 3, DATEADD(day, -459, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (54, 4, 4, DATEADD(day, -462, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (55, 5, 5, DATEADD(day, -465, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (56, 6, 1, DATEADD(day, -468, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (57, 7, 2, DATEADD(day, -471, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (58, 8, 3, DATEADD(day, -474, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (59, 9, 4, DATEADD(day, -477, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (60, 10, 5, DATEADD(day, -480, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (61, 1, 1, DATEADD(day, -483, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (62, 2, 2, DATEADD(day, -486, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (63, 3, 3, DATEADD(day, -489, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (64, 4, 4, DATEADD(day, -492, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (65, 5, 5, DATEADD(day, -495, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (66, 6, 1, DATEADD(day, -498, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (67, 7, 2, DATEADD(day, -501, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (68, 8, 3, DATEADD(day, -504, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (69, 9, 4, DATEADD(day, -507, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (70, 10, 5, DATEADD(day, -510, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (71, 1, 1, DATEADD(day, -513, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (72, 2, 2, DATEADD(day, -516, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (73, 3, 3, DATEADD(day, -519, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (74, 4, 4, DATEADD(day, -522, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (75, 5, 5, DATEADD(day, -525, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (76, 6, 1, DATEADD(day, -528, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (77, 7, 2, DATEADD(day, -531, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (78, 8, 3, DATEADD(day, -534, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (79, 9, 4, DATEADD(day, -537, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (80, 10, 5, DATEADD(day, -540, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (81, 1, 1, DATEADD(day, -543, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (82, 2, 2, DATEADD(day, -546, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (83, 3, 3, DATEADD(day, -549, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (84, 4, 4, DATEADD(day, -552, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (85, 5, 5, DATEADD(day, -555, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (86, 6, 1, DATEADD(day, -558, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (87, 7, 2, DATEADD(day, -561, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (88, 8, 3, DATEADD(day, -564, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (89, 9, 4, DATEADD(day, -567, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (90, 10, 5, DATEADD(day, -570, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (91, 1, 1, DATEADD(day, -573, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (92, 2, 2, DATEADD(day, -576, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (93, 3, 3, DATEADD(day, -579, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (94, 4, 4, DATEADD(day, -582, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (95, 5, 5, DATEADD(day, -585, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (96, 6, 1, DATEADD(day, -588, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (97, 7, 2, DATEADD(day, -591, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (98, 8, 3, DATEADD(day, -594, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (99, 9, 4, DATEADD(day, -597, GETDATE()));
INSERT INTO Pedido (cod_cliente, cod_vendedor, cod_condicao_pagto, data) VALUES (100, 10, 5, DATEADD(day, -600, GETDATE()));
GO

INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (1, 2, 3, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (1, 3, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (2, 3, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (2, 5, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (2, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (3, 4, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (3, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (3, 10, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (3, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (4, 5, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (4, 9, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (4, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (4, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (4, 21, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (5, 6, 2, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (6, 7, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (6, 13, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (7, 8, 4, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (7, 15, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (7, 22, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (8, 9, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (8, 17, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (8, 25, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (8, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (9, 10, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (9, 19, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (9, 28, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (9, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (9, 46, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (10, 11, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (11, 12, 3, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (11, 23, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (12, 13, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (12, 25, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (12, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (13, 14, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (13, 27, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (13, 40, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (13, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (14, 15, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (14, 29, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (14, 43, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (14, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (14, 71, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (15, 16, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (16, 17, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (16, 33, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (17, 18, 4, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (17, 35, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (17, 52, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (18, 19, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (18, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (18, 55, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (18, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (19, 20, 1, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (19, 39, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (19, 58, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (19, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (19, 96, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (20, 21, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (21, 22, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (21, 43, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (22, 23, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (22, 45, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (22, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (23, 24, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (23, 47, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (23, 70, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (23, 93, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (24, 25, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (24, 49, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (24, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (24, 97, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (24, 1, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (25, 26, 2, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (26, 27, 3, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (26, 53, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (27, 28, 4, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (27, 55, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (27, 82, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (28, 29, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (28, 57, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (28, 85, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (28, 113, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (29, 30, 1, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (29, 59, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (29, 88, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (29, 117, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (29, 26, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (30, 31, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (31, 32, 3, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (31, 63, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (32, 33, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (32, 65, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (32, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (33, 34, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (33, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (33, 100, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (33, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (34, 35, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (34, 69, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (34, 103, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (34, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (34, 51, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (35, 36, 2, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (36, 37, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (36, 73, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (37, 38, 4, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (37, 75, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (37, 112, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (38, 39, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (38, 77, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (38, 115, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (38, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (39, 40, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (39, 79, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (39, 118, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (39, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (39, 76, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (40, 41, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (41, 42, 3, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (41, 83, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (42, 43, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (42, 85, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (42, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (43, 44, 5, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (43, 87, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (43, 10, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (43, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (44, 45, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (44, 89, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (44, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (44, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (44, 101, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (45, 46, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (46, 47, 3, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (46, 93, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (47, 48, 4, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (47, 95, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (47, 22, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (48, 49, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (48, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (48, 25, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (48, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (49, 50, 1, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (49, 99, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (49, 28, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (49, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (49, 6, 5, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (50, 51, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (51, 52, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (51, 103, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (52, 53, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (52, 105, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (52, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (53, 54, 5, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (53, 107, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (53, 40, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (53, 93, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (54, 55, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (54, 109, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (54, 43, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (54, 97, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (54, 31, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (55, 56, 2, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (56, 57, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (56, 113, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (57, 58, 4, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (57, 115, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (57, 52, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (58, 59, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (58, 117, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (58, 55, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (58, 113, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (59, 60, 1, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (59, 119, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (59, 58, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (59, 117, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (59, 56, 5, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (60, 61, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (61, 62, 3, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (61, 3, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (62, 63, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (62, 5, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (62, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (63, 64, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (63, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (63, 70, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (63, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (64, 65, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (64, 9, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (64, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (64, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (64, 81, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (65, 66, 2, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (66, 67, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (66, 13, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (67, 68, 4, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (67, 15, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (67, 82, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (68, 69, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (68, 17, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (68, 85, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (68, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (69, 70, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (69, 19, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (69, 88, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (69, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (69, 106, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (70, 71, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (71, 72, 3, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (71, 23, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (72, 73, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (72, 25, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (72, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (73, 74, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (73, 27, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (73, 100, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (73, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (74, 75, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (74, 29, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (74, 103, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (74, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (74, 11, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (75, 76, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (76, 77, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (76, 33, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (77, 78, 4, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (77, 35, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (77, 112, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (78, 79, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (78, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (78, 115, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (78, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (79, 80, 1, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (79, 39, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (79, 118, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (79, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (79, 36, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (80, 81, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (81, 82, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (81, 43, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (82, 83, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (82, 45, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (82, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (83, 84, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (83, 47, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (83, 10, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (83, 93, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (84, 85, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (84, 49, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (84, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (84, 97, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (84, 61, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (85, 86, 2, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (86, 87, 3, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (86, 53, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (87, 88, 4, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (87, 55, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (87, 22, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (88, 89, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (88, 57, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (88, 25, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (88, 113, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (89, 90, 1, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (89, 59, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (89, 28, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (89, 117, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (89, 86, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (90, 91, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (91, 92, 3, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (91, 63, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (92, 93, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (92, 65, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (92, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (93, 94, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (93, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (93, 40, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (93, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (94, 95, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (94, 69, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (94, 43, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (94, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (94, 111, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (95, 96, 2, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (96, 97, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (96, 73, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (97, 98, 4, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (97, 75, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (97, 52, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (98, 99, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (98, 77, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (98, 55, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (98, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (99, 100, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (99, 79, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (99, 58, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (99, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (99, 16, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (100, 101, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (101, 102, 3, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (101, 83, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (102, 103, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (102, 85, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (102, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (103, 104, 5, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (103, 87, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (103, 70, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (103, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (104, 105, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (104, 89, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (104, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (104, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (104, 41, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (105, 106, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (106, 107, 3, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (106, 93, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (107, 108, 4, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (107, 95, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (107, 82, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (108, 109, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (108, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (108, 85, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (108, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (109, 110, 1, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (109, 99, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (109, 88, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (109, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (109, 66, 5, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (110, 111, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (111, 112, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (111, 103, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (112, 113, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (112, 105, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (112, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (113, 114, 5, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (113, 107, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (113, 100, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (113, 93, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (114, 115, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (114, 109, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (114, 103, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (114, 97, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (114, 91, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (115, 116, 2, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (116, 117, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (116, 113, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (117, 118, 4, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (117, 115, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (117, 112, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (118, 119, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (118, 117, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (118, 115, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (118, 113, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (119, 120, 1, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (119, 119, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (119, 118, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (119, 117, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (119, 116, 5, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (120, 1, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (121, 2, 3, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (121, 3, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (122, 3, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (122, 5, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (122, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (123, 4, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (123, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (123, 10, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (123, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (124, 5, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (124, 9, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (124, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (124, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (124, 21, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (125, 6, 2, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (126, 7, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (126, 13, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (127, 8, 4, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (127, 15, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (127, 22, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (128, 9, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (128, 17, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (128, 25, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (128, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (129, 10, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (129, 19, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (129, 28, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (129, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (129, 46, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (130, 11, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (131, 12, 3, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (131, 23, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (132, 13, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (132, 25, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (132, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (133, 14, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (133, 27, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (133, 40, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (133, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (134, 15, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (134, 29, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (134, 43, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (134, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (134, 71, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (135, 16, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (136, 17, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (136, 33, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (137, 18, 4, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (137, 35, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (137, 52, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (138, 19, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (138, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (138, 55, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (138, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (139, 20, 1, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (139, 39, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (139, 58, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (139, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (139, 96, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (140, 21, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (141, 22, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (141, 43, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (142, 23, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (142, 45, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (142, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (143, 24, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (143, 47, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (143, 70, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (143, 93, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (144, 25, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (144, 49, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (144, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (144, 97, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (144, 1, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (145, 26, 2, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (146, 27, 3, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (146, 53, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (147, 28, 4, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (147, 55, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (147, 82, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (148, 29, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (148, 57, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (148, 85, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (148, 113, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (149, 30, 1, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (149, 59, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (149, 88, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (149, 117, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (149, 26, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (150, 31, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (151, 32, 3, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (151, 63, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (152, 33, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (152, 65, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (152, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (153, 34, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (153, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (153, 100, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (153, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (154, 35, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (154, 69, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (154, 103, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (154, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (154, 51, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (155, 36, 2, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (156, 37, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (156, 73, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (157, 38, 4, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (157, 75, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (157, 112, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (158, 39, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (158, 77, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (158, 115, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (158, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (159, 40, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (159, 79, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (159, 118, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (159, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (159, 76, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (160, 41, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (161, 42, 3, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (161, 83, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (162, 43, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (162, 85, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (162, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (163, 44, 5, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (163, 87, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (163, 10, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (163, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (164, 45, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (164, 89, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (164, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (164, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (164, 101, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (165, 46, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (166, 47, 3, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (166, 93, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (167, 48, 4, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (167, 95, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (167, 22, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (168, 49, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (168, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (168, 25, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (168, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (169, 50, 1, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (169, 99, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (169, 28, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (169, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (169, 6, 5, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (170, 51, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (171, 52, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (171, 103, 4, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (172, 53, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (172, 105, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (172, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (173, 54, 5, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (173, 107, 1, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (173, 40, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (173, 93, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (174, 55, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (174, 109, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (174, 43, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (174, 97, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (174, 31, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (175, 56, 2, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (176, 57, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (176, 113, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (177, 58, 4, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (177, 115, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (177, 52, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (178, 59, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (178, 117, 1, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (178, 55, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (178, 113, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (179, 60, 1, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (179, 119, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (179, 58, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (179, 117, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (179, 56, 5, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (180, 61, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (181, 62, 3, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (181, 3, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (182, 63, 4, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (182, 5, 5, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (182, 67, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (183, 64, 5, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (183, 7, 1, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (183, 70, 2, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (183, 13, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (184, 65, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (184, 9, 2, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (184, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (184, 17, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (184, 81, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (185, 66, 2, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (186, 67, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (186, 13, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (187, 68, 4, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (187, 15, 5, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (187, 82, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (188, 69, 5, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (188, 17, 1, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (188, 85, 2, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (188, 33, 3, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (189, 70, 1, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (189, 19, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (189, 88, 3, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (189, 37, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (189, 106, 5, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (190, 71, 2, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (191, 72, 3, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (191, 23, 4, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (192, 73, 4, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (192, 25, 5, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (192, 97, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (193, 74, 5, 4.9);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (193, 27, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (193, 100, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (193, 53, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (194, 75, 1, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (194, 29, 2, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (194, 103, 3, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (194, 57, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (194, 11, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (195, 76, 2, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (196, 77, 3, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (196, 33, 4, 6.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (197, 78, 4, 0.8);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (197, 35, 5, 45.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (197, 112, 1, 18.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (198, 79, 5, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (198, 37, 1, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (198, 115, 2, 2.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (198, 73, 3, 3.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (199, 80, 1, 1.1);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (199, 39, 2, 12.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (199, 118, 3, 22.0);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (199, 77, 4, 1.2);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (199, 36, 5, 5.5);
INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade, valor) VALUES (200, 81, 2, 6.5);
GO

PRINT 'BLOCO ADICIONAL DE DADOS INSERIDO. Verifique as contagens.';
SELECT 'Cliente' AS Tabela, COUNT(*) AS Qtd FROM Cliente;
SELECT 'Produto' AS Tabela, COUNT(*) AS Qtd FROM Produto;
SELECT 'Compra' AS Tabela, COUNT(*) AS Qtd FROM Compra;
SELECT 'Item_Compra' AS Tabela, COUNT(*) AS Qtd FROM Item_Compra;
SELECT 'Pedido' AS Tabela, COUNT(*) AS Qtd FROM Pedido;
SELECT 'Item_Pedido' AS Tabela, COUNT(*) AS Qtd FROM Item_Pedido;
GO
