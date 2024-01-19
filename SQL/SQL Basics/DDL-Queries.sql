# DDL : "DATA Definition Language" Commands
CREATE DATABASE gfg;
USE gfg;

-- CREATE TABLE sample_table
-- (
-- column1 data_type(size) constraint_name,
-- column2 data_type(size) constraint_name,
-- column2 data_type(size) constraint_name
-- ...
-- );
CREATE TABLE Student
(
Roll_No INT,
First_Name VARCHAR(20),
Last_name VARCHAR(20),
Age INT,
Marks INT
);

ALTER TABLE Student ADD outlook_id varchar(50);
ALTER TABLE Student ADD Phone_No INT, DROP Age;

SELECT * FROM Student;
# Changing the Datatype of Phone_No
ALTER TABLE Student MODIFY Phone_No BIGINT;
INSERT INTO Student VALUES(219309156,"Ritika","Gupta",95,"ritika.219309156@muj.manipal.edu",9142909536);

DROP TABLES Student;
DROP DATABASE gfg;

SHOW databases;
# Remove all entries from student table
TRUNCATE TABLE Student;
# Change the name of Database table
RENAME TABLE Student TO Student_Details;

# SQL Constraints : NOT NULL , UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT
# NOT NULL
CREATE TABLE Student(
id INT NOT NULL UNIQUE,
name VARCHAR(20) NOT NULL,
address VARCHAR(20),

PRIMARY KEY(id)
);

ALTER TABLE Student ADD Age INT CHECK(Age>=18);
ALTER TABLE Student MODIFY Age INT DEFAULT 18;

CREATE TABLE Customers(
Customer_id INT NOT NULL UNIQUE,
Customer_name VARCHAR(20) NOT NULL,
address VARCHAR(20),

PRIMARY KEY(Customer_id)
);


CREATE TABLE Orders(
Order_id INT NOT NULL UNIQUE,
Parcel_name VARCHAR(20) NOT NULL,
Parcel_address VARCHAR(20),

FOREIGN KEY(Order_id) REFERENCES Customers(Customer_id)
);

DESCRIBE Orders;
DESCRIBE Customers;

INSERT INTO Customers(Customer_id,Customer_name,address) VALUES(1001,"Sam","Disneyland");
INSERT INTO Customers(Customer_id,Customer_name,address) VALUES(1002,"Cherry","Pluto");
INSERT INTO Customers(Customer_id,Customer_name,address) VALUES(1003,"Dr Stark","Marvel Studio");
INSERT INTO Customers(Customer_id,Customer_name,address) VALUES(1004,"Mike","Seattle");

SELECT* FROM Customers;

UPDATE Customers SET Customer_name = "Blue Shark" WHERE Customer_id=1001;
DELETE FROM Customers WHERE Customer_id =1003;

# Cannot be truncated since it is referenced by Orders
TRUNCATE TABLE Customers;

# Returns all Customer_name except for the customer whose id=1001
SELECT Customer_name FROM Customers where Customer_id<>1001;

SELECT Customer_name FROM Customers where NOT  Customer_id=1001;

SELECT Customer_name FROM Customers WHERE address<>"Marvel Studio" AND address<>"Pluto";

# ORDER BY: Helps to sort the results
SELECT Customer_name,address FROM Customers ORDER BY Customer_id DESC;

# LIMIT :used to restrict the number of records returned by a query.
SELECT * FROM Customers LIMIT 2;

ALTER TABLE Customers ADD no_of_purchases INT;
UPDATE Customers SET no_of_purchases=2 WHERE Customer_id<=1005;

# AGGREGATE functions include COUNT(), SUM(), MIN(), MAX(), and AVG()
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Customers WHERE no_of_purchases=2;

INSERT INTO Orders VALUES (1001,"Bands","Disneyland"),
(1002,"Shoes","Pluto"),
(1003,"Bag","Marvel Studio");

INSERT INTO Orders VALUES(1004,"Bands","Seattle");

