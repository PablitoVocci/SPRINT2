create database dataCenters;

use dataCenters;


create table usuario (
idUsuario int primary key auto_increment,
nome varchar(80) not null,
email varchar(80) not null constraint chkemail check (email like '%@%'),
senha varchar(50) not null,
cpf char(11),
telefone varchar(15),
dtNasc date
);

insert into usuario values
(null, 'Pedro', 'pedropedreiro@hotmail.com', '22cff22', '12345678901', '123456789', '2001-12-11'),
(null, 'Ana', 'anazinhavidaloka111@Gmail.com', '400028922y', '12345678901', '123456789', '1992-02-21'),
(null, 'Rogerio', 'Rogerioceni123@outlook.com', '100gols', '11111111111', '250053339', '1980-10-25');

select * from usuario;


create table empresaCliente (
idEmpresa int primary key auto_increment,
nomeEmpresa varchar(80) not null,
emailEmpresa varchar(80) not null constraint chkEmailEmpresa check (emailEmpresa like '%@%'), 
qntServer int not null,
cep char(8) not null,
cnpj char(14),
telefone varchar(15)
);

insert into empresaCliente values
(null, 'SGMaga', 'sgmagainterpress@outlook.com', 3, '09220460', '01020304050607', '999999999'),
(null, 'Mararara', 'mararamalala@outlook.com', 2, '02333050', '55555555555555', '888888888');

select * from empresaCliente;

create table sensor (
idSensor int primary key auto_increment,
nomeSensor varchar(30) not null,
setor varchar(30) not null,
estadoSensor tinyint constraint chkestadosensor check (estadosensor in(0, 1)),
captura double,
dtAtual datetime default current_timestamp
);

insert into sensor (nomeSensor, setor, estadoSensor, captura) values 
('Temperatura', 'setor 3',  1, 24.5),
( 'Umidade', 'setor 3', 0, 0),
( 'Temperatura', 'setor 2', 0, 0),
( 'Umidade', 'setor 2', 1, 40),
( 'Temperatura', 'setor 5', 1, 30),
( 'Umidade', 'setor 5', 1, 20.3);

select * from sensor;




