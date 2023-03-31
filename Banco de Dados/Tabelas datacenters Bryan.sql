CREATE DATABASE dataCenters;

USE dataCenters;


CREATE TABLE usuario (
idUsuario int primary key auto_increment,
nome varchar(80) not null,
email varchar(80) not null constraint chkemail check (email like '%@%'),
senha varchar(50) not null,
cpf char(11),
telefoneFixo varchar(15),
telefoneMovel varchar(15),
dtNasc date
);

INSERT INTO usuario VALUES
(null, 'Pedro', 'pedropedreiro@hotmail.com', '22cff22', '12345678901', '11 4002 8922', '11 933313333', '2001-12-11'),
(null, 'Ana', 'anazinhavidaloka111@Gmail.com', '400028922y', '12345678901', '11 3333 33333', '11 911113111', '1992-02-21'),
(null, 'Rogerio', 'Rogerioceni123@outlook.com', '100gols', '11111111111', '11 9999 9999', '11 9332213322', '1980-10-25');

SELECT * FROM usuario;


CREATE TABLE empresaCliente (
idEmpresa int primary key auto_increment,
nomeEmpresa varchar(80) not null,
emailEmpresa varchar(80) not null constraint chkEmailEmpresa check (emailEmpresa like '%@%'),
cep char(9) not null,
numEnd varchar(10),
cnpj char(14),
telefoneFixo varchar(15),
telefoneMovel varchar(15)
);

INSERT INTO empresaCliente VALUES
(null, 'SGMaga', 'sgmagainterpress@outlook.com', '09330-330', '33D', '01020304050607', '11 4033 2033', '11 994059999'),
(null, 'Mararara', 'mararamalala@outlook.com', '01000-100', '433','55555555555555', '11 9330 3334', '11 993324499');

SELECT * FROM empresaCliente;

CREATE TABLE sensor (
idSensor int primary key auto_increment,
nomeSensor varchar(30) not null,
estadoSensor tinyint constraint chkestadosensor check (estadosensor in(0, 1)),
captura double,
dtAtual datetime default current_timestamp
);

INSERT INTO sensor (nomeSensor, estadoSensor, captura) VALUES
('Temperatura', 1, 24.5),
( 'Umidade', 0, 0),
( 'Temperatura', 0, 0),
( 'Umidade', 1, 40),
( 'Temperatura', 1, 30),
( 'Umidade', 1, 20.3);

SELECT * FROM sensor;


