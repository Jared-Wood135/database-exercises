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
SELECT customer.first_name, customer.last_name, actor.first_name, actor.last_name
	FROM customer
		INNER JOIN actor USING(last_name);

/* 9d. Select the city name and country name columns from the city table, performing a left join with 
the country table to get the country name column.
Returns correct records: 600*/
SHOW TABLES;
SELECT * FROM country LIMIT 10;
SELECT * FROM city LIMIT 10;
SELECT city.city, country.country
	FROM city
		LEFT JOIN country USING(country_id);

/* 9e. Select the title, description, release year, and language name columns from the film table, 
performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows*/
DESCRIBE film;
DESCRIBE language;
SELECT film.title, film.description, film.release_year, film.original_language_id, language.name AS language
	FROM film
		LEFT JOIN language USING(language_id);

/* 9f. Select the first_name, last_name, address, address2, city name, district, and postal code columns 
from the staff table, performing 2 left joins with the address table then the city table to get the 
address and city related columns.
returns correct number of rows: 2*/
SHOW TABLES;
DESCRIBE staff;
DESCRIBE address;
DESCRIBE city;
SELECT staff.first_name, staff.last_name, address.address, address.address2, city.city, address.district, address.postal_code
	FROM staff
		LEFT JOIN address USING(address_id)
        LEFT JOIN city USING(city_id);

-- 1ST SET OF QUESTIONS (9) END --

/*

BREAK LINE FROM 1ST SET OF QUESTIONS (9) TO 2ND SET OF QUESTIONS (19)

*/

-- 2ND SET OF QUESTIONS (19) START --

-- 1. Display the first and last names in all lowercase of all the actors.
USE sakila;
DESCRIBE actor;
SELECT LOWER(first_name), LOWER(last_name)
	FROM actor;

/* 2. You need to find the ID number, first name, and last name of an actor, of whom you know only 
the first name, "Joe." What is one query would you could use to obtain this information?*/
DESCRIBE actor;
SELECT actor_id, first_name, last_name
	FROM actor
    WHERE first_name = 'Joe';

-- 3. Find all actors whose last name contain the letters "gen":
SELECT *
	FROM actor
    WHERE last_name LIKE '%gen%';

/* 4. Find all actors whose last names contain the letters "li". This time, order the rows by 
last name and first name, in that order.*/
SELECT *
	FROM actor
    WHERE last_name LIKE '%li%'
    ORDER BY last_name, first_name;

/* 5. Using IN, display the country_id and country columns for the following countries: 
Afghanistan, Bangladesh, and China:*/
DESCRIBE country;
SELECT country_id, country
	FROM country
    WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 6. List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*)
	FROM actor
    GROUP BY last_name;

/* 7. List last names of actors and the number of actors who have that last name, but only 
for names that are shared by at least two actors*/
SELECT last_name, COUNT(*) AS occurances
	FROM actor
    GROUP BY last_name
    HAVING occurances >= 2;

-- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW DATABASES;
SHOW TABLES;
SELECT table_schema
	FROM my_codeup_connection.tables
    WHERE table_name LIKE '%address%';

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
SHOW TABLES;
SELECT * FROM staff;
DESCRIBE staff;
DESCRIBE address;
SELECT staff.first_name, staff.last_name, address.address
	FROM staff
		JOIN address USING(address_id);

-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
SHOW TABLES;
SELECT * FROM staff; -- staff_id, first_name, last_name
SELECT * FROM payment; -- staff_id, amount
SELECT CONCAT(staff.first_name, ' ', staff.last_name) as name, SUM(payment.amount) AS total
	FROM staff
		JOIN payment USING(staff_id)
	WHERE payment.payment_date LIKE '2005-08%'
    GROUP BY name;

-- 11. List each film and the number of actors who are listed for that film.
SHOW TABLES;
SELECT * FROM actor LIMIT 10; -- actor_id
SELECT * FROM film_actor LIMIT 10; -- actor_id, film_id
SELECT * FROM film LIMIT 10; -- title, film_id
SELECT film.title AS film_title, COUNT(*) AS total_actors
	FROM film
		JOIN film_actor USING(film_id)
        JOIN actor USING(actor_id)
	GROUP BY film.title;
    
-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT * FROM inventory LIMIT 10; -- film_id
SELECT * FROM film LIMIT 10; -- film_id
SELECT film.title, COUNT(*) AS total_copies
	FROM film
		JOIN inventory USING(film_id)
	WHERE film.title = 'Hunchback Impossible';

/* 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended 
consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries 
to display the titles of movies starting with the letters K and Q whose language is English.*/
SELECT * FROM film LIMIT 10;
SELECT * FROM language LIMIT 10;
SELECT film.title, language.name
	FROM film
		JOIN language USING(language_id)
	WHERE film.title LIKE 'K%' OR 'Q%'
		AND language.name = 'English';

-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT * FROM actor LIMIT 10;
SELECT * FROM film_actor LIMIT 10;
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS actor, film.title AS film
	FROM actor
		JOIN film_actor USING(actor_id)
        JOIN film USING(film_id)
	WHERE film.title =
		(SELECT title
			FROM film
            WHERE title = 'Alone Trip');

/* 15. You want to run an email marketing campaign in Canada, for which you will need the names and 
email addresses of all Canadian customers.*/
SELECT * FROM customer LIMIT 10;
SELECT * FROM customer_list LIMIT 10;
SELECT customer_list.name AS name, customer.email AS email
	FROM customer_list
		JOIN customer ON customer.customer_id = customer_list.ID;

/* 16. Sales have been lagging among young families, and you wish to target all family movies for a 
promotion. Identify all movies categorized as famiy films.*/


-- 17. Write a query to display how much business, in dollars, each store brought in.

-- 18. Write a query to display for each store its store ID, city, and country.

/* 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use 
the following tables: category, film_category, inventory, payment, and rental.)*/

-- 2ND SET OF QUESTIONS (19) END --

/*

BREAK LINE FROM 2ND SET OF QUESTIONS (19) TO 3RD SET OF QUESTIONS (7)

*/
