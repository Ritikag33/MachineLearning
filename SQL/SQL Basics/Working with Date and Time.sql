 -- DATA TRANSFORMATION
 
 CREATE TABLE Customers(
 CustomerID INT PRIMARY KEY,
 FirstName VARCHAR(20),
 LastName VARCHAR(20)
 );
 
 INSERT INTO Customers VALUES (1,"Ritika","Gupta"),
 (2,'Joe','Smith'),
 (3,'Roy','Sen'),
 (4,'Ria','Jain'),
 (5,'Sri','Seal');
 
 -- STRING MANIPULATION 
 
 -- CONCATINATION
 SELECT CONCAT(FirstName," ",LastName) AS FullName FROM Customers;
 -- CASE CONVERSION
SELECT UPPER(FirstName) AS UpperCaseFirstName FROM Customers;
SELECT LOWER(LastName) AS LowerCaseLastName FROM Customers;

-- DATA FORMATTING AND NORMALIZATION	
CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount INT
);

INSERT INTO Orders VALUES(1,1,'2023-09-07',1000),
(2,1,'2023-09-07',800),
(3,2,'2023-08-11',900),
(4,3,'2023-10-10',600),
(5,2,'2023-11-15',900);

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
UnitPrice DECIMAL(10,2)
);

INSERT INTO Products VALUES(200,'Shampoo',650),
(201,'Bag',800),
(202,'Shoes',3500),
(203,'Band',200),
(204,'Chocolate',100);

--  WORKING WITH DATES AND TIME
CREATE TABLE events(
eventID INT PRIMARY KEY,
eventName VARCHAR(255),
eventDate DATE
);

INSERT INTO events VALUES(1001,'Data Science Workshop','2024-01-05');

SELECT eventName, YEAR(eventDate) AS eventYear,
MONTH(eventDate) AS eventMonth
FROM events;

CREATE TABLE appointments(
appointmentID INT PRIMARY KEY,
appointmentDescription VARCHAR(255),
appointmentTime TIME
);

INSERT INTO appointments VALUES(1001,'Meeting with Client','15:45:00');

SELECT appointmentDescription, TIME(appointmentTime) AS AppointmentTime
FROM appointments;


CREATE TABLE ScheduledTasks(
scheduleID INT PRIMARY KEY,
scheduleDesc VARCHAR(255),
scheduleTime DATETIME
);

TRUNCATE TABLE ScheduledTasks;
INSERT INTO ScheduledTasks VALUES(1100,'Database Backup','2024-10-11 23:59:00');

SELECT scheduleDesc, TIMESTAMP(scheduleTime) AS ScheduledDate FROM ScheduledTasks;

SELECT CURDATE();
SELECT NOW();

SELECT CURRENT_TIMESTAMP();

SELECT scheduleDesc, scheduleTime, DATEDIFF(NOW(),scheduleTime) AS DaysUntilDeadline FROM ScheduledTasks;

-- DATA FILTERING AND SELECTION
CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(30),
Salary DECIMAL(10,2),
Age INT,
Department VARCHAR(50)
);

INSERT INTO Employees VALUES(1001,'Jin',50000.00,22,'IT'),
(1002,'Tin',70000.00,23,'Data Science'),
(1003,'Bin',65000.00,22,'ML'),
(1004,'Sri',80000.00,23,'DL'),
(1005,'Sam',90000.00,23,'Big Data');

SELECT * FROM Employees WHERE Age<=25 AND Department='ML';

-- Temporary Table help us to store intermediate results during advanced queries
CREATE TEMPORARY TABLE Temp_ML_employees AS
SELECT EmployeeName, EmployeeID FROM Employees 
WHERE Department='ML';

SELECT * FROM Temp_ML_Employees;
