## Headline: once you write a query to output an optimized display of data, create a 
# temporary table to store and manipulate that data

# Temporary tables create tables from queries. This protects the data integrity of
# the original data set, while retrieving relevant use. Use temporary tables to avoid
# altering the production/final data

# They are essentiallyporxy servers: reduce latency, prodive a sandbox with 
# non-production data

/* SYNTAX
CREATE TEMPORARY TABLE table_name(..);

EXAMPLE: CREATE TEMPORARY TABLE my_numbers(
	n INT UNSIGNED NOT NULL
    );
    
EXAMPLE
USE jemison_1750; #usenrame is also a DB
CREATE TEMPORARY TABLE my_numbers(
	n INT UNSIGNED NOT NULL
    
INSERT INTo my_numbers(n) VALUES (1), (2);

>> if using your own db, you will need to reference the file name  with their 
DB name:

USE jemison_1750;

CREATE TEMPORARY TABLE short_employees AS
select *
FROM employees.employees LIMIT 10;

select * FROM short_employees; >> in db fred

USE employees;
CREATE fred.employees_with-departments_with_salaries AS
SELECT first_name, last_name, salary, dept_name

DELETE columns
select * from exmaple1;

alter table example1 DROP COLUMN emp_no1;
alter table example1 DROP Column emp_no2;

alter table example1 ADD email VARCHAR(100)
*/

-- USE employees;
-- CREATE TEMPORARY TABLE jemison_1750.employees_with_salaries_pt7 AS
-- SELECT first_name, last_name, salary
-- FROM employees
-- JOIN salaries ON salaries.emp_no = employees.emp_no
-- LIMIT 50;

-- SELECT *
-- FROM jemison_1750.employees_with_salaries_pt7;

/* Exercises
1. create a temporary table called employees_with_departments that contains first_name, 
last_name, and dept_name for employees currently with that department. */
 USE employees;
 SET SQL_safe_updates = 0;
 
 CREATE TEMPORARY TABLE jemison_1750.employees_with_departments AS
 SELECT first_name, last_name, dept_name
 FROM employees
 JOIN dept_emp USING(emp_no)
 JOIN departments USING(dept_no)
 WHERE dept_emp.to_date > CURDATE()
 LIMIT 100;
 
 SELECT *
 FROM jemison_1750.employees_with_departments;
 
 /* 1.A. Add a column named full_name to this table. It should be a VARCHAR whose length 
 is the sum of the lengths of the first name and last name columns */
 
 ALTER TABLE jemison_1750.employees_with_departments ADD full_name VARCHAR(50);
 SELECT *
 FROM jemison_1750.employees_with_departments;
 
  /* 1.B. Update the table so that full name column contains the correct data */
  
  UPDATE jemison_1750.employees_with_departments
  SET full_name = CONCAT(first_name, ' ', last_name);
  SELECT *
  FROM jemison_1750.employees_with_departments;
  
   /* 1.C. Remove the first_name and last_name columns from the table */
ALTER TABLE jemison_1750.employees_with_departments DROP COLUMN first_name;
ALTER TABLE jemison_1750.employees_with_departments DROP COLUMN last_name;

/* 1.D. What is another way you could have ended up with this same table? */
# altered the imitial query that we created the temporary table from

/* 2. Create a temporary table based on the payment table from the sakila database. */
USE sakila;
SELECT *
FROM payment;

CREATE TEMPORARY TABLE jemison_1750.payment AS
SELECT *
FROM sakila.payment
LIMIT 150;

SELECT *					#check that it creates the desired table with variables
FROM jemison_1750.payment;

ALTER TABLE jemison_1750.payment ADD cents_amount INT(10);
UPDATE jemison_1750.payment
SET cents_amount = amount * 100;

ALTER TABLE jemison_1750.payment MODIFY cents_amount INT NOT NULL;

SELECT *					#check that it creates the desired table with variables
FROM jemison_1750.payment;

/* 3.Find out how the current average pay in each department compares to the overall, 
historical average pay. In order to make the comparison easier, you should 
use the Z-score for salaries. In terms of salary, what is the best department right 
now to work for? The worst? */

# Step 1: create historic pay table
USE employees;
CREATE TEMPORARY TABLE jemison_1750.current_pay AS
SELECT 
	AVG(salary) AS current_pay, 
	d.dept_name
FROM salaries AS s
JOIN dept_emp AS de ON de.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date > NOW()
GROUP BY dept_name
LIMIT 100;

SELECT *
FROM jemison_1750.current_pay; 	# check that the table displayed correct 
								# variables/ ran correctly

# Step 2: create current pay table
SELECT *
FROM jemison_1750.current_pay;

USE employees;
CREATE TEMPORARY TABLE jemison_1750.historic_pay AS
SELECT 
	AVG(salary) AS historic_pay,
	dept_name
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date <= NOW()
GROUP BY dept_name
LIMIT 100;

SELECT *
FROM jemison_1750.historic_pay;

 # STEP 3: create a thrid table, that joins the two temporary tables on dept_name
CREATE TEMPORARY TABLE jemison_1750.historic_and_current_pay AS
SELECT 
	hp.dept_name, hp.historic_pay AS historic_pay, cp.current_pay AS current_pay
FROM jemison_1750.historic_pay AS hp
JOIN jemison_1750.current_pay AS cp ON cp.dept_name = hp.dept_name
LIMIT 100;

SELECT *
FROM jemison_1750.historic_and_current_pay;

#STEP 4: add z-score
USE jemison_1750;
SELECT * FROM jemison_1750.historic_and_current_pay;

ALTER TABLE jemison_1750.historic_and_current_pay ADD z_score FLOAT(8);
ALTER TABLE jemison_1750.historic_and_current_pay ADD pay_diff FLOAT(8);
ALTER TABLE jemison_1750.historic_and_current_pay ADD stddev FLOAT(8);
ALTER TABLE jemison_1750.historic_and_current_pay DROP COLUMN stddev;
ALTER TABLE jemison_1750.historic_and_current_pay ADD std_dev FLOAT(8);

USE jemison_1750;
UPDATE jemison_1750.historic_and_current_pay
SET pay_diff = current_pay - historic_pay;

CREATE TEMPORARY TABLE jemison_1750.pay_std_dev AS
SELECT STD(current_pay)
FROM jemison_1750.historic_and_current_pay;

SELECT *
FROM jemison_1750.pay_std_dev;
 
USE jemison_1750;
UPDATE jemison_1750.historic_and_current_pay
SET std_dev = jemison_1750.pay_std_dev.STD(current_pay);

-- SET z_score = (
-- 			SELECT (current_pay - historic_pay) / STDDEV(current_pay)
--             FROM historic_and_current_pay
--             );


-- SELECT 		(
-- SELECT AVG(salary) FROM employees.salaries WHERE salaries.to_date < NOW()) as historic_data,
-- (CurAvgSal - (SELECT AVG(salary) FROM employees.salaries)
-- 			)
-- 		/
-- 			(
-- 		SELECT stddev(salary) FROM employees.salaries
-- 			) 
-- 		AS zscore, CurAvgSal, DeptSal.dept_name
-- FROM DeptSal
-- GROUP BY CurAvgSal, DeptSal.dept_name
-- ORDER BY zscore DESC;

CREATE TEMPORARY TABLE numbers AS select

