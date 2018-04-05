DROP TABLE IF EXISTS IMDB;

CREATE DATABASE IMDB;

CREATE TABLE film(
	film_id INT(11) NOT NULL AUTO_INCREMENT,
	title VARCHAR(40) NOT NULL,
	description VARCHAR(200),
	relese_year DATE,
	CONSTRAINT films_pk PRIMARY KEY (film_id));

CREATE TABLE actor(
	actor_id INT(11) NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(80) NOT NULL,
	CONSTRAINT actors_pk PRIMARY KEY (actor_id));

CREATE TABLE film_actor(
	actor_id INT(11),
	film_id INT(11));

ALTER TABLE film ADD last_update DATE AFTER relese_year;
ALTER TABLE actor ADD last_update DATE AFTER last_name;

ALTER TABLE film_actor ADD CONSTRAINT fk_ac_film_1 FOREIGN KEY (actor_id, location) REFERENCES actor (actor_id, location);
ALTER TABLE film_actor ADD CONSTRAINT fk_ac_film_2 FOREIGN KEY (film_id, location) REFERENCES film (film_id, location);