CREATE DATABASE Call_Center;

USE Call_Center;

DESCRIBE Call_Center;

SELECT * FROM Call_Center;

SELECT count(*) FROM Call_Center;


-- Data Cleaning
SET SQL_SAFE_UPDATES = 0;


-- Changing date format
UPDATE Call_Center 
SET call_timestamp = STR_TO_DATE(call_timestamp, "%Y-%m-%d");

ALTER TABLE Call_Center
MODIFY COLUMN call_timestamp DATE;


-- Updating empty values to NUll
UPDATE Call_Center 
SET csat_score = NULL
WHERE csat_score = '';

SET SQL_SAFE_UPDATES = 1;


SELECT *
FROM Call_Center
LIMIT 10;

-- Count of num of rows and num of columns in table
SELECT COUNT(*) AS num_rows
FROM Call_Center;

SELECT COUNT(*) AS num_columns
FROM information_schema.columns
WHERE table_name = 'call_center' AND table_schema = 'call_centerdata';

-- To select distinct values in each column

SELECT DISTINCT sentiment
FROM Call_Center;

SELECT DISTINCT city
FROM Call_Center;

SELECT DISTINCT call_center
FROM Call_Center;


-- To count and % from total of each distinct values in a column in Call_Center table
SELECT city,
       COUNT(*) AS count,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Call_Center) AS percentage
FROM Call_Center
GROUP BY city;
  
-- Call count of each day
SELECT DAYNAME(call_timestamp) AS day_of_week,
COUNT(*) AS call_count
FROM Call_Center
GROUP BY day_of_week
ORDER BY call_count DESC;

-- Calculations
SELECT
  MIN(`call duration in minutes`) AS min_duration,
  MAX(`call duration in minutes`) AS max_duration,
  AVG(`call duration in minutes`) AS avg_duration
FROM Call_Center;


SELECT
  MIN(csat_score) AS min_csat,
  MAX(csat_score) AS max_csat,
  ROUND(AVG(csat_score), 2) AS avg_csat
FROM Call_Center
WHERE csat_score <> 0;


SELECT call_center, response_time, COUNT(*) as count
From Call_Center
GROUP BY 1,2
ORDER BY 1,3 DESC;


SELECT
  DATE(call_timestamp) AS call_day,
  MAX(`call duration in minutes`) AS max_call_duration
FROM Call_Center
GROUP BY call_day
ORDER BY call_day;
