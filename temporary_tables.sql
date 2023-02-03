SHOW DATABASES;
USE oneil_2098;
CREATE TEMPORARY TABLE yeetus(
	deleteus varchar(10));
INSERT INTO yeetus(deleteus) VALUES ('ya'), ('yeet');
SHOW TABLES;
-- EXERCISE START --

/* 1. Using the example from the lesson, create a temporary table called employees_with_departments
that contains first_name, last_name, and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
it means that the query was attempting to write a new table to a database that you can only read.*/
DESCRIBE employees.departments;
-- Creates a completely combined 3 tables
CREATE TEMPORARY TABLE employees_with_departments AS
	SELECT *
		FROM employees.employees
			JOIN employees.dept_emp USING(emp_no)
            JOIN employees.departments USING(dept_no);
-- Creates a table with specific columns (emp_w_dept)
CREATE TEMPORARY TABLE emp_w_dept AS
	SELECT employees.employees.first_name, employees.employees.last_name, employees.departments.dept_name
		FROM employees.employees
			JOIN employees.dept_emp USING(emp_no)
            JOIN employees.departments USING(dept_no);
SELECT * FROM emp_w_dept LIMIT 100;
-- Drops unwanted columns
DESCRIBE employees_with_departments;
ALTER TABLE employees_with_departments
	DROP dept_no,
	DROP emp_no,
	DROP birth_date,
	DROP gender,
	DROP hire_date,
	DROP from_date,
	DROP to_date;
DESCRIBE employees_with_departments;

/* 1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum 
of the lengths of the first name and last name columns.*/
ALTER TABLE employees_with_departments
	ADD full_name VARCHAR(100);

-- 1b. Update the table so that full name column contains the correct data
SET SQL_SAFE_UPDATES = 0;
UPDATE employees_with_departments
	SET full_name = CONCAT(first_name, ' ', last_name);

-- 1c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments
	DROP first_name,
    DROP last_name;

-- 1d. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE alternate AS
	SELECT CONCAT(employees.employees.first_name, ' ', employees.employees.last_name) AS full_name, employees.departments.dept_name AS department
		FROM employees.employees
			JOIN employees.dept_emp USING(emp_no)
            JOIN employees.departments USING(dept_no);
SELECT * FROM alternate ORDER BY full_name LIMIT 100;

/* 2. Create a temporary table based on the payment table from the sakila database.  
Write the SQL necessary to transform the amount column such that it is stored as an integer 
representing the number of cents of the payment. For example, 1.99 should become 199.*/
USE sakila;
SELECT * FROM payment LIMIT 10;
USE oneil_2098;
CREATE TEMPORARY TABLE payment_temp AS
	SELECT ROUND(sakila.payment.amount * 100) AS cost_in_cents
		FROM sakila.payment;
SELECT * FROM payment_temp;

/* 3. Find out how the current average pay in each department compares to the overall current pay 
for everyone at the company. In order to make the comparison easier, you should use the Z-score 
for salaries. In terms of salary, what is the best department right now to work for? The worst?*/
/*
BEST SALARY: Sales - 88842.16
WORST SALARY: HR - 63795.02
BEST Z-SCORE: Production - 0.24
WORST Z-SCORE: Sales - 0.97
*/
-- TEMP TABLE 1: crt_avg_pay_by_dept (dept_name, avg_pay)
-- TEMP TABLE 2: crt_avg_pay (avg_pay)
-- TEMP TABLE 3: stddev_crt_pay (stddev)
-- TEMP 1 Good:
CREATE TEMPORARY TABLE crt_avg_pay_by_dept AS
	SELECT employees.departments.dept_name AS dept_name, ROUND(AVG(employees.salaries.salary), 2) AS avg_pay
		FROM employees.employees
			JOIN employees.dept_emp USING(emp_no)
            JOIN employees.departments USING(dept_no)
            JOIN employees.salaries USING(emp_no)
		WHERE employees.salaries.to_date >= NOW()
        GROUP BY dept_name;
SELECT * FROM crt_avg_pay_by_dept;
DROP TABLE crt_avg_pay_by_dept;
-- TEMP 2 GOOD:
CREATE TEMPORARY TABLE crt_avg_pay AS
	SELECT ROUND(AVG(employees.salaries.salary), 2) AS avg_pay
    FROM employees.salaries
		JOIN employees.dept_emp USING(emp_no)
	WHERE employees.salaries.to_date >= NOW()
		AND employees.dept_emp.to_date >= NOW();
