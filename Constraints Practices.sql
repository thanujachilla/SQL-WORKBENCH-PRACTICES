-------------------------------------------------------------
# Constraints in SQL  
# PRIMARY KEY, FOREIGN KEY, NOT NULL, CHECK  
# DELETE vs TRUNCATE vs DROP
-------------------------------------------------------------
CREATE DATABASE constraints_db; #Create DB
USE constraints_db; # Use DB
-------------------------------------------------------------
# NOT NULL and UNIQUE Constraints
-------------------------------------------------------------
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id INT NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    age INT
);

SELECT * FROM customers;

-- Insert Success
INSERT INTO customers (id, first_name, last_name, age)
VALUES (1, 'Alice', 'Brown', 28);

-- NULL allowed in last_name & age
INSERT INTO customers (id, first_name, last_name, age)
VALUES (2, 'Bob', NULL, NULL);

-- This will FAIL (duplicate id)
INSERT INTO customers (id, first_name, last_name, age)
VALUES (1, 'Chloe', 'James', 22);

-- This will FAIL (first_name is NOT NULL)
INSERT INTO customers (id, first_name, last_name, age)
VALUES (3, NULL, 'Kevin', 30);

-------------------------------------------------------------
# PRIMARY KEY Constraint
-------------------------------------------------------------

ALTER TABLE customers
ADD PRIMARY KEY (id);

SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'constraints_db'
AND TABLE_NAME = 'customers'
AND CONSTRAINT_TYPE = 'PRIMARY KEY';

-- Drop Primary Key
ALTER TABLE customers
DROP PRIMARY KEY;

-- Add Primary Key with custom name
ALTER TABLE customers
ADD CONSTRAINT PK_Customers PRIMARY KEY (id);

-------------------------------------------------------------
# FOREIGN KEY Constraint
-------------------------------------------------------------

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Parent table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Child table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO customers (id, name)
VALUES (1, 'Alice'), (2, 'Bob');

INSERT INTO orders (order_id, order_date, customer_id)
VALUES (1001, '2024-06-10', 1);

-- This will FAIL (customer_id 999 does not exist)
INSERT INTO orders (order_id, order_date, customer_id)
VALUES (1002, '2024-06-11', 999);

-- Test ON DELETE RESTRICT (will fail)
DELETE FROM customers WHERE id = 1;

-- Test ON UPDATE CASCADE
UPDATE customers SET id = 5 WHERE id = 1;

SELECT * FROM customers;  -- parent
SELECT * FROM orders;     -- child

-------------------------------------------------------------
# CHECK and DEFAULT Constraints
-------------------------------------------------------------

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age INT CHECK (age >= 18),
    city VARCHAR(100) DEFAULT 'New York'
);

SELECT * FROM employees;

INSERT INTO employees (id, first_name, last_name, age)
VALUES (1, 'Joey', 'Tribbiani', 21);

-- FAIL: age must be >= 18
INSERT INTO employees (id, first_name, last_name, age)
VALUES (2, 'Ross', 'Geller', 12);

-- DEFAULT applies
INSERT INTO employees (id, first_name, last_name, age)
VALUES (3, 'Rachel', 'Green', 25);

SELECT * FROM employees;

-------------------------------------------------------------
# DELETE vs TRUNCATE vs DROP
-------------------------------------------------------------

DROP TABLE IF EXISTS sample;

CREATE TABLE sample (
    id INT,
    name VARCHAR(50)
);

INSERT INTO sample VALUES
(1, 'A'),
(2, 'B'),
(3, 'C');

SELECT * FROM sample;

-------------------------------------------------------------
# DELETE
# Removes data row-by-row, can use WHERE, can rollback
-------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;

-- Delete specific rows
DELETE FROM sample WHERE id = 1;

SELECT * FROM sample;

-------------------------------------------------------------
# TRUNCATE
# Removes all data instantly, resets AUTO_INCREMENT, cannot use WHERE
-------------------------------------------------------------

TRUNCATE TABLE sample;

SELECT * FROM sample;   -- empty

-------------------------------------------------------------
# DROP
# Removes table structure + data
-------------------------------------------------------------

DROP TABLE sample;

-------------------------------------------------------------
# Drop database
DROP DATABASE constraints_db;
-------------------------------------------------------------
