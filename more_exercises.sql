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
======================================================================================================================
BREAK LINE FROM 1ST SET OF QUESTIONS (9) TO 2ND SET OF QUESTIONS (19)
======================================================================================================================
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
USE sakila;
SELECT * FROM film_category LIMIT 10;
SELECT * FROM film LIMIT 10;
SELECT * FROM film_list LIMIT 10;
SELECT title, category
	FROM film_list
	WHERE category = 'Family';

-- 17. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM sales_by_store LIMIT 10;
	SELECT store, total_sales AS revenue 
		FROM sales_by_store;

-- 18. Write a query to display for each store its store ID, city, and country.
SELECT * FROM store LIMIT 10; -- store_id, address_id
SELECT * FROM address LIMIT 10; -- address_id, city_id
SELECT * FROM city LIMIT 10; -- city_id, city, country_id
SELECT * FROM country LIMIT 10; -- country_id, country
SELECT store.store_id AS store_id, city.city AS city, country.country AS country
	FROM store
		JOIN address USING(address_id)
        JOIN city USING(city_id)
        JOIN country USING(country_id);

/* 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use 
the following tables: category, film_category, inventory, payment, and rental.)*/
SELECT * FROM film_category LIMIT 10; -- film_id, category_id
SELECT * FROM category LIMIT 10; -- category_id, name
SELECT * FROM inventory LIMIT 10; -- inventory_id, film_id, store_id
SELECT * FROM payment LIMIT 10; -- rental_id, amount, staff_id, customer_id, payment_id
SELECT * FROM rental LIMIT 10; -- rental_id, 
SELECT category.name AS genre, SUM(payment.amount) AS revenue
	FROM category
		JOIN film_category USING(category_id)
        JOIN inventory USING(film_id)
        JOIN rental USING(inventory_id)
        JOIN payment USING(rental_id)
	GROUP BY genre
    ORDER BY revenue DESC
    LIMIT 5;

-- 2ND SET OF QUESTIONS (19) END --

/*
======================================================================================================================
BREAK LINE FROM 2ND SET OF QUESTIONS (19) TO 3RD SET OF QUESTIONS (7)
======================================================================================================================
*/

-- 3RD SET OF QUESTIONS (7) START --

-- 1. What is the average replacement cost of a film? Does this change depending on the rating of the film?
USE sakila;
SHOW TABLES;
SELECT * FROM film LIMIT 10;
SELECT rating, ROUND(AVG(replacement_cost), 2)
	FROM film
    GROUP BY rating;

-- 2. How many different films of each genre are in the database?
SELECT * FROM film_list LIMIT 10;
SELECT DISTINCT category, COUNT(*)
	FROM film_list
    GROUP BY category;

-- 3. What are the 5 frequently rented films?
-- Bucket Brotherhood, Rocketeer Mother, Forward Temple, Grit Clockwork, Juggler Hardly
USE sakila;
SELECT * FROM rental LIMIT 10; -- rental_id, inventory_id, customer_id
SELECT * FROM payment LIMIT 10; -- customer_id, rental_id, amount
SELECT * FROM film LIMIT 10; -- film_id, title
SELECT * FROM inventory LIMIT 10;-- film_id, inventory_id, store_id
SELECT film.title AS title, COUNT(payment.rental_id) AS total_rents
	FROM film
		JOIN inventory USING(film_id)
        JOIN rental USING(inventory_id)
        JOIN payment USING(rental_id)
	GROUP BY title
    ORDER BY total_rents DESC;

-- 4. What are the most most profitable films (in terms of gross revenue)?
-- TOP 3: Telegraph Voyage($231.73), Wife Turn($223.69), Zorro Ark($214.69)
SELECT * FROM rental LIMIT 10; -- rental_id, inventory_id, customer_id
SELECT * FROM payment LIMIT 10; -- customer_id, rental_id, amount
SELECT * FROM film LIMIT 10; -- film_id, title
SELECT * FROM inventory LIMIT 10;-- film_id, inventory_id, store_id
SELECT film.title AS title, SUM(payment.amount) AS gross_revenue
	FROM film
		JOIN inventory USING(film_id)
        JOIN rental USING(inventory_id)
        JOIN payment USING(rental_id)
	GROUP BY title
    ORDER BY gross_revenue DESC;

-- 5. Who is the best customer?
-- Karl Seal ($221.55)
SELECT * FROM customer_list LIMIT 10; -- ID, name
SELECT * FROM payment LIMIT 10; -- customer_id, amount
SELECT customer_list.name AS name, SUM(payment.amount) as total_spent
	FROM customer_list
		JOIN payment ON payment.customer_id = customer_list.ID
	GROUP BY name
    ORDER BY total_spent DESC;

-- 6. Who are the most popular actors (that have appeared in the most films)?
-- TOP 3: Susan Davis(54), Gina Degeneres(42), Walter Torn(41)
SELECT * FROM actor LIMIT 10; -- actor_id, first_name, last_name
SELECT * FROM film_actor LIMIT 10; -- actor_id, film_id
SELECT * FROM film LIMIT 10; -- film_id, title
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS name, COUNT(film.title) AS total_movies
	FROM actor
		JOIN film_actor USING(actor_id)
        JOIN film USING(film_id)
	GROUP BY name
    ORDER BY total_movies DESC;

-- 7. What are the sales for each store for each month in 2005?
SELECT * FROM payment; -- staff_id, rental_id, amount, payment_date
SELECT * FROM staff LIMIT 10; -- staff_id, store_id
SELECT staff.store_id AS store_id,
	SUM(CASE WHEN payment.payment_date LIKE '2005-05%' THEN payment.amount ELSE NULL END) AS may_total,
    SUM(CASE WHEN payment.payment_date LIKE '2005-06%' THEN payment.amount ELSE NULL END) AS jun_total,
    SUM(CASE WHEN payment.payment_date LIKE '2005-07%' THEN payment.amount ELSE NULL END) AS jul_total,
    SUM(CASE WHEN payment.payment_date LIKE '2005-08%' THEN payment.amount ELSE NULL END) AS aug_total
FROM payment
	JOIN staff USING(staff_id)
GROUP BY store_id;

-- 3RD SET OF QUESTIONS (7) END --

/*
======================================================================================================================
BREAK LINE FROM 3RD SET OF QUESTIONS (7) TO 3RD SET OF QUESTIONS (BONUS - 1)
======================================================================================================================
*/

