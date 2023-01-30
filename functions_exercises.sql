--  INSTRUCTION PORTION

SHOW DATABASES;
USE albums_db;
SHOW TABLES;
SELECT count(name) FROM albums;
SELECT min(release_date) AS YEET, max(release_date) AS US, round(avg(release_date), 2) AS DELETEUS FROM albums;
SELECT * FROM albums;
SELECT concat('hello', ' world', '!') AS dlrow_olleh;
SELECT concat(artist, ' -- ', name) AS artist_title, release_date  FROM albums;
SELECT substr('hello oneil class', 7, 5);
SELECT substr(release_date, 3, 2) FROM albums;
SELECT upper(artist), artist FROM albums;
SELECT lower(artist), artist FROM albums;
SELECT artist FROM albums;


-- BREAK LINE FROM INSTRUCTION PORTION TO EXERCISE PORTION --

-- Exercise 2
SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM employees LIMIT 5;
SELECT * FROM  salaries LIMIT 5;
SELECT concat(first_name, ' ', last_name) AS full_name 
	FROM employees 
    WHERE last_name LIKE 'E%E';

-- Exercise 3
SELECT concat(UPPER(first_name), ' ', UPPER(last_name)) AS full_name 
	FROM employees 
	WHERE last_name LIKE 'E%E';

-- Exercise 4
SELECT DATEDIFF(hire_date, now()) AS DAYS_EMPLOYED 
	FROM employees 
    WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25'; 

-- Exercise 5
SELECT min(salary) AS Smallest_Salary, max(salary) AS Largest_Salary 
	FROM salaries;

-- Exercise 6
SELECT LOWER(CONCAT(
				(SUBSTR(first_name, 1, 1)), 
				(SUBSTR(last_name, 1, 4)),
				'_', 
				(SUBSTR(birth_date, 6, 2)), 
				(SUBSTR(birth_date, 3, 2))
				)
			)
 AS username, first_name, last_name, birth_date
 FROM employees
 LIMIT 10;
 
 -- END EXERCISE