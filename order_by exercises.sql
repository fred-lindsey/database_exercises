-- USE employees;
-- SELECT first_name
-- FROM employees
-- ORDER BY first_name DESC
-- LIMIT 150;

-- SELECT first_name, last_name
-- FROM employees
-- ORDER BY last_name DESC, first_name ASC
-- LIMIT 300 OFFSET 50; -- skips an iteration of the starting position, ie drops first 50, displays next 300

Use employees;
SELECT * FROM employees;
-- 2. Find all current or previous employees with first names 
-- 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment 
-- with the number of records returned.
-- SELECT emp_no, first_name, last_name, hire_date
-- FROM employees
-- WHERE first_name IN ('Irena', 'Vidya', 'Maya');
SELECT first_name, COUNT(*) AS Total
	FROM employees
WHERE first_name IN 
('Irena', 'Vidya', 'Maya') GROUP BY first_name;
## returns 232: Vidya, 241: Irena, 236: Maya
-- 3. Use OR instead of IN
SELECT first_name, COUNT(*) AS Total
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya'
GROUP BY first_NAME;
## returns 232: Vidya, 241: Irena, 236: Maya
-- 4. And who is male:
SELECT first_name, COUNT(*) AS Total
	FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
And gender = 'M'
GROUP BY first_NAME;
## 'Vidya','151', 'Irena','144', 'Maya','146'
-- 5. Employees with last name beginning in 'E'
SELECT last_name, COUNT(*) AS Total
	FROM employees
	WHERE last_name LIKE 'E%'
    GROUP BY last_name;
-- returns grouping by last name with totals per last name
SELECT COUNT(*) 
FROM employees 
WHERE last_name LIKE 'E%';
-- returns overall total of Employees with last name starting with 'E': 7330
-- 6. Employees with last name beginning or ending in 'E'
SELECT COUNT(*) 
FROM employees 
WHERE (last_name LIKE 'E%'
OR last_name LIKE '%E');
-- returns overall total of Employees with last name starts or ends with 'E': 30723
-- ...and then doesnt end with E
SELECT COUNT(*) 
FROM employees 
WHERE last_name LIKE '%E'
AND (NOT last_name LIKE 'E%');
-- 23393
-- 7. last name starts and ends with E
SELECT COUNT(*) 
FROM employees 
WHERE last_name LIKE 'E%E';
-- returns overall total of Employees with last name starts + ends with 'E': 899
-- 8. All employees hired in the '90s
SELECT COUNT(*)
FROM employees
WHERE hire_date LIKE '199_-__-__';
-- 135214
-- 9. All employees born on XMAS
SELECT COUNT(*)
FROM employees
WHERE birth_date LIKE "____-12-25";
-- 842
-- 10. All employees born on XMAS and hired in 90's:
SELECT COUNT(*)
FROM employees
WHERE hire_date LIKE '199_-__-__'
AND birth_date LIKE "____-12-25";
-- 362
-- 11. employees with 'q' in their names
SELECT COUNT(*) 
FROM employees 
WHERE last_name LIKE '%Q%';
-- 1873
-- 11. employees with 'q', not 'qu', in their names
SELECT COUNT(*) 
FROM employees 
WHERE (last_name LIKE '%Q%'
AND last_name NOT LIKE '%QU%'); -- location of 'NOT' can be before or after obect
-- 547
USE employees_db;
SHOW TABLES;
DESCRIBE employees;

-- ORDER BY exercises:
-- 2. employees names I/V/M, order by first_name
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;
-- first/last in 1st row: Irena Reutenauer
-- first/last in last row: Vidya Simmen
-- 3. employees names I/V/M, order by first_name and last_name
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC, last_name ASC;
-- first/last in 1st row: Irena Acton
-- first/last in last row: Vidya Zweizig
-- 4. SELECT *
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name ASC, first_name ASC;
-- first/last in 1st row: Irena Acton
-- first/last in last row: Vidya Zweizig
-- 5. All employees, last name starts + ends with 'E', order by emp_no
SELECT *
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;
-- emp_no, first/last in 1st row: 10021, Ramzi Erde
-- emp_no, first/last in last row: 499648, Tadahiro Erde
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE 'E%E';
-- number returned: 899
-- 6. All employees, last name starts + ends with 'E', order by hire_date
SELECT *
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date;
-- hire_date, first/last in 1st row: 1985-02-02, Sergi Erde
-- hire_date, first/last in last row: 1999-11-27, Teiji Eldridge
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE 'E%E';
-- number returned: 899
-- 7. Employees hired in the 90's, and on XMAS. Order by oldest, hired last = 1st
SELECT *
FROM employees
WHERE hire_date LIKE '199_-__-__'
AND birth_date LIKE "____-12-25"
ORDER BY birth_date ASC, hire_date DESC;
-- oldest_last = '33936','1952-12-25','Khun','Bernini','M','1999-08-31'
-- youngest_first = '412745','1964-12-25','Douadi','Pettis','M','1990-05-04'
SELECT COUNT(*)
FROM employees
WHERE hire_date LIKE '199_-__-__'
AND birth_date LIKE "____-12-25";
-- 362