CREATE DATABASE flights;

USE flights;

CREATE TABLE person(
CF nvarchar(16) PRIMARY KEY, 
name nvarchar(30) NOT NULL,
surname nvarchar(30) NOT NULL
);

CREATE TABLE airplane(
id_airplane int identity(1,1) PRIMARY KEY,
model nvarchar(20) NOT NULL,
company nvarchar(30) NOT NULL,
n_max_people int NOT NULL
);

CREATE TABLE airport(
id_airport int identity(1,1) PRIMARY KEY, 
city nvarchar(30) NOT NULL,
);

CREATE TABLE travel(
id_travel int identity(1,1) PRIMARY KEY,
id_dest int FOREIGN KEY REFERENCES airport(id_airport),
id_part int FOREIGN KEY REFERENCES airport(id_airport),
date_part datetime NOT NULL,
date_dest datetime NOT NULL,
id_airplane int FOREIGN KEY REFERENCES airplane(id_airplane)
);


CREATE TABLE ticket(
id_ticket int identity(1,1) PRIMARY KEY,
CF nvarchar(16) FOREIGN KEY REFERENCES person(CF),
id_travel int FOREIGN KEY REFERENCES travel(id_travel),
price decimal NOT NULL,
);

CREATE TABLE delete_travel(
id_travel int FOREIGN KEY REFERENCES travel(id_travel) PRIMARY KEY,
);

/*Query vedere il nome e cognome delle persone alle quali è stata eliminata la tratta*/
SELECT name, surname, id_ticket, delete_travel.id_travel
FROM ticket
INNER JOIN delete_travel ON delete_travel.id_travel  = ticket.id_travel 
INNER JOIN person ON ticket.CF = person.CF;

/*Query vedere aerei stanno volando su quale tratta e dove atterreranno*/
SELECT airplane.id_airplane , airplane.model, airplane.company, travel.id_travel, airport.city
FROM travel
INNER JOIN airplane ON airplane.id_airplane = travel.id_airplane
INNER JOIN airport ON travel.id_dest = airport.id_airport;

/*Query visualizzare nome cognome id ticket e punto di partenza ed arrivo*/
SELECT person.name, person.surname, ticket.id_ticket, travel.id_dest, travel.id_part
FROM travel
LEFT JOIN ticket ON ticket.id_travel = travel.id_travel
LEFT JOIN person ON person.CF = ticket.CF; 
