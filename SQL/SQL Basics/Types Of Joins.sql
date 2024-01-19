# Relationship Between Tables

CREATE TABLE CustomerDetails(
	CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName varchar(20),
    Email varchar(100)
);

CREATE TABLE OrderDetails(
OrderID INT PRIMARY KEY NOT NULL,
OrderDate DATE,
CustomerID INT,
TotalAmount DECIMAL(10,2)
);

SELECT *FROM CustomerDetails;
SELECT *FROM OrderDetails;

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

INSERT INTO OrderDetails VALUES(1107,"2023-09-09",1007,100.00);

# LEFT JOIN : returns all records from the left table, along with matching records from the right table. 
# If there's no match, NULL values are returned for columns from the right table.
SELECT CustomerDetails.CustomerName, OrderDetails.OrderID 
FROM CustomerDetails
LEFT JOIN OrderDetails
ON CustomerDetails.CustomerID = OrderDetails.CustomerID;

# RIGHT JOIN :  returns all records from the right table, along with matching records from the left table.
# If there's no match, NULL values are returned for columns from the left table.
SELECT CustomerDetails.CustomerName, OrderDetails.OrderID 
FROM CustomerDetails
RIGHT JOIN OrderDetails
ON CustomerDetails.CustomerID = OrderDetails.CustomerID;

# INNER JOIN : used to retrieve rows from both tables that have matching values based on a specified condition.
SELECT CustomerDetails.CustomerName, OrderDetails.OrderID 
FROM CustomerDetails
INNER JOIN OrderDetails
ON CustomerDetails.CustomerID = OrderDetails.CustomerID
ORDER BY CustomerDetails.CustomerName;

# CROSS JOIN :It combines each row from the first table with every row from the second table.
SELECT CustomerDetails.CustomerName, OrderDetails.OrderID 
FROM CustomerDetails
CROSS JOIN OrderDetails;

# SELF JOIN : a table is joined with itself.
SELECT OrderDetails1.OrderID, OrderDetails2.CustomerID AS CustomerID, OrderDetails1.TotalAmount
FROM OrderDetails as OrderDetails1
JOIN OrderDetails as OrderDetails2
ON OrderDetails1.OrderID = OrderDetails2.CustomerID;



