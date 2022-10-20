CREATE DATABASE taccuino_voti;
USE taccuino_voti;

CREATE TABLE taccuino(
date_day date,
freshman nvarchar(10),
name nvarchar(30),
surname nvarchar(30),
subject nvarchar(30),
valutation decimal,
teacher_name nvarchar(30),
teacher_surname nvarchar(30),
class int,
department nvarchar(5),
note text,
);

CREATE TABLE student(
freshman nvarchar(5) PRIMARY KEY,
name nvarchar(30) NOT NULL,
surname nvarchar(30) NOT NULL,
id_classe int NOT NULL
);

CREATE TABLE teacher(
id int identity(1,1) PRIMARY KEY,
teacher_name nvarchar(30) NOT NULL,
teacher_surname nvarchar(30) NOT NULL,
);

CREATE TABLE class(
id_class int identity(1,1) PRIMARY KEY,
class int NOT NULL,
department nvarchar(2) NOT NULL,
);

CREATE TABLE valutation(
id_valutation int identity(1,1) PRIMARY KEY,
valutation decimal NOT NULL,
subject nvarchar(25) NOT NULL,
id_teacher int NOT NULL,
id_student nvarchar(5) NOT NULL,
);

CREATE TABLE note(
id_nota int identity(1,1) PRIMARY KEY,
id_stud nvarchar(5)NOT NULL, 
notation text NOT NULL,
);

SELECT * FROM taccuino t;

ALTER TABLE valutation
ADD date_day date NOT NULL;

ALTER TABLE valutation
DROP COLUMN subject;

ALTER TABLE valutation 
ADD id_subject int NOT NULL;

ALTER TABLE note
ADD id_teacher int NOT NULL;

CREATE TABLE subject(
id_subject int identity(1,1) PRIMARY KEY,
subject_name nvarchar(30) NOT NULL,
id_teacher int NOT NULL
);

SELECT * FROM taccuino t;

INSERT INTO class (class, department)
SELECT DISTINCT class, department 
FROM taccuino;

SELECT * FROM class c;

INSERT INTO teacher(teacher_name, teacher_surname)
SELECT DISTINCT teacher_name, teacher_surname
FROM taccuino;

SELECT * FROM teacher t ;

INSERT INTO subject(subject_name, id_teacher)
SELECT DISTINCT subject, id
FROM taccuino
INNER JOIN teacher 
ON taccuino.teacher_surname = teacher.teacher_surname
WHERE 1=1;

SELECT * FROM subject s;

DROP TABLE note;

ALTER TABLE valutation 
ADD note text NULL;

INSERT INTO student(freshman, name, surname, id_classe)
SELECT DISTINCT freshman, name, surname, id_class
FROM taccuino
INNER JOIN class 
ON taccuino.class = class.class AND taccuino.department = class.department
WHERE 1=1;

SELECT * FROM student s;

INSERT INTO valutation(valutation, id_teacher, id_student, id_subject, note, date_day)
SELECT valutation, id, freshman, id_subject, note, date_day
FROM taccuino
INNER JOIN teacher ON teacher.teacher_surname = taccuino.teacher_surname
INNER JOIN subject ON taccuino.subject = subject.subject_name;
/*NON FUNZIONA*/

SELECT * FROM valutation v;