-- 3RD SET OF QUESTIONS (BONUS - 1) START --

-- 1. Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
-- Not sure what outstanding classifies as, but I'll define it as the top 5 in rental count
SELECT * FROM film LIMIT 10; -- title, film_id
SELECT * FROM rental LIMIT 10; -- rental_id, inventory_id, customer_id
SELECT * FROM inventory LIMIT 10; -- inventory_id, film_id
SELECT * FROM customer_list LIMIT 10; -- ID, name, phone, address
-- Group top 5 films by rental count (outstanding films)
SELECT film.title AS title, COUNT(rental.rental_id) AS total_rentals
	FROM film
		JOIN inventory USING(film_id)
        JOIN rental USING(inventory_id)
	GROUP BY title
    ORDER BY total_rentals DESC
    LIMIT 5;
-- Find customer info by "outstanding films"
SELECT DISTINCT A.title AS title, customer_list.name AS name, customer_list.phone AS phone, customer_list.address AS address
	FROM film
		JOIN 
			(SELECT film.title AS title, COUNT(rental.rental_id) AS total_rentals
				FROM film
					JOIN inventory USING(film_id)
					JOIN rental USING(inventory_id)
				GROUP BY title
				ORDER BY total_rentals DESC
				LIMIT 5) AS A
		JOIN inventory USING(film_id)
        JOIN rental USING(inventory_id)
        JOIN customer_list ON customer_list.ID = rental.customer_id;

-- 3RD SET OF QUESTIONS (BONUS - 1) END --

/*
======================================================================================================================
BREAK LINE FROM 3RD SET OF QUESTIONS (BONUS - 1) TO EMPLOYEES DATABASE QUESTION (1)
======================================================================================================================
*/

-- EMPLOYEES DATABASE QUESTIONS (1) START --

/* 1. How much do the current managers of each department get paid, relative to the average salary 
for the department? Is there any department where the department manager gets paid less than the average salary?*/
-- Oscar Ghazalie(Production) and Yuchang Weedman(Customer Service)
USE employees;
SHOW TABLES;
SELECT * FROM departments; -- dept_no, dept_name
SELECT * FROM dept_manager LIMIT 10; -- emp_no, dept_no, to_date
SELECT * FROM salaries LIMIT 10; -- emp_no, salary, to_date
SELECT * FROM employees LIMIT 10; -- emp_no, first_name, last_name
-- Salary of each department manager
SELECT departments.dept_name AS department, CONCAT(employees.first_name, ' ', employees.last_name) AS manager, salaries.salary AS salary
	FROM employees
		JOIN salaries USING(emp_no)
        JOIN dept_manager USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE dept_manager.to_date >= NOW()
		AND salaries.to_date >= NOW();
-- AVG salary by department
SELECT departments.dept_name AS department, ROUND(AVG(salaries.salary), 2) AS avg_salary
	FROM departments
		JOIN dept_emp USING(dept_no)
        JOIN salaries USING(emp_no)
	WHERE salaries.to_date >= NOW()
    GROUP BY department;
-- dept, name, salary, avg, T/F if less than avg
SELECT 
	A.department AS department, 
    A.manager AS manager, 
	A.salary AS salary, 
    B.avg_salary AS avg_salary,
	IF(salary < avg_salary, 'True', 'False') AS 'salary_lower_than_avg'
FROM
	(SELECT departments.dept_name AS department, CONCAT(employees.first_name, ' ', employees.last_name) AS manager, salaries.salary AS salary
	FROM employees
		JOIN salaries USING(emp_no)
        JOIN dept_manager USING(emp_no)
        JOIN departments USING(dept_no)
	WHERE dept_manager.to_date >= NOW()
		AND salaries.to_date >= NOW()) AS A
JOIN
	(SELECT departments.dept_name AS department, ROUND(AVG(salaries.salary), 2) AS avg_salary
	FROM departments
		JOIN dept_emp USING(dept_no)
        JOIN salaries USING(emp_no)
	WHERE salaries.to_date >= NOW()
    GROUP BY department) AS B
    USING(department)
ORDER BY salary;

-- EMPLOYEES DATABASE QUESTIONS (1) END --

/*
======================================================================================================================
BREAK LINE FROM EMPLOYEES DATABASE QUESTIONS (1) TO WORLD DATABASE QUESTIONS (6)
======================================================================================================================
*/

-- WORLD DATABASE QUESTIONS (6) START --

-- 1. What languages are spoken in Santa Monica?
SHOW DATABASES;
USE world;
SHOW TABLES;
SELECT * FROM city LIMIT 10;
SELECT * FROM country LIMIT 10;
SELECT * FROM countrylanguage LIMIT 10;
SELECT countrylanguage.Language AS language
	FROM countrylanguage
		JOIN country ON country.code = countrylanguage.CountryCode
        JOIN city ON city.CountryCode = country.code
	WHERE city.Name = 'Santa Monica';

-- 2. How many different countries are in each region?
SELECT DISTINCT Region, COUNT(Name) AS total_countries
	FROM country
    GROUP BY Region
    ORDER BY Region;

-- 3. What is the population for each region?
SELECT Region, SUM(Population) AS total_population
	FROM country
    GROUP BY Region
    ORDER BY Region;

-- 4. What is the population for each continent?
SELECT Continent, SUM(Population) AS total_population
	FROM country
    GROUP BY Continent
    ORDER BY Continent;

-- 5. What is the average life expectancy globally?
SELECT ROUND(AVG(LifeExpectancy), 2) AS global_life_expectancy
	FROM country;

-- 6. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
-- AVG region life expectancy
SELECT Region, ROUND(AVG(LifeExpectancy), 2) AS region_life_expectancy
	FROM country
    GROUP BY Region
    ORDER BY region_life_expectancy;
-- AVG continent life expectancy
SELECT Continent, ROUND(AVG(LifeExpectancy), 2) AS continent_life_expectancy
	FROM country
    GROUP BY Continent
    ORDER BY continent_life_expectancy;

-- WORLD DATABASE QUESTIONS (6) END --

/*
======================================================================================================================
BREAK LINE FROM WORLD DATABASE QUESTIONS (6) TO WORLD DATABASE QUESTIONS (BONUS - 6)
======================================================================================================================
*/

-- WORLD DATABASE QUESTIONS (BONUS - 6) START --

