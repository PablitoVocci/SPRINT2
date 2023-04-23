CREATE DATABASE digitalTherm;

USE digitalTherm;


-- CRIAR A TABELA EMPRESA

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
nomeFantasia VARCHAR(60),
CNPJ CHAR(14) NOT NULL,
telefoneComercial CHAR(15),
emailEmpresarial VARCHAR(80) NOT NULL CONSTRAINT chkEmailEmp CHECK (emailEmpresarial LIKE '%@%'),
senha VARCHAR(45) NOT NULL
);


-- INSERIR DADOS NA TABELA EMPRESA

INSERT INTO empresa VALUES
(NULL, 'Amazon.com, Inc.', 'Amazon', '11111111111111', '(11) 95001-0011', 'AmazonEnt@outlook.com', 'qwerrtyuuio12345'),
(NULL, 'Epic Games, Inc.', 'Epic', '22222222222222', '(11) 9922-0011', 'EpicGames1111@outlook.com', 'poyiyrfgrtgf344tbf'),
(NULL, 'Apple Inc.', 'Apple', '33333333333333', NULL, 'AppleIncent@outlook.com', 'fjhkshgklshglskhgkbg123');


-- CRIAR A TABELA USUARIO

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


-- INSERIR DADOS NA TABELA USUARIO

INSERT INTO usuario VALUES
(NULL, 'Carlos', 'Silva', 'Carlossilvadosantos111@Gmail.com', 'Carlos123', '1999-02-22', 'Masculino', '(11) 99224-3333', NULL, '22222222222', 1),
(NULL, 'Ana', 'Maria', 'AnaMariaRIa@outlook.com', 'aninha111', '2000-02-22', 'Feminino', '(11) 99224-4444', '(44) 4002-89223', '44444444444', 1),
(NULL, 'Paulo', 'Rodri', 'PabloRodri@Amazon.inc', '', '1998-11-22', 'Outro', '(11) 96655-3333', NULL, '12121212121', 2),
(NULL, 'Bernado', 'Matos', 'Bematos@Gmail.com', 'be2222', '1994-02-22', 'Masculino', '(11) 98765-2222', NULL, '66666666666', 3);


-- EXIBIR OS DADOS DA TABELA EMPRESA JUNTO COM OS DADOS DA TABELA USUARIO

SELECT * FROM empresa JOIN usuario ON idEmpresa = fkEmpresa;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA EMPRESA E DA TABELA USUARIO

SELECT empresa.nome AS NomeEmpresa, nomeFantasia, CNPJ, TelefoneComercial, emailEmpresarial, empresa.senha AS SenhaEmpresa,
	idUsuario, usuario.nome as NomeUsuario, sobrenome, email, usuario.senha 
		AS SenhaUsuario, dtNasc, Genero, telefoneCelular, telefoneFixo, CPF 
			FROM empresa JOIN usuario ON idEmpresa = fkEmpresa;


-- CRIAR A TABELA ENDERECO

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


-- INSERIR DADOS NA TABELA ENDERECO

INSERT INTO endereco VALUES 
(NULL, 'Brasil', '09330550', 'São Paulo', 'Mauá', 'toca', 'R.Martins Ovi', '222', NULL, NULL, 2), 
(NULL, 'Brasil', '09888777', 'Bahia', 'loccc', 'toca', 'R.ggg Ovi', '33', 'ala' , 501, NULL), 
(NULL, 'Brasil', '02222555', 'São Paulo', 'mana', 'ggg', 'R.3rgg Ovi', '33', NULL, NULL, 1), 
(NULL, 'Brasil', '555557777', 'São Paulo', 'jjjj', 'uyy', 'R.bfgb Ovi', '222', NULL, 502, NULL);


-- EXIBIR OS DADOS DA TABELA USUARIO JUNTO COM OS DADOS DA TABELA ENDERECO

SELECT * FROM usuario JOIN endereco ON idUsuario = fkUsuario;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA USUARIO E DA TABELA ENDERECO

 SELECT idUsuario, nome, email, telefoneCelular, CPF, pais, CEP, numero 
	FROM usuario JOIN endereco ON idUsuario = fkUsuario;
    
    
