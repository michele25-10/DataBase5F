/*creazione di una library*/
/*creazione di un db*/
CREATE DATABASE quinta_f_library;

/*rendere il database di lavoro db_name
*USE db_name;
*/
USE quinta_f_library;

/*
 *CREATE TABLE table_name(
 *attribute_name type attribute_constraint,
 *...,
 *attribute_name type attribute_constraint,
 *table_constraint);
 *attribute NOT NULL & UNIQUE =>PRIMARY KEY
 */
CREATE TABLE book(
ISBN nvarchar(13) PRIMARY KEY,
title nvarchar (100) NOT NULL
);

/*
 *ohh... mi sono dimenticato un attribute come faccio? 
 *modifichiamo la tabella con 
 *ALTER TABLE table_name 
 *ADD attribute_name type attribute_constraint;
 */
ALTER TABLE book 
ADD publishing_house nvarchar(20) NOT NULL;

/*Elimina la colonna*/
ALTER TABLE book 
DROP COLUMN publishing_house;

ALTER TABLE book 
ADD publishing_house nvarchar(20);


INSERT INTO book (ISBN, title)
VALUES ('9788836007745', 'SQLPHP');

/*Aggiungo ad una tupla un valore specifico con una condizione*/
UPDATE book 
SET publishing_house = 'HOEPLI'
WHERE ISBN = '9788836007745';

INSERT INTO book (ISBN, title, publishing_house)
VALUES ('9788826823317', 
	'NUOVO Scienze e Tecnologie Applicate con ARDUINO',
	'Atlas');

INSERT INTO book (ISBN, title, publishing_house)
VALUES ('9788820383411', 
	'DATAGAME ',
	'HOEPLI');

SELECT * FROM book b;

/*Tabella delle publishing_house*/
CREATE TABLE publishing_house(
id int identity(1,1) PRIMARY KEY,
publishing_house nvarchar(20) NOT NULL
);

/*popolo una tabella da un'altra tabella(Importo)*/
INSERT INTO publishing_house (publishing_house)
SELECT DISTINCT publishing_house 
FROM book;

SELECT * FROM publishing_house ph;

/*UNIONE delle due tabelle (A*B=C)*/
SELECT b.ISBN as 'Codice ISBN', b.title as 'Titolo', ph.id as 'Codice Casa Editrice'
FROM book b
FULL JOIN publishing_house ph
ON b.publishing_house = ph.publishing_house ;

/*Ipotesi 1:
 * Importato la join in una nuova tabella (book_new)
SELECT b.ISBN as 'ISBN', b.title as 'title', ph.id as 'id_publishing_house'
INTO book_new
FROM book b
FULL JOIN publishing_house ph
ON b.publishing_house = ph.publishing_house ;
*/


/*Ipotesi 2:
 * Aggiornamento dei dati sulla tabella esistente
 * 1° passaggio: creare l'attributo id_publishing_name
 * 				 sulla tabella book
 * 2° passaggio: aggiornare le tuple prelevando le informazione della tabella publishing_name
 * N.B. nel nostro caso l'attributo publishing_house di publishing_house non deve essere unique
 */
ALTER TABLE book
ADD id_publishing_name int;

ALTER TABLE publishing_house 
ADD UNIQUE (publishing_house);

UPDATE book 
SET b.id_publishing_name = ph.id 
FROM book b
LEFT JOIN publishing_house ph
ON b.publishing_house = ph.publishing_house
WHERE 1=1;
