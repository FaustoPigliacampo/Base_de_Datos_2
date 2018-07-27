#1)
SELECT c.country_id, c.country, COUNT(*)
FROM country c, city
WHERE c.country_id = city.country_id
GROUP BY country_id, country
ORDER BY country, country_id;

#O

SELECT c.country_id, c.country, COUNT(city_id)
FROM country c
INNER JOIN city USING (country_id)
GROUP BY country_id, country
ORDER BY country, country_id;



#2)
SELECT c.country_id, c.country, COUNT(city_id) AS total
FROM country c
INNER JOIN city
	USING (country_id)
GROUP BY c.country_id
HAVING COUNT(city_id) > 10
ORDER BY 3 DESC;



#3)
SELECT customer.first_name, customer.last_name,
		(SELECT address.address FROM address WHERE customer.address_id = address.address_id) AS address,
		COUNT(*) AS rents,
		(SELECT SUM(amount) FROM payment WHERE payment.customer_id = customer.customer_id) AS amount
FROM customer
INNER JOIN rental
	ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY amount DESC;



#4)
SELECT film_id, title
FROM film
WHERE film_id NOT IN (SELECT DISTINCT film_id FROM inventory);



#5)
SELECT title, inventory_id
FROM film, inventory
WHERE film.film_id = inventory.film_id
AND film.film_id IN (SELECT film_id FROM inventory)
AND title NOT IN (SELECT DISTINCT film.title
					FROM film, inventory, rental
					WHERE film.film_id = inventory.film_id
					AND inventory.inventory_id = rental.inventory_id);



#6)
SELECT customer.last_name, customer.first_name, inventory.store_id, film.title
FROM film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN customer USING (customer_id)
WHERE return_date IS NOT NULL
ORDER BY inventory.store_id, customer.last_name;



#7)
SELECT (SELECT CONCAT(city.city,', ', country.country)
		FROM store, address, city, country
		WHERE store.store_id =  s.store_id
		AND store.address_id = address.address_id
		AND address.city_id = city.city_id
		AND city.country_id = country.country_id) AS store,
		(SELECT CONCAT(staff.first_name,' ', staff.last_name)
		FROM staff
		WHERE staff.store_id = s.store_id) AS manager,
		SUM(p.amount) AS total_sales
FROM payment p
INNER JOIN rental USING (rental_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN store s USING (store_id)
GROUP BY s.store_id;



#8)
SELECT rating, sum(amount)
FROM film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN payment USING (rental_id)
GROUP BY 1;


#9)
SELECT actor_id, first_name, last_name, COUNT(*) AS films
FROM actor
INNER JOIN(film_actor) USING (actor_id)
GROUP BY 1
ORDER BY films DESC
LIMIT 1;



#10)
SELECT name, AVG(film.`length`) AS promedio
FROM category
INNER JOIN (film_category) USING (category_id)
INNER JOIN (film) USING (film_id)
GROUP BY 1
HAVING promedio > (SELECT AVG(`length`) FROM film)
ORDER BY promedio DESC;