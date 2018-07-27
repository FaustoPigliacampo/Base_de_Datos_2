1-

INSERT INTO customer
(store_id, first_name, last_name, email, address_id)
VALUES
(1, 'Fausto', 'Pigliacampo', 'fausto.pigliacampo@outlook.com', (SELECT address_id FROM address
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE country.country LIKE 'United States'
ORDER BY address_id DESC LIMIT 1));

___________________________________________________________________________________________________________

2-

INSERT INTO rental
(rental_date, inventory_id, customer_id, staff_id)
VALUES
(CURRENT_TIMESTAMP,
(SELECT inventory_id
FROM inventory
INNER JOIN film USING (film_id)
WHERE title LIKE 'UNTOUCHABLES SUNRISE'
LIMIT 1),
(SELECT customer_id FROM customer WHERE store_id = 2 LIMIT 1),
(SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1));

___________________________________________________________________________________________________________

3-

UPDATE film
SET release_year = '1901'
WHERE rating LIKE 'G';

UPDATE film
SET release_year = '1902'
WHERE rating LIKE 'PG';

UPDATE film
SET release_year = '1903'
WHERE rating LIKE 'NC-17';

UPDATE film
SET release_year = '1904'
WHERE rating LIKE 'PG-13';

UPDATE film
SET release_year = '1905'
WHERE rating LIKE 'R';

___________________________________________________________________________________________________________

4-

SELECT MAX(rental_id) FROM film
INNER JOIN inventory USING (film_id)
INNER JOIN rental t USING (inventory_id)
WHERE t.return_date IS NULL;

UPDATE rental
SET return_date = CURRENT_TIMESTAMP
WHERE rental_id = 15966;

___________________________________________________________________________________________________________

5-

-- No permite eliminarla por las relaciones con las demas tablas.

-- Seleccionamos la pelicula:
SELECT * FROM film LIMIT 1;

-- Eliminamos todos los registros que tengan esa pelicula de la tabla 'film_category'.
DELETE FROM film_category WHERE film_id = (SELECT film_id FROM film LIMIT 1);

-- Eliminamos todos los registros que tengan esa pelicula de la tabla 'film_actor'.
DELETE FROM film_actor WHERE film_id = (SELECT film_id FROM film LIMIT 1);

-- Eliminamos todos los registros de rentas de los inventarios que pertenezcan a nuesta pelicula.
DELETE FROM rental WHERE inventory_id IN
(SELECT inventory_id FROM inventory WHERE film_id = (SELECT film_id FROM film LIMIT 1));

-- Eliminamos todos los inventarios de la pelicula.
DELETE FROM inventory WHERE film_id = (SELECT film_id FROM film LIMIT 1);

-- Finalmente eliminamos la pelicula.
DELETE FROM film WHERE film_id = 1;

___________________________________________________________________________________________________________

6-

SELECT inventory_id
FROM inventory
INNER JOIN rental USING (inventory_id)
WHERE rental.return_date IS NOT NULL
AND inventory.store_id = 1;
-- inventory_id = 103


INSERT INTO rental
(rental_date, inventory_id, customer_id, staff_id)
VALUES
(CURRENT_TIMESTAMP,
103,
(SELECT customer_id
FROM customer
WHERE customer.first_name LIKE 'Fausto'
AND customer.last_name LIKE 'Pigliacampo'),
(SELECT staff_id
FROM staff
WHERE staff.store_id = (SELECT store_id
						FROM inventory
						WHERE inventory_id = 103
						LIMIT 1)));


INSERT INTO payment
(customer_id, staff_id, rental_id, amount)
VALUES
((SELECT customer_id
FROM customer
WHERE customer.first_name LIKE 'Fausto'
AND customer.last_name LIKE 'Pigliacampo'),
(SELECT staff_id
FROM staff
WHERE staff.store_id = (SELECT store_id
						FROM inventory
						WHERE inventory_id = 103
						LIMIT 1)),
(SELECT rental_id
FROM rental
WHERE rental.inventory_id = 103
AND rental.customer_id = (SELECT customer_id
							FROM customer
							WHERE customer.first_name LIKE 'Fausto'
							AND customer.last_name LIKE 'Pigliacampo')),
(SELECT film.rental_rate
FROM film
INNER JOIN inventory USING (film_id)
WHERE inventory_id = 103));

__________________________________________________________________________________________________________________


Once you're done. Restore the database data using the populate script from class 3.