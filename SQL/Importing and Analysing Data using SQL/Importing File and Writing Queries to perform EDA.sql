CREATE DATABASE Sales_Data;
USE Sales_Data;

SELECT * FROM Bengaluru_House_Data;
# There are 12525 columns
SELECT COUNT(*) FROM Bengaluru_House_Data;

SELECT area_type,location,SUM(price) AS TotalPrice, COUNT(*) AS TotalCount
FROM Bengaluru_House_Data
GROUP BY area_type,location
ORDER BY TotalPrice DESC
LIMIT 5;

SELECT COUNT(*) FROM Bengaluru_House_Data
WHERE area_type='Super built-up  Area'
AND location='Whitefield';

SELECT SUM(price) FROM Bengaluru_House_Data
WHERE area_type='Super built-up  Area'
AND location='Whitefield';

# Max House Price is 2912
SELECT * FROM Bengaluru_House_Data
WHERE price=(SELECT MAX(price) FROM Bengaluru_House_Data);

SET SQL_SAFE_UPDATES = 0;

# SET society TO NULL where society is not mentioned
UPDATE Bengaluru_House_Data
SET society = NULL
WHERE society = '';

# There are 5187 columns where SOCIETY IS NULL
SELECT COUNT(*) FROM Bengaluru_House_Data
WHERE society IS NULL;

/* There are 4 distinct area_type
'Super built-up  Area'
'Plot  Area'
'Built-up  Area'
'Carpet  Area'
*/
SELECT DISTINCT area_type FROM Bengaluru_House_Data;

# There are 1251 unique locations
SELECT COUNT(DISTINCT location) AS UniqueLocations
FROM Bengaluru_House_Data;

SELECT *
FROM Bengaluru_House_Data
WHERE price > (SELECT AVG(price) FROM Bengaluru_House_Data);

# 10 most expensive flat details
SELECT *
FROM Bengaluru_House_Data
ORDER BY price DESC  
LIMIT 10;

# USING gdp DATASET
SELECT * FROM gdp;
# Top 10 Countries with max GDP
SELECT `Country Name`, MAX(Value) AS MaxGDP
FROM gdp
GROUP BY `Country Name`
ORDER BY MaxGDP DESC
LIMIT 10;


SELECT *FROM Mall_Customers;

# Average Spending Score of Female Customers is more than Male Customers
SELECT Gender,AVG(`Spending Score (1-100)`) AS AvgSpendingScore FROM Mall_Customers
GROUP BY Gender
ORDER BY AvgSpendingScore DESC;

# Average Annual Income of Male is more than Female
SELECT Gender,AVG(`Annual Income (k$)`) AS AvgAnnualIncome FROM Mall_Customers
GROUP BY Gender
ORDER BY AvgAnnualIncome DESC;

# Types of Customers based on Age
SELECT 
	CASE
    WHEN age<25 THEN 'Young'
    WHEN age BETWEEN 25 AND 40 THEN 'Middle-Aged'
    ELSE 'Senior'
    END AS AgeSegment,
    COUNT(*) CustomerCount
    FROM Mall_Customers
    GROUP BY AgeSegment;

# Avg Annual Income of People of Each Age Group we found out that Middle-Aged People have greatest avg annual income
SELECT 
    CASE
        WHEN Age < 25 THEN 'Young'
        WHEN Age BETWEEN 25 AND 40 THEN 'Middle-Aged'
        ELSE 'Senior'
    END AS AgeSegment,
    AVG(`Annual Income (k$)`) AS AvgAnnualIncome
FROM Mall_Customers
GROUP BY AgeSegment;

# Average spending score of People of Each Age Group we found out that Middle-Aged People have greatest avg spending score
SELECT 
    CASE
        WHEN Age < 25 THEN 'Young'
        WHEN Age BETWEEN 25 AND 40 THEN 'Middle-Aged'
        ELSE 'Senior'
    END AS AgeSegment,
    AVG(`Spending Score (1-100)`) AS AvgSpendingScore
FROM Mall_Customers
GROUP BY AgeSegment;

# Detail of Top 10 Customers with Highest Spending Score
SELECT *FROM Mall_Customers
ORDER BY `Spending Score (1-100)` DESC
LIMIT 10;

# No of female customers are more than male customers
SELECT Gender,COUNT(*) FROM Mall_Customers
GROUP BY Gender;



