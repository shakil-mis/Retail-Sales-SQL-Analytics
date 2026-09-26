/* ============================================================
   1. DROP OLD TABLES
   ============================================================ */

DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS returns CASCADE;
DROP TABLE IF EXISTS shipments CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS customers CASCADE;


/* ============================================================
   2. DEPARTMENTS
   ============================================================ */

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);


/* ============================================================
   3. EMPLOYEES
   ============================================================ */

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    job_title VARCHAR(100),
    salary NUMERIC(12,2),
    hire_date DATE,
    manager_id INT REFERENCES employees(employee_id)
);


/* ============================================================
   4. CUSTOMERS
   ============================================================ */

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) UNIQUE,
    phone VARCHAR(30),
    city VARCHAR(50),
    country VARCHAR(50),
    gender VARCHAR(20),
    date_of_birth DATE,
    signup_date DATE,
    customer_status VARCHAR(20) DEFAULT 'Active'
);


/* ============================================================
   5. CATEGORIES
   ============================================================ */

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);


/* ============================================================
   6. SUPPLIERS
   ============================================================ */

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    contact_email VARCHAR(120),
    rating NUMERIC(3,2)
);


/* ============================================================
   7. PRODUCTS
   ============================================================ */

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT REFERENCES categories(category_id),
    supplier_id INT REFERENCES suppliers(supplier_id),
    cost_price NUMERIC(12,2),
    selling_price NUMERIC(12,2),
    stock_quantity INT,
    reorder_level INT,
    product_status VARCHAR(20) DEFAULT 'Active',
    created_date DATE
);


/* ============================================================
   8. STORES
   ============================================================ */

CREATE TABLE stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    store_type VARCHAR(30),
    opening_date DATE
);


/* ============================================================
   9. ORDERS
   ============================================================ */

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    employee_id INT REFERENCES employees(employee_id),
    store_id INT REFERENCES stores(store_id),
    order_date TIMESTAMP,
    order_status VARCHAR(30),
    sales_channel VARCHAR(30),
    shipping_address VARCHAR(200)
);


/* ============================================================
   10. ORDER ITEMS
   ============================================================ */

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    unit_price NUMERIC(12,2),
    discount_percent NUMERIC(5,2)
);


/* ============================================================
   11. PAYMENTS
   ============================================================ */

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    payment_date TIMESTAMP,
    payment_method VARCHAR(30),
    amount NUMERIC(12,2),
    payment_status VARCHAR(30)
);


/* ============================================================
   12. SHIPMENTS
   ============================================================ */

CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    shipment_date DATE,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    shipping_method VARCHAR(50),
    shipment_status VARCHAR(30)
);


/* ============================================================
   13. RETURNS
   ============================================================ */

CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,
    order_item_id INT REFERENCES order_items(order_item_id),
    return_date DATE,
    return_quantity INT,
    return_reason VARCHAR(150),
    refund_amount NUMERIC(12,2)
);


/* ============================================================
   14. REVIEWS
   ============================================================ */

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE
);
SELECT*FROM categories;
SELECT*FROM customers;
SELECT*FROM departments;
SELECT*FROM employees;
SELECT*FROM order_items;
SELECT*FROM orders;
SELECT*FROM payments;
SELECT*FROM products;
SELECT*FROM returns;
SELECT*FROM reviews;
SELECT*FROM reviews;
SELECT*FROM shipments;
SELECT*FROM stores;
SELECT*FROM suppliers;

--1-"Write a SQL query to retrieve all columns and all records from the employees table."
SELECT*FROM employees;

/*2-"Write a SQL query to select the first_name, last_name, and salary from the employees table. 
Combine first_name and last_name using string concatenation with an alias 'full_name',
and rename salary as 'salary_amount'."
*/
SELECT
	CONCAT(first_name,' ',last_name) AS full_name,
	salary AS salary_amount
FROM employees;

/*3-"Write a SQL query to retrieve product_name, selling_price, and product_status from the products table
for all active products that have a selling_price strictly greater than 50.00."
*/
SELECT product_name,selling_price,product_status
FROM products
WHERE product_status = 'Active' AND selling_price>50.00;

/*4-"Write a SQL query to retrieve the product_name and selling_price of the top 5 most expensive products
from the products table."
*/
SELECT product_name,selling_price
FROM products
ORDER BY selling_price DESC
lIMIT 5;

