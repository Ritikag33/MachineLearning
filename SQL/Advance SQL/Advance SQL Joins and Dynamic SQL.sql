-- ADVANCE SQL JOINS 
CREATE TABLE table1(
id INT PRIMARY KEY,
name VARCHAR(20),
value1 INT
);

INSERT INTO table1 VALUES(1,'Item A',100),
(2,'Item B',200),
(3,'Item C',300);

CREATE TABLE table2(
id INT PRIMARY KEY,
description VARCHAR(255),
value2 INT
);

INSERT INTO table2 VALUES(1,'Description A',400),
(2,'Description B',500),
(3,'Description C',600);

CREATE TABLE table3(
id INT PRIMARY KEY,
category VARCHAR(255),
value3 INT
);

INSERT INTO table3 VALUES(1,'Category A',1000),
(2,'Category B',1500),
(3,'Category C',2000);

SELECT * FROM table1;
SELECT * FROM table2;
SELECT * FROM table3;

SELECT * FROM table1 
INNER JOIN table2 ON table1.id = table2.id
INNER JOIN table3 ON table2.id = table3.id;


SELECT table1.name,table2.description,table3.category 
FROM table1 
INNER JOIN table2 ON table1.id = table2.id
INNER JOIN table3 ON table2.id = table3.id;

-- Using Aliases
SELECT t1.ID, name, description, category 
FROM table1 AS t1
INNER JOIN table2 AS t2 ON t1.id = t2.id
INNER JOIN table3 AS t3 ON t2.id = t3.id;

-- Using Clauses
SELECT * FROM table1 INNER JOIN table2
USING(id);

SELECT * FROM Employee;
--      DYNAMIC SQL
-- Using Concat
SET @tableName = 'Employee';
SET @condition = 'salary > ''80000'' ';
SET @SQL = CONCAT('SELECT * FROM ', @tableName, ' WHERE ', @condition);

PREPARE dynamic_query FROM @SQL;
EXECUTE dynamic_query;

SET @FILTER = 'high';

SET @SQL = CASE 
    WHEN @FILTER = 'high' THEN 'SELECT * FROM Employee WHERE salary > 70000'
    ELSE 'SELECT * FROM Employee WHERE salary <= 70000'
END;

PREPARE dynamic_query FROM @SQL;
EXECUTE dynamic_query;

-- MATERIALIZED VIEWS
CREATE TABLE Sales(
SalesID INT PRIMARY KEY,
ProductID INT,
quantity INT,
price DECIMAL(10,2),
SalesDate DATE
);

INSERT INTO Sales VALUES(1,101,2,600.00,'2024-01-09'),
(2,101,4,650.00,'2024-01-10'),
(3,102,1,500.00,'2024-01-11'),
(4,103,3,850.00,'2024-01-11'),
(5,104,5,950.00,'2024-01-12');

CREATE VIEW SalesSummary AS
SELECT ProductID,
	SUM(Quantity) AS TotalSold,
	AVG(Price) AS averagePrice
FROM Sales
GROUP BY ProductID;

SELECT * FROM SalesSummary WHERE ProductID=101;
