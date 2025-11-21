# SQL STRING IN-BUILT FUNCTIONS PRACTICES

CREATE DATABASE IF NOT EXISTS functions_db;
USE functions_db;

# Sample Tables

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS numbers;

CREATE TABLE users (
    id INT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO users VALUES
(1, 'Alice Johnson',   'alice.johnson@example.com',   'New York'),
(2, 'Bob Stone',       'bob.stone@example.org',       'Boston'),
(3, 'Charlie Brown',   'charlie_b@example.net',       'Chicago'),
(4, 'david',           'david@example.com',           'Dallas');

CREATE TABLE numbers (
    id INT,
    value DECIMAL(10,4)
);

INSERT INTO numbers VALUES
(1, 10.25),
(2, 7.8),
(3, -3.4),
(4, 5.0);

SELECT * FROM users;
SELECT * FROM numbers;


# LPAD (left pad) & RPAD (right pad)

-- LPAD: pad from the left to a fixed length
SELECT full_name, LPAD(full_name, 15, '*') AS padded_name
FROM users;

SELECT id, LPAD(id, 4, '0') AS padded_id
FROM users;

-- RPAD: pad from the right
SELECT city, RPAD(city, 10, '.') AS padded_city
FROM users;

# SUBSTRING (SUBSTR)

-- SUBSTRING(string, start, length)
SELECT full_name, SUBSTRING(full_name, 1, 5) AS first_5_chars
FROM users;

-- Start from position 7 to end
SELECT full_name, SUBSTRING(full_name, 7) AS from_7_onwards
FROM users;

-- Using SUBSTR alias
SELECT email, SUBSTR(email, 1, 10) AS first_10
FROM users;

# CONCAT (concatenation)

SELECT CONCAT(full_name, ' - ', email) AS name_email
FROM users;

SELECT CONCAT(city, ', ', 'USA') AS city_country
FROM users;

SELECT CONCAT('User ID: ', id) AS label
FROM users;

# REVERSE

SELECT full_name, REVERSE(full_name) AS reversed_name
FROM users;

SELECT email, REVERSE(email) AS reversed_email
FROM users;

# LENGTH (bytes) / CHAR_LENGTH (characters)

SELECT full_name, LENGTH(full_name) AS name_length_bytes
FROM users;

SELECT email, CHAR_LENGTH(email) AS email_length_chars
FROM users;

SELECT city, LENGTH(city) AS city_len
FROM users;

# LOCATE & SUBSTRING with LOCATE

-- LOCATE(substring, string) → position of substring
SELECT email, LOCATE('@', email) AS at_pos
FROM users;

-- Extract username part before '@'
SELECT email,
       SUBSTRING(email, 1, LOCATE('@', email) - 1) AS username_part
FROM users;

-- Extract domain part after '@'
SELECT email,
       SUBSTRING(email, LOCATE('@', email) + 1) AS domain_part
FROM users;

# SUBSTRING_INDEX

-- SUBSTRING_INDEX(string, delimiter, count)
-- Get part before '@'
SELECT email,
       SUBSTRING_INDEX(email, '@', 1) AS username_part
FROM users;

-- Get part after '@'
SELECT email,
       SUBSTRING_INDEX(email, '@', -1) AS domain_part
FROM users;

-- Using '.' as delimiter to get first part of city/email
SELECT email,
       SUBSTRING_INDEX(email, '.', 1) AS before_first_dot
FROM users;

-------------------------------------------------------------
# UPPER() and LOWER()
-------------------------------------------------------------

SELECT full_name,
       UPPER(full_name) AS upper_name,
       LOWER(full_name) AS lower_name
FROM users;

SELECT city, UPPER(city) AS city_upper
FROM users;

# LEFT() and RIGHT()

SELECT full_name,
       LEFT(full_name, 3)  AS left_3,
       RIGHT(full_name, 3) AS right_3
FROM users;

SELECT email,
       LEFT(email, 5) AS first_5,
       RIGHT(email, 7) AS last_7
FROM users;

# REPLACE()

-- Replace domain in email
SELECT email,
       REPLACE(email, 'example.com', 'mydomain.com') AS new_email
FROM users;

-- Replace spaces with underscores
SELECT full_name,
       REPLACE(full_name, ' ', '_') AS underscored_name
FROM users;

# CASE statement

-- Simple CASE for salary-like classification using numbers table
SELECT id, value,
       CASE
           WHEN value < 0 THEN 'Negative'
           WHEN value = 0 THEN 'Zero'
           WHEN value > 0 AND value < 10 THEN 'Small'
           ELSE 'Large'
       END AS value_category
FROM numbers;

-- CASE on city
SELECT full_name, city,
       CASE city
           WHEN 'New York' THEN 'East Coast'
           WHEN 'Boston'   THEN 'East Coast'
           ELSE 'Other'
       END AS region
FROM users;


# REGULAR EXPRESSION (REGEXP / RLIKE)

-- Names starting with capital letter A–M
SELECT * FROM users
WHERE full_name REGEXP '^[A-M]';

-- Emails ending with .com
SELECT * FROM users
WHERE email REGEXP '\\.com$';

-- Full name containing digit (example pattern)
SELECT * FROM users
WHERE full_name REGEXP '[0-9]';

# Mathematical operations (+, -, *, /)

SELECT id, value,
       value + 10  AS plus_10,
       value - 2   AS minus_2,
       value * 2   AS times_2,
       value / 2   AS half
FROM numbers;

-- Using expressions directly
SELECT 10 + 5 AS add_result,
       10 - 3 AS sub_result,
       10 * 4 AS mul_result,
       10 / 4 AS div_result;

# CEIL() and FLOOR()

SELECT id, value,
       CEIL(value)  AS ceil_value,
       FLOOR(value) AS floor_value
FROM numbers;

SELECT CEIL(7.1) AS c1, FLOOR(7.9) AS f1;

# RAND()

-- Random number between 0 and 1
SELECT RAND() AS random_1,
       RAND() AS random_2;

-- Random number between 1 and 100
SELECT FLOOR(1 + (RAND() * 100)) AS random_1_to_100;

-- Random value alongside each row
SELECT id, value, RAND() AS random_value
FROM numbers;

# POWER() and MODULUS (MOD)

SELECT id, value,
       POWER(value, 2) AS squared
FROM numbers;

SELECT POWER(2, 3) AS two_power_three,
       POWER(10, 2) AS ten_square;

-- MOD(x, y) = remainder after division
SELECT MOD(10, 3) AS mod_10_3,
       MOD(15, 4) AS mod_15_4,
       MOD(7, 2)  AS mod_7_2;

-- Modulus on table values
SELECT id, value,
       MOD(value, 2) AS mod_by_2
FROM numbers;

# CAST()
-- Cast string to number
SELECT CAST('123' AS UNSIGNED)   AS num_value,
       CAST('45.67' AS DECIMAL(10,2)) AS dec_value;

-- Cast number to CHAR
SELECT value,
       CAST(value AS CHAR) AS value_as_text
FROM numbers;

-- Cast date string to DATE
SELECT CAST('2025-11-20' AS DATE) AS casted_date;

# UPDATE & SET

SELECT * FROM numbers;

-- Increase all values by 1
UPDATE numbers
SET value = value + 1;

SELECT * FROM numbers;

-- Set city to UPPERCASE for all users in 'Boston'
UPDATE users
SET city = UPPER(city)
WHERE city = 'Boston';

SELECT * FROM users;

-- Change email domain using REPLACE in UPDATE
UPDATE users
SET email = REPLACE(email, 'example.com', 'practice.com');

SELECT * FROM users;

-- DROP DATABASE functions_db;

