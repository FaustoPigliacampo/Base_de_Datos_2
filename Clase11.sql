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