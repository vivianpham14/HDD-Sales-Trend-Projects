-- CREATE TABLE function within MySQL to match csv file before importing any data for hdd_orders
USE hdd_sales_data;
CREATE TABLE hdd_orders(
	order_id INT,
    product_id INT,
    customer_id INT,
    customer_segment VARCHAR(20),
    quantity INT,
    unit_price DOUBLE,
    total_price DOUBLE,
    discount_amount DOUBLE,
    shipping_cost DOUBLE,
    order_date CHAR(10),
    ship_to_city VARCHAR(50),
    carrier VARCHAR(7),
    order_status VARCHAR(13),
    sales_channel VARCHAR(15),
    payment_method VARCHAR(30)
    );

-- For any columns missed, use ALTER and ADD to insert the column
ALTER TABLE hdd_orders
ADD COLUMN shipping_date CHAR(10);

-- SELECT is used to double check the import
SELECT * FROM hdd_orders;

-- CREATE table for the key to hdd_products
USE hdd_sales_data;
CREATE TABLE hdd_products(
	product_id INT,
    product_name VARCHAR(30),
    product_category CHAR(20),
    manufacturing_city CHAR(20),
    size VARCHAR(5),
    color CHAR(7),
    SKU INT,
    unit_price DOUBLE
    );

-- DONT FORGET THE USE STATEMENT HERE before joining tables --> computer is confused on which DB to use
USE hdd_sales_data;
SELECT hdd_orders.product_id FROM hdd_orders
INNER JOIN hdd_products ON hdd_orders.product_id = hdd_products.product_id;

-- Created a new table as an index for customer info
USE hdd_sales_data;
CREATE table customer_data (
	customer_id VARCHAR(200),
	customer_segment CHAR(50),
    customer_street_address VARCHAR (500)
    );

-- Added in customer data table
USE hdd_sales_data;
SELECT hdd_orders.customer_id
FROM hdd_orders
INNER JOIN customer_data ON customer_data.customer_id = hdd_orders.customer_id;

-- DATA CHECKS --
-- DATA COMPARISON
-- customer_data
SELECT customer_id, customer_segment
FROM (
	SELECT customer_id, customer_segment
    FROM customer_data
    UNION ALL
    SELECT customer_id, customer_segment
    FROM hdd_orders
) tbl
GROUP BY customer_id, customer_segment;
-- hdd_products
SELECT product_id
FROM (
	SELECT product_id
    FROM hdd_orders
    UNION ALL
    SELECT product_id
    FROM hdd_products
) tbl;

-- ROW COUNT VERIFICATION: ensure all data was imported
-- Customer_data: no variances (table = 4868, csv = 4868)
	SELECT COUNT(*) AS total_rows FROM hdd_sales_data.customer_data;
-- Hdd_orders: no variances (table = 5000, csv = 5000)
	SELECT COUNT(*) AS total_rows FROM hdd_sales_data.hdd_orders;
-- Hdd_products: no variances (table = 20, csv = 20)
	SELECT COUNT(*) AS total_rows FROM hdd_sales_data.hdd_products;

-- Change data type for consistency in Tableau
ALTER TABLE customer_data MODIFY customer_id INT(200);