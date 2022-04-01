
-- FUNCTIONS exercises:
-- 2. employees last_name 'E%E', use CONCAT to combine first + last into column full_name:
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name
FROM 
	employees
WHERE 
	last_name LIKE 'E%E';

-- 3. Convert last Query to all upper
SELECT 
	UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM 
	employees
WHERE 
	last_name LIKE 'E%E';

/* 4. Find all employees hired in the 90s and born on Christmas. Use datediff() 
function to find how many days they have been working at the company 
(Hint: You will also need to use NOW() or CURDATE()) */
SELECT 
	*, DATEDIFF(CURDATE(), hire_date)/365 AS tenure
FROM 
	employees
WHERE 
	hire_date LIKE '199_-__-__'
AND 
	birth_date LIKE "____-12-25";

/* 5. Find the smallest and largest current salary from the salaries table. */
SELECT 
	MIN(salary), MAX(salary)
FROM 
	salaries
WHERE
	to_date >= CURDATE();

/* 6. Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. */

SELECT 
	LOWER(CONCAT(
	SUBSTR(first_name,1,1),
	SUBSTR(last_name,1,4), '_', 
	SUBSTR(birth_date,6,2), 
	SUBSTR(birth_date,3,2))) AS username, 
	first_name, last_name, birth_date, 
	DATEDIFF(CURDATE(), hire_date)/365 AS tenure ## this part is extra, for me
FROM 
	employees;

