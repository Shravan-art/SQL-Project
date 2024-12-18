CREATE DATABASE Emp1;

USE Emp1;

SELECT * FROM analyzing_employee_trends;

ALTER TABLE analyzing_employee_trends
CHANGE COLUMN `ï»¿emp_no` `emp_id` int;

-- 1. Count the number of employees in each department

SELECT department, COUNT(emp_id) as number_of_employees
FROM analyzing_employee_trends
GROUP BY department;


-- 2.Calculate the average age for each department

SELECT department, AVG(age) AS Avg_Age
FROM analyzing_employee_trends
GROUP BY department;


-- 3. Identify the most common job roles in each department

SELECT department, job_role, COUNT(*) AS most_common_emp
FROM analyzing_employee_trends
GROUP BY 1, 2
ORDER BY 1, 2;


-- 4. Calculate the average job satisfaction for each education level

SELECT education, AVG(job_satisfaction) AS Avg_job_satisfaction
FROM analyzing_employee_trends
GROUP BY 1
ORDER BY 2 DESC ;


-- 5.Determine the average age for employees with different levels of job satisfaction

SELECT job_satisfaction, AVG(age) AS Avg_Age
FROM analyzing_employee_trends
GROUP BY 1
ORDER BY 1, 2 DESC;


-- 6. Calculate the attrition rate for each age band

SELECT age_band, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS Attrition_Rate
FROM analyzing_employee_trends
GROUP BY age_band;


-- 7. Identify the departments with the highest and lowest average job satisfaction

WITH Department_Satisfaction AS (
     SELECT department, AVG(job_satisfaction) AS Avg_Job_Satisfaction
     FROM analyzing_employee_trends
     GROUP BY 1 )
SELECT department, Avg_Job_Satisfaction,
	 RANK() OVER(ORDER BY Avg_Job_Satisfaction DESC) AS Highest_Rank,
	 RANK() OVER(ORDER BY Avg_Job_Satisfaction ASC) AS Lowest_Rank
FROM Department_Satisfaction;


-- 8. Find the age band with the highest attrition rate among employees with a specific education level

SELECT age_band, education, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS attrition_rate
FROM analyzing_employee_trends
GROUP BY 1, 2 
ORDER BY 3 DESC
LIMIT 1;


-- 9.Find the education level with the highest average job satisfaction among employees who travel frequently

SELECT emp_id, education, business_travel, AVG(job_satisfaction) AS Avg_Job_Satisfaction
FROM analyzing_employee_trends
WHERE business_travel = 'Travel_Frequently'
GROUP BY 1, 2, 3
ORDER BY 3 DESC
LIMIT 3;


-- 10. Identify the age band with the highest average job satisfaction among married employees

SELECT emp_id, marital_status, age_band, AVG(job_satisfaction) AS Avg_Job_Satisfaction
FROM analyzing_employee_trends
WHERE marital_status = 'Married'
GROUP BY 1, 2, 3
ORDER BY 4 DESC
LIMIT 1;

-- END