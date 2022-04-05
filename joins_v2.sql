USE employees;
# Write a query that shows each department along with current mgr
# show manager name and department name.
# manager name from employees; employees join dept_manager (emp_no), dept_emp join departments (dept_no)
# where dept_emp.to_date = "9999-01-01'
SELECT CONCAT(e.first_name, ' ', e.last_name) AS mgr_name, d.dept_name AS department
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01';
# Find the name of all departments managed by women
# from employees: gender, name, emp_no. join dept_manager using emp_no, join departments using dept_no. 
# select gender, name, department
# use WHERE clause for current, to_date from dept_manager
SELECT e.gender, e.last_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';
# Find the current titles of all employing working in Customer service
# find employees in customer serivce by:
# title from titles (join with emp_no), dept_no from dept_emp (join with emp_no),
#dept_name from departments (join with dept_no), WHERE dept_name = 'Customer Service'
# show title, department, GROUP BY title
SELECT COUNT(t.title) AS title_count, t.title, d.dept_name AS department
FROM titles AS t
JOIN dept_emp AS de ON de.emp_no = t.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Customer Service' and de.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY t.title ASC;
# 5. find the current salary of all current managers
# show name, salary, department managed
# name from employees, salary from salaries (join with emp_no), join dept_manager with emp_no, 
# join departments with dept_no
SELECT CONCAT(e.first_name, ' ', e.last_name), d.dept_name, s.salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE s.to_date = '9999-01-01';
#6. Find the number of current employees in each dept.
#show dept_no, dept_name and count(num_employees) group by dept_name
# dept_no and name from departments, join dept_emp thru dept_no, count(emp_no),group by dept_no
SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS employees
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_name;
# 7. which department has the highest avg salary?
# show dept_name, avg(salary)
# dept_name from departments, join dept_emp thru dept_no, join salaries through emp_no
SELECT d.dept_name, AVG(s.salary)
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;
# 8. Who is the highest paid employee in Marketing?
# name from employees, join salaries through emp_no, select salary, join dept_emp on emp_no, 
# join departments on dept_no
# show name, salary
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name, s.salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON de.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date = '9999-01-01' AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;