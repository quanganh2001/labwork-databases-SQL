- On northwind database, write SQL statements to:
USE northwind;
-- 1. List all orders made after '2006-03-24'
SELECT *
FROM orders
WHERE order_date > '2006-03-24';
-- 2. Show product_code, unit_price, quantity, value of orders details whose order_id = 31.
-- Note: value can be calculated as unit_price * quantity * (1-discount) 
SELECT 
	order_id,product_code,
    unit_price,quantity,unit_price*quantity*(1-discount) AS value
FROM order_details
JOIN products ON products.id=order_details.product_id
WHERE order_id=31;

-- 3. Write a query to show the order id, order_date, the company name of customer, value of each row for orders made after ‘2006-03-24’
SELECT
	orders.id AS order_id,
    product_id,
    order_date,
    customers.company,
    unit_price * quantity * (1-discount) AS value
FROM orders
JOIN order_details
	ON orders.id = order_details.order_id
JOIN customers
	ON orders.customer_id = customer_id
WHERE order_date > '2006-03-24 00:00:00';

-- 4. Write a query to show information of each order including: order id, order_date,
-- company name, sub_total value of orders made after ‘2006-03-24’
SELECT
	orders.id, order_date, customers.company,
    SUM(unit_price * quantity * (1-discount)) AS value
FROM orders
JOIN order_details
	ON orders.id = order_details.order_id
JOIN customers
	ON customer_id = customers.id
WHERE order_date > '2006-03-24 00:00:00'
GROUP BY order_id
ORDER BY id;

-- 5. Write a query to show information of each order including: order id, order_date,
-- company name, sub_total of orders made after ‘2006-03-24’ and sub_total greater than
-- or equal to 800. Hint: using HAVING
SELECT orders.id,order_date,company, 
	SUM(unit_price * quantity * (1 - discount)) AS sub_total 
FROM orders
JOIN customers ON orders.customer_id=customers.id
JOIN order_details ON orders.id=order_details.order_id
WHERE order_date > '2006-03-24'
GROUP BY order_id
HAVING sub_total>=800
ORDER BY order_id;

-- 6. As the company will give rewards for employees who sold more than 1000$, the director needs a report listing these employees (full_name, sale in dolars) from high to low. Write a query for this report. 
-- The results will look like the below figure.
SELECT 
	employees.id, 
	CONCAT(first_name, ' ', last_name) AS full_name, 
    SUM(unit_price * quantity * (1-discount)) AS sale
FROM employees
JOIN orders ON employees.id = employee_id
JOIN order_details ON orders.id = order_id
GROUP BY employees.id
HAVING sale > 1000
ORDER BY sale DESC;

-- 7. Create a view consisting all partners (customers and suppliers) of Northwind. The
-- columns consist of company, full_name, email_address, and type (C for customers, S
-- for suppliers).
CREATE VIEW Partners AS
SELECT 
	CONCAT(last_name, ' ', first_name) as full_name,
    email_address,
    'C' as type
FROM Customers
UNION
SELECT 
	CONCAT(last_name, ' ', first_name) as full_name,
    email_address,
    'S' as type
FROM Suppliers;

SELECT * FROM Partners;

-- 8. Show all categories, eliminate duplicated rows, and sort the results according to
-- alphabet order. 
SELECT DISTINCT category FROM products ORDER BY category;

-- 9. Show minimum, maximum, average, standard deviation, and variance of standard_cost of products
SELECT 
	MAX(standard_cost),
    MIN(standard_cost),
    AVG(standard_cost),
    STDDEV(standard_cost)
FROM products;

SELECT VARIANCE(standard_cost) as StandardCost
FROM products;

-- 10. Show the average list_price of each category
SELECT 
	category, 
    AVG(list_price) AS average_list_price
FROM products
GROUP BY category;

-- 11. Create a stored procedure listing top n categories whose average prices are highest. The
-- procedure should accept n as a parameter.

-- List the top 10 categories whose average prices are the highest
DELIMITER //
CREATE PROCEDURE TopNCategories(n INT)
BEGIN
	SELECT 
		category, 
        AVG(list_price) AS average_list_price
	FROM products
	GROUP BY category
    ORDER BY average_list_price DESC
    LIMIT n;
END //
DELIMITER ;

CALL TopNCategories(10);

-- 12. Among avarage list_prices of categories above, show the minimum values.
DELIMITER //
CREATE PROCEDURE mint(n INT)
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS mint AS(
		SELECT category, AVG(list_price) AS average_list_price
		FROM products
		GROUP BY category
        ORDER BY average_list_price DESC
		LIMIT n
	);
    SELECT MIN(average_list_price) AS min FROM mint;
    DROP TABLE mint;
END //
DELIMITER ;

CALL mint(5);

SELECT category, AVG(list_price) AS average_list_price
FROM products
GROUP BY category
ORDER BY average_list_price DESC
LIMIT 1

SELECT MIN(average_list_price) as min_price
FROM(
	SELECT category, AVG(list_price) AS average_list_price
	FROM products
	GROUP BY category
) a;

-- 13. For each purchase_order, show their id, full_name of person creating, and full_name
-- of person approving.
SELECT purchase_orders.id, 
	CONCAT(e1.first_name, " ", e1.last_name) AS person_Create, 
    CONCAT(e2.first_name, " ", e2.last_name) AS person_Approve 
FROM purchase_orders 
JOIN employees e1 ON e1.id=purchase_orders.created_by
JOIN employees e2 ON e2.id=purchase_orders.approved_by;