-- JOINS Notes
/* JOIN/Inner JOIN, LEFT JOIN, RIGHT JOIN
		TYPES
		ONE to MANY - many rows on one table become single row on another table
			one employee : many salaries (over time)
        MANY to MANY - many on one are assc with many on another
			departments : employees (employees have worked for many depts, 
            depts have had/have many employees)
	
    SYNTAX:
    SELECT columns
    FROM table_a AS A 		<< table a is the left table
    JOIN table_b AS B ON A.id = B.fk_id		<< table b is the right table
    
    INNER JOIN
SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id;

	LEFT JOIN
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

	RIGHT JOIN
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

