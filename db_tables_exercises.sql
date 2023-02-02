-- Welcome to MySQL!
-- Two --'s represent a single line comment
/*this
is
how
we do a multi-line commentt */
/* Yes */

SHOW DATABASES;
SHOW CREATE DATABASE chipotle;
USE chipotle;
SHOW TABLES;
USE orders;
SHOW TABLES;
SHOW CREATE TABLE orders;
SELECT DATABASE();
DESCRIBE orders;
USE fruits_db;
SHOW TABLES;
SHOW CREATE TABLE fruits;
DESCRIBE fruits;
SELECT id FROM fruits;
SELECT 1+1;
SELECT 1+1 FROM fruits;
SELECT id, 1+1 FROM fruits;
USE orders;
SHOW DATABASES;
SHOW CREATE DATABASE chipotle;
USE chipotle;
SHOW TABLES;
DESCRIBE orders;
SELECT 1+1;
DESCRIBE orders;
SELECT id, id + 1 FROM orders;
SELECT id, id + 1 AS 'additive_id' FROM orders;
DESCRIBE fruits;
SHOW DATABASES;
USE fruits_db;
CREATE TABLE fruits_db;

-- BREAK LINE FROM CLASS TUTORIAL

SHOW DATABASES;
USE employees;
SHOW TABLES;
DESCRIBE departments;
DESCRIBE dept_no;
DESCRIBE departments;
SHOW TABLES;
DESCRIBE dept_emp;
SHOW DATABASES;
USE employees;
SHOW TABLES;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
/* Q: 6. Which table(s) do you think contain a numeric type column?
   A: In departments -> NONE
   A: In dept_emp -> emp_no
   A: In dept_manager -> emp_no
   A: In employees -> emp_no
   A: In salaries -> emp_no, salary
   A: In titles -> emp_no
   
   Q: 7. Which table(s) do you think contain a string type column?
   A: In departments ->  dept_no, dept_name
   A: In dept_emp -> dept_no
   A: In dept_manager -> dept_no
   A: In employees -> first_name, last_name, gender
   A: In salaries -> NONE
   A: In titles -> title
   
   Q: 8. Which table(s) do you think contain a date type column?
   A: In departments -> NONE
   A: In dept_emp -> from_date, to_date
   A: In dept_manager -> from_date, to_date
   A: In employees -> birth_date, hire_date
   A: In salaries -> from_date, to_date
   A: In titles -> from_date, to_date
   
   Q: 9. What is the relationship between the employees and the departments tables?
   A: There doesn't appear to be a direct relationship between the two;
   however, establishing the 'emp_no' from the 'employees' table can be
   referenced into 'dept_emp' and 'dept_manager' to establish a link
   between the 'emp_no' and 'dept_no'
   
   Q: 10. Show the SQL that created the dept_manager table.
   A: LINE1 -> SHOW DATABASE;
	  LINE2 -> USE employees;
      LINE3 -> SHOW TABLES;
      LINE4 -> DESCRIBE dept_manager

END OF EXERCISE*/

USE fruits_db;
SELECT * FROM employees.employees;
-- Selects ALL from 'employees.employees REGARDLESS of current database
-- The 'employees.employees' is similar to CLI 'employees/employees'
SELECT * FROM fruits WHERE name = 'apple';
-- Selects ALL from 'fruits' where the NAME MATCHES 'apple'
SELECT * FROM fruits WHERE name LIKE '%apple';
-- Selects ALL from 'fruits' where the NAME HAS 'apple'
SELECT * FROM fruits WHERE name IN('apple', 'dragonfruit');