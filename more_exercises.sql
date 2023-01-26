-- MORE DRILLS WITH THE SAKILA DATABASE
-- 1. SELECT statements
SHOW DATABASES;
USE sakila;
SHOW TABLES;
SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT film_id, title, release_year FROM film;

-- 2. DISTINCT operator
SELECT DISTINCT last_name FROM actor;
SELECT * FROM address LIMIT 1;
SELECT DISTINCT postal_code FROM address;
SELECT * FROM film LIMIT 1;
SELECT DISTINCT rating FROM film;

-- 3. WHERE clause
SELECT * FROM film LIMIT 1;
SELECT title, description, rating, length FROM film WHERE length >= 180;
SHOW TABLES;
SELECT * FROM payment LIMIT 1;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27 00:00:00';
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27 00:00:00';
SELECT * FROM customer LIMIT 5;
SELECT * FROM customer WHERE last_name LIKE 'S%' AND first_name LIKE '%N';
SELECT * FROM customer WHERE active = FALSE AND last_name LIKE 'M%';
SELECT * FROM category LIMIT 5;
SELECT * FROM category WHERE category_id > 4 AND name IN ('C', 'S', 'T');
SELECT * FROM staff LIMIT 5;
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NOT NULL;
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NULL;

-- IN operator
SELECT * FROM address LIMIT 100;
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');
SELECT * FROM payment LIMIT 5;
SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');