SHOW DATABASES;
USE employees;
SHOW TABLES;

-- EXERCISE START --

/* 1. Write a query that returns all employees, their department number, their start date, 
their end date, and a new column 'is_current_employee' that is a 1 if the employee is still 
with the company and 0 if not.*/
/*
employees(emp_no, first_name, last_name)
dept_emp(emp_no, dept_no, from_date, to_date)
*/
DESCRIBE employees;
DESCRIBE dept_emp;
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, dept_emp.dept_no AS dept_no,
	dept_emp.from_date AS start_date, dept_emp.to_date AS end_date,
    IF(dept_emp.to_date > NOW(), TRUE, FALSE) AS is_current_employee
    FROM employees
		JOIN dept_emp USING(emp_no)
	ORDER BY name
    LIMIT 100;

/* 2. Write a query that returns all employee names (previous and current), and a new column 
'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/
SELECT last_name,
	CASE last_name
		WHEN SUBSTR(last_name, 1, 1) LIKE 'A' THEN 'A'
		ELSE 'Not a name'
	END AS alpha_group
    FROM employees;

-- 3. How many employees (current or previous) were born in each decade?

/* 4. What is the current average salary for each of the following department groups: R&D, 
Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/

-- EXERCISE END --