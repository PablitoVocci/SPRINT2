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


-- INSERIR DADOS NA TABELA (EMPRESA)

INSERT INTO empresa VALUES
(NULL, 'Amazon.com, Inc.', 'Amazon', '11111111111111', '(11) 95001-0011', 'AmazonEnt@outlook.com', 'qwerrtyuuio12345'),
(NULL, 'Epic Games, Inc.', 'Epic', '22222222222222', '(11) 9922-0011', 'EpicGames1111@outlook.com', 'poyiyrfgrtgf344tbf'),
(NULL, 'Apple Inc.', 'Apple', '33333333333333', NULL, 'AppleIncent@outlook.com', 'fjhkshgklshglskhgkbg123');


-- CRIAR A TABELA (FUNCIONARIO) QUE É DEPENDENTE DA TABELA (EMPRESA)

CREATE TABLE funcionario (
idFuncionario INT AUTO_INCREMENT,
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
CONSTRAINT pkEmpFu PRIMARY KEY (idFuncionario, fkEmpresa)
) AUTO_INCREMENT = 500;


-- INSERIR DADOS NA TABELA (FUNCIONARIO)

INSERT INTO funcionario VALUES
(NULL, 'Carlos', 'Silva', 'Carlossilvadosantos111@Gmail.com', 'Carlos123', '1999-02-22', 'Masculino', '(11) 99224-3333', NULL, '22222222222', 1),
(NULL, 'Ana', 'Maria', 'AnaMariaRIa@outlook.com', 'aninha111', '2000-02-22', 'Feminino', '(11) 99224-4444', '(44) 4002-89223', '44444444444', 1),
(NULL, 'Paulo', 'Rodri', 'PabloRodri@Amazon.inc', '', '1998-11-22', 'Outro', '(11) 96655-3333', NULL, '12121212121', 2),
(NULL, 'Bernado', 'Matos', 'Bematos@Gmail.com', 'be2222', '1994-02-22', 'Masculino', '(11) 98765-2222', NULL, '66666666666', 3);


-- CRIAR A TABELA (ENDERECO) QUE É INDEPENDENTE DA TABELA (EMPRESA)

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
fkEmpresa INT,
constraint fkEmpresaEnd FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);


-- INSERIR DADOS NA TABELA (ENDERECO)

INSERT INTO endereco VALUES 
(NULL, 'Brasil', '09110-222', 'São Paulo', 'Mauá', 'toca', 'R.Martins Ovi', '222', NULL, 2),
(NULL, 'Brasil', '09220-220', 'São Paulo', 'Mocca', 'noronhas', 'R.Pedro C', '21B', NULL, 3),
(NULL, 'Brasil', '01111-111', 'São Paulo', 'mana', 'ggg', 'R.3rgg Ovi', '33', NULL, 1);
    
    
-- CRIAR A TABELA (SETOREMPRESA) QUE É DEPENDENTE DA TABELA (EMPRESA)

CREATE TABLE setorEmpresa (
idSetorEmp INT AUTO_INCREMENT,
nome VARCHAR(40) NOT NULL,
andar INT NOT NULL,
representante VARCHAR(50),
fkEmpresa INT,
CONSTRAINT fkEmpresaSet FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT pkSetorEmp PRIMARY KEY (idSetorEmp, fkEmpresa)
);


-- INSERIR DADOS NA TABELA (SETOREMPRESA)

INSERT INTO setorEmpresa VALUES
(NULL, 'Setor administrativo', 4, 'Mathias', 1),
(NULL, 'Setor Segurança', 2, 'Ana', 1),
(NULL, 'Setor Vendas', 6, 'Josue', 2),
(NULL, 'Setor Backup', 7, 'Marlos', 3),
(NULL, 'Setor Jogos', 2, 'Felipe', 2),
(NULL, 'Setor Dados', 1, 'Carlos', 2);
    
    
-- CRIAR A TABELA (SERVIDOR) QUE É DEPENDENDETE DA TABEA (SETOREMPRESA) E (EMPRESA)

