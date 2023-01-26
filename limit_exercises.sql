SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM employees LIMIT 5;
SELECT DISTINCT title FROM titles;
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date >= '1990-01-01' AND hire_date <= '1999-12-31' AND hire_date LIKE '%12-31%' ORDER BY hire_date LIMIT 5;
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date >= '1990-01-01' AND hire_date <= '1999-12-31' AND hire_date LIKE '%12-31%' ORDER BY hire_date LIMIT 5 OFFSET 45;
/*

START EXERCISE

2. "Zykh", "Zyda", "Zwicker", "Zweizig", "Zumaque", "Zultner", "Zucker", "Zuberek", "Zschoche", "Zongker"
3. "Dipayan Hennebert", "Mohammad Zallocco", "Supot Aingworth", "Kwangyoen Sabnani", "Froduald Koshino"
4. "Serge Thombley", "Nobuyoshi Vrecion", "Sahrah Roccetti", "Persi SChlumberger", "Yolla Ratnaker"

END EXERCISE

*/