# INNER JOIN IN SQL
SELECT Customers.Customer_name, Orders.Parcel_name 
FROM Customers 
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Order_id;

#GROUP BY Clause : groups rows returned by a query into summary rows based on the values of one or more columns.
SELECT Parcel_name,COUNT(*) 
FROM Orders
GROUP BY Parcel_name;

# HAVING clause : works on the result set of a GROUP BY.
SELECT Parcel_name,count(*)
FROM Orders
GROUP BY Parcel_name 
HAVING COUNT(*)<=1;

# UNION :  combine the result set of two or more SELECT statements, removing duplicate records. 
# UNION ALL does the same but allows duplicates.
SELECT Customer_name FROM Customers
UNION
SELECT Parcel_name FROM Orders;

# SUBQUERIES
SELECT Customer_name FROM Customers WHERE no_of_purchases = (SELECT MAX(no_of_purchases) FROM Customers);

# QUERIES IN SQL
CREATE TABLE Engineering(
	ProjectID INT PRIMARY KEY UNIQUE,
    ProjectName VARCHAR(100),
    startDate DATE,
    endDate DATE,
    LeadEngineer VARCHAR(100),
    Budget DECIMAL(10,2)
);

INSERT INTO Engineering(ProjectID, ProjectName, startDate, endDate,LeadEngineer,Budget)
VALUES
(1001,"Eklavya","2023-02-01","2024-05-11","Joe Smith",90000.00),
(1002,"Shurma","2022-02-01","2024-07-19","Haji Ali",100000.00),
(1003,"Choco-choco","2021-09-23","2023-11-15","Waffle Sheikh",700000.00),
(1004,"Tuffani Marshmalo","2022-03-19","2024-01-10","Shami Shami",100000.00),
(1005,"Munch It","2020-08-21","2025-07-19","Cadbury Lazeez",65000.00),
(1006,"Shushi","2021-05-15","2024-03-22","Snoory Gill",980000.00);

SELECT ProjectName, LeadEngineer FROM Engineering;

SET SQL_SAFE_UPDATES = 0;
UPDATE Engineering SET startDate="2020-09-01" WHERE ProjectName="Shushi";

SELECT SUM(Budget) FROM Engineering;

SELECT Engineering.ProjectName, Orders.Parcel_name as Product 
FROM Engineering 
INNER JOIN Orders 
WHERE Engineering.ProjectID=Orders.Order_id;

# Retrieving only unique values
SELECT DISTINCT Parcel_name FROM Orders;

# Aliasing in SQL
# Aliasing is the process of renaming a table or a column temporarily during the query execution. 
# This can be particularly useful for making column names more readable and for disambiguating in the case of joins and subqueries.

SELECT e.ProjectName, e.LeadEngineer AS EngineerName
FROM Engineering as e;

SELECT DISTINCT ProjectName FROM Engineering;

SELECT COUNT(*) ProjectName FROM Engineering;
SELECT COUNT(*) LeadEngineer FROM Engineering WHERE Budget>=90000;
SELECT ProjectName FROM Engineering WHERE Budget BETWEEN 50000 AND 100000;

# LIKE Clause
# Returns row where ProjectName starts with "Choco"
SELECT * FROM Engineering WHERE ProjectName LIKE "%Choco";
SELECT * FROM Engineering WHERE ProjectName NOT LIKE "%Choco";

SELECT ProjectName FROM Engineering WHERE Budget>90000 AND startDate>2021-01-01;

# Looking for null values in our table
SELECT ProjectID FROM Engineering WHERE Budget IS NULL;

# AGGREGATE FUNCTIONS
SELECT COUNT(*) AS Total_Projects
FROM Engineering
WHERE YEAR(startDate)<= 2021;

SELECT AVG(Budget) AS AverageBudget
FROM Engineering 
WHERE year(startDate)>=2021;

-- SORTING AND GROUPING
SELECT * FROM Engineering ORDER BY startDate;

