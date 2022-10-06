CREATE DATABASE student;
USE student;
CREATE TABLE studente(
nome nvarchar(30) NOT NULL,
cognome nvarchar(30) NOT NULL,
id_stud int identity(1,1) PRIMARY KEY,
classe nvarchar(3) NOT NULL
);

CREATE TABLE gruppo(
id_grup int identity(1,1) PRIMARY KEY,
rappresentante nvarchar(30) NOT NULL,
nome_gruppo nvarchar(15) NOT NULL
);

CREATE TABLE stu_gru(
id_stud int,
id_grup int,
);

INSERT INTO stu_gru (id_stud)
SELECT id_stud 
FROM studente
WHERE 1=1;

ALTER TABLE stu_gru 
ADD primary_key int identity(1,1) UNIQUE;

SELECT s.nome, s.cognome, s.classe, g.id_grup, g.rappresentante
FROM studente s
LEFT JOIN gruppo g ON s.id_stud = g.id_grup
LEFT JOIN stu_gru sg ON s.id_stud = sg.id_stud AND sg.id_grup = g.id_grup
WHERE s.classe = '5F';