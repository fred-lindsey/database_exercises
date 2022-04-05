# 1. 
USE join_example_db;

# 2. a. JOIN example
SELECT *
FROM users
JOIN roles on users.role_id = roles.id;

# 2. b. LEFT JOIN example
SELECT *										# yields all data, even where right side has null values
FROM users
LEFT JOIN roles on users.role_id = roles.id;

# 2. c. RGHT JOIN example
SELECT 
	users.name AS user_name, 
    roles.name AS role_name
FROM users
RIGHT JOIN roles on users.role_id = roles.id;

# 3.  USE COUNT
SELECT 
    roles.name,
    COUNT(role_id)
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY roles.name;

#1. Use the employees database.
USE employees;

/* 2. Using the example in the Associative Table Joins section as a guide, write 
a query that shows each department along with the name of the current manager for 
that department. */

SELECT CONCAT														#select columns to display
			(e.first_name, ' ', e.last_name) AS manager_name, 		#frst + last from employees, as mgr name
			e.emp_no AS manager_no, 								#emp_no from emloyees as mgr_no,
            d.dept_name												#dept_name from departments
FROM employees AS e													#specify FROM employees, as table e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no						#joins dm and e, based on emp_no in both tables
JOIN departments AS d ON d.dept_no = dm.dept_no						#joins d and dm, based on dept_no in both tables
WHERE dm.to_date = '9999-01-01';									#where to_date is current

/* 3. Find the name of all departments currently managed by women. */
SELECT 
			e.gender AS manager_gender, 								
            d.dept_name						
FROM employees AS e													
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no						
JOIN departments AS d ON d.dept_no = dm.dept_no						
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

/* 4. Find the current titles of employees currently working in the Customer Service department. */
SELECT 
	t.title AS employee_title, 
    dept_name
FROM titles AS t
JOIN dept_emp AS de ON de.emp_no = t.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE dept_name = 'Customer Service' AND de.to_date = '9999-01-01';

/* 5. Find the salary of all current Managers */
USE employees;
SELECT
	CONCAT(e.first_name, ' ', e.last_name) AS mgr_name,
    s.salary AS mgr_salary,
    dm.dept_no AS mgr_dept,
    d.dept_name AS department_name
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.emp_no = s.emp_no 
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE s.to_date = '9999-01-01'
ORDER BY d.dept_name; # extra, for readability

/* 6. Find the number of current employees in each department */
USE employees;
SELECT
	d.dept_no,
    d.dept_name,
    COUNT(emp_no) AS num_employees
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY dept_name; # 

/* 7. Which department has the highest avg salary? */
SELECT
    d.dept_name,
    ROUND(AVG(salary)) AS average_salary
FROM employees AS e
JOIN salaries AS s on s.emp_no = e.emp_no
	AND s.to_date > curdate()
    AND de.to_date > curdate()
JOIN dept_emp AS de ON de.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;