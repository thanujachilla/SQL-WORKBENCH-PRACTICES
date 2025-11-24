USE Sakila;
-- 1. display all customer details who have made more than 5 payments.
select *
from customer
where customer_id in (SELECT customer_id
FROM PAYMENT
GROUP BY customer_id
having count(*) > 5);

-- 2. Find the names of actors who have acted in more than 10 films.
SELECT first_name, last_name FROM actor WHERE actor_id IN (Select actor_id 
FROM film_actor 
GROUP BY actor_id
HAVING count(*) > 10);

-- 3. Find the names of customers who never made a payment.
Select first_name, last_name FROM Customer WHERE customer_id NOT IN (Select DISTINCT customer_id FROM payment);

-- 4. List all films whose rental rate is higher than the average rental rate of all films.
Select * FROM film WHERE rental_rate > (Select AVG(rental_rate) FROM film);

-- 5. List the titles of films that were never rented.
Select title FROM film WHERE film_id NOT IN (Select film_id FROM Inventory WHERE inventory_id IN (Select Inventory_id FROM rental));

-- 6. Display the customers who rented films in the same month as customer with ID 5.
SELECT DISTINCT first_name, last_name, email
FROM customer
WHERE customer_id IN (
SELECT DISTINCT customer_id
FROM rental
WHERE DATE_FORMAT(rental_date, '%Y-%m') IN (
SELECT DISTINCT DATE_FORMAT(rental_date, '%Y-%m')
FROM rental
WHERE customer_id = 5));

-- 7. Find all staff members who handled a payment greater than the average payment amount.
SELECT staff_id, first_name, last_name
FROM staff
WHERE staff_id IN (
SELECT DISTINCT staff_id
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment));

-- 8. Show the title and rental duration of films whose rental duration is greater than the average.
SELECT title, rental_duration
FROM film
WHERE rental_duration > (SELECT AVG(rental_duration) FROM film);

-- 9. Find all customers who have the same address as customer with ID 1.
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE address_id = (
SELECT address_id
FROM customer WHERE customer_id = 1) AND customer_id <> 1;

-- 10. List all payments that are greater than the average of all payments.
SELECT payment_id, customer_id, staff_id, amount, payment_date
FROM payment
WHERE amount > (
SELECT AVG(amount)
FROM payment);


