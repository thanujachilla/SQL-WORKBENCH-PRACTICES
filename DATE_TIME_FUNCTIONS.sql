# SQL DATE & TIME FUNCTIONS PRACTICE

USE sakila;

# NOW(), CURRENT_TIMESTAMP(), CURDATE(), CURTIME()

SELECT NOW() AS current_datetime;

SELECT CURRENT_TIMESTAMP AS current_ts;

SELECT CURDATE() AS today_date;

SELECT CURTIME() AS current_time;

# DATE(), TIME() – extract only date or time from DATETIME

SELECT rental_id, rental_date, DATE(rental_date) AS only_date
FROM rental
LIMIT 5;

SELECT rental_id, rental_date, TIME(rental_date) AS only_time
FROM rental
LIMIT 5;

# YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND()

SELECT rental_id,
       YEAR(rental_date) AS year_rented,
       MONTH(rental_date) AS month_rented,
       DAY(rental_date) AS day_rented
FROM rental
LIMIT 5;

SELECT payment_id,
       HOUR(payment_date) AS pay_hour,
       MINUTE(payment_date) AS pay_minute,
       SECOND(payment_date) AS pay_second
FROM payment
LIMIT 5;

# DATEDIFF() – difference in days

-- Days between return_date and rental_date
SELECT rental_id, rental_date, return_date,
       DATEDIFF(return_date, rental_date) AS days_rented
FROM rental
WHERE return_date IS NOT NULL
LIMIT 10;

-- Difference between today and rental_date
SELECT rental_id,
       DATEDIFF(CURDATE(), DATE(rental_date)) AS days_since_rented
FROM rental
LIMIT 5;

# TIMESTAMPDIFF() – difference in any unit

-- Hours between rental and return
SELECT rental_id,
       TIMESTAMPDIFF(HOUR, rental_date, return_date) AS hours_rented
FROM rental
WHERE return_date IS NOT NULL
LIMIT 10;

-- Months between two dates in payment
SELECT payment_id,
       TIMESTAMPDIFF(MONTH, payment_date, NOW()) AS months_difference
FROM payment
LIMIT 5;

# ADDDATE(), SUBDATE(), DATE_ADD(), DATE_SUB()

-- Add 7 days to rental_date
SELECT rental_id, rental_date,
       DATE_ADD(rental_date, INTERVAL 7 DAY) AS due_date
FROM rental
LIMIT 5;

-- Subtract 1 month from payment_date
SELECT payment_id, payment_date,
       DATE_SUB(payment_date, INTERVAL 1 MONTH) AS previous_month
FROM payment
LIMIT 5;

# EXTRACT() – extract year, month, day, etc.

SELECT rental_id,
       EXTRACT(YEAR FROM rental_date) AS year_part,
       EXTRACT(MONTH FROM rental_date) AS month_part,
       EXTRACT(DAY FROM rental_date) AS day_part
FROM rental
LIMIT 5;

-- Extract hour/minute from payment
SELECT payment_date,payment_id,
       EXTRACT(HOUR FROM payment_date) AS hour_part,
       EXTRACT(MINUTE FROM payment_date) AS minute_part
FROM payment
LIMIT 5;

# DATE_FORMAT() – custom formatting

SELECT rental_id,
       DATE_FORMAT(rental_date, '%d-%M-%Y') AS formatted_date
FROM rental
LIMIT 5;

SELECT payment_id,
       DATE_FORMAT(payment_date, '%Y/%m/%d %H:%i') AS formatted_dt
FROM payment
LIMIT 5;

# STR_TO_DATE() – convert strings into dates

SELECT STR_TO_DATE('20-11-2025', '%d-%m-%Y') AS converted_date;

SELECT STR_TO_DATE('2025/11/20 14:30', '%Y/%m/%d %H:%i') AS converted_dt;

# UNIX_TIMESTAMP() & FROM_UNIXTIME()---This calculates:nHow many seconds between 1970-01-01 00:00:00 UTC AND 2005-05-25 11:30:45

SELECT payment_id,
       UNIX_TIMESTAMP(payment_date) AS epoch_time
FROM payment
LIMIT 5;

-- Convert epoch back to readable datetime
SELECT FROM_UNIXTIME(1700000000) AS readable_datetime;

-------------------------------------------------------------
# LEAST(), GREATEST(), MIN(), MAX()
-------------------------------------------------------------

-- MAX payment amount
SELECT MAX(amount) AS max_payment FROM payment;

-- MIN rental duration
SELECT MIN(DATEDIFF(return_date, rental_date)) AS min_days
FROM rental WHERE return_date IS NOT NULL;

-- GREATEST / LEAST (compare values)
SELECT GREATEST(20,50,16) AS greatest_value , LEAST(10, 20, 5) AS least_value;

# COALESCE() – handle NULL values

SELECT customer_id,
       COALESCE(return_date, 'Not Returned Yet') AS status
FROM rental
LIMIT 10;

# LAST_DAY() – last day of month

SELECT rental_date, LAST_DAY(rental_date) AS month_end
FROM rental
LIMIT 5;

# DAYNAME(), MONTHNAME()

SELECT rental_date,
       DAYNAME(rental_date) AS weekday,
       MONTHNAME(rental_date) AS month_name
FROM rental
LIMIT 5;

-------------------------------------------------------------
# NOW vs SYSDATE – difference
-------------------------------------------------------------

SELECT NOW() AS now_function, SYSDATE() AS sysdate_function;
-- now()
-- Returns the time when the query started
-- Stays fixed for the whole query
-- Does not change even if the query runs for 30 seconds
-- SYSDATE()
-- returns the exact system time at the moment the function is executed.
-- If your query takes 10 seconds to run, SYSDATE() can change inside the same query.


-- DROP DATABASE functions_db;(IF NEEDED)
