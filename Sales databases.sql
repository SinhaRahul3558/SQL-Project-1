create database Sales_Table;
show databases;
use Sales_Table;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Alice Johnson', 'alice@example.com', 'USA'),
(2, 'Bob Smith', 'bob@example.com', 'UK'),
(3, 'Carlos Vega', 'carlos@example.com', 'Mexico'),
(4, 'Diana Wu', 'diana@example.com', 'China'),
(5, 'Ethan Lee', 'ethan@example.com', 'South Korea'),
(6, 'Fatima Noor', 'fatima@example.com', 'UAE'),
(7, 'George Brown', 'george@example.com', 'USA'),
(8, 'Hannah Kim', 'hannah@example.com', 'South Korea'),
(9, 'Ivan Petrov', 'ivan@example.com', 'Russia'),
(10, 'Julia Meier', 'julia@example.com', 'Germany');


INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 499.99),
(3, 'Headphones', 'Accessories', 79.99),
(4, 'Office Chair', 'Furniture', 150.00),
(5, 'Notebook', 'Stationery', 5.99),
(6, 'Pen Set', 'Stationery', 12.50),
(7, 'Monitor', 'Electronics', 199.99),
(8, 'Mouse', 'Accessories', 25.00),
(9, 'Desk Lamp', 'Furniture', 45.00),
(10, 'Backpack', 'Accessories', 39.99);


INSERT INTO orders VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-01-15'),
(3, 3, '2024-02-05'),
(4, 4, '2024-02-20'),
(5, 5, '2024-03-01'),
(6, 6, '2024-03-15'),
(7, 7, '2024-03-25'),
(8, 8, '2024-04-05'),
(9, 9, '2024-04-10'),
(10, 10, '2024-04-20');



INSERT INTO order_items VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 1),
(5, 5, 5, 5),
(6, 6, 6, 2),
(7, 7, 7, 1),
(8, 8, 8, 2),
(9, 9, 9, 1),
(10, 10, 10, 2);

select * from customers;
select * from products;
select * from orders;
select * from order_items;


#Total number of customers

select count(*) as cnt from customers;

#Total Revenue:

select sum(products.price * order_items.quantity) as total_revenue
from products join order_items
on products.product_id = order_items.product_id;

#Top 5 best-selling products (by quantity)

select products.product_name,
sum(order_items.quantity) as total_quantity
from products
join order_items
on products.product_id = order_items.product_id
group by products.product_name
order by total_quantity desc
limit 5;

select product_name,total_quantity
from
(select product_name,total_quantity,
dense_rank() over(partition by product_name order by ranking.total_quantity desc ) as rnk
from
(select products.product_name,
sum(order_items.quantity) as total_quantity
from products
join order_items
on products.product_id = order_items.product_id
group by products.product_name
order by total_quantity desc) as ranking) as top_5
where rnk < 5;

#Revenue by product category

select * from customers;
select * from products;
select * from orders;
select * from order_items;


select category,sum(total_revenue) as total
from
(SELECT 
    category,
    product_name,
    total_revenue,
    Row_number() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS rn
FROM (
    SELECT
        products.category,
        products.product_name,
        ROUND(SUM(order_items.quantity * products.price), 0) AS total_revenue
    FROM products
    JOIN order_items ON products.product_id = order_items.product_id
    GROUP BY products.category, products.product_name
) AS P) as R
group by category
order by total desc;

#Monthly revenue trend
select * from customers;
select * from products;
select * from orders;
select * from order_items;

SELECT 
    MONTH(orders.order_date) AS month,
    SUM(order_items.quantity * products.price) AS revenue
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
GROUP BY MONTH(orders.order_date);

#Customers by country

select country,count(*) as cnt 
from customers
group by country
order by cnt desc;

# Most active customers (by number of orders)

select customers.name,count(orders.order_id) as cnt
from customers
join orders
on customers.customer_id = orders.customer_id
group by customers.name;


