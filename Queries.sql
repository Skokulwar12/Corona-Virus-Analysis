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

SELECT 
	TO_CHAR(date, 'Month') AS Month_name,
	MODE() WITHIN GROUP (ORDER BY confirmed) AS most_confirmed,
	MODE() WITHIN GROUP (ORDER BY deaths) AS most_deaths,
	MODE() WITHIN GROUP (ORDER BY recovered) AS most_recovered
FROM covid_dataset
WHERE confirmed != '0'
AND recovered != '0'
AND deaths != '0'
GROUP BY Month_name
ORDER BY most_confirmed DESC, 
		 most_recovered DESC;

--Q6. Find minimum values for confirmed, deaths, recovered per year.

SELECT TO_CHAR(date, 'YYYY') AS Year,
	MIN(confirmed) AS min_confirmed,
	MIN(deaths) AS min_deaths,
	MIN(recovered) AS min_recovered
FROM covid_dataset
WHERE confirmed != '0'
AND recovered != '0'
AND deaths != '0'
GROUP BY Year;

-- Q7. Find maximum values of confirmed, deaths, recovered per year.

SELECT TO_CHAR(date, 'YYYY') AS Year,
	MAX(confirmed) AS min_confirmed,
	MAX(deaths) AS min_deaths,
	MAX(recovered) AS min_recovered
FROM covid_dataset
GROUP BY Year;

-- Q8. The total number of case of confirmed, deaths, recovered each month.

SELECT TO_CHAR(date, 'Month') AS Months,
	   SUM(confirmed) AS total_confirmed,
	   SUM(deaths) AS total_deaths,
	   SUM(recovered) AS total_recovered
FROM covid_dataset
GROUP BY Months
ORDER BY total_confirmed DESC,
		 total_deaths DESC,
	 	 total_recovered DESC;

-- Q9. Check how corona virus spread out with respect to confirmed case.
--      (Eg.: total confirmed cases, their average, variance & STDEV )