/*5-"Write a SQL query to select customer_id, first_name, last_name, and email from the customers table for all customers 
whose email address ends with '@gmail.com'."
*/
SELECT customer_id,first_name,last_name,email
FROM customers
WHERE email LIKE '%@gmail.com';

/*6-"Write a SQL query to retrieve order_id, shipment_id, and shipping_method from the shipments table where 
the actual_delivery_date is missing or NULL."
*/
SELECT order_id,shipment_id,shipping_method
FROM shipments
WHERE actual_delivery_date IS NULL;


/*7-"Write a SQL query to calculate the total number of products, the average selling_price, and the sum of
total stock_quantity for products with product_status = 'Active'."
*/
SELECT 
	COUNT(*) AS total_products,
	ROUND(AVG(selling_price),2) AS avg_selling_price,
	SUM(stock_quantity) AS total_stock
FROM products
WHERE product_status = 'Active';
SELECT * FROM products;

/*8-"Write a SQL query to find category_id and the total count of products in each category from the products table. 
Only include categories that have 5 or more products, and order the results by total products in descending order."
*/
SELECT 
    p.category_id,
    c.category_name,
    COUNT(*) AS total_products
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_name
HAVING COUNT(*) >= 5
ORDER BY total_products DESC;

/*9-"Write a SQL query to *select employee_id, first_name, last_name, and department_name by joining the employees 
table with the departments table."
*/
SELECT* FROM departments;
SELECT* FROM employees;

SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

/*
"10-Write a SQL query to calculate the total sales revenue for each category. Join categories, products, 
and order_items tables. Display category_name and total_revenue (calculated as quantity * unit_price), ordered by total_revenue in descending order."
*/

SELECT
 c.category_name,
 SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;


/*
"11-"Write a SQL query to retrieve employee_id, first_name, last_name, and salary from the employees table 
for employees who earn more than the average salary of all employees."
*/
SELECT * FROM employees;
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
WHERE salary>(
	SELECT
	AVG(salary)
	FROM employees
);

/*
"12-"Write a SQL query to select customer_id, first_name, last_name, and email from the customers table 
for customers who have NEVER placed any order."
*/
SELECT * FROM customers;
SELECT * FROM orders;

SELECT 
	customer_id,
	first_name,
	last_name,
	email
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);
	

/*"13-"Write a SQL query using a CTE (WITH clause) to calculate the total order value 
for each order (quantity * unit_price) from order_items, and then select all order_id and total_order_value
where total_order_value > 1000."
*/

WITH order_summary AS (
SELECT 
order_id,
SUM(quantity*unit_price) AS total_order_value
FROM order_items
GROUP BY order_id
)
SELECT * FROM order_summary
WHERE total_order_value>1000;

SELECT * FROM employees;

/*14-Write a SQL query using the ROW_NUMBER() window function to find the highest-paid employee in each department. 
Return department_id, employee_id, first_name, last_name, and salary."
*/

SELECT * FROM departments;
WITH RankedEmployees AS (
SELECT	
	e.department_id,
	d.department_name,
	e.employee_id,
	e.first_name,
	e.last_name,
	e.salary,
	ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS RANKING
FROM employees e
JOIN departments d ON e.department_id = d.department_id
)
SELECT * FROM RankedEmployees
WHERE RANKING = 1;

/*15-"Write a SQL query to calculate the cumulative/running total of payment amounts ordered by payment_date.
Display payment_id, payment_date, amount, and running_total."
*/
SELECT * FROM payments;
SELECT
	payment_id,
	payment_date,
	amount,
	SUM(amount) OVER (ORDER BY payment_date) AS running_total
FROM payments;

/*16-"Write a SQL query using the LAG() function to display payment_id, payment_date, amount, 
and the previous_payment_date (the payment_date of the immediately preceding payment when ordered by payment_date)."
*/
SELECT
	payment_id,
	payment_date,
	amount,
	LAG(payment_date) OVER(ORDER BY payment_date) as previous_payment_date
FROM payments;

/*17."Write a SQL query to calculate the total spent by each customer across all their orders. Return customer_id, 
first_name, last_name, email, and total_spent. Only show the top 5 highest-spending customers."
*/

SELECT*FROM customers;
SELECT*FROM orders;
SELECT*FROM order_items;

SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	c.email,
	SUM(oi.quantity*oi.unit_price) AS total_spent
FROM order_items oi 
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_spent DESC
LIMIT 5 ;

	