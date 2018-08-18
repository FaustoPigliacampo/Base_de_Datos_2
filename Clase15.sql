#1) Create a view named list_of_customers, it should contain the following columns:
#	customer id
#	customer full name, 
#	address
#	zip code
#	phone 
#	city
#	country
#	status (when active column is 1 show it as 'active', otherwise is 'inactive') 
#	store id

CREATE OR REPLACE VIEW list_of_customers AS
	SELECT customer.customer_id, CONCAT(customer.last_name, ', ', customer.first_name) AS 'full name', address.address, 
			address.postal_code AS 'zip code', address.phone, city.city, country.country,
			CASE customer.active WHEN '1' THEN 'active'
									ELSE 'inactive'
									END AS status, 
			customer.store_id
	FROM customer
	INNER JOIN address USING (address_id)
	INNER JOIN city USING (city_id)
	INNER JOIN country USING (country_id);

SELECT * FROM list_of_customers;



#2) Create a view named film_details, it should contain the following columns:
#		film id,  title, description,  category,  price,  length,  rating, 
#		and actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

CREATE OR REPLACE VIEW film_details AS
	SELECT film.film_id, film.title, film.description, c.name AS 'category', film.replacement_cost, film.`length`, film.rating, 
			GROUP_CONCAT(CONCAT(actor.first_name, ' ', actor.last_name) ORDER BY actor.last_name SEPARATOR ' - ') AS 'actors'
	FROM film
	INNER JOIN film_category USING (film_id)
	INNER JOIN category c USING (category_id)
	INNER JOIN film_actor USING (film_id)
	INNER JOIN actor USING (actor_id)
	GROUP BY 1, 4;


SELECT * FROM film_details;



#3) Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

CREATE OR REPLACE VIEW sales_by_film_category AS
	SELECT category.name, SUM(payment.amount) AS total_rental
	FROM category 
	INNER JOIN film_category USING(category_id)
	INNER JOIN film USING(film_id)
	INNER JOIN inventory USING(film_id)
	INNER JOIN rental USING(inventory_id)
	INNER JOIN payment USING(rental_id)
	GROUP BY 1;

SELECT * FROM sales_by_film_category;



#4) Create a view called actor_information where it should return:
#		actor id, first name, last name, and the amount of films he/she acted on.

CREATE OR REPLACE VIEW actor_information AS
	SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film.film_id)
	FROM actor
	INNER JOIN film_actor USING(actor_id)
	INNER JOIN film USING(film_id)
	INNER JOIN inventory USING(film_id)
	INNER JOIN rental USING(inventory_id)
	INNER JOIN payment USING(rental_id)
	GROUP BY 1;

SELECT * FROM actor_information;


#5) Analyze view actor_info, explain the entire query and specially how the sub query works.
#	Be very specific, take some time and decompose each part and give an explanation for each. 


select `a`.`actor_id` AS `actor_id`, `a`.`first_name` AS `first_name`, `a`.`last_name` AS `last_name`,
#Seleccionamos el id, first_name y last_name de actor
	group_concat(
		distinct concat(
			`c`.`name`, ': ',(
			#Nos muestra el nombre de todas las categorías y ...
				select group_concat( `f`.`title` order by `f`.`title` ASC separator ', ' )
				#... las peliculas que pertenecen a esa categoria, en las cuales participo el actor, separadas por ', '
					from(( `sakila`.`film` `f`
						join `sakila`.`film_category` `fc` on(( `f`.`film_id` = `fc`.`film_id` )))
						#Hacemos un JOIN de film_category con la tabla film, cuando los film_id sean iguales
						join `sakila`.`film_actor` `fa` on(( `f`.`film_id` = `fa`.`film_id` )))
						#Hacemos un JOIN de film_actor con la tabla film, cuando los film_id sean iguales
					where(( `fc`.`category_id` = `c`.`category_id` )
					#Comparamos los category_id de ambas tablas
						and( `fa`.`actor_id` = `a`.`actor_id` )))
						#Comparamos los actor_id de ambas tablas
		)order by `c`.`name` ASC separator '; '
		#Ordenamos las categorias en orden ascendente, y las separamos con '; '
	) AS `film_info`
	#Nombramos a la cuarta columna como 'film_info'
from ((( `sakila`.`actor` `a`
		left join `sakila`.`film_actor` `fa` on ( `a`.`actor_id` = `fa`.`actor_id` ))
		left join `sakila`.`film_category` `fc` on ( `fa`.`film_id` = `fc`.`film_id` ))
		left join `sakila`.`category` `c` on( `fc`.`category_id` = `c`.`category_id` )
#Añadimos todas las tablas de las que se va a juntar información
group by `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`;
#Agrupamos por las tres primeras columnas


#6) Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.

Son vistas que  muestran su resultado en una tabla temporaria.
Se utilizan para no tener que repetir una misma query varias veces, y para tener un acceso mas rapido a la informacion.
