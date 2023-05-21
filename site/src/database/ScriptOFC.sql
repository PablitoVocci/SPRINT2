CREATE DATABASE digitalTherm;
USE digitalTherm;

-- CRIAR A TABELA (EMPRESA)

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
nomeFantasia VARCHAR(60),
CNPJ CHAR(14) NOT NULL UNIQUE,
telefone CHAR(15),
email VARCHAR(80) NOT NULL CONSTRAINT chkEmailEmp CHECK (email LIKE '%@%'),
senha VARCHAR(50) NOT NULL
);

INSERT INTO empresa VALUES
(null, 'epic', 'Games', '12345678901234', '123456789012345', 'EpicGames@EPic', 'senha123');


CREATE TABLE funcionario (
idFuncionario INT AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
sobrenome VARCHAR(60),
email VARCHAR(80) NOT NULL CONSTRAINT chkEmailUsu CHECK (email like '%@%'),
senha VARCHAR(50) NOT NULL,
dtNasc DATE NOT NULL,
celular CHAR(11),
telefone CHAR(15),
CPF CHAR(11) NOT NULL UNIQUE,
CEP CHAR(8),
num VARCHAR(10),
fkEmpresa INT,
CONSTRAINT fkEmpresaU FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT pkEmpFu PRIMARY KEY (idFuncionario, fkEmpresa)
) AUTO_INCREMENT = 500;

INSERT INTO funcionario VALUES
(null, 'pedro', 'malon', 'pedromalon@pedro', '1234', '2001-12-11', '11111111111', null, '1111111111', '11111111', '12a', 1);


CREATE TABLE endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
pais VARCHAR(45) NOT NULL,
CEP CHAR(9) NOT NULL,
estado VARCHAR(40) NOT NULL,
cidade VARCHAR(50) NOT NULL,
bairro VARCHAR(50) NOT NULL,
rua VARCHAR(60) NOT NULL,
fkEmpresa INT,
constraint fkEmpresaEnd FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO endereco VALUES
(null, 'Brasil', '09990560', 'são paulo', 'maua', 'josePedro', 'Rua jorge', 1);


CREATE TABLE setorEmpresa (
idSetorEmp INT AUTO_INCREMENT,
nome VARCHAR(40) NOT NULL,
andar INT,
fkEmpresa INT,
CONSTRAINT fkEmpresaSet FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT pkSetorEmp PRIMARY KEY (idSetorEmp, fkEmpresa)
);

INSERT INTO setorEmpresa VALUES
(null, 'setor leste', 5, 1);

CREATE TABLE enderecoSetor (
idEnderecoSetor INT AUTO_INCREMENT,
fkSetor INT,
fkEndereco INT,
numero VARCHAR(10),
complemento VARCHAR(61),
CONSTRAINT fkSetorEnd FOREIGN KEY (fkSetor) REFERENCES setorEmpresa(idSetorEmp),
CONSTRAINT FKEndSet FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
CONSTRAINT pkEmpEnd PRIMARY KEY (idEnderecoSetor, fksetor, fkEndereco)
);

INSERT INTO enderecoSetor VALUES
(null, 1, 1, '33c', 'casa azul');


CREATE TABLE servidor  (
idServidor INT AUTO_INCREMENT,
quadrante VARCHAR(15),
descricao VARCHAR(300),
fkSetorEmp INT,
fkEmpresa INT,
CONSTRAINT fkSetorServ FOREIGN KEY (fkSetorEmp) REFERENCES setorEmpresa(idSetorEmp),
CONSTRAINT fkSetorEmp FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT pkSetorSe PRIMARY KEY (idServidor, fkSetorEmp, fkEmpresa)
) AUTO_INCREMENT = 50;


INSERT INTO servidor VALUES 
(null, '1A', 'primeiro', 1, 1);



CREATE TABLE tipoSensor (
idTipoSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL
);

INSERT INTO tipoSensor VALUES
(null, 'DHT11');


CREATE TABLE unidadeMedida (
idUnidadeMedida INT PRIMARY KEY AUTO_INCREMENT,
unidadeSensor VARCHAR(20)
);

INSERT INTO unidadeMedida VALUES
(null, 'C°');


CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
chave TINYINT CONSTRAINT chkchave CHECK (chave in (0, 1)),
fkTipoSensor INT,
fkUnidadeMedida INT,
fkServidor INT,
CONSTRAINT fkSensorTipoS FOREIGN KEY (fkTipoSensor) REFERENCES tipoSensor(idTipoSensor),
CONSTRAINT fkSensorUni FOREIGN KEY (fkUnidadeMedida) REFERENCES unidadeMedida(idUnidadeMedida),
CONSTRAINT fkSensorServ FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor),
CONSTRAINT pkSensorT PRIMARY KEY (idSensor, fkTipoSensor, fkUnidadeMedida)
);

INSERT INTO sensor VALUES
(null, 1, 1, 1, 50);


/*
esta tabela "medida" deve estar de acordo com o comando INSERT
do ambiente de DESENVOLVIMENTO do arquivo "main.js"
*/

create table medida (
	idMedida INT AUTO_INCREMENT,
	temperatura DECIMAL(10,2),
	umidade DECIMAL(10,2),
	momento DATETIME,
	fkSensor INT,
	CONSTRAINT fkMedSen FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    CONSTRAINT pkMedSen PRIMARY KEY (idMedida, fkSensor)
);

INSERT INTO medida VALUES
(null, 22.55, 85.55, now(), 1);