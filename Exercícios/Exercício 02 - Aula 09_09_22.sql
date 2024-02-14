# Gabriel-Hepper-MYSQL

USE senac;

CREATE TABLE Filmes
(
titulo VARCHAR(250),
ano INT(4),
diretor VARCHAR(100),
genero VARCHAR(20),
atoresPrincipais VARCHAR(1000),
duracao INT(4), -- em minutos
valorDoIngresso REAL(5,2)
);

SET SQL_SAFE_UPDATES = 0;

SELECT DISTINCT atoresPrincipais FROM Filmes WHERE genero like 'terror'
ORDER BY atoresPrincipais DESC;

SELECT titulo FROM Filmes WHERE ano > '1900' AND ano <= '2000' AND duracao <= '70';

SELECT titulo, diretor, valorDoIngresso/duracao AS precoPorMinuto FROM Filmes;

UPDATE Filmes SET valorDoIngresso = valorDoIngresso * 1.027
 WHERE atoresPrincipais LIKE 'Nicholas Cage';
 
 DELETE FROM Filmes WHERE valorDoIngresso/duracao < 0.13;
 
 INSERT INTO Filmes(titulo, ano, diretor, genero, atoresPrincipais, duracao, valorDoIngresso)
 VALUES ("Titanic 3D", '1997', 'James Cameron', 'drama/romance',
		'Leonardo DiCaprio e Kate Winslet', '194', '18.00');
        
SELECT * FROM filmes;