-- EXIBIR OS DADOS DA TABELA EMPRESA JUNTO COM OS DADOS DA TABELA ENDERECO

SELECT * FROM empresa JOIN endereco ON idEmpresa = fkEmpresa;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA EMPRESA E DA TABELA ENDERECO

SELECT idEmpresa, nome, nomeFantasia, CNPJ, emailEmpresarial, pais, CEP, numero
	FROM empresa JOIN endereco ON idEmpresa = fkEmpresa;
    
    
-- CRIAR A TABELA SETOREMPRESA

CREATE TABLE setorEmpresa (
idSetorEmp INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(40) NOT NULL,
andar INT NOT NULL,
representante VARCHAR(50),
fkEmpresa INT,
CONSTRAINT fkEmpresaSet FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);


-- INSERIR DADOS NA TABELA SETOREMPRESA

INSERT INTO setorEmpresa VALUES
(NULL, 'Setor administrativo', 4, 'Mathias', 1),
(NULL, 'Setor Segurança', 2, 'Ana', 1),
(NULL, 'Setor Vendas', 6, 'Josue', 2),
(NULL, 'Setor Dados', 1, 'Carlos', 2);


-- EXIBIR OS DADOS DA TABELA EMPRESA JUNTO COM OS DADOS DA TABELA SETOREMPRESA

SELECT * FROM empresa JOIN setorEmpresa ON idEmpresa = fkEmpresa;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA EMPRESA E DA TABELA SETOREMPRESA

SELECT idEmpresa, NomeFantasia, idSetorEmp AS SetoresEmpresa, setorEmpresa.nome AS NomeSetor, andar, representante
	FROM empresa JOIN setorEmpresa ON idEmpresa = fkEmpresa;
    
-- CRIAR A TABELA SERVIDORES

CREATE TABLE servidores  (
idServidores INT AUTO_INCREMENT,
nome VARCHAR(45),
fkSetor INT,
CONSTRAINT fkSetorServ FOREIGN KEY (fkSetor) REFERENCES setorEmpresa(idSetorEmp),
CONSTRAINT pkSetorSe PRIMARY KEY (idServidores, fkSetor)
);


-- INSERIR DADOS NA TABELA SERVIDORES

INSERT INTO servidores VALUES
(NULL, 'Servidor inferior esquerdo', 2),
(NULL, 'Servidor inferior Direito', 2),
(NULL, 'Servidor superior esquerdo', 2),
(NULL, 'Servidor inferior esquerdo', 1),
(NULL, 'Servidor superior meio', 1),
(NULL, 'Servidor superior direito', 3);


-- EXIBIR OS DADOS DA TABELA SETOREMPRESA JUNTO COM OS DADOS DA TABELA SERVIDORES

SELECT * FROM setorEmpresa JOIN servidores ON idSetorEmp = fkSetor;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA SETOREMPRESA E DA TABELA SERVIDORES

SELECT fkEmpresa as Empresa, idSetorEmp AS SetorEmpresa, setorEmpresa.nome AS nomeSetor, andar, representante, idServidores AS ServidoresEmpresa,
	servidores.nome AS NomeServidor FROM setorEmpresa JOIN servidores ON idSetorEmp = fkSetor;
    
    
-- CRIAR A TABELA LEITURAIDEAL

CREATE TABLE leituraIdeal (
idLeituraIdeal INT PRIMARY KEY AUTO_INCREMENT,
minimo VARCHAR(40),
maximo VARCHAR(40),
fkServidores INT,
CONSTRAINT fkLeituraIDS FOREIGN KEY (fkServidores) REFERENCES servidores(idServidores)
);


-- INSERIR DADOS NA TABELA LEITURAIDEAL

