CREATE TABLE 
			covid_dataset (
			province VARCHAR(150),
			country_or_region VARCHAR(200),
			latitude FLOAT,
			longitude FLOAT,
			date DATE,
			confirmed INT,
			deaths INT,
			recovered INT
);

--Q1. Check total number of rows.

SELECT COUNT(*) 
FROM covid_dataset;

-- Q2. Check what is start_date and end_date.

SELECT MIN(date) AS start_date,
	   MAX(date) AS end_date
FROM covid_dataset;

-- Q3. Number of month present in dataset.

SELECT COUNT(DISTINCT DATE_TRUNC('Month', date)) 
	   AS num_months
FROM covid_dataset;

-- Q4. Find monthly average for confirmed, deaths, recovered.

SELECT TO_CHAR(date, 'Month') AS Months,
	ROUND(AVG(confirmed) :: numeric, 0) AS average_confirmed,
	ROUND(AVG(deaths) :: numeric, 0) AS average_deaths,
	ROUND(AVG(recovered) :: numeric, 0) AS average_recovered
FROM covid_dataset
GROUP BY Months;

-- Q5. Find most frequent value for confirmed, deaths, recovered each month.

SELECT TO_CHAR(date,'Month') AS Months
	   MODE(confirmed) AS most_confirmed,
	   MODE(deaths) AS most_deaths,
	   MODE(recovered) AS most_recovered
FROM covid_dataset
GROUP BY Months;