SELECT * FROM crt_avg_pay;
DROP TABLE crt_avg_pay;
-- TEMP 3 GOOD:
CREATE TEMPORARY TABLE stddev_crt_pay AS
	SELECT ROUND(STDDEV(employees.salaries.salary), 2) AS stddev
    FROM employees.salaries
		JOIN employees.dept_emp USING(emp_no)
	WHERE employees.salaries.to_date >= NOW()
		AND employees.dept_emp.to_date >= NOW();
SELECT * FROM stddev_crt_pay;
DROP TABLE stddev_crt_pay;
-- COMPARISON OF STDDEV BY DEPARTMENT
SELECT
	crt_avg_pay_by_dept.dept_name AS department,
    crt_avg_pay_by_dept.avg_pay AS avg_pay_by_dept,
    ROUND((ABS(crt_avg_pay.avg_pay - crt_avg_pay_by_dept.avg_pay) / stddev_crt_pay.stddev), 2) AS z_score,
    crt_avg_pay.avg_pay AS overall_avg_pay,
    stddev_crt_pay.stddev AS stddev_pay
FROM
	crt_avg_pay_by_dept,
    crt_avg_pay,
    stddev_crt_pay
ORDER BY z_score;

/* 4. Hint Consider that the following code will produce the z score for current salaries.
-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

-- MY RESPONSE TO QUESTION 4: "I do not believe this is an answerable question besides being a hint"

-- END EXERCISE --

/*
======================================================================================================================
BREAK LINE FROM EXERCISE TO BONUS EXERCISE
======================================================================================================================
*/

-- BONUS EXERCISE START --

/* To your work with current salary zscores, determine the overall historic average departement 
average salary, the historic overall average, and the historic zscores for salary. Do the zscores 
for current department average salaries tell a similar or a different story than the historic 
department salary zscores?*/
-- Z-SCORE OF OVERALL CURRENT
CREATE TEMPORARY TABLE crt_z_score AS
SELECT
	crt_avg_pay_by_dept.dept_name AS department,
    crt_avg_pay_by_dept.avg_pay AS avg_pay_by_dept,
    ROUND((ABS(crt_avg_pay.avg_pay - crt_avg_pay_by_dept.avg_pay) / stddev_crt_pay.stddev), 2) AS z_score,
    crt_avg_pay.avg_pay AS overall_avg_pay,
    stddev_crt_pay.stddev AS stddev_pay
FROM
	crt_avg_pay_by_dept,
    crt_avg_pay,
    stddev_crt_pay
ORDER BY z_score;
SELECT * FROM crt_z_score;
-- Z-SCORE OF ALL (PAST & CURRENT)
CREATE TEMPORARY TABLE all_z_score AS
SELECT
	crt_avg_pay_by_dept.dept_name AS department,
    crt_avg_pay_by_dept.avg_pay AS avg_pay_by_dept,
    ROUND((ABS(avg_all_salaries.avg_all_salary - crt_avg_pay_by_dept.avg_pay) / stddev_crt_pay.stddev), 2) AS z_score,
    avg_all_salaries.avg_all_salary AS avg_all_salary,
    stddev_crt_pay.stddev AS stddev_pay
FROM
	crt_avg_pay_by_dept,
    avg_all_salaries,
    stddev_crt_pay
ORDER BY z_score;
SELECT * FROM all_z_score;
-- TEMP TABLE OF ALL SALARIES
CREATE TEMPORARY TABLE avg_all_salaries AS
	SELECT ROUND(AVG(employees.salaries.salary), 2) AS avg_all_salary
    FROM employees.salaries;
SELECT * FROM avg_all_salaries;
-- SHOW Z-SCORE OF CURRENT AND ALL SALARIES BY DEPARTMENT NAME
SELECT
	crt_z_score.department AS department,
    crt_z_score.z_score AS z_score_of_current_salary,
    all_z_score.z_score AS z_score_of_all_salaries
FROM
	crt_z_score
		JOIN all_z_score USING(department)
ORDER BY department;
/*
The z-score of current and all salaries tell very different stories for most departments.
The only exceptions are the departments "Development", "Production", and "Research" with at most a .03 difference in z-score.
Otherwise, there seems to be no correlation of department's current z-scores always being less or more than the z-score of all salaries.
Z-scores of current salaries have a range of .73 starting at .24 - .97.
Z-scores of all salaries have a range of 1.45 starting at 0 - 1.45.
In summary, no similarity can be made by looking at these two sets of z-scores.

-- BONUS EXERCISE END --