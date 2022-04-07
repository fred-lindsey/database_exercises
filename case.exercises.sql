/* CASE Statments Notes:
	Use CASE statements when
		- you have more than 2 optional values
	Types
		- Boolean Match/Cast
			SELECT 
				dept_name,
                dept_name = 'Research' AS is_research
                dept_name LIKE '%Research%' AS like_research
			FROM departments;
            >> yieds Boolean values for those two column results
        - IF() >> used to check max of two outcomes, otherwise complexity is too high to track
			SELECT 
				dept_name,
                IF(dept_name = 'Research', True, False) AS is_research
			FROM departments;
            
            SELECT 
				dept_name,
                IF(dept_name = 'Research', 'Yes', 'No' ) AS is_research
			FROM departments;
            
            SELECT 
				dept_name,
                IF(dept_name = 'Research', 'Yes', IF(dept_name = 'Marketing', 'Marketing', 'No'))
			FROM departments
        - Simple case
			SELECT 
				dept_name,
                CASE dept_name
					WHEN 'Research' THEN 1
                    ELSE 0
				END AS is_research
			FROM departments;
        - Complex case >> use to create sub-categories of data with labels. "Bending Data"
			SELECT 
				dept_name,
                CASE
                WHEN dept_name IN ('Marketing', 'Sales') THEN 'Money Makers'
                WHEN dept_name LIKE '%research%' OR dept_name LIKE '%resources%' THEN 'People People'
                Else 'Others'
			END AS department_categories
		FROM departments;
         **CREATIVE USE of Cases**
         - PIVOT Tables >> non-tech stakeholders in industry love pivot tables
			It's a table with the relationship/intersection between 2+ variables on an aggregate
            value (COUNT or AVG.
            This can be done programmatically with SQL:
				"give me the diferent titles held across different departments"
					>> COUNTING pivot table
            SELECT 
				dept_name,
                CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer'
                
		** END NOTES */
        
        USE employees;
        /* 1. Write a query that returns all employees, their department number, 
        their start date, their end date, and a new column 'is_current_employee' 
        that is a 1 if the employee is still with the company and 0 if not. */
        # need employee name (first, last), dept_no, is_current_employee (0/1)
        # use Boolean match/cast, from employees
        # create temp table is extra, for me
			SELECT 
				CONCAT(first_name, ' ', last_name), 
                dept_emp.dept_no AS start_date, 									#from dept_emp, join on emp_no
                dept_emp.from_date AS end_date, 
                dept_emp.to_date,
				IF (dept_emp.to_date > NOW(), True, False) AS is_current_employee
            FROM employees
            JOIN dept_emp USING(emp_no)
            ORDER BY to_date DESC;
		
        USE jemison_1750;
		
        SELECT *
        FROM jemison_1750.current_employees;
			
	/* 2. Write a query that returns all employee names (previous and current), and a 
    new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first 
    letter of their last name. */ 
    
    USE employees;
    SELECT
		CONCAT(first_name, ' ', last_name),
        CASE
			WHEN last_name RLIKE '^[A-H]' THEN 'A-H'
            WHEN last_name RLIKE '^[I-Q]' THEN 'I-Q'
            WHEN last_name RLIKE '^[R-Z]' THEN 'R-Z'
		END AS alpha_group
	FROM employees
    LIMIT 500;
    
    SELECT
		first_name,
        last_name,
        CASE 
			WHEN LEFT(last_name, 1) AS first_letter_of_last_name
    /* 3. How many employees (current or previous) were born in each decade? */ 
    # display each decade in a column, and a count of employees born in that decade
    
    USE employees;
    SELECT 
		COUNT(*),
		CASE
			WHEN YEAR(birth_date) BETWEEN 1940 AND 1949 THEN '1940s'
			WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
			WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
			WHEN YEAR(birth_date) BETWEEN 1970 AND 1979 THEN '1970s'
			WHEN YEAR(birth_date) BETWEEN 1980 AND 1989 THEN '1980s'
			WHEN YEAR(birth_date) BETWEEN 1990 AND 1999 THEN '1990s'
			ELSE 'too young'
		END AS decade_born
	FROM employees
    GROUP by decade_born; #'182886','1950s'; '117138','1960s'

		
    /* 4. What is the current average salary for each of the following department 
    groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */ 
    SELECT 
		AVG(salaries.salary) AS avg_salary,
        CASE
			WHEN dept_name IN ('research', 'development') THEN 'R&D'
        END AS departments.dept_name AS department
	FROM employees
    WHERE dept_emp.to_date > now()
	JOIN salaries USING(emp_no)
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
        
    