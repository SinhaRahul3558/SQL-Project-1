show databases;
use health;

CREATE TABLE pizza_orders (
    order_id INT,
    pizza_name VARCHAR(50),
    quantity INT,
    price DECIMAL(5,2)
);

INSERT INTO pizza_orders (order_id, pizza_name, quantity, price) VALUES
(1, 'Margherita', 2, 8),
(2, 'Pepperoni', 1, 10),
(3, 'Veggie', 3, 9),
(4, 'Margherita', 1, 8);

select * from  pizza_orders;

SELECT 
    order_id,
    SUM(quantity * price) AS total_sales,
    SUM(SUM(quantity * price)) OVER () AS total_total_sales,
    cast(SUM(quantity * price) * 100.0 / SUM(SUM(quantity * price)) OVER ()) AS per_
FROM pizza_orders
GROUP BY order_id;



select order_id,total_sales,total_total_sales,
cast(total_sales*100/total_total_sales as decimal(10,2)) as percentage_
from
(SELECT 
    order_id,
    SUM(quantity * price) AS total_sales,
    SUM(SUM(quantity * price)) OVER () AS total_total_sales
FROM pizza_orders
GROUP BY order_id) as base_table ;

# Example 2: Percentage of Sales by Pizza Category

-- Create pizzas table
CREATE TABLE pizzas (
    pizza_id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(20),
    price DECIMAL(5,2)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    pizza_id INT,
    quantity INT,
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);


-- Insert data into pizzas
INSERT INTO pizzas (pizza_id, name, category, price) VALUES
(1, 'Margherita', 'Classic', 8.5),
(2, 'Pepperoni Feast', 'Meat', 10.0),
(3, 'Veggie Delight', 'Veg', 9.0);

-- Insert data into orders
INSERT INTO orders (order_id, pizza_id, quantity) VALUES
(101, 1, 2),
(102, 2, 1),
(103, 3, 3),
(104, 2, 2);



select * from pizzas;
select * from orders;

insert into pizzas values(4,"Chicken","meat",9.7);

SELECT 
    category,
    total_sales,
    total_Total_sales,
    CONCAT(CAST(total_sales * 100.0 / total_Total_sales AS DECIMAL(10,0)), '%') AS per_category
FROM (
    SELECT 
        p.category,
        SUM(o.quantity * p.price) AS total_sales,
        SUM(SUM(o.quantity * p.price)) OVER() AS total_Total_sales
    FROM pizzas p 
    JOIN orders o ON p.pizza_id = o.pizza_id
    GROUP BY p.category
) AS base_join_table;

#

CREATE TABLE orders4 (
    order_id INT,
    customer_id INT,
    order_date DATE
);

INSERT INTO orders4 (order_id, customer_id, order_date) VALUES
(1, 101, '2025-05-01'),
(2, 102, '2025-05-01'),
(3, 103, '2025-05-02');

CREATE TABLE order_items4 (
    item_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2)
);

INSERT INTO order_items4 (item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 201, 2, 20.00),
(2, 1, 202, 1, 50.00),
(3, 2, 201, 1, 20.00),
(4, 3, 203, 3, 15.00);

CREATE TABLE products4 (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

INSERT INTO products4 (product_id, product_name, category) VALUES
(201, 'USB Cable', 'Electronics'),
(202, 'Headphones', 'Electronics'),
(203, 'T-shirt', 'Clothing');

select * from orders4;
select * from order_items4;
select * from products4;


# Find revenue by category and its percentage of total revenue

select * from orders4;
select * from order_items4;
select * from products4;

select p.category,
sum(oi.quantity*oi.price) as total_revenue,
sum(sum(oi.quantity*oi.price)) over() as total_total_revenue,
concat(cast(sum(oi.quantity*oi.price) *100/sum(sum(oi.quantity*oi.price)) over() as decimal(10,2)),"%")as percentage_revenue
from order_items4 oi
join products4 p
group by p.category;

select category,total_revenue,total_total_revenue,
concat(cast(total_revenue*100/total_total_revenue as decimal(10,2))," ", "%") as Percentage_revenue
from
(select p.category,
sum(oi.quantity*oi.price) as total_revenue,
sum(sum(oi.quantity*oi.price)) over() as total_total_revenue
from order_items4 oi
join products4 p
group by p.category) as basic_table;


#

-- products table
CREATE TABLE products5 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- orders table
CREATE TABLE orders5 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);

