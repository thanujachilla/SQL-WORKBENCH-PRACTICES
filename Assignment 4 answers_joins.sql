-- SQL JOIN QUESTIONS 
USE sakila;
-- 1. List all customers along with the films they have rented.
Select c.customer_id,c.first_name,c.last_name,f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id
ORDER BY c.customer_id;

-- 2. List all customers and show their rental count, including those who haven't rented any films.
SELECT c.customer_id, c.first_name, c.last_name, count(r.rental_id) AS Rental_count 
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY Rental_count;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
Select f.film_id,f.title,fc.category_id
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
ORDER BY fc.category_id;

-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
Select c.customer_id,c.first_name,c.last_name,sff.email AS Staff_Email
FROM customer c 
LEFT JOIN staff sff ON c.store_id = sff.store_id
UNION
Select c.customer_id,c.first_name,c.last_name,sff.email 
FROM customer c 
RIGHT JOIN staff sff ON c.store_id = sff.store_id;

-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".
Select a.actor_id, a.first_name, a.last_name,f.title 
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'ACADEMY DINOSAUR';

-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
Select s.store_id,s.address_id, count(sff.staff_id) AS Staff_Count 
FROM store s 
LEFT JOIN staff sff ON s.store_id = sff.store_id 
GROUP BY s.store_id,s.address_id;

-- select staff_id FROM staff;

-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.
Select c.customer_id, c.first_name,c.last_name, count(R.rental_id) AS rental_count
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name,c.last_name
HAVING Count(r.rental_id) > 5
ORDER BY c.customer_id;
