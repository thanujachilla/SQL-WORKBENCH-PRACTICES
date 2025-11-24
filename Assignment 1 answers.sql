DESCRIBE sakila.actor;
USE sakila;
-- 1) Get all customers whose first name starts with 'J' and who are active.
select * from sakila.customer
Where first_name LIKE "J%" AND active = 1 ;

-- 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
select * FROM sakila.film
Where title LIKE "%ACTION%" OR description LIKE "%WAR%";

-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
select * FROM sakila.customer
Where last_name <> 'SMITH' AND first_name LIKE "%a" ;

-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
select * FROM sakila.film
Where rental_rate > 3.0 AND replacement_cost IS NOT NULL ;

-- 5. Count how many customers exist in each store who have active status = 1.
Select store_id, COUNT(*) AS Active_customers
FROM sakila.customer
WHERE active = 1
GROUP BY store_id;

-- 6. Show distinct film ratings available in the film table.
SELECT DISTINCT rating FROM sakila.film;

-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
SELECT rental_duration, Count(film_id) AS Film_count FROM sakila.film 
GROUP BY rental_duration
HAVING AVG(length) > 100 ;

-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
Select Payment_date, SUM(amount) FROM sakila.payment
GROUP BY Payment_date
HAVING count(*)>100;

-- 9. Find customers whose email address is null or ends with '.org'.
Select * FROM sakila.customer
WHERE email IS NULL OR email LIKE '%.org';

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
Select * FROM sakila.film   -- Select title,rating, rental_rate FROM sakila.film
WHERE rating IN ('PG','G')
ORDER BY rental_rate DESC;

-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
Select rental_duration, count(*) 
FROM sakila.film
WHERE title LIKE 'T%' 
GROUP BY rental_duration
HAVING COUNT(*) > 5 ;

-- 12. List all actors who have appeared in more than 10 films.
SELECT a.actor_id, a.first_name, a.last_name, count(film_id) AS FILM_COUNT FROM sakila.actor a 
LEFT JOIN  Sakila.film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING FILM_COUNT > 10;

-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
Select rental_rate, length FROM sakila.film
ORDER BY rental_rate ASC, length DESC
limit 5;

-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.

Select c.customer_id, c.first_name, c.last_name, count(r.rental_id) AS rental_count FROM sakila.customer c LEFT JOIN sakila.rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC;

-- 15. List the film titles that have never been rented.
Select f.title FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id 
LEFT JOIN rental r ON i.inventory_id  = r.inventory_id
WHERE r.rental_id IS NULL;

-- 16. Find all staff members along with the total payments they have processed, ordered by total payment amount in descending order.
select s.staff_id, s.first_name, s.last_name, count(p.payment_id) AS Proc_payments, SUM(p.amount) AS total_amount FROM staff s 
LEFT JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name 
HAVING proc_payments
ORDER BY total_amount DESC;

-- 17. Show the category name along with the total number of films in each category.
Select c.name, Count(fc.film_id) AS Total_films FROM category c 
LEFT JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- 18. List the top 3 customers who have spent the most money in total.
Select c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS Total_amount 
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY Total_amount DESC
LIMIT 3;

-- 19. Find all films that were rented in the month of May (any year) and have a rental duration greater than 5 days.
Select f.film_id, f.title FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.rental_duration > 5 AND MONTH(rental_date) = 5;

-- 20. Get the average rental rate for each film category, but only include categories with more than 50 films.
Select c.name, avg(f.rental_rate) as AVG_rentalrate
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
Having count(distinct fc.film_id) > 50;






