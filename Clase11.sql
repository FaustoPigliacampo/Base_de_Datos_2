1)
SELECT c.country_id, c.country, COUNT(*)
FROM country c, city
WHERE c.country_id = city.country_id
GROUP BY country_id, country
ORDER BY country, country_id;


2)
SELECT c.country_id, c.country, COUNT(city) AS total
FROM country c
INNER JOIN city
	ON city.country_id = c.country_id
GROUP BY c.country_id
HAVING COUNT(city) > 10
ORDER BY COUNT(city) DESC;


3)
SELECT customer.first_name, customer.last_name,
		(SELECT address.address
		FROM address
		WHERE customer.address_id = address.address_id) AS address,
		COUNT(*) AS rents,
		(SELECT SUM(amount)
		FROM payment
		WHERE payment.customer_id = customer.customer_id) AS amount
FROM customer
INNER JOIN rental
	ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY amount DESC;


4)
SELECT film_id, title
FROM film
WHERE film_id NOT IN (SELECT film_id FROM inventory);


5)
SELECT title, inventory_id
FROM film, inventory
WHERE film.film_id = inventory.film_id
AND film.film_id IN (SELECT film_id FROM inventory)
AND title NOT IN (SELECT DISTINCT film.title
					FROM film, inventory, rental
					WHERE film.film_id = inventory.film_id
					AND inventory.inventory_id = rental.inventory_id);


6)
SELECT customer.last_name, customer.first_name, store.store_id, film.title
FROM rental, film,customer,store, staff, inventory
WHERE return_date IS NULL 
AND rental.customer_id = customer.customer_id
AND store.store_id = staff.store_id
AND staff.staff_id = rental.staff_id
AND film.film_id = inventory.film_id
AND inventory.inventory_id = rental.inventory_id
ORDER BY store.store_id, customer.last_name;