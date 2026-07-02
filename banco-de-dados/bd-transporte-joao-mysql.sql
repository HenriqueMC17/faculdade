#Diferenças do Mysql para o SQL server
	#Removemos GO, pois não é necessário no MySQL.
	#Substituímos IDENTITY(1,1) por AUTO_INCREMENT.
	#Usamos DECIMAL(10,2) no lugar de NUMERIC(10,2).
	#Mudamos a sintaxe das FOREIGN KEY para serem declaradas separadamente.


CREATE DATABASE transporteJoao;
USE transporteJoao;

CREATE TABLE veiculo (
    placa VARCHAR(7) PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    ano INT NULL,
    cor VARCHAR(100)
);

CREATE TABLE motorista (
    cod_motorista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(300) NOT NULL,
    email VARCHAR(350) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    cnh VARCHAR(200)
);

CREATE TABLE passageiro (
    cod_passageiro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    rg VARCHAR(20) NULL,
    email VARCHAR(30) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);

CREATE TABLE manutencao (
    cod_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    nome VARCHAR(200) NOT NULL,
    placa VARCHAR(7) NOT NULL,
    FOREIGN KEY (placa) REFERENCES veiculo(placa)
);

CREATE TABLE viagem (
    cod_viagem INT AUTO_INCREMENT PRIMARY KEY,
    rua_origem VARCHAR(100),
    numero_origem VARCHAR(10),
    bairro_origem VARCHAR(200),
    estado_origem VARCHAR(200),
    cep_origem VARCHAR(10),
    rua_destino VARCHAR(100),
    numero_destino VARCHAR(10),
    bairro_destino VARCHAR(200),
    estado_destino VARCHAR(200),
    cep_destino VARCHAR(10),
    valor DECIMAL(10,2) NOT NULL,
    data_saida DATETIME NOT NULL,
    data_retorno DATETIME,
    cod_motorista INT NOT NULL,
    placa VARCHAR(7) NOT NULL,
    FOREIGN KEY (cod_motorista) REFERENCES motorista(cod_motorista),
    FOREIGN KEY (placa) REFERENCES veiculo(placa)
);

CREATE TABLE carga (
    cod_carga INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    quantidadee INT NOT NULL,
    cod_viagem INT NOT NULL,
    FOREIGN KEY (cod_viagem) REFERENCES viagem(cod_viagem)
);

CREATE TABLE passageiro_viagem (
    cod_viagem INT NOT NULL,
    cod_passageiro INT NOT NULL,
    PRIMARY KEY (cod_viagem, cod_passageiro),
    FOREIGN KEY (cod_viagem) REFERENCES viagem(cod_viagem),
    FOREIGN KEY (cod_passageiro) REFERENCES passageiro(cod_passageiro)
);
