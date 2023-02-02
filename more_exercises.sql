-- MORE DRILLS WITH THE SAKILA DATABASE --

-- 1ST SET OF QUESTIONS (9) START --

-- 1. SELECT statements --

-- 1a. Select all columns from the actor table.
SHOW DATABASES;
USE sakila;
SHOW TABLES;
SELECT * FROM actor;

-- 1b. Select only the last_name column from the actor table.
SELECT last_name FROM actor;

-- 1c. Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year FROM film;

-- 2. DISTINCT operator --

-- 2a. Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name FROM actor;

-- 2b. Select all distinct (different) postal codes from the address table.
SELECT * FROM address LIMIT 1;
SELECT DISTINCT postal_code FROM address;

-- 2c. Select all distinct (different) ratings from the film table.
SELECT * FROM film LIMIT 1;
SELECT DISTINCT rating FROM film;

-- 3. WHERE clause --

-- 3a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT * FROM film LIMIT 1;
SELECT title, description, rating, length FROM film WHERE length >= 180;

/* 3b. Select the payment id, amount, and payment date columns from the payments table for payments made on or 
after 05/27/2005.*/
SHOW TABLES;
SELECT * FROM payment LIMIT 1;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27 00:00:00';

/* 3c. Select the primary key, amount, and payment date columns from the payment table for payments made on 
05/27/2005.*/
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date = '2005-05-27 00:00:00';

/* 3d. Select all columns from the customer table for rows that have a last names beginning with S and a 
first names ending with N.*/
SELECT * FROM customer LIMIT 5;
SELECT * FROM customer WHERE last_name LIKE 'S%' AND first_name LIKE '%N';

/* 3e. Select all columns from the customer table for rows where the customer is inactive or has a 
last name beginning with "M".*/
SELECT * FROM customer WHERE active = FALSE AND last_name LIKE 'M%';

/* 3f. Select all columns from the category table for rows where the primary key is greater than 4 
and the name field begins with either C, S or T.*/
SELECT * FROM category LIMIT 5;
SELECT * FROM category WHERE category_id > 4 AND name IN ('C', 'S', 'T');

-- 3g. Select all columns minus the password column from the staff table for rows that contain a password.
SELECT * FROM staff LIMIT 5;
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NOT NULL;

-- 3h. Select all columns minus the password column from the staff table for rows that do not contain a password.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NULL;

-- IN operator -- 

/* 4a. Select the phone and district columns from the address table for addresses in California, England, 
Taipei, or West Java.*/
SELECT * FROM address LIMIT 100;
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');

/* 4b. Select the payment id, amount, and payment date columns from the payment table for payments made on 
05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND 
operator as in previous exercises.)*/
SELECT * FROM payment LIMIT 5;
SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

-- 4c. Select all columns from the film table for films rated G, PG-13 or NC-17.
SHOW DATABASES;
USE sakila;
SHOW TABLES;
SELECT * FROM film LIMIT 10;
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

-- BETWEEN operator --

/* 5a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second 
before midnight 05/26/2005.*/
SELECT * FROM payment LIMIT 10;
SELECT * FROM payment WHERE payment_date BETWEEN '2005-05-26 00:00:00' AND '2005-05-26  23:59:59';

/* 5b. Select the film_id, title, and descrition columns from the film table for films where the length of 
the description is between 100 and 120.*/
SELECT film_id, title, description from film WHERE LENGTH(description) BETWEEN 100 AND 120;

-- LIKE operator --

-- 6a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".
SELECT * FROM film WHERE description LIKE 'A Thoughtful%';

-- 6b. Select the following columns from the film table for rows where the description ends with the word "Boat".
SELECT * FROM film WHERE description LIKE '%Boat';

/* 6c. Select the following columns from the film table where the description contains the word "Database" and 
the length of the film is greater than 3 hours.*/
SELECT * FROM film WHERE description LIKE '%Database%' AND length > 180;

-- LIMIT operator --

-- 7a. Select all columns from the payment table and only include the first 20 rows.
SELECT * FROM payment LIMIT 20;

/* 7b. Select the payment date and amount columns from the payment table for rows where the payment amount 
is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.*/
SELECT payment_date, amount FROM payment WHERE amount > 5 AND payment_id BETWEEN 1000 AND 2000;

/* 7c. Select all columns from the customer table, limiting results to those where the zero-based index is 
between 101-200.*/
SELECT * FROM customer LIMIT 10;
SELECT * FROM customer WHERE customer_id BETWEEN 101 AND 200;

-- ORDER BY statement --

-- 8a. Select all columns from the film table and order rows by the length field in ascending order.
SELECT * FROM film ORDER BY length;

-- 8b. Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating FROM film ORDER BY rating DESC;

/* 8c. Select the payment date and amount columns from the payment table for the first 20 payments 
ordered by payment amount in descending order.*/
SELECT * FROM payment LIMIT 10;
SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20;

/* 8d. Select the title, description, special features, length, and rental duration columns from the 
film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental 
duration between 5 and 7 days, ordered by length in descending order.*/
SELECT title, description, special_features, length, rental_duration from film WHERE length < 120 AND rental_duration BETWEEN 5 AND 7 ORDER BY length DESC LIMIT 10;


-- JOIN statement --

/* 9a. Select customer first_name/last_name and actor first_name/last_name columns from performing a 
left join between the customer and actor column on the last_name column in each table. (i.e. 
customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 620*/
SHOW DATABASES;
USE sakila;
SHOW TABLES;
DESCRIBE customer;
DESCRIBE actor;
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_first_name_customer_last_name,
	CONCAT(actor.first_name, ' ', actor.last_name) AS actor_first_name_actor_last_name
    FROM customer
    JOIN actor
    LIMIT 100;

/* 9b. Select the customer first_name/last_name and actor first_name/last_name columns from performing 
a /right join between the customer and actor column on the last_name column in each table. (i.e. 
customer.last_name = actor.last_name)
returns correct number of records: 200*/
SHOW TABLES;
DESCRIBE customer;
DESCRIBE actor;
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_first_name_customer_last_name,
	CONCAT(actor.first_name, ' ', actor.last_name) AS actor_first_name_actor_last_name
    FROM customer
    RIGHT JOIN actor USING(last_name);


/* 9c. Select the customer first_name/last_name and actor first_name/last_name columns from performing 
an inner join between the customer and actor column on the last_name column in each table. (i.e. 
customer.last_name = actor.last_name)
returns correct number of records: 43*/

/* 9d. Select the city name and country name columns from the city table, performing a left join with 
the country table to get the country name column.
Returns correct records: 600*/

/* 9e. Select the title, description, release year, and language name columns from the film table, 
performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows*/

/* 9f. Select the first_name, last_name, address, address2, city name, district, and postal code columns 
from the staff table, performing 2 left joins with the address table then the city table to get the 
address and city related columns.
returns correct number of rows: 2*/

-- 1ST SET OF QUESTIONS (9) END --

/*

BREAK LINE FROM 1ST SET OF QUESTIONS (9) TO 2ND SET OF QUESTIONS (19)

*/