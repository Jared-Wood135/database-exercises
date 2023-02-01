-- EXERCISE START --

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
SHOW DATABASES;
USE employees;
SHOW TABLES;
/*
employees(emp_no, hire_date)
dept_emp(emp_no, to_date)
*/
SELECT * FROM employees LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT employees.emp_no AS emp_no, CONCAT(employees.first_name, ' ', employees.last_name) AS name, 
	employees.hire_date AS hire_date, dept_emp.to_date AS to_date
	FROM employees
		JOIN dept_emp USING(emp_no)
    WHERE hire_date =
		(SELECT hire_date
			FROM employees
            WHERE emp_no = 101010)
		AND to_date = '9999-01-01'
	ORDER BY emp_no;

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SHOW TABLES;
/*
employees(emp_no, first_name, last_name)
dept_emp(emp_no, to_date)
titles(emp_no, title)
*/
DESCRIBE employees;
DESCRIBE dept_emp;
DESCRIBE titles;
-- CURRENT EMPLOYEES WITH FIRST NAME 'Aamod'
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, employees.emp_no
	FROM employees
		JOIN dept_emp USING(emp_no)
	WHERE employees.first_name = 'Aamod'
		AND dept_emp.to_date = '9999-01-01'
    ORDER BY name;
-- CURRENT EMPLOYEES WITH ALL TITLES WITH FIRST NAME 'Aamod'
SELECT A.name AS name, titles.title AS title
	FROM
		(SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, employees.emp_no
			FROM employees
				JOIN dept_emp USING(emp_no)
			WHERE employees.first_name = 'Aamod'
				AND dept_emp.to_date = '9999-01-01'
			ORDER BY name) AS A
	JOIN titles USING(emp_no)
    ORDER BY name;
-- CONFIRMATION QUERY
SELECT CONCAT(employees.first_name, ' ', employees.last_name), titles.title AS title, titles.to_date AS title_date, dept_emp.to_date AS emp_date
	FROM employees
		JOIN titles USING(emp_no)
        JOIN dept_emp USING(emp_no)
	WHERE (employees.first_name = 'Aamod' AND employees.last_name = 'Albarhamtoshy')
		OR (employees.first_name = 'Aamod' AND employees.last_name = 'Andreotta');

/* 3. How many people in the employees table are no longer working for the company? 
Give the answer in a comment in your code.*/
-- 91479 employees no longer working at the company
SHOW TABLES;
SELECT COUNT(*)
	FROM dept_emp; -- 331603 TOTAL
SELECT COUNT(*)
	FROM dept_emp
	WHERE to_date = '9999-01-01'; -- 240124 CURRENT
	
SELECT COUNT(*) AS not_employed_total
	FROM dept_emp
    WHERE to_date != '9999-01-01'; -- 91479 LEFT

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
-- Hilary Kambil, Isamu Legleitner, Karsten Sigstam, Leon DasSarma
SHOW TABLES;
DESCRIBE departments;
DESCRIBE dept_manager;
DESCRIBE employees;
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS department, employees.gender AS gender
	FROM employees
		JOIN dept_manager USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE dept_manager.to_date = '9999-01-01'
		AND employees.gender = 'F'
	ORDER BY name;

/*5. Find all the employees who currently have a higher salary than the companies overall, 
historical average salary.*/
SHOW TABLES;
/*
employees(emp_no, first_name, last_name)
salaries(emp_no, salary, to_date)
*/
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, salaries.salary AS salary
	FROM employees
		JOIN salaries USING(emp_no)
        JOIN dept_emp USING(emp_no)
	WHERE salary > 
		(SELECT AVG(salary)
			FROM salaries
            WHERE to_date != '9999-01-01')
		AND salaries.to_date = '9999-01-01'
		AND dept_emp.to_date = '9999-01-01'
	ORDER BY salary;

/*6. How many current salaries are within 1 standard deviation of the current highest salary?
What percentage of all salaries is this?*/
-- GET STDDEV OF CURRENT SALARIES
SELECT STDDEV(salary)
FROM salaries
WHERE to_date = '9999-01-01';
-- GET HIGHEST SALARY
SELECT MAX(salary)
FROM salaries
WHERE to_date = '9999-01-01';
-- COUNT OF SALARIES WITHIN 1 STDDEV OF MAX SALARY
SELECT COUNT(*)
	FROM salaries
	WHERE salary >=
		(SELECT MAX(salary)
			FROM salaries
			WHERE to_date = '9999-01-01') -
				(SELECT STDDEV(salary)
					FROM salaries
					WHERE to_date = '9999-01-01')
/*		AND
        (SELECT MAX(salary)
			FROM salaries
			WHERE to_date = '9999-01-01') +
				(SELECT STDDEV(salary)
					FROM salaries
					WHERE to_date = '9999-01-01')*/
	AND to_date = '9999-01-01';
-- PERCENT OF ABOVE SALARIES COMPARED TO ALL SALARIES .03%
SELECT
	(SELECT COUNT(*)
	FROM salaries
	WHERE salary >=
		(SELECT MAX(salary)
			FROM salaries
			WHERE to_date = '9999-01-01') -
				(SELECT STDDEV(salary)
					FROM salaries
					WHERE to_date = '9999-01-01')
		AND to_date = '9999-01-01')
	/
	(SELECT COUNT(*)
		FROM salaries
        WHERE to_date = '9999-01-01');

-- EXERCISE END --

/*

BREAK LINE FROM EXERCISE TO BONUS EXERCISE

*/

-- BONUS EXERCISE START --

-- 1. Find all the department names that currently have female managers.

-- 2. Find the first and last name of the employee with the highest salary.

-- 3. Find the department name that the employee with the highest salary works in.


-- BONUS EXERCISE END --
