CREATE DATABASE digitalTherm;

USE digitalTherm;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
nomeFantasia VARCHAR(60) NOT NULL,
CNPJ CHAR(14) NOT NULL,
telefoneComercial CHAR(15) NOT NULL,
emailEmpresarial VARCHAR(80) NOT NULL CONSTRAINT chkEmailEmp CHECK (emailEmpresarial LIKE '%@%'),
senha VARCHAR(45) NOT NULL
);

INSERT INTO empresa VALUES
(NULL, 'Amazon.com, Inc.', 'Amazon', '11111111111111', '(11) 95001-0011', 'AmazonEnt@outlook.com', 'qwerrtyuuio12345'),
(NULL, 'Epic Games, Inc.', 'Epic', '22222222222222', '(11) 9922-0011', 'EpicGames1111@outlook.com', 'poyiyrfgrtgf344tbf');

CREATE TABLE usuario (
idUsuario INT AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
sobrenome VARCHAR(60) NOT NULL,
email VARCHAR(80) NOT NULL CONSTRAINT chkEmailUsu CHECK (email like '%@%'),
senha VARCHAR(50) NOT NULL,
dtNasc DATE NOT NULL,
genero VARCHAR(30) NOT NULL,
telefoneCelular CHAR(15) NOT NULL,
telefoneFixo CHAR(15),
CPF CHAR(11) NOT NULL,
fkEmpresa INT,
CONSTRAINT fkEmpresaU FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT pkEmpUsu PRIMARY KEY (idUsuario, fkEmpresa)
) AUTO_INCREMENT = 500;

INSERT INTO usuario VALUES
(NULL, 'Carlos', 'Silva', 'Carlossilvadosantos111@Gmail.com', 'Carlos123', '1999-02-22', 'Masculino', '(11) 99224-3333', NULL, '22222222222', 1),
(NULL, 'Ana', 'Maria', 'AnaMariaRIa@outlook.com', 'aninha111', '2000-02-22', 'Feminino', '(11) 99224-4444', '(44) 4002-89223', '44444444444', 1),
(NULL, 'Paulo', 'Rodri', 'PabloRodri@Amazon.inc', '', '1998-11-22', 'Outro', '(11) 96655-3333', NULL, '12121212121', 2),
(NULL, 'Bernado', 'Matos', 'Bematos@Gmail.com', 'be2222', '1994-02-22', 'Masculino', '(11) 98765-2222', NULL, '66666666666', 2);


SELECT * FROM empresa JOIN usuario ON idEmpresa = fkEmpresa;


CREATE TABLE endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
pais VARCHAR(45) NOT NULL,
CEP CHAR(9) NOT NULL,
estado VARCHAR(40) NOT NULL,
cidade VARCHAR(50) NOT NULL,
bairro VARCHAR(50) NOT NULL,
rua VARCHAR(60) NOT NULL,
numero VARCHAR(10) NOT NULL,
complemento VARCHAR(55),
fkUsuario INT,
fkEmpresa INT,
constraint fkusuarioEnd FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
constraint fkEmpresaEnd FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO endereco VALUES 
(NULL, 'Brasil', '09330550', 'São Paulo', 'Mauá', 'toca', 'R.Martins Ovi', '222', NULL, NULL, 2), 
(NULL, 'Brasil', '09888777', 'Bahia', 'loccc', 'toca', 'R.ggg Ovi', '33', 'ala' , 501, NULL), 
(NULL, 'Brasil', '02222555', 'São Paulo', 'mana', 'ggg', 'R.3rgg Ovi', '33', NULL, NULL, 1), 
(NULL, 'Brasil', '555557777', 'São Paulo', 'jjjj', 'uyy', 'R.bfgb Ovi', '222', NULL, 502, NULL);

SELECT * FROM usuario JOIN endereco ON idUsuario = fkUsuario;
SELECT * FROM empresa JOIN endereco ON idEmpresa = fkEmpresa;

