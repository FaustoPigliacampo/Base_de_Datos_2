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
SELECT DISTINCT r1.customer_id
FROM rental r1
WHERE NOT EXISTS (SELECT *
                FROM rental r2
                WHERE r1.customer_id = r2.customer_id
                AND r1.rental_id != r2.rental_id);


4)
SELECT DISTINCT r1.customer_id
FROM rental r1
WHERE EXISTS (SELECT *
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
FROM actor a
WHERE EXISTS (
    SELECT *
    FROM film_actor f_a
    WHERE a.actor_id = f_a.actor_id
    AND EXISTS (
        SELECT * 
        FROM film f
        WHERE f.film_id = f_a.film_id
        AND (title LIKE ('BETRAYED REAR') AND title NOT LIKE ('CATCH AMISTAD'))));



ARREGLAR [[[[


7)
SELECT first_name, last_name
FROM actor a
WHERE EXISTS (
    SELECT *
    FROM film_actor f_a
    WHERE a.actor_id = f_a.actor_id
    AND EXISTS (
        SELECT * 
        FROM film f
        WHERE f.film_id = f_a.film_id
        AND (title LIKE ('CATCH AMISTAD') AND title LIKE ('BETRAYED REAR'))));
            


8)
SELECT *
FROM actor q1
WHERE EXISTS (
    SELECT *
    FROM film_actor q2
    WHERE q1.actor_id = q2.actor_id
    AND EXISTS (
        SELECT * 
        FROM film q3
        WHERE q3.film_id = q2.film_id
        AND title NOT LIKE ('BETRAYED REAR') OR ('CATCH AMISTAD')
    )
);


]]]]