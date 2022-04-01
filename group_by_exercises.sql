/*Notes: GROUP BY will answer real business questions. You select the attribute that you want 
information for: GENDER, TENURE, etc. */
SELECT first_name 
FROM employees
GROUP BY first_name;

SELECT emp_no, AVG(salary) FROM salaries 
GROUP BY emp_no
ORDER BY AVG(salary) DESC;

SELECT emp_no, AVG(salary), MIN(to_date) FROM salaries
GROUP BY emp_no
ORDER BY AVG(salary) DESC
LIMIT 50;

-- different avg salary for genders?
SELECT gender, AVG(salary), FORMAT(STDDEV(salary), 0), MIN(salary) FROM employees
JOIN salaries using (emp_no)
GROUP BY gender, last_name;

-- HAVING 
SELECT emp_no, AVG(salary) AS avg_salary FROM salaries
GROUP BY emp_no
HAVING avg_salary > 50000;

-- GROUP BY Exercises
-- General refresher, accessing and viewing tables in DB
USE employees_db;
SHOW TABLES;
SELECT * from titles;
/* 2. In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.*/
SELECT DISTINCT(title) 
FROM titles; ## returns 7 titles

/* OR...*/

SELECT title
FROM titles
GROUP BY title;

/* 3. Write a query to to find a list of all unique last names of all employees that start 
and end with 'E' using GROUP BY. */
SELECT DISTINCT(last_name), COUNT(*) AS same_last_name # returns unique names with count
FROM employees 
WHERE last_name LIKE 'E%E' ## returns 5 rows
GROUP BY last_name;
/* 4. Write a query to to find all unique combinations of first and last names of all employees
 whose last names start and end with 'E'. */
 SELECT first_name, last_name
 FROM employees 
 WHERE last_name LIKE('E%E')
 GROUP BY first_name, last_name;
 /* 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those 
 names in a comment in your sql code. */
SELECT DISTINCT(last_name)
FROM employees 
WHERE (last_name LIKE'%q%'
AND NOT last_name LIKE'%qu%')
GROUP BY last_name;
/* 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name. */
SELECT DISTINCT(last_name), COUNT(*)
FROM employees 
WHERE (last_name LIKE'%q%'
AND NOT last_name LIKE'%qu%')
GROUP BY last_name;
 /* 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number 
 of employees for each gender with those names. */
 SELECT gender, first_name, COUNT(gender)
 FROM employees
 WHERE first_name IN ('Irena', 'Vidya', 'Maya')
 GROUP BY gender, first_name;
 /* 8. Using your query that generates a username for all of the employees, generate a count of employees for each unique username. 
 Are there any duplicate usernames? BONUS: How many duplicate usernames are there? */
 SELECT 
	LOWER(
		CONCAT(
        SUBSTR(first_name,1,1),
        SUBSTR(last_name,1,4),
        '_', 
        SUBSTR(birth_date,6,2), 
        SUBSTR(birth_date,3,2))
        ) 
        AS username, 
    COUNT(*) AS n_username
FROM 
	employees
GROUP BY 
	username
HAVING
	n_username > 1
ORDER BY
	n_username DESC;
/* 9. 
a. Determine the historic average salary for each employee. When you hear, read, 
or think "for each" with regard to SQL, you'll probably be grouping 
by that exact column. */
SELECT AVG(salary), COUNT(*)
FROM salaries
GROUP BY salary;
