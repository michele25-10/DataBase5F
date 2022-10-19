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

ALTER TABLE travel
DROP COLUMN price; 

CREATE TABLE ticket(
id_ticket int identity(1,1) PRIMARY KEY,
CF nvarchar(16) FOREIGN KEY REFERENCES person(CF),
id_travel int FOREIGN KEY REFERENCES travel(id_travel),
price decimal NOT NULL,
);

CREATE TABLE delete_travel(
id_travel int FOREIGN KEY REFERENCES travel(id_travel) PRIMARY KEY,
);