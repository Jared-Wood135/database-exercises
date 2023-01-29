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

BONUS:

END EXERCISE

*/