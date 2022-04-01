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
