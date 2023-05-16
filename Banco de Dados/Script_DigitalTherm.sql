CREATE DATABASE digitalTherm;


USE digitalTherm;


-- CRIAR A TABELA (EMPRESA)

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
nomeFantasia VARCHAR(60),
CNPJ CHAR(14) NOT NULL,
telefoneComercial CHAR(15),
emailEmpresarial VARCHAR(80) NOT NULL CONSTRAINT chkEmailEmp CHECK (emailEmpresarial LIKE '%@%'),
senha VARCHAR(50) NOT NULL
);


create table servidor (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(300)
);

/*
esta tabela "medida" deve estar de acordo com o comando INSERT
do ambiente de DESENVOLVIMENTO do arquivo "main.js"
*/

create table medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dht11_umidade DECIMAL(10,2),
	dht11_temperatura DECIMAL(10,2),
	momento DATETIME,
	fk_servidor INT,
	FOREIGN KEY (fk_servidor) REFERENCES servidor(id)
);