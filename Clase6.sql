1)
SELECT a1.first_name, a1.last_name
FROM actor a1
WHERE EXISTS (SELECT *
                FROM actor a2
                WHERE a1.last_name = a2.last_name
                AND a1.actor_id <> a2.actor_id)
ORDER BY last_name;



2)
SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (SELECT DISTINCT actor_id
                        FROM film_actor);

                

3)
SELECT DISTINCT r1.customer_id, c.first_name, c.last_name
FROM rental r1, customer c
WHERE c.customer_id = r1.customer_id
AND NOT EXISTS (SELECT *
                FROM rental r2
                WHERE r1.customer_id = r2.customer_id
                AND r1.rental_id != r2.rental_id);



4)
SELECT DISTINCT r1.customer_id, c.first_name, c.last_name
FROM rental r1, customer c
WHERE c.customer_id = r1.customer_id
AND EXISTS (SELECT *
                FROM rental r2
                WHERE r1.customer_id = r2.customer_id
                AND r1.rental_id != r2.rental_id);



5)
SELECT DISTINCT first_name, last_name
FROM actor a
WHERE EXISTS (
    SELECT *
    FROM film_actor f_a
    WHERE a.actor_id = f_a.actor_id
    AND EXISTS (
        SELECT * 
        FROM film f
        WHERE f.film_id = f_a.film_id
        AND (title LIKE ('BETRAYED REAR') OR title LIKE ('CATCH AMISTAD'))));



6)
SELECT first_name, last_name
FROM actor
WHERE actor_id IN(
        SELECT actor_id
        FROM film,film_actor 
        WHERE film.film_id=film_actor.film_id 
        AND (film.title LIKE 'BETRAYED REAR')) 
AND actor_id NOT IN (
        SELECT actor_id
        FROM film,film_actor 
        WHERE film.film_id=film_actor.film_id 
        AND (film.title LIKE 'CATCH AMISTAD'));



7)
SELECT first_name, last_name
FROM actor
WHERE actor_id IN(
        SELECT actor_id
        FROM film,film_actor 
        WHERE film.film_id=film_actor.film_id 
        AND (film.title LIKE 'BETRAYED REAR')) 
AND actor_id IN (
        SELECT actor_id
        FROM film,film_actor 
        WHERE film.film_id=film_actor.film_id 
        AND (film.title LIKE 'CATCH AMISTAD'));



8)
SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN(
        SELECT actor_id
        FROM film,film_actor 
        WHERE film.film_id=film_actor.film_id 
        AND (film.title LIKE ('BETRAYED REAR') OR film.title LIKE ('CATCH AMISTAD')));