#Average order value


select avg(order_total) as avg_order_total
from
  (SELECT o.order_id, SUM(p.price * oi.quantity) AS order_total
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY o.order_id) as avg_order;

#Top spending customers

select * from customers;
select * from products;
select * from orders;
select * from order_items;

select customers.name,
sum(products.price * order_items.quantity) as total_revenue
from customers
join orders on customers.customer_id = orders.customer_id
join order_items
on orders.order_id = order_items.order_id
join products
on products.product_id = order_items.product_id
group by customers.name
order by total_revenue desc
limit 5;


SELECT name, total_revenue
FROM (
    SELECT name, total_revenue,
           RANK() OVER (ORDER BY total_revenue DESC) AS rnking
    FROM (
        SELECT customers.name,
               SUM(products.price * order_items.quantity) AS total_revenue
        FROM customers
        JOIN orders ON customers.customer_id = orders.customer_id
        JOIN order_items ON orders.order_id = order_items.order_id
        JOIN products ON products.product_id = order_items.product_id
        GROUP BY customers.name
    ) AS R
) AS p
WHERE rnking <= 5;

#Total number of orders

select  count(*) as cnt from orders;

#Most frequently bought product

select * from customers;
select * from products;
select * from orders;
select * from order_items; 


select products.product_id,
products.product_name,
count(*) as number_of_purchase_product
from products
join order_items
on products.product_id = order_items.product_id
group by products.product_id,products.product_name
limit 1;

#Customers who bought electronics

select * from customers;
select * from products;
select * from orders;
select * from order_items; 

select name 
from
(select customers.name,products.category
from customers
join orders
on customers.customer_id = orders.customer_id
join order_items
on order_items.order_id = orders.order_id
join products
on products.product_id = order_items.product_id
where products.category = "Electronics") as customer_name;


#Revenue per customer

SELECT c.name, SUM(p.price * oi.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name;

# Top 3 categories by revenue

SELECT p.category, SUM(p.price * oi.quantity) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue desc
limit 3;

#Customers who bought more than 1 item in any order

SELECT DISTINCT c.name,oi.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.name,oi.quantity
having sum(oi.quantity) > 1;

# avarage spending per customer

SELECT AVG(total_spent) AS avg_spent
FROM (
  SELECT c.customer_id, SUM(p.price * oi.quantity) AS total_spent
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id
) AS spending;

# Orders that include accessories


SELECT DISTINCT o.order_id
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category = 'Accessories';

#Product with highest total revenue

SELECT p.product_name, SUM(p.price * oi.quantity) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 1;

select product_name,total_revenue
from
(select product_name,total_revenue,
rank() over(order by total_revenue desc) as rnk
from
(SELECT p.product_name, SUM(p.price * oi.quantity) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name) as hig_) as ranking
where rnk = 1;


# How many customers made more than one order


select * from customers;
select * from products;
select * from orders;
select * from order_items; 

SELECT COUNT(*) AS customers_with_multiple_orders
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS multiple_orders;


#Which country generates most revenue

SELECT c.country, SUM(p.price * oi.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
group by c.country
ORDER BY revenue DESC
LIMIT 1;

#Total items sold per category

SELECT p.category, SUM(oi.quantity) AS total_items
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category;

#Orders with total value greater than $500

SELECT o.order_id, SUM(p.price * oi.quantity) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING order_value > 500;

#List of products never ordered

SELECT p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

# #List of products  ordered

SELECT p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id is not NULL;

#Find most popular product in each category

SELECT category, product_name, total_quantity FROM (
  SELECT p.category, p.product_name, SUM(oi.quantity) AS total_quantity,
         RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS rnk
  FROM products p
  JOIN order_items oi ON p.product_id = oi.product_id
  GROUP BY p.category, p.product_name
) ranked_products
WHERE rnk = 1;

# Revenue generated each day

SELECT o.order_date, SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;

