INSERT INTO leituraIdeal VALUES 
(NULL, '18C°', '32C°', 1),
(NULL, '40%', '55%', 1),
(NULL, '17C°', '35C°', 2),
(NULL, '41%', '56%', 2),
(NULL, '18°', '32C°', 3),
(NULL, '44%', '59%', 3),
(NULL, '18C°', '32C°', 4),
(NULL, '50%', '67%', 4);


-- EXIBIR OS DADOS DA TABELA SERVIDORES JUNTO COM OS DADOS DA TABELA LEITURAIDEAL

SELECT * FROM servidores JOIN leituraIdeal ON idServidores = fkServidores;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA SERVIDORES E DA TABELA LEITURAIDEAL

SELECT idServidores AS ServidorEmpresa, nome, idLeituraIdeal AS LeituraIdeal, minimo, maximo 
	FROM servidores JOIN leituraIdeal ON idServidores = fkServidores;
    

-- CRIAR A TABELA TIPOSENSOR

CREATE TABLE tipoSensor (
idTipoSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL
);


-- INSERIR DADOS NA TABELA TIPOSENSOR

INSERT INTO tipoSensor VALUES 
(NULL, 'temperatura C° umidade %'),
(NULL, 'Temperatura °F umdidade %');



-- CRIAR A TABELA SENSOR

CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
estado TINYINT CONSTRAINT chkEstado CHECK (estado in (0, 1)),
fkTipoSensor INT,
fkServidores INT,
CONSTRAINT fkSensorTipo FOREIGN KEY (fkTipoSensor) REFERENCES tipoSensor(idTipoSensor),
CONSTRAINT pkSensorT PRIMARY KEY (idSensor, fkTipoSensor),
CONSTRAINT fkSensorServ FOREIGN KEY (fkServidores) REFERENCES servidores(idServidores)
);


-- INSERIR DADOS NA TABELA SENSOR

INSERT INTO sensor VALUES 
(NULL, 1, 1, 2),
(NULL, 0, 1, 3),
(NULL, 1, 1, 4),
(NULL, 1, 2, 1);


-- EXIBIR OS DADOS DA TABELA TIPOSENSOR JUNTO COM OS DADOS DA TABELA SENSOR E DA TABELA SERVIDORES

SELECT * FROM tipoSensor JOIN sensor ON idTipoSensor = fkTipoSensor 
	JOIN servidores ON idServidores = fkServidores;
    
    
-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA TIPOSENSOR DA TABELA SENSOR E DA TABELA SERVIDORES

SELECT idTipoSensor AS TipoSensor, tipoSensor.nome AS NomeSensor, estado, IdServidores,
	servidores.nome AS NomeServidor,fkSetor AS Setor FROM tipoSensor JOIN sensor ON idTipoSensor = fkTipoSensor 
		JOIN servidores ON idServidores = fkServidores;
        
        
-- CRIAR A TABELA LEITURA

CREATE TABLE leitura (
idLeitura INT AUTO_INCREMENT,
temperatura DOUBLE,
umidade DOUBLE,
dtCaptura DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
CONSTRAINT fkLeituraSen FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
CONSTRAINT pkleituraS PRIMARY KEY (idLeitura, fkSensor)
);


-- INSERIR DADOS NA TABELA LEITURA

INSERT INTO leitura (temperatura, umidade, fkSensor) VALUES
(44.5, NULL, 1),
(NULL, 50.2, 1),
(43.5, NULL, 2),
(NULL, 44, 2);


-- EXIBIR OS DADOS DA TABELA SENSOR JUNTO COM OS DADOS DA TABELA LEITURA

SELECT * FROM sensor JOIN leitura ON idSensor = fkSensor;


-- EXIBIR OS DADOS DE ALGUNS ATRIBUTOS ESCOLHIDO DA TABELA SENSOR DA TABELA LEITURA E DA TABELA SERVIDORES

SELECT idLeitura AS Leitura, temperatura, umidade, dtCaptura AS DataHoraCaptura, 
	nome AS nomeServidor, fkSetor AS SetorServidor FROM sensor JOIN leitura ON idSensor = fkSensor
		 JOIN servidores ON idServidores = fkServidores;