-- Not exactly sure what 'x' is besides being a NULL row...

-- 1. Find all the countries whose local name is different from the official name
SELECT Name AS official_name, LocalName AS local_name
	FROM country
    WHERE Name != LocalName
    ORDER BY official_name;

-- 2. How many countries have a life expectancy less than x?
SELECT Name
	FROM country
    WHERE LifeExpectancy < (SELECT LifeExpectancy FROM country WHERE Name LIKE 'x');

-- 3. What state is city x located in?
-- No states are outlined in the world schema, thus unsure what to do here

-- 4. What region of the world is city x located in?
SELECT country.Region AS region
	FROM country
		JOIN city ON city.CountryCode = country.Code
	WHERE city.Name = 'x';

-- 5. What country (use the human readable name) city x located in?
SELECT country.Name
	FROM country
		JOIN city ON city.CountryCode = country.Code
	WHERE city.Name = 'x';

-- 6. What is the life expectancy in city x?
SELECT country.LifeExpectancy
	FROM country
		JOIN city ON city.CountryCode =  country.Code
	WHERE city.Name = 'x';

-- WORLD DATABASE QUESTIONS (BONUS - 6) END --

/*
======================================================================================================================
BREAK LINE FROM WORLD DATABASE QUESTIONS (BONUS - 6) TO ADVANCED: PIZZA DATABASE 1ST SET OF QUESTIONS (10)
======================================================================================================================
*/

-- ADVANCED: PIZZA DATABASE 1ST SET OF QUESTIONS (10) START --

-- 1. What information is stored in the toppings table? How does this table relate to the pizzas table?
-- topping_id, topping_name, topping_price...  It gives pertinent topping data in relation to the pizza database
SHOW DATABASES;
USE pizza;
SHOW TABLES;
DESCRIBE toppings;
SELECT * FROM toppings;

-- 2. What information is stored in the modifiers table? How does this table relate to the pizzas table?
-- modifier_id, modifier_name, modifier_price... It gives pertinent data in terms of cheese amount to the pizza database
DESCRIBE modifiers;
SELECT * FROM modifiers;

-- 3. How are the pizzas and sizes tables related?
-- Both tables contain the "size_id" column
DESCRIBE pizzas;
DESCRIBE sizes;

-- 4. What other tables are in the database?
/* Besides the "toppings", "modifiers", "pizzas", and "sizes" tables used in questions 1-3, there are tables
"crust_types", "pizza_modifiers", and "pizza_toppings"*/
SHOW TABLES;

-- 5. How many unique toppings are there?
-- 9 unique toppings
SELECT * FROM toppings;
SELECT DISTINCT COUNT(topping_name) AS unique_toppings
	FROM toppings;

-- 6. How many unique orders are in this dataset?
-- 26334 Unique orders
SELECT * FROM crust_types; -- 2 unique
SELECT * FROM modifiers; -- 3 unique
SELECT * FROM pizza_modifiers; -- NULL
SELECT * FROM pizza_toppings; -- NULL//4 unique topping amounts
SELECT * FROM pizzas; -- NULL
SELECT * FROM sizes; -- 4 unique
SELECT * FROM toppings; -- 9 unique

-- 7. Which size of pizza is sold the most?
-- "large" at 5061 orders
SELECT * FROM pizzas;
SELECT sizes.size_name AS sizes, COUNT(pizzas.size_id) total
	FROM sizes
		JOIN pizzas USING(size_id)
	GROUP BY sizes
    ORDER BY total DESC;

-- 8. How many pizzas have been sold in total?
-- 20001 total sold
SELECT COUNT(*) AS total
	FROM pizzas;

-- 9. What is the most common size of pizza ordered?
-- "large"
SELECT sizes.size_name AS size, COUNT(pizzas.size_id) AS total
	FROM sizes
		JOIN pizzas USING(size_id)
	GROUP BY size
    ORDER BY total DESC;

-- 10. What is the average number of pizzas per order?
-- 2.0001 pizzas per order on average
SELECT AVG(A.total)
	FROM
		(SELECT order_id, COUNT(*) AS total
		FROM pizzas
		GROUP BY order_id
		ORDER BY order_id) AS A;

-- ADVANCED: PIZZA DATABASE 1ST SET OF QUESTIONS (10) END --

/*
======================================================================================================================
BREAK LINE FROM ADVANCED: PIZZA DATABASE 1ST SET OF QUESTIONS (10)
TO ADVANCED: PIZZA DATABASE 2ND SET OF QUESTIONS (3)
======================================================================================================================
*/

-- ADVANCED: PIZZA DATABASE 2ND SET OF QUESTIONS (3) START --
/* CONDITIONAL FOR FOLLOWING QUESTIONS:
Find the total price for each order. The total price is the sum of: 1, 2, 3...
Topping price is affected by the amount of the topping specified. A light amount 
is half of the regular price. An extra amount is 1.5 times the regular price, and 
double of the topping is double the price.*/
SELECT * FROM crust_types LIMIT 10; -- crust_type_id, crust_type_name
SELECT * FROM modifiers LIMIT 10; -- modifier_id, modifier_name, modifier_price
SELECT * FROM pizza_modifiers LIMIT 10; -- pizza_id, modifier_id
SELECT * FROM pizza_toppings LIMIT 10; -- pizza_id, topping_id, topping_amount
SELECT * FROM pizzas LIMIT 10; -- pizza_id, order_id, crust_type_id, size_id
SELECT * FROM sizes LIMIT 10; -- size_id, size_name, size_price
SELECT * FROM toppings LIMIT 10; -- topping_id, topping_name, topping_price

-- 1. The price based on pizza size
SELECT pizzas.order_id AS order_id, SUM(size_price) AS total
	FROM pizzas
		JOIN sizes USING(size_id)
	GROUP BY order_id
    ORDER BY order_id;

-- 2. Any modifiers that need to be charged for
SELECT pizzas.order_id AS order_id, SUM(modifiers.modifier_price) AS total
	FROM pizzas
		JOIN pizza_modifiers USING(pizza_id)
        JOIN modifiers USING(modifier_id)
	GROUP BY order_id
    ORDER BY order_id;

