--      JSON AND XML IN SQL
CREATE TABLE EmployeeDetails(
EmployeeID INT PRIMARY KEY, 
EmpoyeeInfo JSON
);

INSERT INTO EmployeeDetails VALUES (101, '{"Name":"Joy","Position":"Data Scientist","Salary":120000}'),
							(102, '{"Name":"Gini","Position":"ML Engineer","Salary":110000}'),
                            (103, '{"Name":"Jin","Position":"Data Analyst","Salary":105000}'),
                            (104, '{"Name":"Sri","Position":"AI Engineer","Salary":100000}'),
                            (105, '{"Name":"Joe","Position":"Data Engineer","Salary":90000}');

SELECT * FROM EmployeeDetails;

SELECT EmployeeID,
	JSON_VALUE(EmpoyeeInfo, '$.Name') AS EmployeeName,
    JSON_VALUE(EmpoyeeInfo, '$.Position') AS EmployeePosition,
    JSON_VALUE(EmpoyeeInfo, '$.Salary') AS EmployeeSalary
FROM EmployeeDetails;

-- DATA BLENDING
CREATE TABLE Orders(
orderID INT PRIMARY KEY,
customerID INT,
orderDate DATE,
totalAmount DECIMAL(10,2)
);
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES(1001,1,'2024-01-10',1000),
(1002,1,'2024-01-10',500),
(1003,2,'2024-01-12',700),
(1004,3,'2024-01-13',900),
(1005,1,'2024-01-11',600);

CREATE TABLE Customer(
customerID INT PRIMARY KEY,
customerName VARCHAR(20),
email VARCHAR(255)
);

INSERT INTO Customer VALUES(1,'John','john@gmail.com'),
(2,'Jay','jay@gmail.com'),
(3,'Joe','joe@gmail.com');
-- BLEND DATA
SELECT  o.orderDate,
        c.customerName
FROM Orders o
JOIN
Customer c ON o.customerID = c.customerID;
        
CREATE TABLE Product(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2)
);

INSERT INTO Product VALUES(1100,'Shoe',2000),
(1101,'Bag',800),
(1102,'Bottle',300);

CREATE TABLE OrderDetails(
orderID INT,
ProductID INT,
quantity INT,
PRIMARY KEY(orderID,ProductID),
FOREIGN KEY(orderID) REFERENCES Orders(orderID),
FOREIGN KEY(ProductID) REFERENCES Product(ProductID)
);

INSERT INTO OrderDetails VALUES(1001,1100,1),
(1002,1102,3),
(1005,1101,2);

SELECT o.orderID,o.orderDate,o.totalAmount,c.customerName,p.ProductID,od.quantity,p.Price,
(od.quantity*p.Price) AS TotalAmount
FROM Orders o 
JOIN Customer c ON o.customerID=c.customerID
JOIN OrderDetails od ON od.orderID = o.orderID
JOIN Product p ON p.ProductID = od.ProductID
INTO OUTFILE '/Users/ritikagupta/anaconda3/bin/Data_Blend.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';


SHOW VARIABLES LIKE 'secure_file_priv';




