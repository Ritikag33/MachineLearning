-- DATA PRE-PROCESSING AND ANALYSIS
/* Data preprocessing and analysis in SQL refers to the process of data cleaning,
transforming and preparing raw data to make to suitable for analysis and extracting
meaningful insights from it. */

CREATE DATABASE LargeData;
USE LargeData;


CREATE TABLE Employee(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(20),
Age INT,
Salary DECIMAL(10,2),
Department VARCHAR(50)
);

INSERT INTO Employee VALUES (6,'Sri',20,50000,'DS'),
(7,'Joy',21,NULL,NULL),
(8,'Kirti',25,NULL,'AI'),
(9,'Jia',24,75000,'DL');
INSERT INTO Employee VALUES(10,'Smriti',NULL,NULL,'AI');
SELECT * FROM Employee;

-- HANDLING MISSING VALUES

-- IMPUTATION
UPDATE Employee AS e
JOIN 
(SELECT AVG(AGE) AS AvgAge
from Employee 
WHERE Age is NOT NULL) AS sub
SET e.AGE = sub.AvgAge
WHERE e.Age IS NULL ;

SELECT* FROM Employee;

-- DELETION 
DELETE FROM Employee WHERE Salary IS NULL;

TRUNCATE TABLE Employee;
-- FLAGGING

UPDATE Employee
SET Department='Unknown'
WHERE Department IS NULL;


-- REMOVING DUPLICATES
CREATE TABLE Sales(
SaleID INT PRIMARY KEY,
ProductName VARCHAR(30),
SalesAmount DECIMAL(10,2)
);

INSERT INTO Sales VALUES(1,'Shoes',1500),
(2,'Shoes',1500),
(3,'Bag',900),
(4,'Bag',900),
(5,'Band',200);

TRUNCATE TABLE Sales;
-- USING SELF JOIN
DELETE s1 FROM Sales s1
JOIN Sales s2 ON s1.ProductName = s2.ProductName AND s1.SalesAmount=s2.SalesAmount
WHERE s1.SaleID > s2.SaleID; 

SELECT * FROM Sales;

-- AGGREGATE
SELECT ProductName, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY ProductName;

-- Identifying duplicate records based on ProductName and SalesAmount using Advanced Query
SELECT * FROM Sales WHERE (ProductName,SalesAmount) IN 
(SELECT ProductName, SalesAmount
FROM Sales
GROUP BY ProductName, SalesAmount
HAVING COUNT(*)>1
);
