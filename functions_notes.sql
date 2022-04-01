-- NOTES on FUNCTIONS 

-- CONCAT: 
-- 		SELECT CONCAT('string' , 'column' , 'character')
USE employees;
SELECT lower(concat((first_name), '.' , (last_name), '@company.com')) 
AS email 
FROM employees;

-- LIKE: >> returns results that fit the pattern
-- 		SELECT first_name
--     	FROM employees
--     	WHERE first_name LIKE '%ack%';

-- NOT LIKE: >> returns results that do not fit the pattern
-- 		SELECT DISTINCT first_name
--     	FROM employees
--     	WHERE first_name NOT LIKE '%ack%';

-- SUBSTR: >> extract part of the string with the SUBSTR fucntion
-- 		SUBSTR(string, start_index, length) # start index is which character you start from
USE employees;
SELECT lower(concat(substr(first_name,1,1), '.',last_name)) 
AS username 
FROM employees;
-- CASE CONVERSION:
-- 		UPPER/LOWER >> SELECT UPPER('abcde'), LOWER ('ABCDE');
SELECT * FROM employees;
SELECT LOWER(first_name), UPPER(last_name)
FROM employees;

-- REPLACE: >> manipulate strings by replacing SUBSTRs
-- 		REPLACE(subject, search, replacement)
-- 		SELECT REPLACE('abcdefg', 'abc', '123') , OUTPIUT >> 123defg

-- DATE/TIME:
-- 		NOW: SELECT NOW(); >> outputs YYYY-MM-DD HH:MM:SS
-- 		CURDATE: SELECT CURDATE(); >> outputs YY-MM-DD
-- 		NOW: SELECT CURTIME(); >> outputs HH:MM:SS
SELECT DAYNAME("1970-01-01"); # OUTPUT>> Thursday
SELECT MONTHNAME("2022-03-31"); # OUTPUT>> March
SELECT CURDATE(); # 2022-04-01
SELECT CURTIME(); # 14:57:21

-- how many years between employe hire_date and today?
SELECT *, DATEDIFF(CURDATE(), hire_date)/365
AS TENURE
FROM employees;

-- unix time: number of seconds since 1970-01-01
SELECT unix_timestamp('1971-01-01');

-- add the function outputs as new columns onto existing output:
SELECT *, DAYNAME(birth_date)
AS Weekday_DOB
FROM employees;

-- NUMERIC Aggregate Functions
--		MIN/MAX/AVERAGE/STDDEV/COUNT/SUM
SELECT AVG(salary), MIN(salary), STDDEV(salary)
FROM salaries;

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

