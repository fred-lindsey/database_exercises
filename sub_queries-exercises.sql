/* Sub-Queries Exs */
Use employees;
SELECT *
FROM employees
LIMIT 150;

/* 1. Find all the current employees with the same hire date as employees
101010 using a sub-query */
SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT * 
FROM employees
WHERE hire_date = (SELECT hire_date FROM employees WHERE emp_no = 101010);

/* 2. Find all the titles ever held by all current employees with the first name Aamod. */
SELECT emp_no
FROM employees
WHERE first_name = 'Aamod';

SELECT title, COUNT(*)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
FROM employees
WHERE first_name = 'Aamod'
				)
GROUP BY title;

/* 3. How many people in the employees table are no longer working for the company? 
Give the answer in a comment in your code. */


SELECT emp_no FROM titles
WHERE to_date > now();

SELECT COUNT(emp_no) FROM employees
WHERE (
		SELECT emp_no FROM titles
		WHERE to_date > now()
		);
        