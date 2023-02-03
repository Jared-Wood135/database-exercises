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
	CASE
		WHEN SUBSTR(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN SUBSTR(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        WHEN SUBSTR(last_name, 1, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
		ELSE 'Not a name'
	END AS alpha_group
    FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
SELECT * FROM employees ORDER BY birth_date LIMIT 10;
DESCRIBE employees;
SELECT
	COUNT(CASE WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN birth_date ELSE NULL END) AS 'employees_from_1950',
    COUNT(CASE WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN birth_date ELSE NULL END) AS 'employees_from_1960s'
		FROM employees;    

/* 4. What is the current average salary for each of the following department groups: R&D, 
Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/
SELECT * FROM salaries LIMIT 10; -- (emp_no, salary, to_date)
SELECT * FROM dept_emp LIMIT 10; -- (emp_no, dept_no)
SELECT * FROM departments; -- (dept_no, dept_name)
SELECT
	AVG(CASE WHEN departments.dept_name = 'Research' OR departments.dept_name = 'Development' 
		THEN salaries.salary ELSE NULL END) 
        AS 'R & D avg_salary',
    AVG(CASE WHEN departments.dept_name = 'Sales' OR departments.dept_name = 'Marketing'
		THEN salaries.salary ELSE NULL END)
		AS 'Sales & Marketing avg_salary',
	AVG(CASE WHEN departments.dept_name = 'Production' OR departments.dept_name = 'Quality Management'
		THEN salaries.salary ELSE NULL END)
        AS 'Prod & QM avg_salary',
	AVG(CASE WHEN departments.dept_name = 'Finance' OR departments.dept_name = 'Human Resources'
		THEN salaries.salary ELSE NULL END)
		AS 'Finanace & HR avg_salary',
	AVG(CASE WHEN departments.dept_name = 'Customer Service'
		THEN salaries.salary ELSE NULL END)
        AS 'Customer Service avg_salary'
	FROM departments
		JOIN dept_emp USING(dept_no)
        JOIN salaries USING(emp_no)
	WHERE salaries.to_date >= NOW();

-- EXERCISE END --