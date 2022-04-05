/* Sub-Queries Exs */
Use employees;
SELECT *
FROM employees
LIMIT 150;

/* 1. Find all the current employees with the same hire date as employees
101010 using a sub-query */
-- SELECT hire_date
-- FROM employees
-- WHERE emp_no = 101010; ## inner query

SELECT * 
FROM employees
JOIN dept_emp USING(emp_no)
WHERE to_date > now()
AND hire_date = (SELECT hire_date FROM employees WHERE emp_no = 101010);

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
AND to_date > now()
				)
GROUP BY title;

/* 3. How many people in the employees table are no longer working for the company? 
Give the answer in a comment in your code. */

SELECT COUNT(emp_no) AS not_employed
FROM employees 
WHERE  emp_no NOT IN (
	SELECT emp_no
	FROM salaries
	WHERE to_date >='9999-01-01'
	); #59,900

/* 4. Find all current female department managers. List name */
# need names, gender = F, dept_manager, dept
-- SELECT CONCAT(e.first_name, ' ', e.last_name) AS manager, e.gender, d.dept_name
-- FROM employees AS e
-- JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
-- JOIN departments AS d ON d.dept_no = dm.dept_no
-- WHERE e.gender = 'F' and dm.to_date = '9999-01-01';

SELECT g.last_name AS manager, g.gender, departments.dept_name
FROM
	(
		SELECT *
		FROM employees
        WHERE gender = 'F'
	) as g
JOIN dept_manager ON g.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE to_date > CURDATE(); # DasSarma, Kambil, Legleitner, Sigstam

/* 5. Find all the employees who currently have a higher salary than the companies overall, historical 
average salary. */
-- SELECT emp_no
-- FROM salaries AS s
-- JOIN employees AS e USING(emp_no)
-- WHERE to_date > now()
-- AND salary > (SELECT AVG(salary) FROM salaries);

SELECT (ROUND(AVG(salary))
FROM salaries;

SELECT last_name, first_name, salaries.salary
FROM employees 
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE salaries.salary > (SELECT ROUND(AVG(salary)) AS avg_salary FROM salaries)
ORDER BY salaries.salary DESC;

/* 6. How many current salaries are within 1 standard deviation of the current highest 
salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of 
all salaries is this? */

SELECT MAX(salary) FROM salaries WHERE to_date > now(); # current max salary

SELECT STDDEV(salary) FROM salaries WHERE to_date > now(); # stddev for current salary

SELECT COUNT(*) 
FROM salaries
WHERE to_date > now()
AND salary > (
(SELECT MAX(salary) FROM salaries WHERE to_date > now()) - 
(SELECT STDDEV(salary) FROM salaries WHERE to_date > now())

);


SELECT max(salary)
FROM salaries
WHERE to_date > CURDATE(); #158220

SELECT COUNT(*)
FROM salaries
WHERE (
	salary IN (max(salary) - STDDEV(salary)
		)
