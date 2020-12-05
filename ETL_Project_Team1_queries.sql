-- Create table structure for starbucks_data
CREATE TABLE starbucks_data (
store_number varchar PRIMARY KEY,
address TEXT,
city TEXT,
state varchar,
country TEXT,
zipcode varchar,
longitude float,
latitude float
);

-- Create table structure for income_data
CREATE TABLE income_data(
id INT PRIMARY KEY,
state_name TEXT,
city TEXT, 
zip_code varchar,
lat float,
lon float,
median float,
stdev float
);

SELECT * 
FROM starbucks_data
LIMIT 1;

SELECT * FROM income_data
LIMIT 1

DROP TABLE startbucks_data
DROP TABLE income_data

-- Rename column in income_data table
ALTER TABLE income_data
RENAME COLUMN median TO median_income

-- Joins starbucks_data & income_data tables (Income DESC)
SELECT S.state, 
S.city, 
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code
ORDER BY 3 DESC

-- Joins starbucks_data & income_data tables (Income ASC)
SELECT S.state, 
S.city, 
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code
ORDER BY 3

-- Display Minimum & Maximum Median_income
SELECT MIN(median_income) AS Min_income,
MAX(median_income) AS Max_income
FROM income_data

-- Display Maxmium median_income for each state
SELECT A.state, 
max(median_income) AS Max_Income
FROM(
SELECT S.state, 
S.city, 
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code) A
GROUP BY A.state
ORDER BY 1
	
-- Display Minmium median_income for each state
SELECT A.state, 
MIN(median_income) AS Min_Income
FROM(
SELECT S.state, 
S.city, 
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code) A
GROUP BY A.state
ORDER BY 1
	
--Display Starbucks locations for each state
SELECT state,
COUNT(store_number) AS Number_of_Starbucks
FROM starbucks_data
GROUP BY state
ORDER BY 1

-- Display total Number of Median Income for each state
SELECT A.state, 
COUNT(median_income) AS Number_of_Income
FROM(
SELECT S.state, 
S.city, 
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code) A
GROUP BY A.state
ORDER BY 1

-- Display Total Number of Maxmium Medium Income for each state
SELECT  A.state,
COUNT(DISTINCT A.zip_code) AS Total_Locations,
A.median_income
FROM(
SELECT S.state, 
S.city, 
I.zip_code,
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code
WHERE I.median_income >= 300000) A
GROUP BY  A.state, A.median_income
ORDER BY 2 DESC

-- Display Total Number of Minmium Medium Income for each state
SELECT  A.state,
COUNT(DISTINCT A.zip_code) AS Total_Locations,
A.median_income
FROM(
SELECT S.state, 
S.city, 
I.zip_code,
I.median_income,
I.stdev
FROM starbucks_data AS S INNER JOIN 
income_data AS I
ON S.zipcode = I.zip_code
WHERE I.median_income = 0) A
GROUP BY  A.state, A.median_income
ORDER BY 2 DESC


