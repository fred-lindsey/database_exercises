-- Syntax: SELECT clumns FROM table LIMIT count [OFFSET count];
-- 2. 1st ten distinct last names, sorted DESC
USE employees;
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- 3. employees hired in 90's and born on XMAS. Find first 5, sort by hire date:
SELECT first_name, last_name
FROM employees
WHERE hire_date LIKE '199_-__-__'
AND birth_date LIKE "____-12-25"
ORDER BY hire_date DESC
LIMIT 5;
/*
'Khun','Bernini'
'Elvis','Goodrum'
'Sachar','Ghalwash'
'Moto','Siegrist'
'Ulf','Pehl'
*/
-- 4. 
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '199_-__-__'
ORDER BY hire_date
LIMIT 5 OFFSET 5;
/*
4. LIMIT = LIMIT number of resukts from query, 
OFFSET removes an x amount of results
from the top of the query. EG "LIMT 50, OFFSET 50;" yields the second 50 results in a 
query with the first 50 having been "offset" from the larger query

Page 1 -> LIMIT = 5, OFFSET = 0, Records 1-5
...
Page 5 -> LIMIT = 5, OFFSET = 20, Records 21-25
*/



