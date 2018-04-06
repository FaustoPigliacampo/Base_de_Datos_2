SELECT title, special_features FROM film WHERE rating LIKE 'PG-13';


SELECT title, length FROM film;


SELECT title, rental_rate, replacement_cost
FROM film
WHERE replacement_cost BETWEEN 20.00 AND 24.00;


SELECT film.title, category.name, film.rating
FROM film, film_category, category
WHERE film.film_id=film_category.film_id
AND film_category.category_id=category.category_id
AND film.special_features LIKE 'Behind the Scenes';


SELECT actor.first_name, actor.last_name, film.title 'Titulo'
FROM actor, film_actor, film
WHERE actor.actor_id = film_actor.actor_id
AND film.film_id = film_actor.film_id
AND film.title LIKE 'ZOOLANDER FICTION';


SELECT address.address, city.city, country.country
FROM store, address, city, country
WHERE country.country_id = city.country_id
AND city.city_id = address.city_id
AND address.address_id = store.address_id
AND store.store_id = 1;


SELECT film1.title, film1.rating, film2.rating, film2.title
FROM film film1, film film2
WHERE film1.rating = film2.rating
AND film1.title != film2.title


SELECT title, first_name, last_name , address.address
FROM store, staff, film ,inventory, address
WHERE store.store_id = inventory.store_id
AND inventory.film_id = film.film_id
AND address.address_id = store.address_id
AND store.store_id=2
AND store.manager_staff_id = staff.staff_id;