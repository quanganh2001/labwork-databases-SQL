SHOW DATABASES;
USE northwind;
SHOW TABLES;

-- 1. Write a query to get discontinued Product list (Product ID and name).
SELECT id, product_name
FROM Products
WHERE Discontinued = 1 
ORDER BY product_name;

-- 2. Retrive the top 4 cheapest products
SELECT id, product_name, list_price
FROM Products
ORDER BY list_price ASC
LIMIT 4;

-- 3. Write a query to get Product list (id, name, list_price) whose list_price cost between $15 and $25. Hint: using BETWEEN operator or comparison operators (<>) combined with AND operator. 
SELECT id, product_name, list_price
FROM Products
WHERE (list_price>=15) AND (list_price <=25)
ORDER BY list_price DESC;

SELECT id, product_name, list_price
FROM Products
WHERE list_price BETWEEN 15 AND 25;

-- 4. List employees with two columns: id, full_name which is constructed from
-- first_name and last_name.
SELECT id, concat(first_name,' ',last_name ) as full_name
FROM Employees;

-- 5. Find employees whose names start with ‘A’.
SELECT id, last_name, first_name
FROM Employees
WHERE first_name LIKE 'A%' OR last_name LIKE 'A%';

-- 6. Show how many different cities the employees living in. 
SELECT DISTINCT city
FROM employees;

-- 7. Show ship_name of table orders without duplicated values. 
SELECT DISTINCT ship_name
FROM Orders
ORDER BY id;

-- 8. Show the minimum, maximum of list price in Products table
SELECT MAX(list_price), MIN(list_price)
FROM products;

-- 9. Display the number of current (mean Discontinued = 0) products. 
SELECT count(*) AS number_products
FROM Products
WHERE Discontinued = 0;

-- 10. Show the average and standard deviation of the list_price of products.
SELECT
	AVG(list_price) as average_price,
    STDDEV(list_price) as standard_deviation
FROM Products;

-- 11. Use subquey, show Product list (name, list_price) expensive than the average price. 
SELECT id, product_name, list_price
FROM Products
WHERE list_price > 
	(
		SELECT AVG(list_price)
        FROM products
    )
ORDER BY list_price;

-- 12. Insert a new row to table Suppliers with the following values: company = ‘Habeco’,
-- last_name = ‘Nguyễn’, first_name = ‘Hồng Linh’ city = ‘Hanoi’, country_region =‘Vietnam’.
INSERT INTO Suppliers(company, last_name, first_name, city, country_region) VALUES ('Habeco', 'Nguyễn', 'Hồng Linh', 'Hanoi', 'Vietnam');

SELECT * FROM Suppliers;

-- 13. Insert a new product into table products with the following values: 
-- product_code = ‘TBTruc Bach’, SupplierID = the value corresponding to ‘Habeco’, list_price = 22, discontinued = 0, category = ‘Beverages’ 
INSERT INTO products(product_code, supplier_ids, list_price, discontinued, category) 
VALUES('TBTruc Bach', 11, 22, 0, 'Beverages');

SELECT * FROM Products;

-- 14. Modify the information of ‘Truc Bach’: standard_cost = 18. 
UPDATE products 
SET standard_cost = 18
WHERE product_code = 'TBTruc Bach'; 
SELECT * FROM products; 

-- 15. Try deleting the row which is just inserted in table suppliers.
DELETE FROM Suppliers 
WHERE company = 'Habeco'
	AND last_name = 'Nguyen'
    AND first_name = 'Hong Linh'
    AND city = 'Hanoi'
    AND country_region = 'Vietnam';