# Gabriel-Hepper-MYSQL

USE senac;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM aeroporto;
SELECT * FROM voo;
SELECT * FROM piloto;
SELECT * FROM escala;

create table aeroporto
(CODA char(3) not null,
NOMEA varchar(20) not null, 
CIDADE varchar(50) not null, 
PAIS char(2) not null,
constraint PK_AEROPORTO primary key(CODA));

insert into aeroporto values ('poa','salgado filho','porto alegre','BR');
insert into aeroporto values ('gru','guarulhos','sao paulo','BR');
insert into aeroporto values ('gal','galeao','rio de janeiro','BR');
insert into aeroporto values ('rom','int de rome','roma','IT');
insert into aeroporto values ('stu','int de stutgart','stutgart','AL');
insert into aeroporto values ('gau','charles de gaulle','paris','FR');
insert into aeroporto values ('mun','int de munique','munique','AL');

create table voo
(CODV char(5) not null, 
ORIGEM char(3) not null, 
DEST char(3) not null,
HORA int not null,
constraint PK_VOO primary key(CODV),
constraint FK_AER_VOOORIG foreign key (ORIGEM) references aeroporto (CODA),
constraint FK_AER_VOODEST foreign key (DEST) references aeroporto (CODA));

insert into voo values ('RG230','gru','poa','7');
insert into voo values ('RG330','gru','rom','11');
insert into voo values ('RG430','poa','gru','14');
insert into voo values ('RG530','gru','gau','17');
insert into voo values ('RG531','gau','gru','11');
insert into voo values ('VS100','gru','rom','14');
insert into voo values ('VS150','rom','gru','7');
insert into voo values ('LF200','gru','stu','8');
insert into voo values ('LF210','stu','mun','17');
insert into voo values ('KL400','gal','stu','14');

create table piloto
(CODP char(3) not null,
NOMEP varchar(10) not null,
SALARIO int not null, 
GRATIFICACOES int not null, 
TEMPO int not null, 
PAIS char(2) not null,
COMPANHIA varchar(10) not null,
constraint PK_PILOTO primary key(CODP));

insert into piloto values ('p11','joao', 3000, 200, 5,'BR','tam');
insert into piloto values ('p13','pedro', 2000, 100, 5,'BR','tam');
insert into piloto values ('p12','paulo', 3000, 200, 3,'BR','tam');
insert into piloto values ('p21','antonio', 1500, 300, 7,'BR','gol');
insert into piloto values ('p22','carlos', 5000, 200, 10,'BR','gol');
insert into piloto values ('p31','hanz', 5000, 1000, 6,'AL','lufthansa');
insert into piloto values ('p41','roel', 5000, 2000, 5,'NL','klm');

create table escala
(CODV char(5) not null, 
DATA date not null,
CODP char(3),
AVIAO varchar(10) not null,
constraint PK_ESCALA primary key(CODV, DATA),
constraint FK_PILOTO_ESCALA foreign key (CODP) references piloto (CODP),
constraint FK_VOO_ESCALA foreign key (CODV) references voo (CODV));

insert into escala values('RG230','2014-05-01','p11','777');
insert into escala values('RG230','2014-06-01','p11','777');
insert into escala values('VS100','2014-05-01','p21','A-320');
insert into escala values('LF200','2014-05-01','p31','777');
insert into escala values('RG330','2014-06-01','p12','777');
insert into escala values('RG330','2014-07-01','p12','A-320');
insert into escala values('RG530','2014-05-01','p12','A-320');
insert into escala values('LF200','2014-06-01','p31','A-320');
insert into escala values('KL400','2014-05-01','p41','A-320');
insert into escala values('LF210','2014-05-01','p31','A-320');
insert into escala values('VS150','2014-06-01','p21','A-320');

USE senac;

/*1°A*/
/*Selecionar a cidade e o país onde o código do voo é igual a RG230.*/
SELECT cidade, pais FROM aeroporto INNER JOIN voo
ON voo.dest = aeroporto.coda
WHERE voo.codv = 'RG230';

/*1°B*/
/*Selecionar o dódigo de voo e o nome do piloto onde o código do piloto da tabela piloto
é igual ao código do piloto na tabela escala.*/
SELECT CODV, NOMEP FROM piloto INNER JOIN escala ON piloto.CODP = escala.CODP;

/*1°C*/
/*Selecionar o código do voo, hora, data da tabela voo junto com a tabela escala
onde o código de voo na tabela voo e igual ao código de voo na tabela escala e junto
da tabela aeroporto onde o destino do voo é igual ao código A do aeroporto onde
o país é igual a 'it' ou 'al'.*/
SELECT voo.CODV, HORA, DATA FROM voo INNER JOIN escala ON voo.CODV = escala.CODV
INNER JOIN aeroporto ON voo.dest = aeroporto.CODA
 WHERE aeroporto.pais = 'it' OR aeroporto.pais = 'al';

/*1°D*/
/*Selecionar o menor salário, o maior salário e a média dos salarios dos pilotos.*/
SELECT MIN(SALARIO) AS MENOR, MAX(SALARIO) AS MAIOR, AVG(SALARIO) AS MÉDIA
FROM piloto WHERE PAIS = 'BR';

/*2°A*/
/*Selecionar nome do piloto, companhia e salário do piloto e agrupe pela companhia que
tem salário menor que 2000.*/
SELECT NOMEP, COMPANHIA, SALARIO FROM piloto
GROUP BY COMPANHIA HAVING max(SALARIO) < '2000';

/*2°B*/
/*Selecione a companhia do piloto junto da tabela escala onde o código do piloto
da escala é igual o código do piloto do piloto e agrupe pela companhia que tem
avião sem repetir igual a 1.*/
SELECT COMPANHIA FROM piloto INNER JOIN ESCALA ON ESCALA.CODP = PILOTO.CODP
GROUP BY COMPANHIA HAVING count(distinct aviao) = '1';

/*3°A*/
/*Selecione o nome do piloto da tabela piloto onde dentro da companhia selecione
a companhia do piloto do piloto e agrupe pela companhia tendo código do piloto
que seja maior que 1.*/
SELECT NOMEP FROM piloto WHERE COMPANHIA IN (SELECT PILOTO.COMPANHIA FROM PILOTO
GROUP BY PILOTO.COMPANHIA HAVING count(PILOTO.CODP) > 1);

/*3°B*/
/*Selecione o nome do piloto da tabela piloto onde o salario seja menor selecionando
a média do salário do piloto da tabela piloto.*/ 
SELECT NOMEP FROM piloto WHERE SALARIO < (SELECT AVG(PILOTO.SALARIO) FROM PILOTO);
