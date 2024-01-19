-- WINDOW FUNCTIONS
CREATE DATABASE window_functions;
USE window_functions;

CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(20),
Department VARCHAR(50),
Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES(1,'Gia','Data Science',120000.00),
(2,'Tom','Machine Learning',95000.00),
(3,'Sri','AI',105000.00),
(4,'Roy','DL',115000),
(5,'Sia','AI',85000),
(6,'Tia','Data Science',95000),
(7,'Joy','Data Science',100000);
-- WINDOW FUNCTION
SELECT EmployeeID, EmployeeName, Department, Salary, 
AVG(Salary) OVER (PARTITION BY Department) AS AverageSalary
FROM Employees;
-- ROW NUMBER FUNCTION
SELECT EmployeeID, EmployeeName, Department, Salary,
ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber
FROM Employees; 

-- RANK FUNCTION (When assign same rank skips equivalent no. of ranks)
SELECT EmployeeID, EmployeeName, Department, Salary,
RANK() OVER (ORDER BY Salary DESC) AS EmployeeRank
FROM Employees; 


-- DENSE RANK FUNCTION (Do not skip ranks when assigning)
SELECT EmployeeID, EmployeeName, Department, Salary,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseEmployeeRank
FROM Employees; 

-- SUM FUNCTION
SELECT EmployeeID, EmployeeName, Department, Salary,
SUM(Salary) OVER (PARTITION BY Department) AS TotalDepartmentSalary
FROM Employees;

-- Gives  cumulative sum of salaries within each department
SELECT EmployeeID, EmployeeName, Department, Salary,
SUM(Salary) OVER (PARTITION BY Department ORDER BY EmployeeID) AS CumulativeDepartmentSalary
FROM Employees;

-- AVG FUNCTION
SELECT EmployeeID, EmployeeName, Department, Salary,
AVG(Salary) OVER (PARTITION BY Department) AS AverageDepartmentSalary
FROM Employees;

-- MIN & MAX FUNCTION
SELECT EmployeeID, EmployeeName, Department, Salary,
MIN(Salary) OVER (ORDER BY Department) AS MinDepartmentSalary,
MAX(Salary) OVER (ORDER BY Department) AS MaxDepartmentSalary
FROM Employees;

CREATE TABLE Sales(
id INT PRIMARY KEY,
Product VARCHAR(50),
SalesAmount DECIMAL(10,2),
SalesDate DATE 
);
TRUNCATE TABLE Sales;
INSERT INTO Sales VALUES (1,'Bands',1000.00,'2023-09-11'),
(2,'Bag',1500.00,'2022-11-12'),
(3,'Shoes',2000.00,'2024-06-07'),
(4,'Watch',1200.00,'2021-04-11'),
(5,'Chocolates',1300.00,'2021-10-12'),
(6,'Bag',800.00,'2022-09-08'),
(7,'Shoes',2500.00,'2023-11-10'),
(8,'Chocolates',1200.00,'2023-09-08');

SELECT id, Product, SalesAmount, SalesDate,
MIN(SalesAmount) OVER (PARTITION BY Product) AS MinSalesPerProduct,
MAX(SalesAmount) OVER (PARTITION BY Product) AS MaxSalesPerProduct
FROM Sales;


SELECT id, Product, SalesAmount, SalesDate,
AVG(SalesAmount) OVER (PARTITION BY Product) AS AvgSalesPerProduct
FROM Sales;

-- WEEKLY PARTITIONING
SELECT id, Product, SalesAmount, SalesDate,
SUM(SalesAmount) OVER (PARTITION BY Product ORDER BY SalesDate
			RANGE BETWEEN INTERVAL 7 DAY PRECEDING AND CURRENT ROW) AS Weekly_Sales
FROM Sales;

