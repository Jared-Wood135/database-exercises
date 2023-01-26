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

-- BREAK LINE FROM INSTRUCTION PORTION TO EXERCISE PORTION --

-- Exercise 2
SHOW DATABASES;
USE employees;
SELECT concat(first_name, last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E';

-- Exercise 3
SELECT concat(UPPER(first_name), UPPER(last_name)) AS full_name FROM employees WHERE last_name LIKE 'E%E';

-- Exercise 4
SELECT concat(first_name, last_name) AS Employee_Name, datediff((hire_date LIKE '199%' AND birth_date LIKE '%12-25'), CURDATE()) FROM employees;

-- Exercise 5
SELECT min(salaries) AS Smallest_Salaries, max(salaries) AS Largest_Salaries FROM employees;

-- Exercise 6
SELECT concat(substr(lower(first_name), 1, 1), (substr(lower(last_name), 1, 4), '_', (substr(birth_date), 6, 2), (substr(birth_date), 3, 2)-- AS username

/*

START EXERCISES

2. 