-- 3. The sum of the topping prices
SELECT pizzas.order_id AS order_id, ROUND(SUM(A.topping_total), 2) AS total
	FROM 
		pizzas
			JOIN
				(SELECT
					pizza_toppings.pizza_id AS pizza_id,
					pizza_toppings.topping_id AS topping_id,
					pizza_toppings.topping_amount AS topping_amount,
						CASE
							WHEN topping_amount = 'light' THEN (toppings.topping_price * 0.5)
							WHEN topping_amount = 'regular' THEN (toppings.topping_price * 1)
							WHEN topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
							WHEN topping_amount = 'double' THEN (toppings.topping_price * 2)
							ELSE NULL
							END AS topping_total
				FROM pizza_toppings
				JOIN toppings USING(topping_id)
				ORDER BY pizza_id)
                AS A USING(pizza_id)
    GROUP BY order_id
    ORDER BY order_id;
-- Topping multiplier by topping amount
SELECT
	pizza_toppings.pizza_id AS pizza_id,
	pizza_toppings.topping_id AS topping_id,
	pizza_toppings.topping_amount AS topping_amount,
		CASE
			WHEN topping_amount = 'light' THEN (toppings.topping_price * 0.5)
			WHEN topping_amount = 'regular' THEN (toppings.topping_price * 1)
			WHEN topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
			WHEN topping_amount = 'double' THEN (toppings.topping_price * 2)
			ELSE NULL
			END AS topping_total
FROM pizza_toppings
	JOIN toppings USING(topping_id)
ORDER BY pizza_id;

-- ADVANCED: PIZZA DATABASE 2ND SET OF QUESTIONS (3) END --

/*
======================================================================================================================
BREAK LINE FROM ADVANCED: PIZZA DATABASE 2ND SET OF QUESTIONS (3) TO ADDITIONAL QUESTIONS (20)
======================================================================================================================
*/

-- ADDITIONAL QUESTIONS (20) START --

-- 1. What is the average price of pizzas that have no cheese?
-- $14.89 avg price of pizzas with no cheese (Includes size and topping price)
/*
modifiers & pizza_modifies = Cheese Price
	modifiers -> modifier_id, modifier_name, modifier_price
    pizza_modifies -> pizza_id, modifier_id
toppings & pizza_toppings = topping price
	toppings -> topping_id, topping_name, topping_price
    pizza_toppings -> pizza_id, topping_id, topping_amount
pizzas & sizes = size price
	pizzas -> pizza_id, order_id, crust_type_id, size_id
    sizes -> size_id, size_name, size_price
*/
-- PRICE cheese BY pizza_id
SELECT
	pizzas.pizza_id AS pizza_id,
	CASE
			WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
            ELSE NULL
            END
            AS cheese_cost
FROM
	pizzas
		LEFT JOIN pizza_modifiers USING(pizza_id)
        LEFT JOIN modifiers USING(modifier_id)
ORDER BY pizza_id;
-- PRICE toppings BY pizza_id
SELECT pizzas.pizza_id AS pizza_id,
    ROUND(SUM(CASE
			WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
            WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
            WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
            WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
            ELSE NULL
            END), 2)
            AS toppings_cost
FROM
	pizzas
		LEFT JOIN pizza_toppings USING(pizza_id)
        LEFT JOIN toppings USING(topping_id)
GROUP BY pizza_id
ORDER BY pizza_id;
-- PRICE size BY pizza_id
SELECT pizzas.pizza_id,
	CASE
			WHEN sizes.size_name = 'small' THEN sizes.size_price
            WHEN sizes.size_name = 'medium' THEN sizes.size_price
            WHEN sizes.size_name = 'large' THEN sizes.size_price
            WHEN sizes.size_name = 'x-large' THEN sizes.size_price
            ELSE NULL
            END
            AS size_cost
FROM
	pizzas
		LEFT JOIN sizes USING(size_id)
ORDER BY pizza_id;
-- PRICE by pizza_id
SELECT
	A.pizza_id AS pizza_id,
    A.modifier_id AS modifier_id,
    SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
FROM
	(SELECT
	pizzas.pizza_id AS pizza_id,
    pizza_modifiers.modifier_id,
	CASE
			WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
            ELSE NULL
            END
            AS cheese_cost
	FROM
		pizzas
			LEFT JOIN pizza_modifiers USING(pizza_id)
			LEFT JOIN modifiers USING(modifier_id)) AS A
	LEFT JOIN
		(SELECT pizzas.pizza_id AS pizza_id,
			ROUND(SUM(CASE
				WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
				WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
				WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
				WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
				ELSE NULL
				END), 2)
				AS toppings_cost
		FROM
			pizzas
				LEFT JOIN pizza_toppings USING(pizza_id)
				LEFT JOIN toppings USING(topping_id)
		GROUP BY pizza_id
		ORDER BY pizza_id) 
        AS B USING(pizza_id)
	LEFT JOIN
		(SELECT pizzas.pizza_id,
			CASE
				WHEN sizes.size_name = 'small' THEN sizes.size_price
				WHEN sizes.size_name = 'medium' THEN sizes.size_price
				WHEN sizes.size_name = 'large' THEN sizes.size_price
				WHEN sizes.size_name = 'x-large' THEN sizes.size_price
				ELSE NULL
				END
				AS size_cost
		FROM
			pizzas
				LEFT JOIN sizes USING(size_id)
		ORDER BY pizza_id) 
        AS C USING(pizza_id)
GROUP BY pizza_id, modifier_id
ORDER BY pizza_id;
-- AVG COST OF PIZZA W/ NO CHEESE
SELECT
	ROUND(AVG(A.total), 2)
FROM
	(SELECT
	A.pizza_id AS pizza_id,
    A.modifier_id AS modifier_id,
    SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
FROM
	(SELECT
		pizzas.pizza_id AS pizza_id,
		pizza_modifiers.modifier_id AS modifier_id,
		CASE
			WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
            ELSE NULL
            END
            AS cheese_cost
	FROM
		pizzas
			LEFT JOIN pizza_modifiers USING(pizza_id)
			LEFT JOIN modifiers USING(modifier_id)) AS A
			LEFT JOIN
				(SELECT pizzas.pizza_id AS pizza_id,
					ROUND(SUM(CASE
						WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
						WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
						WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
						WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
						ELSE NULL
						END), 2)
						AS toppings_cost
				FROM
					pizzas
						LEFT JOIN pizza_toppings USING(pizza_id)
						LEFT JOIN toppings USING(topping_id)
				GROUP BY pizza_id
				ORDER BY pizza_id) 
				AS B USING(pizza_id)
			LEFT JOIN
				(SELECT pizzas.pizza_id,
					CASE
						WHEN sizes.size_name = 'small' THEN sizes.size_price
						WHEN sizes.size_name = 'medium' THEN sizes.size_price
						WHEN sizes.size_name = 'large' THEN sizes.size_price
						WHEN sizes.size_name = 'x-large' THEN sizes.size_price
						ELSE NULL
						END
						AS size_cost
				FROM
					pizzas
						LEFT JOIN sizes USING(size_id)
				ORDER BY pizza_id) 
				AS C USING(pizza_id)
	GROUP BY pizza_id, modifier_id) AS A
