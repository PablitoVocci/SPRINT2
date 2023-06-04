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
(null, 'Setor leste', 5, 1),
(null, 'Setor Sul', 3, 1),
(null, 'Setor Norte', 6, 1),
(null, 'Setor Sudeste', 9, 1);


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
(null, 1, 1, '33c', 'casa marinho'),
(null, 2, 1, '33b', 'casa verde'),
(null, 3, 1, '33a', 'casa rosa'),
(null, 4, 1, '11', 'casa amarela');


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
select * from servidor;

INSERT INTO servidor VALUES 
(null, '1A', 'primeiro', 1, 1),
(null, '1A', 'segundo', 1, 1),
(null, '1A', 'terceiro', 1, 1),
(null, '1A', 'quarto', 1, 1),
(null, '1A', 'Quinto', 1, 1),

(null, '3A', 'primeiro', 2, 1),
(null, '3A', 'segundo', 2, 1),
(null, '3A', 'terceiro', 2, 1),
(null, '3A', 'quarto', 2, 1),

(null, '4A', 'primeiro', 3, 1),
(null, '4A', 'segundo', 3, 1),


(null, '2A', 'primeiro', 4, 1),
(null, '2A', 'segundo', 4, 1),
(null, '2A', 'terceiro', 4, 1);



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
(null, 1, 1, 1, 50),
(null, 1, 1, 1, 51),
(null, 1, 1, 1, 52),
(null, 1, 1, 1, 53),
(null, 1, 1, 1, 54),

(null, 1, 1, 1, 55),
(null, 1, 1, 1, 56),
(null, 1, 1, 1, 57),
(null, 1, 1, 1, 58),

(null, 1, 1, 1, 59),
(null, 1, 1, 1, 60),

(null, 1, 1, 1, 61),
(null, 1, 1, 1, 62),
(null, 1, 1, 1, 63);



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

-- Sensor 1
-- Sensor 1
INSERT INTO medida VALUES
(null, 17.00, 40.00, now(), 1),
(null, 21.00, 42.00, now(), 1),
(null, 33.00, 44.00, now(), 1),
(null, 23.00, 54.00, now(), 1),
(null, 12.00, 54.00, now(), 1),
(null, 12.00, 66.00, now(), 1),
(null, 43.00, 87.00, now(), 1);

-- Sensor 2
INSERT INTO medida VALUES
(null, 17.00, 65.00, now(), 2),
(null, 45.00, 42.00, now(), 2),
(null, 25.00, 44.00, now(), 2),
(null, 65.00, 46.00, now(), 2),
(null, 33.00, 66.00, now(), 2),
(null, 37.00, 33.00, now(), 2),
(null, 22.00, 52.00, now(), 2);

-- Sensor 3
INSERT INTO medida VALUES
(null, 55.00, 77.00, now(), 3),
(null, 31.00, 44.00, now(), 3),
(null, 53.00, 44.00, now(), 3),
(null, 12.00, 46.00, now(), 3),
(null, 21.00, 48.00, now(), 3),
(null, 15.00, 67.00, now(), 3),
(null, 29.00, 52.00, now(), 3);

-- Sensor 4
INSERT INTO medida VALUES
(null, 14.00, 76.00, now(), 4),
(null, 55.00, 54.00, now(), 4),
(null, 32.00, 66.00, now(), 4),
(null, 15.00, 46.00, now(), 4),
(null, 32.00, 99.00, now(), 4),
(null, 11.00, 50.00, now(), 4),
(null, 33.00, 43.00, now(), 4);

-- Sensor 5
INSERT INTO medida VALUES
(null, 12.00, 40.00, now(), 5),
(null, 22.00, 99.00, now(), 5),
(null, 24.00, 65.00, now(), 5),
(null, 55.00, 45.00, now(), 5),
(null, 31.00, 45.00, now(), 5),
(null, 37.00, 33.00, now(), 5),
(null, 23.00, 76.00, now(), 5);

