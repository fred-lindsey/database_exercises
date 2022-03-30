use employees; -- use this DB
show tables; -- reveals all tables in DB
describe employees; -- reveals field, type, null, key, default columns
describe titles;
describe salaries;
describe dept_manager;
describe dept_emp;
describe departments;
-- which tables have numeric columns: all tables, except departments
-- which tables contain strings: all
-- which tables contain date: salaries, employees, titles, dept_emp, dept_manager
-- what is the relationship between employees and departments tables: neither allow null values
-- what is the code that created the dept_manager table:

show tables;
show create table dept_manager;
-- SELECT * FROM information_schema.columns WHERE table_schema = 'employees';