WHERE A.modifier_id = COALESCE(A.modifier_id, 0);

-- 2. What is the most common size for pizzas that have extra cheese?
-- Medium: 575
USE pizza;
SELECT 
	sizes.size_name AS size, 
	COUNT(pizza_modifiers.modifier_id) AS total
FROM
	sizes
		LEFT JOIN pizzas USING(size_id)
        LEFT JOIN pizza_modifiers USING(pizza_id)
WHERE pizza_modifiers.modifier_id = 1
GROUP BY size
ORDER BY total DESC;

-- 3. What is the most common topping for pizzas that are well done?
-- Bacon: 618
SELECT
	toppings.topping_name AS topping,
    COUNT(pizza_toppings.topping_id) AS total
FROM toppings
	LEFT JOIN pizza_toppings USING(topping_id)
    LEFT JOIN pizza_modifiers USING(pizza_id)
    LEFT JOIN modifiers USING(modifier_id)
WHERE pizza_modifiers.modifier_id = 2
GROUP BY topping
ORDER BY total DESC;

-- 4. How many pizzas are only cheese (i.e. have no toppings)?
-- 2548 pizzas
SELECT
	COUNT(*) AS total
FROM
	(SELECT
		pizzas.pizza_id AS pizza_id,
		pizza_toppings.topping_id AS topping_id
	FROM 
		pizzas 
			LEFT JOIN pizza_toppings USING(pizza_id))
	AS A
WHERE topping_id IS NULL;

/* 5. How many orders consist of pizza(s) that are only cheese? What is the average price 
of these orders? The most common pizza size?*/
-- 2548 only cheese pizza
-- $14.23 avg for only cheese pizza
-- Large: 577 pizzas
SELECT
	ROUND(AVG(total), 2)
FROM
	(SELECT
		A.pizza_id AS pizza_id,
		A.modifier_id AS modifier_id,
		SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
	FROM
		(SELECT
			pizzas.pizza_id AS pizza_id,
			pizza_modifiers.modifier_id,
			CASE
				WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
				WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
				WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
				ELSE NULL
				END
				AS cheese_cost
		FROM
			pizzas
				LEFT JOIN pizza_modifiers USING(pizza_id)
				LEFT JOIN modifiers USING(modifier_id)) AS A
		LEFT JOIN
			(SELECT 
				pizzas.pizza_id AS pizza_id,
				ROUND(SUM(CASE
					WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
					WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
					WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
					WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
					ELSE NULL
					END), 2)
					AS toppings_cost
			FROM
				pizzas
					LEFT JOIN pizza_toppings USING(pizza_id)
					LEFT JOIN toppings USING(topping_id)
			GROUP BY pizza_id
			ORDER BY pizza_id) 
			AS B USING(pizza_id)
		LEFT JOIN
			(SELECT 
				pizzas.pizza_id,
				CASE
					WHEN sizes.size_name = 'small' THEN sizes.size_price
					WHEN sizes.size_name = 'medium' THEN sizes.size_price
					WHEN sizes.size_name = 'large' THEN sizes.size_price
					WHEN sizes.size_name = 'x-large' THEN sizes.size_price
					ELSE NULL
					END
					AS size_cost
			FROM
				pizzas
					LEFT JOIN sizes USING(size_id)
			ORDER BY pizza_id) 
			AS C USING(pizza_id)
	GROUP BY pizza_id, modifier_id
	ORDER BY pizza_id) AS A
WHERE A.modifier_id = 3;
-- Size of no cheese pizza
SELECT
	size_name AS size,
    COUNT(size_id) AS total
FROM
	(SELECT
		pizzas.pizza_id AS pizza_id,
		sizes.size_name AS size_name,
        sizes.size_id AS size_id,
        pizza_modifiers.modifier_id AS modifier_id
	FROM
		pizzas
			LEFT JOIN sizes USING(size_id)
            LEFT JOIN pizza_modifiers USING(pizza_id)
            LEFT JOIN modifiers USING(modifier_id))
	AS A
WHERE modifier_id = 3
GROUP BY size
ORDER BY total DESC;

-- 6. How may large pizzas have olives on them?
-- 1326 pizzas
SELECT
	COUNT(*) AS total
FROM
	pizzas
		LEFT JOIN pizza_toppings USING(pizza_id)
        LEFT JOIN sizes USING(size_id)
WHERE 
	pizza_toppings.topping_id = 7
    AND sizes.size_id = 3;

-- 7. What is the average number of toppings per pizza?
-- 2 toppings/pizza on average
SELECT
	ROUND(AVG(total)) AS avg_toppings
FROM
	(SELECT
		pizzas.pizza_id AS pizza_id,
		COUNT(pizza_toppings.topping_id) AS total
	FROM
		pizzas
			LEFT JOIN pizza_toppings USING(pizza_id)
	GROUP BY pizza_id)
    AS A;

-- 8. What is the average number of pizzas per order?
-- 2 pizzas/order on avg
SELECT
	ROUND(AVG(total)) AS avg_total
FROM
	(SELECT
		order_id,
		COUNT(pizza_id) AS total
	FROM pizzas
	GROUP BY order_id)
    AS A;

-- 9. What is the average pizza price?
-- $14.39 average pizza price
SELECT
	ROUND(AVG(total), 2) AS avg_total
