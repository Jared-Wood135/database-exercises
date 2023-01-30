SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM titles LIMIT 10;
SELECT COUNT(DISTINCT title) FROM titles;
SELECT * FROM employees LIMIT 10;
SELECT last_name FROM employees GROUP BY last_name ORDER BY last_name;
SELECT last_name, first_name FROM employees GROUP BY last_name, first_name HAVING last_name LIKE 'E%E';
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E' GROUP BY full_name ORDER BY full_name;
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
SELECT last_name, COUNT(*) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
SELECT first_name, gender, COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY first_name, gender ORDER BY first_name;
SELECT LOWER(CONCAT(
				(SUBSTR(first_name, 1, 1)), 
				(SUBSTR(last_name, 1, 4)),
				'_', 
				(SUBSTR(birth_date, 6, 2)), 
				(SUBSTR(birth_date, 3, 2))
				)
			)
 AS username, COUNT(*)
 FROM employees
 GROUP BY username
 HAVING COUNT(*) > 1;

SELECT SUM(occur) AS total_duplicates 
FROM
(SELECT LOWER(CONCAT(
				(SUBSTR(first_name, 1, 1)), 
				(SUBSTR(last_name, 1, 4)),
				'_', 
				(SUBSTR(birth_date, 6, 2)), 
				(SUBSTR(birth_date, 3, 2))
				)
			)
 AS username, COUNT(*) AS occur
 FROM employees
 GROUP BY username
 HAVING occur > 1) AS A;

/*

START EXERCISE

2. 7
3. SELECT last_name FROM employees GROUP BY last_name ORDER BY last_name;
4. SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E' GROUP BY full_name ORDER BY full_name;
5. "Chleq", "Lindqvist", "Qiwen"
6. "Chleq: 189", "Lindqvist: 190", "Qiwen: 168"
7. SELECT first_name, gender, COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY first_name, gender ORDER BY first_name;
8. SELECT LOWER(CONCAT(
				(SUBSTR(first_name, 1, 1)), 
				(SUBSTR(last_name, 1, 4)),
				'_', 
				(SUBSTR(birth_date, 6, 2)), 
				(SUBSTR(birth_date, 3, 2))
				)
			)
 AS username, COUNT(*)
 FROM employees
 GROUP BY username;
9. Yes, 6, 27403

END EXERCISE 

*/

-- START BONUS EXERCISES: --

-- Determine the historic average salary for each employee.
SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM salaries LIMIT 10;
SELECT * FROM employees LIMIT 10; -- Link emp_no with name and salary average
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, AVG(salary) AS avg_salary
	FROM employees NATURAL JOIN salaries 
    GROUP BY emp_no, name
    LIMIT 10;

/*  Using the dept_emp table, count how many current employees work in each department.
The query result should show 9 rows, one for each department and the employee count.  */
SHOW TABLES;
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_emp LIMIT 10; -- Link dept_no with dept_name and COUNT(emp_no) AS 1 integer
SELECT dept_name, COUNT(emp_no) AS total_employees
	FROM departments NATURAL JOIN dept_emp
    GROUP BY dept_name;

-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, COUNT(salary) AS total_different_salaries
	FROM employees NATURAL JOIN salaries
    GROUP BY emp_no, name
    LIMIT 10;

--  Find the maximum salary for each employee.
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, MAX(salary) AS highest_salary
	FROM employees NATURAL JOIN salaries
    GROUP BY emp_no, name
    LIMIT 10;

-- Find the minimum salary for each employee.
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, MIN(salary) AS lowest_salary
	FROM employees NATURAL JOIN salaries
    GROUP BY emp_no, name
    LIMIT 10;

-- Find the standard deviation of salaries for each employee.
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, STDDEV(salary) AS stddev_salary
	FROM employees NATURAL JOIN salaries
    GROUP BY emp_no, name
    ORDER BY stddev_salary
    LIMIT 10;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, MAX(salary) AS highest_salary
	FROM employees NATURAL JOIN salaries
    GROUP BY emp_no, name
    HAVING highest_salary > 150000
    ORDER BY highest_salary DESC
    LIMIT 10;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, AVG(salary) AS average_salary
	FROM employees NATURAL JOIN salaries
    GROUP BY emp_no, name
    HAVING average_salary BETWEEN 80000 AND 90000
    ORDER BY average_salary
    LIMIT 10;

-- END BONUS EXERCISES: --