-- order_items table
CREATE TABLE order_items5 (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO products5 (product_id, product_name, price) VALUES
(201, 'Margherita Pizza', 8.99),
(202, 'Pepperoni Pizza', 10.99),
(203, 'Veggie Pizza', 9.99),
(204, 'BBQ Chicken Pizza', 11.99),
(205, 'Hawaiian Pizza', 10.49),
(206, 'Cheese Pizza', 7.99),
(207, 'Buffalo Wings', 6.99),
(208, 'Garlic Bread', 4.99),
(209, 'Soda Can', 1.99),
(210, 'Chocolate Lava Cake', 5.49);

INSERT INTO orders5 (order_id, order_date, customer_id) VALUES
(301, '2025-06-01', 101),
(302, '2025-06-01', 102),
(303, '2025-06-02', 103),
(304, '2025-06-02', 104),
(305, '2025-06-03', 105),
(306, '2025-06-03', 106),
(307, '2025-06-04', 107),
(308, '2025-06-04', 108),
(309, '2025-06-05', 109),
(310, '2025-06-05', 110);

-- Insert into order_items
INSERT INTO order_items5 (order_item_id, order_id, product_id, quantity) VALUES
(401, 301, 201, 1),
(402, 301, 209, 2),
(403, 302, 202, 1),
(404, 302, 208, 1),
(405, 303, 203, 2),
(406, 303, 207, 1),
(407, 304, 204, 1),
(408, 304, 209, 1),
(409, 305, 205, 1),
(410, 305, 210, 1);

select * from orders5;
select * from order_items5;
select * from products5;

#  calculates the percentage of total revenue contributed by
# Pepperoni Pizza 

#1st
SELECT 
    ROUND(
        100.0 * pepperoni_revenue / total_revenue,
    2) AS pepperoni_revenue_percentage
FROM
    (SELECT 
         SUM(CASE WHEN p.product_id = 202 THEN p.price * oi.quantity ELSE 0 END) AS pepperoni_revenue,
         SUM(p.price * oi.quantity) AS total_revenue
     FROM order_items5 oi
     JOIN products5 p ON oi.product_id = p.product_id
    ) sub;

#2nd

select product_name,total_revenue_pepperoni,t_total_revenue_all_products,
concat(cast(total_revenue_pepperoni*100/t_total_revenue_all_products as decimal(10,2)),"%")as percentage_revenue
from
(
SELECT 
  p.product_name,
  SUM(oi.quantity * p.price) AS total_revenue_pepperoni,
  SUM(SUM(oi.quantity * p.price)) OVER () AS t_total_revenue_all_products
FROM order_items5 oi
JOIN products5 p ON oi.product_id = p.product_id
GROUP BY p.product_name) as sub
where product_name = "Pepperoni Pizza";

# 3rd method 

SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN p.product_id = 202 THEN p.price * oi.quantity ELSE 0 END)
        / SUM(p.price * oi.quantity), 
    2) AS pepperoni_revenue_percentage
FROM order_items5 oi
JOIN products5 p ON oi.product_id = p.product_id;


# . What percentage of total items sold were Pizzas 
#(products ending with 'Pizza')?

select * from orders5;
select * from order_items5;
select * from products5;

select sum(percentage) as total_percentage
from
(SELECT 
  product_name,
  total_quantity,
  t_total_quantity_all_products,
  total_quantity * 100.0 / t_total_quantity_all_products AS percentage
FROM (
  SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(SUM(oi.quantity)) OVER () AS t_total_quantity_all_products
  FROM order_items5 oi
  JOIN products5 p ON oi.product_id = p.product_id
  GROUP BY p.product_name
) AS join_table
WHERE product_name LIKE '%pizza') as total_contribute_percentage;

#
SELECT 
  SUM(CASE WHEN p.product_name LIKE '%Pizza' THEN oi.quantity ELSE 0 END) * 100.0 / 
  SUM(oi.quantity) AS pizza_percentage_of_total_items
FROM order_items5 oi
JOIN products5 p ON oi.product_id = p.product_id;


# ✅ 2. What percentage of orders included Garlic Bread?


select * from orders5;
select * from order_items5;
select * from products5;


SELECT 
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN oi.product_id = 208 THEN oi.order_id END) 
        / COUNT(DISTINCT oi.order_id), 
    2) AS garlic_bread_order_percentage
FROM order_items5 oi;

