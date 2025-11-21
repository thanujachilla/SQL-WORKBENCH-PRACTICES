-- 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
SELECT email,first_name,last_name,address_id, Count(*) FROM Sakila.customer
GROUP BY email,first_name,last_name,address_id
HAVING COUNT(*)>1;
---------------------------------------------------------------------------------------------------------------------
-- 2. Number of times letter 'a' is repeated in film descriptions
SELECT 
    SUM(
        LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'a', ''))
    ) AS total_a_count
FROM Sakila.film;
---------------------------------------------------------------------------------------------------------------------
-- 3. Number of times each vowel is repeated in film descriptions 
SELECT 
SUM(LENGTH(DESCRIPTION) - LENGTH(REPLACE(LOWER(DESCRIPTION),'a',''))) AS a_COUNT,
SUM(LENGTH(DESCRIPTION) - LENGTH(REPLACE(LOWER(DESCRIPTION),'e',''))) AS e_COUNT,
SUM(LENGTH(DESCRIPTION) - LENGTH(REPLACE(LOWER(DESCRIPTION),'i',''))) AS i_COUNT,
SUM(LENGTH(DESCRIPTION) - LENGTH(REPLACE(LOWER(DESCRIPTION),'o',''))) AS o_COUNT,
SUM(LENGTH(DESCRIPTION) - LENGTH(REPLACE(LOWER(DESCRIPTION),'u',''))) AS u_COUNT
FROM Sakila.film;
---------------------------------------------------------------------------------------------------------------------
-- 4. Display the payments made by each customer
       -- i. Year wise
SELECT
customer_id,
YEAR(payment_date)  AS pay_year,
COUNT(*)            AS payment_count,
SUM(amount)         AS total_amount
FROM sakila.payment
GROUP BY
customer_id,
YEAR(payment_date)
ORDER BY customer_id,
YEAR(payment_date);

-- ii. Month wise
SELECT
customer_id,
MONTH(payment_date)  AS pay_month,
COUNT(*)            AS payment_count,
SUM(amount)         AS total_amount
FROM sakila.payment
GROUP BY
customer_id,
MONTH(payment_date)
ORDER BY customer_id,
MONTH(payment_date);

-- iii. Week wise
SELECT
customer_id,
YEARWEEK(payment_date, 3) AS year_week,
COUNT(*)                  AS payment_count,
SUM(amount)               AS total_amount
FROM sakila.payment
GROUP BY customer_id,
YEARWEEK(payment_date, 3)
ORDER BY customer_id,
YEARWEEK(payment_date, 3);

---------------------------------------------------------------------------------------------------------------------
-- 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
SELECT
CASE
WHEN(MOD(2024 , 400)=0 OR (MOD(2024 , 4) = 0 AND (MOD(2024 , 100) <> 0)))
THEN 'LEAP YEAR'
ELSE 'NOT LEAP YEAR' 
END AS RESULT_LEAP_YEAR;
---------------------------------------------------------------------------------------------------------------------
-- 6. Display number of days remaining in the current year from today.

SELECT DATEDIFF((CONCAT(YEAR(CURDATE()),'-','12-31')) , CURDATE()) AS remaining_days;
---------------------------------------------------------------------------------------------------------------------
-- 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table. 

SELECT Payment_id,Payment_date,
CASE 
WHEN MONTH(Payment_date) BETWEEN 1 AND 3 THEN 'Q1'
WHEN MONTH(Payment_date) BETWEEN 4 AND 6 THEN 'Q2'
WHEN MONTH(Payment_date) BETWEEN 7 AND 9 THEN 'Q3'
WHEN MONTH(Payment_date) BETWEEN 10 AND 12 THEN 'Q4'
ELSE 'NO QUARTER'
END AS QUARTER_INFO
FROM Sakila.payment;
---------------------------------------------------------------------------------------------------------------------
-- 8. Display the age in year, months, days based on your date of birth-----------
  -- For example: 21 years, 4 months, 12 days
 SELECT 
  CONCAT(
    TIMESTAMPDIFF(YEAR, '2000-04-20', CURDATE()), ' years, ',
    TIMESTAMPDIFF(MONTH, '2000-04-20', CURDATE()) 
       - TIMESTAMPDIFF(YEAR, '2000-04-20', CURDATE()) * 12, ' months, ',
    DATEDIFF(
        CURDATE(),
        DATE_ADD(
            '2000-04-20',
            INTERVAL TIMESTAMPDIFF(MONTH, '2000-04-20', CURDATE()) MONTH
        )
    ), ' days'
  ) AS age;
   