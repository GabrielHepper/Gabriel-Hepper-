CREATE DATABASE  exercício1;
USE exercício1;

CREATE TABLE prods
(codigo NUMERIC(3) NOT NULL,
nome VARCHAR(50) NOT NULL,
preco NUMERIC(5,2) NOT NULL,
tipo CHAR(1) NULL,
CONSTRAINT PK1 PRIMARY KEY (codigo));

INSERT INTO prods VALUES
(10, 'HD', 200, 'C'),
(11, 'Memória', 250, 'C'),
(12, 'Impressora', 600, 'P'),
(13, 'Processador', 600, 'C'),
(14, 'DVD-RW', 2, 'S'),
(15, 'Papel A4', 19, 'S'),
(16, 'Scanner', 199, 'P');

DESCRIBE TABLE prods;
SELECT * FROM prods;

SELECT nome FROM prods;

SELECT tipo FROM prods WHERE tipo = 'C';
SELECT tipo FROM prods WHERE tipo = 'P';
SELECT tipo FROM prods WHERE tipo = 'S';

SELECT SUM(preco/7) AS mediaTotal FROM prods;
SELECT SUM(preco/2) AS mediaSuprimentos FROM prods WHERE tipo = 'S';
SELECT SUM(preco/3) AS mediaC FROM prods WHERE tipo = 'C';
SELECT SUM(preco/2) AS mediaP FROM prods WHERE tipo = 'P';
SELECT SUM(preco/2) AS mediaS FROM prods WHERE tipo = 'S';

SELECT AVG(preco) AS mediaTotal FROM prods;
SELECT AVG(preco) AS mediaSuprimentos FROM prods WHERE tipo = 'S';
SELECT AVG(preco) AS mediaC FROM prods WHERE tipo = 'C';
SELECT AVG(preco) AS mediaP FROM prods WHERE tipo = 'P';
SELECT AVG(preco) AS mediaS FROM prods WHERE tipo = 'S';