CREATE TABLE servidor  (
idServidor INT AUTO_INCREMENT,
quadrante VARCHAR(15),
fkSetorEmp INT,
fkEmpresa INT,
CONSTRAINT fkSetorServ FOREIGN KEY (fkSetorEmp) REFERENCES setorEmpresa(idSetorEmp),
CONSTRAINT fkSetorEmp FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT pkSetorSe PRIMARY KEY (idServidor, fkSetorEmp, fkEmpresa)
) AUTO_INCREMENT = 50;


-- INSERIR DADOS NA TABELA (SERVIDORES)

INSERT INTO servidor VALUES
(NULL, '1A', 2, 1),
(NULL, '2A', 2, 1),
(NULL, '1B', 2, 1),
(NULL, '1A', 1, 1),
(NULL, '1C', 1, 1),
(NULL, '2B', 3, 2),
(NULL, '2B', 5, 2),
(NULL, '3B', 5, 2),
(NULL, '4B', 4, 3),
(NULL, '5B', 4, 3),
(NULL, '1C', 3, 2);


-- CRIAR A TABELA (TIPOSENSOR)

CREATE TABLE tipoSensor (
idTipoSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL
);


-- INSERIR DADOS NA TABELA (TIPOSENSOR)

INSERT INTO tipoSensor VALUES 
(NULL, 'DHT11');



-- CRIAR A TABELA (TIPOLEITURA)

CREATE TABLE tipoLeitura (
idTipoLeitura INT PRIMARY KEY AUTO_INCREMENT,
uniMedida VARCHAR(20)
);


-- INSERIR DADOS NA TABELA (TIPOLEITURA)

INSERT INTO tipoLeitura VALUES
(NULL, 'TEMP C° UMID %'),
(NULL, 'TEMP °F UMID %');


-- CRIAR A TABELA (SENSOR) QUE É DEPENDENDE DA TABELA (TIPOSENSOR) E (TIPOLEITURA)

CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
estado TINYINT CONSTRAINT chkEstado CHECK (estado in (0, 1)),
fkTipoSensor INT,
fkTipoLeitura INT,
fkServidor INT,
CONSTRAINT fkSensorTipoS FOREIGN KEY (fkTipoSensor) REFERENCES tipoSensor(idTipoSensor),
CONSTRAINT fkSensorTipoL FOREIGN KEY (fkTipoLeitura) REFERENCES tipoLeitura(idTipoLeitura),
CONSTRAINT fkSensorServ FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor),
CONSTRAINT pkSensorT PRIMARY KEY (idSensor, fkTipoSensor, fkTipoLeitura)
);


-- INSERIR DADOS NA TABELA (SENSOR)

INSERT INTO sensor VALUES 
(NULL, 1, 1, 1, 50),
(NULL, 1, 1, 1, 51),
(NULL, 1, 1, 1, 52),
(NULL, 1, 1, 1, 53),
(NULL, 1, 1, 1, 54),
(NULL, 1, 1, 1, 55),
(NULL, 1, 1, 1, 56),
(NULL, 1, 1, 1, 57),
(NULL, 1, 1, 2, 58);

        
        
-- CRIAR A TABELA (LEITURA) QUE É DEPENDENTE DA TABELA (SENSOR)

CREATE TABLE leitura (
idLeitura INT AUTO_INCREMENT,
temperatura DOUBLE,
umidade DOUBLE,
dtCaptura DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
CONSTRAINT fkLeituraSen FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
CONSTRAINT pkleituraS PRIMARY KEY (idLeitura, fkSensor)
);


-- INSERIR DADOS NA TABELA (LEITURA)

INSERT INTO leitura (temperatura, umidade, fkSensor) VALUES
(20.2, NULL, 1),
(NULL, 50.2, 1),
(24.4, NULL, 2),
(NULL, 44, 2),
(29, NULL, 3),
(NULL, 50, 3),
(28.6, NULL, 4),
(NULL, 56.3, 4),
(32.5, NULL, 5),
(NULL, 43, 5);


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA (EMPRESA) E DA TABELA (ENDERECO)

SELECT idEmpresa, nome, nomeFantasia, CNPJ, emailEmpresarial, pais, CEP, numero
	FROM empresa JOIN endereco ON fkEmpresa = idEmpresa;

    

-- EXIBIR ALGUNS DADOS DE APENAS UMA (EMPRESA) ESCOLHIDA E SEU (ENDERECO)