-- Sensor 6
INSERT INTO medida VALUES
(null, 4.00, 78.00, now(), 6),
(null, 21.00, 65.00, now(), 6),
(null, 25.00, 54.00, now(), 6),
(null, 31.00, 90.00, now(), 6),
(null, 33.00, 97.00, now(), 6),
(null, 17.00, 43.00, now(), 6),
(null, 39.00, 34.00, now(), 6);

-- Sensor 7
INSERT INTO medida VALUES
(null, 17.00, 46.00, now(), 7),
(null, 14.00, 78.00, now(), 7),
(null, 43.00, 44.00, now(), 7),
(null, 17.00, 65.00, now(), 7),
(null, 12.00, 43.00, now(), 7),
(null, 14.00, 50.00, now(), 7),
(null, 39.00, 32.00, now(), 7);

-- Sensor 8
INSERT INTO medida VALUES
(null, 17.00, 67.00, now(), 8),
(null, 43.00, 54.00, now(), 8),
(null, 25.00, 32.00, now(), 8),
(null, 29.00, 46.00, now(), 8),
(null, 21.00, 48.00, now(), 8),
(null, 37.00, 50.00, now(), 8),
(null, 39.00, 52.00, now(), 8);

-- Sensor 9
INSERT INTO medida VALUES
(null, 17.00, 56.00, now(), 9),
(null, 21.00, 76.00, now(), 9),
(null, 25.00, 65.00, now(), 9),
(null, 11.00, 33.00, now(), 9),
(null, 33.00, 45.00, now(), 9),
(null, 34.00, 54.00, now(), 9),
(null, 39.00, 32.00, now(), 9);

-- Sensor 10
INSERT INTO medida VALUES
(null, 17.00, 40.00, now(), 10),
(null, 21.00, 42.00, now(), 10),
(null, 43.00, 44.00, now(), 10),
(null, 23.00, 46.00, now(), 10),
(null, 33.00, 48.00, now(), 10),
(null, 11.00, 50.00, now(), 10),
(null, 39.00, 52.00, now(), 10);

-- Sensor 11
INSERT INTO medida VALUES
(null, 17.00, 23.00, now(), 11),
(null, 21.00, 45.00, now(), 11),
(null, 12.00, 56.00, now(), 11),
(null, 21.00, 23.00, now(), 11),
(null, 33.00, 12.00, now(), 11),
(null, 37.00, 34.00, now(), 11),
(null, 27.00, 54.00, now(), 11);

-- Sensor 12
INSERT INTO medida VALUES
(null, 17.00, 23.00, now(), 12),
(null, 11.00, 56.00, now(), 12),
(null, 34.00, 65.00, now(), 12),
(null, 32.00, 54.00, now(), 12),
(null, 12.00, 23.00, now(), 12),
(null, 37.00, 56.00, now(), 12),
(null, 39.00, 67.00, now(), 12);

-- Sensor 13
INSERT INTO medida VALUES
(null, 17.00, 65.00, now(), 13),
(null, 22.00, 42.00, now(), 13),
(null, 34.00, 77.00, now(), 13),
(null, 29.00, 34.00, now(), 13),
(null, 32.00, 48.00, now(), 13),
(null, 12.00, 75.00, now(), 13),
(null, 24.00, 52.00, now(), 13);

-- Sensor 14
INSERT INTO medida VALUES
(null, 44.00, 40.00, now(), 14),
(null, 33.00, 54.00, now(), 14),
(null, 33.00, 55.00, now(), 14),
(null, 22.00, 66.00, now(), 14),
(null, 12.00, 45.00, now(), 14),
(null, 37.00, 32.00, now(), 14),
(null, 19.00, 54.00, now(), 14);

    
SELECT AVG(medida.temperatura) AS temperatura_media, AVG(medida.umidade) AS umidade_media, setorEmpresa.nome
FROM medida
JOIN sensor ON medida.fkSensor = sensor.idSensor
JOIN servidor ON sensor.fkServidor = servidor.idServidor
JOIN setorEmpresa ON servidor.fkSetorEmp = setorEmpresa.idSetorEmp
JOIN empresa ON setorEmpresa.fkEmpresa = empresa.idEmpresa where setorEmpresa.fkEmpresa = 1
GROUP BY setorEmpresa.nome;