FROM
	(SELECT
		A.pizza_id AS pizza_id,
		A.modifier_id AS modifier_id,
		SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
	FROM
		(SELECT
			pizzas.pizza_id AS pizza_id,
			pizza_modifiers.modifier_id,
			CASE
				WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
				WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
				WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
				ELSE NULL
				END
				AS cheese_cost
		FROM
			pizzas
				LEFT JOIN pizza_modifiers USING(pizza_id)
				LEFT JOIN modifiers USING(modifier_id)) AS A
			LEFT JOIN
				(SELECT 
					pizzas.pizza_id AS pizza_id,
					ROUND(SUM(CASE
						WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
						WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
						WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
						WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
						ELSE NULL
						END), 2)
						AS toppings_cost
				FROM
					pizzas
						LEFT JOIN pizza_toppings USING(pizza_id)
						LEFT JOIN toppings USING(topping_id)
				GROUP BY pizza_id
				ORDER BY pizza_id) 
				AS B USING(pizza_id)
			LEFT JOIN
				(SELECT 
					pizzas.pizza_id,
					CASE
						WHEN sizes.size_name = 'small' THEN sizes.size_price
						WHEN sizes.size_name = 'medium' THEN sizes.size_price
						WHEN sizes.size_name = 'large' THEN sizes.size_price
						WHEN sizes.size_name = 'x-large' THEN sizes.size_price
						ELSE NULL
						END
						AS size_cost
				FROM
					pizzas
						LEFT JOIN sizes USING(size_id)
				ORDER BY pizza_id) 
				AS C USING(pizza_id)
		GROUP BY pizza_id, modifier_id
		ORDER BY pizza_id)
        AS A;

-- 10. What is the average order total?
-- $28.77 / order on average
SELECT
	ROUND(AVG(total), 2) AS avg_total
FROM
	(SELECT
		A.order_id AS order_id,
		SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
	FROM
		(SELECT
			pizzas.order_id AS order_id,
			pizzas.pizza_id AS pizza_id,
			pizza_modifiers.modifier_id,
			CASE
				WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
				WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
				WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
				ELSE NULL
				END
				AS cheese_cost
		FROM
			pizzas
				LEFT JOIN pizza_modifiers USING(pizza_id)
				LEFT JOIN modifiers USING(modifier_id)) AS A
			LEFT JOIN
				(SELECT 
					pizzas.pizza_id AS pizza_id,
					ROUND(SUM(CASE
						WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
						WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
						WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
						WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
						ELSE NULL
						END), 2)
						AS toppings_cost
				FROM
					pizzas
						LEFT JOIN pizza_toppings USING(pizza_id)
						LEFT JOIN toppings USING(topping_id)
				GROUP BY pizza_id
				ORDER BY pizza_id) 
				AS B USING(pizza_id)
			LEFT JOIN
				(SELECT pizzas.pizza_id,
					CASE
						WHEN sizes.size_name = 'small' THEN sizes.size_price
						WHEN sizes.size_name = 'medium' THEN sizes.size_price
						WHEN sizes.size_name = 'large' THEN sizes.size_price
						WHEN sizes.size_name = 'x-large' THEN sizes.size_price
						ELSE NULL
						END
						AS size_cost
				FROM
					pizzas
						LEFT JOIN sizes USING(size_id)
				ORDER BY pizza_id) 
				AS C USING(pizza_id)
		GROUP BY order_id)
        AS A;

-- 11. What is the average number of items per order?
-- 2 items/order on avg
SELECT
	ROUND(AVG(total), 2) AS avg_total
FROM
	(SELECT
		order_id,
		COUNT(pizza_id) AS total
	FROM
		pizzas
	GROUP BY order_id
	ORDER BY order_id)
    AS A;

-- 12. What is the average number of toppings per pizza for each size of pizza?
/*
SMALL: 2.36
MEDIUM: 2.37
LARGE: 2.37
X-LARGE: 2.44
*/
-- toppings by pizza
SELECT
	pizzas.pizza_id AS pizza_id,
	COUNT(pizza_toppings.topping_id) AS toppings_total
FROM
	pizzas
		LEFT JOIN pizza_toppings USING(pizza_id)
GROUP BY pizza_id;
-- toppings by size
SELECT
	sizes.size_name AS size,
    ROUND(AVG(A.toppings_total), 2) AS avg_toppings
FROM
	sizes
		LEFT JOIN pizzas USING(size_id)
        LEFT JOIN
			(SELECT
				pizzas.pizza_id AS pizza_id,
				COUNT(pizza_toppings.topping_id) AS toppings_total
			FROM
				pizzas
					LEFT JOIN pizza_toppings USING(pizza_id)
			GROUP BY pizza_id)
            AS A USING(pizza_id)
GROUP BY size;

-- 13. What is the average order total for orders that contain more than 1 pizza?
-- $37.25 avg / order with more than 1 pizza
SELECT
	ROUND(AVG(total), 2)
FROM
	(SELECT
		order_id,
		ROUND(SUM(total), 2) AS total
	FROM
		((SELECT
			order_id,
			COUNT(*) AS pizzas
		FROM
			pizzas
		GROUP BY order_id
		HAVING pizzas >= 2)
		AS A
		LEFT JOIN
			(SELECT
				A.pizza_id AS pizza_id,
				A.order_id AS order_id,
				SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
			FROM
				(SELECT
					pizzas.pizza_id AS pizza_id,
					pizzas.order_id AS order_id,
					pizza_modifiers.modifier_id,
				CASE
					WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
					WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
					WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
					ELSE NULL
					END
					AS cheese_cost
				FROM
					pizzas
						LEFT JOIN pizza_modifiers USING(pizza_id)
						LEFT JOIN modifiers USING(modifier_id)) AS A
			LEFT JOIN
				(SELECT pizzas.pizza_id AS pizza_id,
					ROUND(SUM(CASE
						WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
						WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
						WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
						WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
						ELSE NULL
						END), 2)
						AS toppings_cost
				FROM
					pizzas
						LEFT JOIN pizza_toppings USING(pizza_id)
						LEFT JOIN toppings USING(topping_id)
				GROUP BY pizza_id
				ORDER BY pizza_id) 
				AS B USING(pizza_id)
			LEFT JOIN
				(SELECT pizzas.pizza_id,
					CASE
						WHEN sizes.size_name = 'small' THEN sizes.size_price
						WHEN sizes.size_name = 'medium' THEN sizes.size_price
						WHEN sizes.size_name = 'large' THEN sizes.size_price
						WHEN sizes.size_name = 'x-large' THEN sizes.size_price
						ELSE NULL
						END
						AS size_cost
				FROM
					pizzas
						LEFT JOIN sizes USING(size_id)
				ORDER BY pizza_id) 
				AS C USING(pizza_id)
		GROUP BY order_id, pizza_id)
		AS B USING(order_id))
		GROUP BY order_id) AS A;
