/* SUB- QUERIES notes:
Sub queries allow isolation of each part of the statement
>> select query that is enclosed within another query: inner eval first
	types: SCALAR, COLUMN, ROW, TABLE
    
EX: which employees have higher than average salary
SELECT AVG(salary) from salaries >> gives AVG salary

NOW...

SELECT emp_no from salaries
WHERE salary > (SELECT avg(salary) from salaries);

EX 2: get names of all current managers:

SELECT emp_no FROM dept_manager
WHERE dept_manager.to_date>now()

SELECT first_name, last_name
FROM empoyees
WHERE emp_no is IN(

		SELECT emp_no FROM dept_manager
		WHERE dept_manager.to_date>now()
        
        )
        
EX 3: table subqueries return entire table

SELECT * FROM salaries
WHERE to_date > now()

SELECT current_salary.emp_no, current_salary.salary, first_name
FROM (
	SELECT * FROM salaries
	WHERE to_date > now()
    ) AS current_salaries

SELECT AVG(salary) from salaries

SELECT * FROM salaries
JOIN empoyees USING(emp_no)
WHERE salary > (SELECT AVG(salary) from salaries)
AND salaries.to_date > now();

EX 4. : all dept current mangaers and birth dates
SELECT emp_no FROM dept_manager
WHERE to_date > now();

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (SELECT emp_no FROM dept_manager
WHERE to_date > now())
*/
EX 5: find employees with first name george
join with salary table  and list first, last, salary

USE employees;

SELECT * from employees
WHERE first_name LIKE 'geor%';

SELECT table1.first_name, table1.last_name, salary
FROM (SELECT * from employees
WHERE first_name LIKE 'geor%') AS table1
JOIN salaries USING (emp_no);