SELECT 
  CONCAT(
    ROUND(
      COUNT(DISTINCT oi.order_id) * 100.0 / (SELECT COUNT(DISTINCT order_id) FROM order_items5),
      2
    ),
    '%'
  ) AS garlic_bread_order_percentage
FROM order_items5 oi
JOIN products5 p ON oi.product_id = p.product_id
WHERE p.product_name = 'Garlic Bread';

select product_id,product_name,number_of_quantity,
t_T_quantity,
number_of_quantity*100/t_T_quantity as percenatge_
from
(select p.product_id,p.product_name,
count(distinct oi.quantity) as number_of_quantity,
sum(count(distinct oi.quantity)) over() as t_T_quantity
from products5 p
join order_items5 oi
on p.product_id = oi.product_id
group by p.product_id) as join_table
where product_name = "Garlic Bread"


#What percentage of
# customers placed orders on or before 2025-06-02?

select * from orders5;
select * from order_items5;
select * from products5;

select sum(per_) as total_percentage
from
(select order_date,number_0f_customer,
Total_number_of_customer,
number_0f_customer*100/Total_number_of_customer as per_
from
(
select order_date,count(distinct customer_id) as number_0f_customer,
sum(count(distinct customer_id)) over() as Total_number_of_customer
from orders5
group by order_date) as order_table
where order_date <= '2025-06-02') as Total_number_0f_custpmerpercentage 


# 2nd 
SELECT 
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN order_date <= '2025-06-02' THEN customer_id END)
        / COUNT(DISTINCT customer_id), 
    2) AS early_customer_percentage
FROM orders5;

# What percentage of orders contained more than 1 item?

select * from orders5;
select * from order_items5;
select * from products5;

SELECT 
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders5), 
    2) AS multi_item_order_percentage
FROM (
    SELECT order_id
    FROM order_items5
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS multi_item_orders;


select number_of_order*100/P_count as perc_
from
(SELECT order_id,count(*) as number_of_order,
sum(count(*)) over() as P_count
 FROM order_items5
 GROUP BY order_id
 HAVING COUNT(*) > 1) as basic_table


 # find login streaks of at least 3 consecutive days per user

CREATE TABLE logins (
    user_id INT,
    login_date DATE
);

-- Sample inserts
INSERT INTO logins (user_id, login_date) VALUES
(1, '2025-06-01'),
(1, '2025-06-02'),
(1, '2025-06-03'),
(1, '2025-06-05'),
(2, '2025-06-01'),
(2, '2025-06-03'),
(2, '2025-06-04'),
(2, '2025-06-05');

select * from logins;
      
SELECT *
FROM (
    SELECT 
        user_id,
        MIN(login_date) AS streak_start,
        MAX(login_date) AS streak_end,
        COUNT(*) AS streak_length
    FROM (
        SELECT 
            user_id,
            login_date,
            login_date - INTERVAL ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) day AS grp
        FROM logins
    ) AS ranked_logins
    GROUP BY user_id, grp
) AS grouped_logins
WHERE streak_length >= 3
ORDER BY user_id, streak_start;

# find the median salary of employee using sql 


CREATE TABLE employees6 (
    employee_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO employees6 (employee_id, salary) VALUES
(1, 50000.00),
(2, 60000.00),
(3, 55000.00),
(4, 52000.00),
(5, 58000.00),
(6, 61000.00),
(7, 57000.00),
(8, 59000.00),
(9, 53000.00),
(10, 56000.00);


select * from employees6;


SELECT
    AVG(salary) AS median_salary
FROM (
    SELECT
        salary,
        ROW_NUMBER() OVER (ORDER BY salary) AS rn,
        COUNT(*) OVER () AS cnt
    FROM employees6
) sub
WHERE rn IN (cnt +1 / 2, cnt / 2);


-- Step 1: Table create करना
CREATE TABLE employees7 (
    employee_id INT,
    salary DECIMAL(10, 2)
);

-- Step 2: 5 rows insert करना
INSERT INTO employees7 (employee_id, salary)
VALUES 
(1, 30000.00),
(2, 45000.00),
(3, 25000.00),
(4, 40000.00),
(5, 35000.00);

select * from employees7;

SELECT
    AVG(salary) AS median_salary
FROM (
    SELECT
        salary,
        ROW_NUMBER() OVER (ORDER BY salary) AS rn,
        COUNT(*) OVER () AS cnt
    FROM employees7
) sub
WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2));

#