-- pizzas by order_id
SELECT
	order_id,
    COUNT(*) AS pizzas
FROM
	pizzas
GROUP BY order_id
HAVING pizzas >= 2;
-- total by pizza_id
SELECT
	A.pizza_id AS pizza_id,
    A.order_id AS order_id,
    SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
FROM
	(SELECT
	pizzas.pizza_id AS pizza_id,
    pizzas.order_id AS order_id,
    pizza_modifiers.modifier_id,
	CASE
			WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
            ELSE NULL
            END
            AS cheese_cost
	FROM
		pizzas
			LEFT JOIN pizza_modifiers USING(pizza_id)
			LEFT JOIN modifiers USING(modifier_id)) AS A
	LEFT JOIN
		(SELECT pizzas.pizza_id AS pizza_id,
			ROUND(SUM(CASE
				WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
				WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
				WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
				WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
				ELSE NULL
				END), 2)
				AS toppings_cost
		FROM
			pizzas
				LEFT JOIN pizza_toppings USING(pizza_id)
				LEFT JOIN toppings USING(topping_id)
		GROUP BY pizza_id
		ORDER BY pizza_id) 
        AS B USING(pizza_id)
	LEFT JOIN
		(SELECT pizzas.pizza_id,
			CASE
				WHEN sizes.size_name = 'small' THEN sizes.size_price
				WHEN sizes.size_name = 'medium' THEN sizes.size_price
				WHEN sizes.size_name = 'large' THEN sizes.size_price
				WHEN sizes.size_name = 'x-large' THEN sizes.size_price
				ELSE NULL
				END
				AS size_cost
		FROM
			pizzas
				LEFT JOIN sizes USING(size_id)
		ORDER BY pizza_id) 
        AS C USING(pizza_id)
GROUP BY order_id, pizza_id
ORDER BY pizza_id;

-- 14. What is the most common pizza size for orders that contain only a single pizza?
/*
LARGE: 952
X-LARGE: 922
MEDIUM: 919
SMALL: 916
*/
SELECT
	sizes.size_name AS size,
    COUNT(pizza_id) AS total
FROM
	pizzas
		LEFT JOIN
			sizes USING(size_id)
		LEFT JOIN
			(SELECT
				order_id,
				COUNT(pizza_id) AS pizzas
			FROM
				pizzas
			GROUP BY order_id
			HAVING pizzas = 1)
			AS A USING(order_id)
WHERE A.pizzas = 1
GROUP BY size
ORDER BY total DESC;

-- 15. How many orders consist of 3+ pizzas? What is the average number of toppings for these orders?
/*
Orders w/ 3+ toppings: 6972
Avg toppings for these: 6.28
*/
-- AVG toppings for orders with 3+ toppings
SELECT
	ROUND(AVG(total_topping), 2) AS avg_topping
FROM
	(SELECT
		pizzas.order_id AS order_id,
		COUNT(pizza_toppings.topping_id) AS total_topping
	FROM
		pizzas
		LEFT JOIN
			pizza_toppings USING(pizza_id)
	GROUP BY order_id
	HAVING total_topping >= 3)
    AS A;
    
-- Total orders with 3+ toppings
SELECT
	COUNT(*)
FROM
	(SELECT
		pizzas.order_id AS order_id,
		COUNT(pizza_toppings.topping_id) AS total_topping
	FROM
		pizzas
		LEFT JOIN
			pizza_toppings USING(pizza_id)
	GROUP BY order_id
	HAVING total_topping >= 3)
    AS A;
-- Orders with 3+ toppings
SELECT
	pizzas.order_id AS order_id,
    COUNT(pizza_toppings.topping_id) AS total_topping
FROM
	pizzas
	LEFT JOIN
		pizza_toppings USING(pizza_id)
GROUP BY order_id
HAVING total_topping >= 3;

-- 16. What is the most common topping on large and extra large pizzas?
/*
Large: Pepperoni(1364)
X-Large: Canadian Bacon(1401)
*/
SELECT
	*
FROM
	(SELECT
		toppings.topping_name AS topping,
		COUNT(pizza_toppings.topping_id) AS X_LARGE
	FROM
		toppings
		LEFT JOIN
			pizza_toppings USING(topping_id)
		LEFT JOIN
			pizzas USING(pizza_id)
	WHERE pizzas.size_id = 4
	GROUP BY topping)
    AS A
	JOIN
		(SELECT
			toppings.topping_name AS topping,
			COUNT(pizza_toppings.topping_id) AS LARGE
		FROM
			toppings
			LEFT JOIN
				pizza_toppings USING(topping_id)
			LEFT JOIN
				pizzas USING(pizza_id)
		WHERE pizzas.size_id = 3
		GROUP BY topping)
        AS B USING(topping)
ORDER BY topping;
-- Toppings by X-Large
SELECT
	toppings.topping_name AS topping,
	COUNT(pizza_toppings.topping_id) AS X_LARGE
FROM
	toppings
    LEFT JOIN
		pizza_toppings USING(topping_id)
	LEFT JOIN
		pizzas USING(pizza_id)
WHERE pizzas.size_id = 4
GROUP BY topping;
-- Toppings by Large
SELECT
	toppings.topping_name AS topping,
    COUNT(pizza_toppings.topping_id) AS LARGE
FROM
	toppings
	LEFT JOIN
		pizza_toppings USING(topping_id)
	LEFT JOIN
		pizzas USING(pizza_id)
WHERE pizzas.size_id = 3
GROUP BY topping;

-- 17. What is the most common topping for orders that consist of 2 pizzas?
-- Canadian Bacon: 1994
SELECT
	toppings.topping_name AS topping,
    COUNT(toppings.topping_id) AS total
FROM pizza_toppings
	LEFT JOIN
		toppings USING(topping_id)
	LEFT JOIN
		pizzas USING(pizza_id)
	LEFT JOIN
		(SELECT
			order_id,
			COUNT(pizza_id) AS total
		FROM
			pizzas
		GROUP BY order_id
		HAVING total = 2)
        AS A USING(order_id)
WHERE A.total = 2
GROUP BY topping
ORDER BY total DESC;
-- Orders with 2 pizzas
SELECT
	order_id,
    COUNT(pizza_id) AS total
FROM
	pizzas