CREATE TABLE setorEmpresa (
idSetorEmp INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(40) NOT NULL,
andar INT NOT NULL,
representante VARCHAR(50),
fkEmpresa INT,
CONSTRAINT fkEmpresaSet FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO setorEmpresa VALUES
(NULL, 'Setor administrativo', 4, 'Mathias', 1),
(NULL, 'Setor Segurança', 2, 'Ana', 1),
(NULL, 'Setor Vendas', 6, 'Josue', 2),
(NULL, 'Setor Dados', 1, 'Carlos', 2);

SELECT * FROM empresa JOIN setorEmpresa ON idEmpresa = fkEmpresa;

CREATE TABLE servidores  (
idServidores INT AUTO_INCREMENT,
nome VARCHAR(45),
fkSetor INT,
CONSTRAINT fkSetorServ FOREIGN KEY (fkSetor) REFERENCES setorEmpresa(idSetorEmp),
CONSTRAINT pkSetorSe PRIMARY KEY (idServidores, fkSetor)
);

INSERT INTO servidores VALUES
(NULL, 'Servidor inferior esquerdo', 2),
(NULL, 'Servidor inferior Direito', 2),
(NULL, 'Servidor superior esquerdo', 2),
(NULL, 'Servidor inferior esquerdo', 1),
(NULL, 'Servidor superior meio', 1),
(NULL, 'Servidor superior direito', 3);

SELECT * FROM setorEmpresa JOIN servidores ON idSetorEmp = fkSetor;

CREATE TABLE leituraIdeal (
idLeituraIdeal INT PRIMARY KEY AUTO_INCREMENT,
minimo VARCHAR(40),
maximo VARCHAR(40),
fkServidores INT,
CONSTRAINT fkLeituraIDS FOREIGN KEY (fkServidores) REFERENCES servidores(idServidores)
);

INSERT INTO leituraIdeal VALUES 
(NULL, '18C°', '32C°', 1),
(NULL, '17C°', '35C°', 2),
(NULL, '18°', '32C°', 3),
(NULL, '18C°', '32C°', 4);

SELECT * FROM servidores JOIN leituraIdeal ON idServidores = fkServidores;

CREATE TABLE tipoSensor (
idTipoSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL
);

INSERT INTO tipoSensor VALUES 
(NULL, 'Temperatura C°'),
(NULL, 'Temperatura °F'),
(NULL, 'Umidade %');

CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
estado TINYINT CONSTRAINT chkEstado CHECK (estado in (0, 1)),
fkTipoSensor INT,
fkServidores INT,
CONSTRAINT fkSensorTipo FOREIGN KEY (fkTipoSensor) REFERENCES tipoSensor(idTipoSensor),
CONSTRAINT pkSensorT PRIMARY KEY (idSensor, fkTipoSensor),
CONSTRAINT fkSensorServ FOREIGN KEY (fkServidores) REFERENCES servidores(idServidores)
);

INSERT INTO sensor VALUES 
(NULL, 1, 1, 2),
(NULL, 1, 3, 2),
(NULL, 0, 1, 3),
(NULL, 0, 3, 3),
(NULL, 1, 2, 1);

SELECT * FROM tipoSensor JOIN sensor ON idTipoSensor = fkTipoSensor JOIN SERVIDORES ON idServidores = fkServidores;

CREATE TABLE leitura (
idLeitura INT AUTO_INCREMENT,
temperatura DOUBLE,
umidade DOUBLE,
dtCaptura DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
CONSTRAINT fkLeituraSen FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
CONSTRAINT pkleituraS PRIMARY KEY (idLeitura, fkSensor)
);

INSERT INTO leitura (temperatura, umidade, fkSensor) VALUES
(31.3, NULL, 1), 
(22.3, NULL, 3), 
(NULL, 55, 2),
(NULL, 70, 4);

SELECT * FROM sensor JOIN leitura ON idSensor = fkSensor JOIN servidores ON idServidores = fkServidores;