# The priority order is as follows:
# The projects will be ordered by Budget in descending order (DESC).
# If two projects have the same Budget, then they will be ordered by startDate in ascending order (ASC).
SELECT * FROM Engineering ORDER BY Budget DESC, startDate ASC;


# When using GROUP BY, all columns in the SELECT list that are not part of an aggregate function (like COUNT, SUM, AVG, etc.) 
# must be included in the GROUP BY clause.
SELECT YEAR(startDate), COUNT(*) as Projects
FROM Engineering
GROUP BY YEAR(startDate);

SELECT YEAR(startDate), COUNT(*) as Projects
FROM Engineering
GROUP BY YEAR(startDate)
HAVING COUNT(*) > 1;

# Handling NULL values
SELECT 5 + NULL; # Returns NULL

# SQL provides functions like COALESCE and IFNULL to handle NULL values effectively.
# If startDate is not null, it will return the year of startDate. If startDate is null, it will return 2021.
SELECT COALESCE(year(startDate), 2021) FROM Engineering;

# will return the year of startDate if it's not null. If startDate is null, it will return 2021. 
SELECT IFNULL(YEAR(startDate), 2021) FROM Engineering;

SELECT ProjectName, COUNT(*) AS no_of_projects
FROM Engineering
WHERE ProjectName IS NOT NULL
GROUP BY ProjectName;

INSERT INTO Engineering(ProjectID, ProjectName, startDate, endDate,LeadEngineer,Budget)
VALUES
(1007,NULL,"2023-02-01","2024-05-11","Joe Smith",90000.00);

SELECT ProjectName, COUNT(*) AS no_of_projects
FROM Engineering
WHERE ProjectName IS NULL
GROUP BY ProjectName;

# DATE AND TIME FUNCTIONS
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP;

SELECT ProjectName, year(startDate) AS startYear, month(startDate) AS startMonth, day(startDate) as startDay
FROM Engineering;

SELECT ProjectName, date_format(startDate,"%d/%m/%Y") as FormattedStartDate
FROM Engineering;
# DATEDIFF(): Finds the difference between two dates
SELECT ProjectName, DATEDIFF(CURDATE(),startDate) AS InProgressSince
FROM Engineering
WHERE DATEDIFF(CURDATE(),startDate) > 365 ;

# WORKING WITH EXPRESSIONS
SELECT ProjectName, Budget,
CASE 
	WHEN Budget IS NULL THEN "Unknown"
	WHEN Budget<=50000 THEN "Low"
    WHEN Budget>50000 AND Budget<=100000 THEN "Average"
    ELSE "High"
END AS 'BudgetRange'
FROM Engineering;
    
SELECT ProjectName, LeadEngineer, Budget,
	CASE ProjectName
		WHEN ProjectName='Choco-choco' THEN Budget *0.2
        WHEN ProjectName='Munch It' THEN Budget *0.1
		ELSE Budget*0.05
    END AS BonusAmount
FROM Engineering;

SELECT ProjectName, DATEDIFF(CURDATE(),startDate) AS DaysInProject,
CASE
	WHEN DATEDIFF(CURDATE(),startDate) > 730 THEN "GEM" 
    WHEN DATEDIFF(CURDATE(),startDate) < 730 THEN "Rookie" 
END AS ProjectAchievement
FROM Engineering;

# CONCAT
SELECT ProjectID,CONCAT(ProjectName," ",LeadEngineer) AS ProjectanditsLeader
FROM Engineering;

# UPPER AND LENGTH CLAUSE
SELECT UPPER(ProjectName), LENGTH(ProjectName) AS NameLength
FROM Engineering;

# Using IN to filter rows
SELECT LeadEngineer FROM Engineering WHERE ProjectName IN("Choco-choco","Munch It");
# Aggregate Functions with DISTINCT
SELECT COUNT(DISTINCT ProjectName) FROM Engineering;