GROUP BY order_id
HAVING total = 2;

-- 18. Which size of pizza most frequently has modifiers?
/*
Large: 1714
X-Large: 1652
Medium: 1637
Small: 1582
*/
SELECT
	sizes.size_name AS size,
    COUNT(pizza_id) AS total
FROM
	sizes
    LEFT JOIN
		pizzas USING(size_id)
	LEFT JOIN
		pizza_modifiers USING(pizza_id)
WHERE pizza_modifiers.modifier_id IN(1, 2, 3)
GROUP BY size
ORDER BY total DESC;

-- 19. What percentage of pizzas with hot sauce have extra cheese?
-- Pizzas with hot sauce and extra cheese
SELECT
	COUNT(pizzas.pizza_id) AS total
FROM
	pizzas
	LEFT JOIN
		pizza_toppings USING(pizza_id)
	LEFT JOIN
		pizza_modifiers USING(pizza_id)
WHERE pizza_modifiers.modifier_id = 1
	AND pizza_toppings.topping_id = 9;
-- Percent of pizzas with hot sauce and extra cheese
-- 3% of all pizzas are hot sauce AND extra cheese
SELECT
	ROUND(
		(SELECT
			COUNT(pizzas.pizza_id) AS total
		FROM
			pizzas
			LEFT JOIN
				pizza_toppings USING(pizza_id)
			LEFT JOIN
				pizza_modifiers USING(pizza_id)
		WHERE pizza_modifiers.modifier_id = 1
			AND pizza_toppings.topping_id = 9)
		/
		(SELECT
			COUNT(*)
		FROM
			pizzas), 2)
	AS total_percent;

-- 20. What is the average order price for orders that have at least 1 pizza with pineapple?
-- $35.24 avg order price for orders with at least 1 pizza w/ pineapple
-- Prices of orders with pizzas with pineaple
SELECT
	ROUND(AVG(B.total), 2) AS avg_total
FROM
	(SELECT DISTINCT
		pizzas.order_id AS order_id
	FROM
		pizzas
		LEFT JOIN
			pizza_toppings USING(pizza_id)
	WHERE pizza_toppings.topping_id = 8)
    AS A
    LEFT JOIN
		(SELECT
			A.order_id AS order_id,
			SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
		FROM
			(SELECT
				pizzas.pizza_id AS pizza_id,
				pizzas.order_id AS order_id,
				pizza_modifiers.modifier_id,
				CASE
					WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
					WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
					WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
					ELSE NULL
					END
					AS cheese_cost
			FROM
				pizzas
				LEFT JOIN pizza_modifiers USING(pizza_id)
				LEFT JOIN modifiers USING(modifier_id)) AS A
		LEFT JOIN
			(SELECT 
				pizzas.pizza_id AS pizza_id,
				ROUND(SUM(CASE
					WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
					WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
					WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
					WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
					ELSE NULL
					END), 2)
					AS toppings_cost
			FROM
				pizzas
				LEFT JOIN pizza_toppings USING(pizza_id)
				LEFT JOIN toppings USING(topping_id)
			GROUP BY pizza_id
			ORDER BY pizza_id) 
			AS B USING(pizza_id)
		LEFT JOIN
			(SELECT pizzas.pizza_id,
				CASE
					WHEN sizes.size_name = 'small' THEN sizes.size_price
					WHEN sizes.size_name = 'medium' THEN sizes.size_price
					WHEN sizes.size_name = 'large' THEN sizes.size_price
					WHEN sizes.size_name = 'x-large' THEN sizes.size_price
					ELSE NULL
					END
					AS size_cost
			FROM
				pizzas
				LEFT JOIN sizes USING(size_id)
			ORDER BY pizza_id) 
			AS C USING(pizza_id)
	GROUP BY order_id)
    AS B USING(order_id)
WHERE order_id IN(B.order_id);
-- Orders with pineapple
SELECT DISTINCT
	pizzas.order_id AS order_id
FROM
	pizzas
	LEFT JOIN
		pizza_toppings USING(pizza_id)
WHERE pizza_toppings.topping_id = 8;
-- Price by order_id
SELECT
    A.order_id AS order_id,
    SUM(COALESCE(A.cheese_cost, 0) + COALESCE(B.toppings_cost, 0) + COALESCE(C.size_cost, 0)) AS total
FROM
	(SELECT
	pizzas.pizza_id AS pizza_id,
    pizzas.order_id AS order_id,
    pizza_modifiers.modifier_id,
	CASE
			WHEN pizza_modifiers.modifier_id = 1 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 2 THEN modifiers.modifier_price
            WHEN pizza_modifiers.modifier_id = 3 THEN modifiers.modifier_price
            ELSE NULL
            END
            AS cheese_cost
	FROM
		pizzas
			LEFT JOIN pizza_modifiers USING(pizza_id)
			LEFT JOIN modifiers USING(modifier_id)) AS A
	LEFT JOIN
		(SELECT 
			pizzas.pizza_id AS pizza_id,
			ROUND(SUM(CASE
				WHEN pizza_toppings.topping_amount = 'light' THEN (toppings.topping_price * 0.5)
				WHEN pizza_toppings.topping_amount = 'regular' THEN (toppings.topping_price * 1)
				WHEN pizza_toppings.topping_amount = 'extra' THEN (toppings.topping_price * 1.5)
				WHEN pizza_toppings.topping_amount = 'double' THEN (toppings.topping_price * 2)
				ELSE NULL
				END), 2)
				AS toppings_cost
		FROM
			pizzas
				LEFT JOIN pizza_toppings USING(pizza_id)
				LEFT JOIN toppings USING(topping_id)
		GROUP BY pizza_id
		ORDER BY pizza_id) 
        AS B USING(pizza_id)
	LEFT JOIN
		(SELECT pizzas.pizza_id,
			CASE
				WHEN sizes.size_name = 'small' THEN sizes.size_price
				WHEN sizes.size_name = 'medium' THEN sizes.size_price
				WHEN sizes.size_name = 'large' THEN sizes.size_price
				WHEN sizes.size_name = 'x-large' THEN sizes.size_price
				ELSE NULL
				END
				AS size_cost
		FROM
			pizzas
				LEFT JOIN sizes USING(size_id)
		ORDER BY pizza_id) 
        AS C USING(pizza_id)
GROUP BY order_id;

-- ADDITIONAL QUESTIONS (20) END --