create database pizzhut;
use pizzhut;
show databases;

use pizzhut;

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;




# retrive total number of order placed

select count(order_id) as number_of_order from orders;

#calculated total reveneu generated from pizz_sales

select round(sum(order_details.quantity * pizzas.price),2) as total_reveneu from order_details 
join pizzas  on order_details.pizza_id = pizzas.pizza_id;

#identify highest_priced pizza

select pizza_types.name,pizzas.price from pizza_types 
join pizzas on  pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc
limit 1;

select name,price from
(SELECT 
        pizza_types.name,
        pizzas.price,
        RANK() OVER (ORDER BY pizzas.price DESC) AS price_rank
    FROM pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id) as ranking_pizza
where price_rank  =1 ;

# identify most common size pizza ordered

select pizzas.size,count(pizzas.size) as number_of_size from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizzas.size
order by number_of_size desc
limit 1;


SELECT size, number_of_size
FROM (
    SELECT 
        pizzas.size, 
        COUNT(pizzas.size) AS number_of_size,
        RANK() OVER (ORDER BY COUNT(pizzas.size) DESC) AS `rank`
    FROM pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    GROUP BY pizzas.size
) AS ranked_sizes;

select pizzas.size, count(*) as cnt from pizzas
group by pizzas.size
limit 1;

select pizzas.size,COUNT(pizzas.size) AS number_of_size,row_number()
over(paratiorder by COUNT(pizzas.size) desc) as rnk
from pizzas;

# list top 5 most ordered pizza type with  along quntity

SELECT 
    SUM(order_details.quantity) AS quantity,
    pizza_types.name
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN 
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.name
ORDER BY 
    quantity desc limit 5;

select quantity,name 
from
(select quantity,name,
rank() over(order by quantity desc) as rnk
from
(
SELECT 
    SUM(order_details.quantity) AS quantity,
    pizza_types.name
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN 
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.name
ORDER BY 
    quantity) as ranking_quantity) as top5_pizza
where rnk < 6;

 
# total quantity of each pizza category ordered


select pizza_types.name,sum(order_details.quantity) as quantity 
from  pizza_types join pizzas on 
pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name;

# distribution of order by hours of days

select hour(time) as hours, count(order_id) from orders
group by hours;

# find the category wise distribution of pizza

select category,count(name) as cnt from pizza_types
group by category;

# group the orders by date and  calculate the avearge  number of pizza ordered by days

#1st step

select orders.date,sum(order_details.quantity) as qunatity from orders
join order_details on orders.order_id = order_details.order_id
group by orders.date;

#2nd step

select round(avg(qunatity),0) as avg_number_of_pizza from
(select orders.date,sum(order_details.quantity) as qunatity from orders
join order_details on orders.order_id = order_details.order_id
group by orders.date) as daily_quantity;


# top 3 most ordered pizza type based on reveneu

select pizza_types.name,
round(sum(order_details.quantity * pizzas.price),0) as revenue
from pizza_types join pizzas on
pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on
order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc
limit 3;

select name, revenue 
from
(select  name, revenue,
rank() over(order by revenue desc) as rn from
(select pizza_types.name,
round(sum(order_details.quantity * pizzas.price),0) as revenue
from pizza_types join pizzas on
pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on
order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue) as a ) as b
where rn < 4;

#Calculate the percentage contribution of each pizza type to total revenue.


SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) * 100.0 / 
          (SELECT SUM(order_details.quantity * pizzas.price)
           FROM pizzas
           JOIN order_details ON pizzas.pizza_id = order_details.pizza_id), 2) AS percentage_contribution
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY percentage_contribution DESC;

## top 3 most ordered pizza category based on reveneu
SELECT 
    pizza_types.category,
    ROUND(
        SUM(order_details.quantity * pizzas.price) / 
        (
            SELECT SUM(order_details.quantity * pizzas.price)
            FROM order_details 
            JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
        ) * 100, 2
    ) AS revenue_percentage
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue_percentage DESC;

# 

WITH total_revenue_cte AS (
    SELECT 
        ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
),
category_revenue_cte AS (
    SELECT 
        pt.category,
        SUM(od.quantity * p.price) AS category_revenue
    FROM pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON od.pizza_id = p.pizza_id
    GROUP BY pt.category
)

SELECT 
    crc.category,
    ROUND((crc.category_revenue / trc.total_revenue) * 100, 2) AS revenue_percentage
FROM category_revenue_cte crc
JOIN total_revenue_cte trc
ORDER BY revenue_percentage desc;

# analyze cumulative reveneu generated over time

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;
 
select date,
sum(total_reveneu) over(order by date) as cumm_reveneu
from 
(select orders.date,
round(sum(order_details.quantity*pizzas.price),0) as total_reveneu
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders 
on orders.order_id = order_details.order_id
group by orders.date
order by total_reveneu desc) as sales; 

#Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;
 
#1st step
select pizza_types.category,pizza_types.name,
round(sum(order_details.quantity * pizzas.price),0)as total_reveneu
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name
order by total_reveneu desc;

#2nd step
select category,total_reveneu
from
(select category,name,total_reveneu,
rank() over(partition by category order by total_reveneu desc) as rn
from
(select pizza_types.category,pizza_types.name,
round(sum(order_details.quantity * pizzas.price),0)as total_reveneu
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name
order by total_reveneu desc) as revenue) as total_sales
where rn < 4 ;

#
















