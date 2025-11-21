# SQL BASICS – SELECT & CONDITIONS

CREATE DATABASE IF NOT EXISTS basics_db;
USE basics_db;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Alice', 'HR', 5000, 'New York'),
(2, 'Bob', 'IT', 7000, 'Texas'),
(3, 'Charlie', 'HR', 5000, 'Chicago'),
(4, 'David', 'Finance', 9000, 'New York'),
(5, 'Eve', NULL, 7500, 'Texas');

SELECT * FROM employees;


# SELECT  

SELECT name FROM employees;

SELECT id, name, salary FROM employees;

SELECT * FROM employees;

# SELECT DISTINCT  

SELECT DISTINCT department FROM employees;

SELECT DISTINCT city FROM employees;

SELECT DISTINCT salary FROM employees;

# SELECT COUNT  


SELECT COUNT(*) FROM employees;

SELECT COUNT(city) FROM employees;        -- ignores NULLs

SELECT COUNT(DISTINCT department) FROM employees;


# SELECT with LIMIT  

SELECT * FROM employees LIMIT 3;

SELECT name, salary FROM employees ORDER BY salary DESC LIMIT 2;

SELECT * FROM employees LIMIT 1 OFFSET 2;  -- skip first 2, show next 1

# WHERE  

SELECT * FROM employees WHERE city = 'Texas';

SELECT * FROM employees WHERE salary > 6000;

SELECT * FROM employees WHERE department IS NULL;

# AND, OR, NOT  

SELECT * FROM employees WHERE department = 'HR' AND city = 'Chicago';

SELECT * FROM employees WHERE salary > 6000 OR city = 'New York';

SELECT * FROM employees WHERE NOT (department = 'HR');

# LIKE (pattern matching)  
-- % = multiple characters
-- _ = single character

SELECT * FROM employees WHERE name LIKE 'A%';   -- starts with A

SELECT * FROM employees WHERE name LIKE '%e';   -- ends with e

SELECT * FROM employees WHERE name LIKE '_o%';  -- second letter is o

# NULL  

SELECT * FROM employees WHERE department IS NULL;

SELECT * FROM employees WHERE department IS NOT NULL;


# GROUP BY  

SELECT department, COUNT(*) AS total_emps
FROM employees
GROUP BY department;

SELECT city, SUM(salary) AS total_salary
FROM employees
GROUP BY city;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

# HAVING  
-- HAVING works after GROUP BY (unlike WHERE)

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 6000;

SELECT city, COUNT(*) AS count_emps
FROM employees
GROUP BY city
HAVING COUNT(*) >= 2;

# BETWEEN  

SELECT * FROM employees WHERE salary BETWEEN 5000 AND 8000;

SELECT * FROM employees WHERE id BETWEEN 2 AND 4;

# ORDER BY (ASC, DESC)  

SELECT * FROM employees ORDER BY salary ASC;

SELECT * FROM employees ORDER BY salary DESC;

SELECT * FROM employees ORDER BY department ASC, salary DESC;

# < , > , <= , >=  

SELECT * FROM employees WHERE salary > 7000;

SELECT * FROM employees WHERE salary < 6000;

SELECT * FROM employees WHERE salary >= 7000;

SELECT * FROM employees WHERE salary <= 5000;

# Aggregate Functions  
# SUM(), AVG(), MIN(), MAX(), COUNT()

SELECT SUM(salary) FROM employees;

SELECT AVG(salary) FROM employees;

SELECT MIN(salary), MAX(salary) FROM employees;

SELECT COUNT(*) FROM employees;

# SQL ORDER OF EXECUTION  
# 1. FROM  
# 2. WHERE  
# 3. GROUP BY  
# 4. HAVING  
# 5. SELECT  
# 6. ORDER BY  
# 7. LIMIT

-- Example demonstrating full order:
SELECT city, AVG(salary) AS avg_salary
FROM employees
WHERE salary > 5000
GROUP BY city
HAVING AVG(salary) > 6000
ORDER BY avg_salary DESC
LIMIT 2;

DROP DATABASE basics_db; -------------------- NEVER DO IT WHEN YOU WORK IN PRODUCTION/ANY IMP PLACES. 

