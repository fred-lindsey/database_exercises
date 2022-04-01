USE employees;
SELECT *
FROM employees
LIMIT 100;

SELECT *
FROM employees
WHERE hire_date = "1985-01-01";

# USING LIKE

SELECT *
FROM employees
WHERE hire_date LIKE '1985-__-01'; # YYYY-MM-DD



SELECT  DISTINCT first_name
FROM employees
WHERE hire_date LIKE '1985-__-01'; # YYYY-MM-DD
-- % = any number of characters can be a wildcard, _ = only one character

# USING IN

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');

# USING NULL/NOT NULL

SELECT emp_no, title
FROM titles
WHERE to_date IS NOT NULL;

# CHAINING WHERE Clauses
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Baek')
AND emp_no < 20000;

# Comment on what you are trying to achieve, for example
SELECT emp_no, first_name, last_name
FROM employees
WHERE (emp_no < 20000
  AND last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar');
   



