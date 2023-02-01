-- Exercise Start --

-- Join Example Database Exercises Start --

-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
SHOW DATABASES;
USE join_example_db;
SELECT * FROM roles LIMIT 10;
SELECT * FROM users LIMIT 10;
SELECT *
	FROM users JOIN roles;
SELECT * FROM users LEFT JOIN roles ON users.role_id = roles.id;
SELECT * FROM users, roles;

/* 2. Use join, left join, and right join to combine results from the
users and roles tables as we did in the lesson.
Before you run each query, guess the expected number of results. */
SELECT * FROM users JOIN roles; -- Combines all columns without restrictions
SELECT * FROM users LEFT JOIN roles ON users.id = roles.id; -- users.role_id has nulls
SELECT * FROM users RIGHT JOIN roles ON roles.id = users.id; -- Error users.role_id has no nulls

/* 3. Although not explicitly covered in the lesson, aggregate functions like count
can be used with join queries. Use count and the appropriate join type to get a list
of roles along with the number of users that has the role. Hint: You will also need
to use group by in the query. */
SELECT roles.name, COUNT(users.name) AS total_users
	FROM users JOIN roles ON users.role_id = roles.id
    GROUP BY roles.name;

-- Join Example Database Exercises End --

-- Employees Database Exercises Start --

-- 1. Use the employees database.
SHOW DATABASES;
USE employees;

/* 2. Using the example in the Associative Table Joins section as a guide, write a query
that shows each department along with the name of the current manager for that department. */
SHOW TABLES;
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM employees LIMIT 10; -- dept_no and emp_no
SELECT departments.dept_name AS department_name, CONCAT(employees.first_name, ' ', employees.last_name) AS department_manager
	FROM departments 
		JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
        JOIN employees ON employees.emp_no = dept_manager.emp_no
	WHERE dept_manager.to_date = '9999-01-01';

-- 3. Find the name of all departments currently managed by women.
SHOW TABLES;
SELECT * FROM employees LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM departments; -- dept_no and emp_no
	SELECT departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS manager, employees.gender
	FROM departments
		JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
        JOIN employees ON employees.emp_no = dept_manager.emp_no
	WHERE employees.gender = 'F' AND dept_manager.to_date = '9999-01-01';

-- 4. Find the current titles of employees currently working in the Customer Service department.
SHOW TABLES;
SELECT * FROM employees LIMIT 10;
SELECT * FROM titles LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM departments LIMIT 10;
SELECT titles.title AS Title, COUNT(titles.emp_no) AS Count
	FROM titles
		JOIN dept_emp ON dept_emp.emp_no = titles.emp_no
        JOIN departments ON departments.dept_no = dept_emp.dept_no
	WHERE departments.dept_name = 'Customer Service' AND titles.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01'
    GROUP BY titles.title;

-- 5. Find the current salary of all current managers.
SHOW TABLES;
/* departments (dept_no, dept_name),
dept_manager (emp_no, dept_no, to_date), 
employees (emp_no, first_name, last_name),
salaries (emp_no, to_date) */
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SHOW TABLES;
SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) AS Name, salaries.salary AS Salary
	FROM departments
		JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
        JOIN employees ON employees.emp_no = dept_manager.emp_no
        JOIN salaries ON salaries.emp_no = employees.emp_no
	WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';

-- 6. Find the number of current employees in each department.
SHOW TABLES;
/*
departments (dept_no, dept_name),
dept_emp (dept_no, emp_no, to_date),
*/
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT departments.dept_no, departments.dept_name, COUNT(emp_no)
	FROM departments
		JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
	WHERE dept_emp.to_date = '9999-01-01'
    GROUP BY departments.dept_no, departments.dept_name
    ORDER BY departments.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SHOW TABLES;
/*
departments(dept_no, dept_name)
dept_emp(dept_no, emp_no)
salaries(emp_no, salaries, to_date)
*/
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT departments.dept_name, AVG(salaries.salary) AS avg_salary
	FROM departments
		JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
        JOIN salaries ON salaries.emp_no = dept_emp.emp_no
	WHERE salaries.to_date = '9999-1-01' AND dept_emp.to_date = '9999-01-01'
    GROUP BY departments.dept_name
    ORDER BY avg_salary DESC
    LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SHOW TABLES;
/*
departments(dept_no, dept_name)
dept_emp(emp_no, dept_no, to_date)
salaries(emp_no, salary, to_date)
employees(emp_no, first_name, last_name)
*/
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, salaries.salary, departments.dept_name
	FROM employees
		JOIN salaries ON salaries.emp_no = employees.emp_no
        JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
        JOIN departments ON departments.dept_no = dept_emp.dept_no
	WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01' AND departments.dept_name = 'Marketing'
    ORDER BY salaries.salary DESC
    LIMIT 1;

