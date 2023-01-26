SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM employees LIMIT 5;
SELECT count(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
SELECT count(*) FROM employees WHERE first_name='Irena' OR first_name='Vidya' OR first_name='Maya';
SELECT count(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') AND gender='M';
SELECT count(*) FROM employees WHERE last_name LIKE '%E';
SELECT count(*) FROM employees WHERE last_name LIKE '%E' OR last_name LIKE 'E%';
SELECT count(*) FROM employees WHERE last_name LIKE 'E%' AND last_name NOT LIKE '%E';
SELECT count(*) FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';
SELECT count(*) FROM employees WHERE last_name LIKE 'E%'
SELECT count(*) FROM employees WHERE hire_date >= '1990-01-01' AND 
hire_date <= '1999-12-31';
SELECT count(*) FROM employees WHERE hire_date LIKE '%12-25%';
SELECT count(*) FROM employees WHERE hire_date >= '1990-01-01' AND hire_date <= '1999-12-31' AND hire_date LIKE '%12-25%';
SELECT count(*) FROM employees WHERE last_name LIKE '%q%';
SELECT count(*) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

/*
START EXERCISE

2. 709
3. 709
4. 441
5. 24292
6. 30723 // 6431
7. 899 // 7330
8. 135214
9. 789
10. 346
11. 1873
12. 547

END EXERCISE
*/

--  BREAK LINE OF where_exercises.sql TO order_by_exercises --

SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name DESC;
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name ASC, last_name ASC;
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name DESC, last_name DESC;
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name ASC, first_name ASC;
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name DESC, first_name DESC;
SELECT emp_no, first_name, last_name FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%' ORDER BY emp_no ASC;
SELECT emp_no, first_name, last_name FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%' ORDER BY emp_no DESC;
SELECT count(*) FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%' ORDER BY emp_no ASC;
SELECT count(*) FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%' ORDER BY hire_date ASC;
SELECT first_name, last_name, hire_date FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%' ORDER BY hire_date ASC;
SELECT first_name, last_name, hire_date FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%' ORDER BY hire_date DESC;
SELECT count(*) FROM employees WHERE hire_date <= '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%12-25%';
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date <= '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%12-25%' ORDER BY hire_date ASC;
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date <= '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%12-25%' ORDER BY hire_date DESC;

/*
START EXERCISE

2. "Irena Reutenauer" and "Vidya Awdeh"
3. "Irena Acton" and "Vidya Zweizig"
4. "Irena Acton" and "Maya Zyda"
5. "Total: 899", "First: 10021, Ramzi Erde", "Last: 499648, Tadahiro Erde"
6. "Total: 899", "First: Teiji Eldridge", "Last: Sergi Erde"
7. "Total: 481", "First: Alselm Cappello", "Last: Jouko Dechter"

END EXERCISE
*/