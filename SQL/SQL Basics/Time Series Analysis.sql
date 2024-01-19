-- TIME SERIES ANALYSIS (Observation recorded over a time) 
CREATE TABLE SalesData(
Date DATE,
SalesAmount DECIMAL(10,2)
);

INSERT INTO SalesData VALUES('2023-11-01',20000),
('2023-11-02',30000),
('2023-11-03',40000),
('2023-11-04',50000),
('2023-11-05',60000),
('2023-11-06',70000),
('2023-11-07',80000),
('2023-11-08',90000),
('2023-11-09',100000),
('2023-11-10',10000),
('2023-11-11',110000),
('2023-11-12',85000),
('2023-11-13',75000),
('2023-11-14',65000),
('2023-11-15',55000),
('2023-11-16',45000),
('2023-11-17',35000),
('2023-11-18',25000),
('2023-11-20',15000),
('2023-11-21',30000),
('2023-11-22',40000),
('2023-11-23',60000),
('2023-11-24',80000),
('2023-11-25',11000),
('2023-11-26',22000),
('2023-11-27',33000),
('2023-11-28',55000),
('2023-11-29',95000),
('2023-11-30',105000);

SELECT * FROM SalesData;

SELECT SUM(SalesAmount) AS AverageSales FROM SalesData;
SELECT AVG(SalesAmount) AS TotalSales FROM SalesData;

SELECT Date, SalesAmount FROM SalesData WHERE SalesAmount=(SELECT MAX(SalesAmount) FROM SalesData);

-- Rolling Average
SELECT Date, SalesAmount, 
AVG(SalesAmount) OVER (ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS RollingAverage
FROM SalesData;

SELECT WEEK(Date) AS WeekNumber,
		SUM(SalesAmount) AS WeeklySales
FROM SalesData
GROUP BY WEEK(Date)
ORDER BY WeekNumber;

-- PERFORMACE OPTIMIZATION

-- Slow Query
SELECT * FROM SalesData WHERE YEAR(Date)='2023';

-- Indexing for Faster Data Retrieval
CREATE INDEX idx_date ON SalesData(Date);

-- Query Rewriting for Better Performance 
SELECT Date, SalesAmount
FROM SalesData
WHERE Date BETWEEN '2023=11-01' AND '2023-11-30';

-- Avoiding nested queries