-- 9. Which current department manager has the highest salary?
SHOW TABLES;
/*
departments (dept_no, dept_name)
employees(emp_no, first_name, last_name, to_date)
salaries(emp_no, salary, to_date)
dept_manager (emp_no, dept_no)
*/
SELECT * FROM departments LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, salaries.salary AS salary, departments.dept_name as department
	FROM departments
		JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
        JOIN employees ON employees.emp_no = dept_manager.emp_no
        JOIN salaries ON salaries.emp_no = employees.emp_no
	WHERE
		dept_manager.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01'
        AND departments.dept_name = 'Marketing'
    GROUP BY
		department, name, salary;

-- 10. Determine the average salary for each department. Use all salary information and round your results.
SHOW TABLES;
/*
departments(dept_name, dept_no)
dept_emp(dept_no, emp_no)
salaries(emp_no, salary)
*/
SELECT * FROM departments LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT
	departments.dept_name AS department, ROUND(AVG(salaries.salary)) AS average_salary
FROM
	departments
		JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
        JOIN salaries ON salaries.emp_no = dept_emp.emp_no
GROUP BY
	department
ORDER BY
	average_salary DESC;

-- EXERCISE END --

/*

BREAK LINE FROM EXERCISE TO BONUS EXERCISE

*/

-- BONUS EXERCISE START --

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
SHOW TABLES;
/*
employees(emp_no, first_name, last_name)
dept_emp(emp_no, dept_no, to_date)
departments(dept_no, dept_name)
dept_manager(dept_no, to_date)
*/
DESCRIBE employees;
DESCRIBE dept_emp;
DESCRIBE departments;
DESCRIBE dept_manager;
-- NAME OF CURRENT MANAGER BY DEPARTMENT NAME QUERY
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS dept_name
	FROM employees
		JOIN dept_manager USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE dept_manager.to_date = '9999-01-01';
-- NAME OF CURRENT EMPLOYEES BY DEPARTMENT NAME QUERY
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS dept_name
	FROM employees
		JOIN dept_emp USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE dept_emp.to_date = '9999-01-01';
-- NAME OF CURRENT EMPLOYEES & MANAGERS BY DEPARTMENT NAME QUERY
SELECT B.name AS current_employee_name, A.name AS current_manager_name, A.dept_name AS dept_name
	FROM
		(SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS dept_name
			FROM employees
				JOIN dept_manager USING(emp_no)
				JOIN departments USING(dept_no)
			WHERE dept_manager.to_date = '9999-01-01') AS A
	JOIN
		(SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS dept_name
			FROM employees
				JOIN dept_emp USING(emp_no)
				JOIN departments USING(dept_no)
			WHERE dept_emp.to_date = '9999-01-01') AS B
		USING(dept_name)
        LIMIT 100;
        
-- 12. Bonus Who is the highest paid employee within each department.
SHOW TABLES;
/*
employees(emp_no, first_name, last_name)
dept_emp(emp_no, dept_no, to_date)
departments(dept_no, dept_name)
salaries(emp_no, salary, to_date)
*/
DESCRIBE employees;
DESCRIBE dept_emp;
DESCRIBE departments;
DESCRIBE salaries;
-- NAME OF CURRENT EMPLOYEE BY DEPARTMENT NAME
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS dept_name
	FROM employees
		JOIN dept_emp USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE dept_emp.to_date = '9999-01-01';
-- HIGHEST CURRENT SALARY BY DEPARTMENT NAME
SELECT MAX(salaries.salary) AS salary, departments.dept_name AS dept_name
	FROM salaries
		JOIN dept_emp USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE salaries.to_date = '9999-01-01'
	GROUP BY departments.dept_name;
-- CURRENT EMPLOYEE & HIGHEST CURRENT SALARY BY DEPARTMENT NAME
SELECT A.name AS current_employee_name, B.salary AS current_salary, B.dept_name AS dept_name
	FROM 
		(SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS name, departments.dept_name AS dept_name
			FROM employees
				JOIN dept_emp USING(emp_no)
				JOIN departments USING(dept_no)
			WHERE dept_emp.to_date = '9999-01-01') AS A
		JOIN
			(SELECT MAX(salaries.salary) AS salary, departments.dept_name AS dept_name
				FROM salaries
					JOIN dept_emp USING(emp_no)
					JOIN departments USING(dept_no)
				WHERE salaries.to_date = '9999-01-01'
				GROUP BY departments.dept_name) AS B
		GROUP BY B.dept_name, B.salary;

-- BONUS EXERCISE END --