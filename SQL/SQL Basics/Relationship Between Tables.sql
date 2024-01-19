-- TABLE RELATIONSHIPS
DROP TABLE CustomerDetails;
DROP TABLE OrderDetails;
# ONE TO MANY RELATIONSHIP : One Customer can have many orders
CREATE TABLE CustomerDetails(
	CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName varchar(20),
    Email varchar(100)
);

CREATE TABLE OrderDetails(
OrderID INT PRIMARY KEY NOT NULL,
OrderDate DATE,
CustomerID INT,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES CustomerDetails(CustomerID)
);

INSERT INTO CustomerDetails VALUES(1001,"Micky","micky@disney.com"),
(1002,"Scooby","scooby@cartoon.com"),
(1003,"Gian","gian@dora.com"),
(1004,"Kitertsu","kitertsu@cartoon.com"),
(1005,"Phineas","phineas@disney.com")
;

INSERT INTO OrderDetails VALUES(1101,"2023-05-09",1001,980.80),
(1102,"2023-07-11",1001,500.80),
(1103,"2023-06-06",1003,650.80),
(1104,"2023-03-19",1002,500.50),
(1105,"2024-01-01",1004,250.00),
(1106,"2023-05-09",1005,980.80);

SELECT CustomerDetails.CustomerName, OrderDetails.CustomerID 
FROM CustomerDetails JOIN OrderDetails
WHERE CustomerDetails.CustomerID = OrderDetails.CustomerID;

DROP TABLE person;
-- ONE TO ONE RELATIONSHIP:  One person can have only one passport.
# This relationship is established using a primary key in one table that is referenced by a foreign key in another table.


CREATE TABLE person (
  id   INT UNIQUE,
  first_name varchar(20) NOT NULL,
  last_name varchar(20) NOT NULL
);

CREATE TABLE passport (
  id   serial,
  country varchar(20) NOT NULL,
  date_of_issue DATE NOT NULL,
  person_id INT NOT NULL,
  FOREIGN KEY (person_id) REFERENCES person (id),
  UNIQUE (person_id) # **
);

INSERT INTO person VALUES(1001,"Ritika","Gupta");
INSERT INTO person VALUES(1002,"James","Seal");

INSERT INTO passport VALUES(2190,"India","2021-09-01",1001);
INSERT INTO passport VALUES(2110,"Australia","2021-09-11",1002);

SELECT CONCAT(person.first_name," ",person.last_name), passport.country 
FROM person JOIN passport 
WHERE person.id=passport.person_id;

-- MANY TO MANY RELATIONSHIP
DROP TABLE students;
DROP TABLE classes;
CREATE TABLE students (
	id INT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL
);

INSERT INTO students VALUES(001,"Joe","Sen"),
(002,"Ria","Ben"),
(003,"Sri","Gill"),
(004,"Gia","Gin");

CREATE TABLE classes (
	id INT PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	description VARCHAR(100) NOT NULL
);

INSERT INTO classes VALUES(111,"Data Science","I'm interesting"),
(112,"AI","I'm powerful"),
(113,"web3","I'm private");

DROP TABLE enrollments;

CREATE TABLE enrollments (
	id INT PRIMARY KEY,
	student_id INT NOT NULL,
	class_id INT NOT NULL,
	FOREIGN KEY (student_id) REFERENCES students (id),
	FOREIGN KEY (class_id) REFERENCES classes (id)
);

INSERT INTO enrollments VALUES(200,001,111),
(201,001,112),
(202,002,111),
(203,003,111),
(204,004,112),
(205,003,112);

SELECT CONCAT(students.first_name," ",students.last_name),students.id, classes.title,classes.id 
FROM students
JOIN enrollments ON students.id = enrollments.student_id
JOIN classes ON classes.id = enrollments.class_id;