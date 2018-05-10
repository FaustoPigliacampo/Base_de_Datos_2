1)
SELECT c.country_id, c.country, COUNT(*)
FROM country c, city
WHERE c.country_id = city.country_id
GROUP BY country_id, country
ORDER BY country, country_id;


2)
SELECT c.country_id, c.country, (SELECT COUNT(*) FROM city WHERE c.country_id = city.country_id) AS total
FROM country c
WHERE (SELECT COUNT(*) FROM city WHERE city.country_id = c.country_id) > 10
ORDER BY (SELECT COUNT(*) FROM city WHERE city.country_id = c.country_id) DESC;


3)
Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. 


Show the ones who spent more money first .