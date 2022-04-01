
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