SELECT idEmpresa, nome, nomeFantasia, CNPJ, emailEmpresarial, pais, CEP, numero
	FROM empresa JOIN endereco ON fkEmpresa = idEmpresa 
		WHERE idEmpresa = 3;
        

-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA (EMPRESA) E DA TABELA (SETOREMPRESA)

SELECT idEmpresa, NomeFantasia, idSetorEmp AS SetorEmpresa, setorEmpresa.nome
	AS NomeSetor, andar, representante FROM empresa JOIN setorEmpresa ON fkEmpresa = idEmpresa;
    

-- EXIBIR ALGUNS DADOS DE APENAS UMA (EMPRESA) ESCOLHIDA E SEU (SETOREMPRESA)

SELECT idEmpresa, NomeFantasia, idSetorEmp AS SetorEmpresa, setorEmpresa.nome 
	AS NomeSetor, andar, representante FROM empresa JOIN setorEmpresa ON fkEmpresa = idEmpresa
		WHERE idEmpresa = 2;
        

-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA (SETOREMPRESA) E DA TABELA (SERVIDOR) E (EMPRESA)

SELECT idServidor, quadrante, idSetorEmp, setorEmpresa.nome AS nomeSetor, idEmpresa, nomeFantasia AS nomeEmpresa
	FROM servidor JOIN setorEmpresa ON fkSetorEmp = idSetorEmp
		JOIN empresa ON servidor.fkEmpresa = idEmpresa;


-- EXIBIR ALGUNS DADOS DE APENAS UMA (EMPRESA) ESCOLHIDA E SEU (SETOREMPRESA) E (SERVIDOR)

SELECT idServidor, quadrante, idSetorEmp, setorEmpresa.nome AS nomeSetor,
	idEmpresa, nomeFantasia AS nomeEmpresa FROM servidor JOIN setorEmpresa ON fkSetorEmp = idSetorEmp
		JOIN empresa ON servidor.fkEmpresa = idEmpresa WHERE idEmpresa = 2;
            

    
-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA (SENSOR) JUNTO COM A TABELA (TIPOSENSOR) E (TIPOLEITURA) E (SERVIDOR)

SELECT idSensor, estado, nome, uniMedida, idServidor, quadrante, fkSetorEmp as Setor
	FROM sensor JOIN tipoSensor ON fkTipoSensor = idTipoSensor
		JOIN tipoLeitura ON fkTipoLeitura = idTipoLeitura
			JOIN servidor ON  fkServidor = idServidor;
            
            
-- EXIBIR ALGUNS DADOS DE APENAS UM (SETOR) ESCOLHIDO E SEUS (SENSOR) E (TIPOSENSOR) E (TIPOLEITURA) E (SERVIDOR)

SELECT idSensor, estado, nome, uniMedida, idServidor, quadrante, fkSetorEmp as Setor
	FROM sensor JOIN tipoSensor ON fkTipoSensor = idTipoSensor
		JOIN tipoLeitura ON fkTipoLeitura = idTipoLeitura
			JOIN servidor ON  fkServidor = idServidor
				WHERE fkSetorEmp = 5;
            
            

-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA (SENSOR) DA TABELA (LEITURA) E (SERVIDOR)

SELECT idLeitura, estado, temperatura, umidade, dtCaptura, quadrante, fkSetorEmp
	FROM sensor JOIN leitura ON fkSensor = idSensor
		JOIN servidor ON fkServidor = idServidor;
        
        
-- EXIBIR ALGUNS DADOS DE APENAS UM (SETOR) ESCOLHIDO E SEUS (SENSOR) E (LEITURA) E (SERVIDOR)

SELECT idLeitura, estado, temperatura, umidade, dtCaptura, quadrante, fkSetorEmp AS setor
	FROM sensor JOIN leitura ON fkSensor = idSensor
		JOIN servidor ON fkServidor = idServidor
			WHERE fkSetorEmp = 1;
         


-- UPDATE NO CEP DA EMPRESA EPIC GAMES

UPDATE endereco SET CEP = '12345-789' where idEndereco = 1;


-- DELETANDO O USUARIO ANA 

DELETE FROM funcionario where idFuncionario = 501;
SELECT idFuncionario, nome, email, telefoneCelular, CPF from funcionario;








