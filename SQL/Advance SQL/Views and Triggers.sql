-- SQL VIEWS
CREATE DATABASE advanceSQL;
USE advanceSQL;

CREATE TABLE Employee(
employeeID INT PRIMARY KEY,
firstName VARCHAR(20),
lastName VARCHAR(20),
salary DECIMAL(10,2)
);

INSERT INTO Employee VALUES(1,'Joe','Mi',80000),
(2,'Roy','Sen',95000),
(3,'Sri','Jain',87000),
(4,'Joe','Bell',97000),
(5,'Toe','Li',78000);

-- Creating a View
CREATE VIEW EmployeeView AS
SELECT employeeID,firstName, lastName, salary
FROM Employee;

-- Using View
SELECT * FROM EmployeeView WHERE updatedSalary>90000;

-- Granting Permission on a view
-- GRANT SELECT ON EmployeeView TO YourUser;

-- Modify a View
ALTER VIEW EmployeeView AS
SELECT employeeID, firstName, lastName, salary*1.1 AS updatedSalary
FROM Employee;

-- Deleting a View
DROP VIEW IF EXISTS EmployeeView;

CREATE TABLE Sales(
salesID INT PRIMARY KEY,
productID INT,
employeeID INT,
quantity INT,
price DECIMAL(10,2)
);
TRUNCATE TABLE Sales;

INSERT INTO Sales VALUES(1,1,1,5,800),
(2,2,1,3,750),
(3,3,2,1,900),
(4,2,3,4,600),
(5,1,5,1,1200);

DROP VIEW IF EXISTS SalesView;

CREATE VIEW SalesView AS
SELECT productID,employeeID, SUM(quantity*price) AS TotalSales
FROM Sales
GROUP BY productID;

SELECT * FROM SalesView WHERE TotalSales>1000;

CREATE VIEW EmployeeSalesView AS
SELECT Employee.employeeID, Employee.firstName, Employee.lastName, SalesView.TotalSales
FROM Employee
JOIN
SalesView ON Employee.employeeID = SalesView.employeeID;

-- Nested View
CREATE VIEW NestedView as
SELECT employeeID,firstName,lastName
FROM EmployeeView
WHERE updatedSalary>80000;

SELECT * FROM NestedView;

-- SQL Triggers : Trigger is a statement that a system executes automatically when there is any modification to the database.
-- Before/ AFTER/ INSTEAD OF 

CREATE DATABASE triggers;
USE triggers;

CREATE TABLE Employee(
employeeID INT PRIMARY KEY,
firstName VARCHAR(20),
lastName VARCHAR(20),
salary DECIMAL(10,2)
);


DROP TRIGGER IF EXISTS `triggers`.`Employee_BEFORE_INSERT`;

DELIMITER $$
USE `triggers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `triggers`.`Employee_BEFORE_INSERT` BEFORE INSERT ON `Employee` FOR EACH ROW
BEGIN
	IF New.salary < 45000 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Salary below 50000 not allowed';
	END IF;
END$$
DELIMITER ;

INSERT INTO Employee VALUES(1,'Joe','Mi',80000),
(2,'Roy','Sen',95000),
(3,'Sri','Jain',87000),
(4,'Joe','Bell',97000),
(5,'Toe','Li',78000);

DROP TRIGGER IF EXISTS `triggers`.`Employee_BEFORE_UPDATE`;

DELIMITER $$
USE `triggers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `triggers`.`Employee_BEFORE_UPDATE` BEFORE UPDATE ON `Employee` FOR EACH ROW
BEGIN
	IF New.salary < 55000 THEN
		SIGNAL SQLSTATE '50000'
        SET MESSAGE_TEXT ='Salary below 55000 not allowed';
	END IF;
END$$
DELIMITER ;

-- Keeps record of time when we make changes to the table
CREATE TABLE auditLog(
logID INT PRIMARY KEY AUTO_INCREMENT,
tableName VARCHAR(50),
action VARCHAR(30),
employeeID INT,
TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS `triggers`.`Employee_AFTER_UPDATE`;

DELIMITER $$
USE `triggers`$$
CREATE DEFINER = CURRENT_USER TRIGGER `triggers`.`Employee_AFTER_UPDATE` AFTER UPDATE ON `Employee` FOR EACH ROW
BEGIN
	INSERT INTO auditLog(tableName, action,employeeID, TIMESTAMP) VALUES
    ('Employee','Update',New.employeeID,NOW());
END$$
DELIMITER ;

UPDATE Employee
SET salary = 66000
WHERE employeeID = 3;

SELECT * FROM auditLog;
