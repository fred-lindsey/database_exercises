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