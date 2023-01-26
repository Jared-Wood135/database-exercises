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