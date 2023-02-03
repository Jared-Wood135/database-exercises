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
UPDATE employees_with_departments
	SET full_name = CONCAT(first_name, ' ', last_name)
    WHERE 

-- 1c. Remove the first_name and last_name columns from the table.

-- 1d. What is another way you could have ended up with this same table?

/* 2. Create a temporary table based on the payment table from the sakila database.  
Write the SQL necessary to transform the amount column such that it is stored as an integer 
representing the number of cents of the payment. For example, 1.99 should become 199.*/

/* 3. Find out how the current average pay in each department compares to the overall current pay 
for everyone at the company. In order to make the comparison easier, you should use the Z-score 
for salaries. In terms of salary, what is the best department right now to work for? The worst?*/

/* 4. Hint Consider that the following code will produce the z score for current salaries.
-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;*/

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

