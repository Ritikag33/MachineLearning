-- SET THEORY CLAUSES

CREATE TABLE Customers1(
	CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName varchar(20),
    Email varchar(100)
);

CREATE TABLE Customers2(
	CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName varchar(20),
    Email varchar(100)
);

INSERT INTO Customers1 VALUES(1001,"Micky","micky@disney.com"),
(1002,"Scooby","scooby@cartoon.com"),
(1003,"Gian","gian@dora.com");

TRUNCATE TABLE Customers2;

INSERT INTO Customers2 VALUES
(1004,"Kitertsu","kitertsu@cartoon.com"),
(1005,"Phineas","phineas@disney.com"),
(1003,"Gian","gian@dora.com");
;
-- UNION -- Returns only unique rows
SELECT * FROM Customers1
UNION
SELECT * FROM Customers2;


-- UNION ALL -- include duplicate rows as well
SELECT * FROM Customers1
UNION ALL
SELECT * FROM Customers2;

-- INTERSECTION : INTERSECT is not permitted in SQL Workbench
SELECT DISTINCT c1.CustomerName, c1.CustomerID, c2.Email
FROM Customers1 AS c1
JOIN Customers2 AS c2
ON c1.CustomerID = c2.CustomerID;

-- EXCEPTIONS IN SQL
CREATE DATABASE Exceptions;
USE Exceptions;

DROP TABLE tutorials;
CREATE TABLE tutorials(
id INT PRIMARY KEY,
author VARCHAR(20),
city VARCHAR(20)
);

INSERT INTO tutorials VALUES(1,"Smith","Ahmdabad"),
(2,"Joe","Srinagar"),
(3,"Gia","Chandigarh"),
(4,'Roe','Amer'),
(5,'Harry','Dwarka');

DROP PROCEDURE ExampleProcedure;
# CREATING A PROCEDURE
Delimiter // 
CREATE PROCEDURE ExampleProcedure()
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE tutorialID INTEGER;
    DECLARE tutorialAuthor, tutorialCity VARCHAR(20);
    DECLARE cur CURSOR FOR SELECT * FROM tutorials;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1; 
    OPEN cur;
	label : LOOP
		FETCH cur INTO tutorialID, tutorialAuthor, tutorialCity;
		INSERT INTO CustomerA VALUES (tutorialID, tutorialAuthor,tutorialCity);
		IF done=1 THEN LEAVE label;
		END IF;
	END LOOP;
    CLOSE cur;
END //
Delimiter ;

CREATE TABLE CustomerA(
id INT PRIMARY KEY,
author VARCHAR(20),
city VARCHAR(20)
);

CALL ExampleProcedure;

SELECT * FROM CustomerA;

-- SEMI JOINS AND ANTI-JOINS
CREATE TABLE CustomerDetails(
	CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName varchar(20),
    Email varchar(100)
);
DROP TABLE OrderDetails;
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
INSERT INTO CustomerDetails VALUES(1006,"Tara","tara@suits.com");

TRUNCATE TABLE OrderDetails;
INSERT INTO OrderDetails VALUES(1101,"2023-05-09",1001,980.80),
(1002,"2023-07-11",1001,500.80),
(1003,"2023-06-06",1003,650.80),
(1004,"2023-03-19",1002,500.50),
(1005,"2024-01-01",1004,250.00),
(1006,"2023-05-09",1005,980.80);

# Semi-Join: Returns each row from the first table where one or more matches are found in the second table.
SELECT OrderID, OrderDate, TotalAmount 
FROM OrderDetails o
WHERE EXISTS (
	SELECT 1 FROM CustomerDetails c 
    WHERE o.CustomerID = c.CustomerID
);
# Anti-Join: Returns each row from the first table where no matches are found in the second table.
SELECT OrderID, OrderDate, TotalAmount 
FROM OrderDetails o
WHERE NOT EXISTS (
	SELECT 1 FROM CustomerDetails c 
    WHERE o.CustomerID = c.CustomerID
);

-- SUBQUERIES INSIDE WHERE AND SELECT CLAUSE
SELECT CustomerName, Email FROM CustomerDetails
WHERE CustomerID = (SELECT CustomerID from OrderDetails WHERE YEAR(OrderDate)='2024');

SELECT C.CustomerID, C.CustomerName, IFNULL(TotalOrders,0) AS TotalOrders
FROM CustomerDetails AS C
LEFT JOIN 
(SELECT CustomerID, COUNT(OrderID) AS TotalOrders		
FROM OrderDetails
GROUP BY CustomerID) AS CustomerOrders
ON C.CustomerID = CustomerOrders.CustomerID; 

CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(20)
);

INSERT INTO Customers VALUES(1,'Joe'),
(2,'Reo'),
(3,'Lio'),
(4,'Toy');

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(20)
);

INSERT INTO Products VALUES(101,'Shoes'),
(102,'Bag'),
(103,'Clothes'),
(104,'Bands');
    
CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders VALUES (110,1,101,2),
(111,1,102,1),
(112,2,101,3),
(113,3,104,5),
(114,4,103,2);


SELECT C.CustomerID, C.CustomerName, P.ProductName, IFNULL(TotalQuantity,0) AS TotalQuantity
FROM Customers C 
CROSS JOIN Products P
LEFT JOIN (
SELECT CustomerID, ProductID, SUM(Quantity) AS TotalQuantity
FROM Orders
GROUP BY CustomerID, ProductID) AS CustomerProductOrders
ON C.CustomerID = CustomerProductOrders.CustomerID AND P.ProductID = CustomerProductOrders.ProductID;


-- SCALAR SUB-QUERY
SELECT OrderID FROM Orders WHERE Quantity = (SELECT MAX(Quantity) FROM Orders);

-- MULTIPLE ROW SUBQUERY
SELECT CustomerName, CustomerID FROM Customers 
WHERE CustomerID IN (
SELECT DISTINCT CustomerID FROM Orders WHERE
Quantity> (SELECT AVG(Quantity) FROM Orders)
);

CREATE TABLE Department(
 id INT PRIMARY KEY,
 DepartmentName VARCHAR(50)
 );
 
 INSERT INTO Department VALUES(1,'Data Science'),
 (2,'Machine Learning'),
 (3,'AI'),
 (4,'DL');
 
 CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 EmployeeName VARCHAR(30),
 DepartmentID INT,
 Salary DECIMAL(10,2),
 FOREIGN KEY (DepartmentID) REFERENCES Department(id)
 );
 
 INSERT INTO Employee VALUES(1,'Ria',2,90000.00),
 (2,'Jian',1,100000.00),
 (3,'Jaan',4,750000.00),
 (4,'Ria',3,85000.00);
  INSERT INTO Employee VALUES(5,'Sri',1,95000.00),
 (6,'Kirti',2,90000.00);
 
 # Correlated Subquery
 # compare each employee's salary with the average salary of employees in the same department. 
 SELECT EmployeeID, EmployeeName, DepartmentName, Salary 
 FROM Employee AS e
 JOIN Department ON e.DepartmentID = Department.id
 WHERE Salary > (
 SELECT AVG(Salary) FROM Employee AS SubQuery
 WHERE e.DepartmentID = SubQuery.DepartmentId
 )
 ;