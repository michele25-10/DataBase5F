CREATE DATABASE campionato;

USE campionato;

CREATE TABLE serie_a(
id_atleta int,
nome nvarchar(30),
squadra nvarchar(30),
id_squadra int
);

CREATE TABLE stipendio(
id_atleta int, 
mese nvarchar(30),
anno nvarchar(5),
stipendio int,
);

DROP TABLE stipendio;

CREATE TABLE stipendio(
id_atleta int, 
mese nvarchar(30),
anno nvarchar(5),
stipendio int,
);

CREATE TABLE atleta(
id_atleta int PRIMARY KEY,
nome nvarchar(30) NOT NULL
);

CREATE TABLE stipendio_atleta(
id int identity(1,1) PRIMARY KEY,
id_atleta int FOREIGN KEY REFERENCES atleta(id_atleta),
mese nvarchar(15) NOT NULL,
anno nvarchar(4) NOT NULL,
stipendio decimal(8, 3),
);

CREATE TABLE squadra(
id_squadra int PRIMARY KEY,
nome_squadra int NOT NULL,
);

ALTER TABLE squadra
DROP COLUMN nome_squadra;

ALTER TABLE squadra
ADD nome_squadra nvarchar(30) NOT NULL;

CREATE TABLE tesseramento(
id int identity(1,1) PRIMARY KEY,
id_atleta int FOREIGN KEY REFERENCES atleta(id_atleta),
id_squadra int FOREIGN KEY REFERENCES squadra(id_squadra),
);

INSERT INTO atleta(id_atleta, nome)
SELECT DISTINCT id_atleta, nome 
FROM serie_a;

INSERT INTO squadra(id_squadra, nome_squadra)
SELECT DISTINCT id_squadra, squadra
FROM serie_a;

INSERT INTO stipendio_atleta(id_atleta, mese, anno, stipendio)
SELECT DISTINCT stipendio.id_atleta, stipendio.mese, stipendio.anno, stipendio.stipendio
FROM stipendio;

INSERT INTO tesseramento(id_atleta, id_squadra)
SELECT DISTINCT id_atleta, id_squadra 
FROM serie_a;

SELECT * FROM squadra s ORDER BY s.nome_squadra;

SELECT COUNT(*) FROM squadra s;

----Unione atleti e squadra attraverso tesseramento
SELECT a.nome, s.nome_squadra
FROM tesseramento t 
INNER JOIN atleta a ON t.id_atleta = a.id_atleta
INNER JOIN squadra s ON t.id_squadra = s.id_squadra;

---Quanti calciatori per squadra
SELECT s.nome_squadra, COUNT(s.id_squadra)
FROM tesseramento t 
INNER JOIN atleta a ON t.id_atleta = a.id_atleta
INNER JOIN squadra s ON t.id_squadra = s.id_squadra
GROUP BY s.nome_squadra 
ORDER BY COUNT(s.id_squadra) DESC;

---Qual'è lo stipendio totale versato dalle società
SELECT s.nome_squadra, SUM(sa.stipendio) as "stipendio totale", AVG(sa.stipendio) as "Stipendio medio", COUNT(*) as "totale conti"
FROM stipendio_atleta sa 
INNER JOIN tesseramento t ON sa.id_atleta = t.id_atleta
INNER JOIN squadra s ON s.id_squadra = t.id_squadra
GROUP BY s.nome_squadra
ORDER BY SUM(sa.stipendio) ASC; 
