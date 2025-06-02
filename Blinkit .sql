create database blinkit_db;
use blinkit_db;
show databases;


select * 
from blinkit_grocery_data;

# 

select count(*) from blinkit_grocery_data;

#

update blinkit_grocery_data 
set `Item Fat Content` = 
case 
	when `Item Fat Content` in ("LF","low fat") then "Low Fat"
	when `Item Fat Content` = "reg" then "Regular"
	else `Item Fat Content`
end

#

select distinct `Item Fat Content` from blinkit_grocery_data ;

# total sales: The overall revenue generated from all item sold

select round(sum(`Total Sales`),2) as revenue from blinkit_grocery_data ;

# use cast function convert to another data type 

select cast(sum(`Total Sales`)/100000 as decimal(10,2)) as revenue_millions from blinkit_grocery_data ;


# avg salary

select cast(avg(`Total Sales`) as decimal(10,0)) as avg_revenue from blinkit_grocery_data ;


# avg rating

select cast(avg(`rating`) as decimal(10,2)) as avg_rating from blinkit_grocery_data ;

# total sales by fat content

select * 
from blinkit_grocery_data;

select `Item Fat Content`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
group by `Item Fat Content`
order by `Item Fat Content`;



select `Item Fat Content`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
where `outlet Establishment Year` = 2020
group by `Item Fat Content`
order by `Item Fat Content`;

# # total sales by item type

select `Item type`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
where `outlet Establishment Year` = 2020
group by `Item type`
order by total_revenue_millions desc;

select `Item type`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
where `outlet Establishment Year` = 2020
group by `Item type`
order by total_revenue_millions desc
limit 5;

# fat content by outlet for total sales
select * 
from blinkit_grocery_data;

select `outlet location type`,`Item Fat Content`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
group by `outlet location type`,`Item Fat Content`
order by total_revenue_millions desc;


select `outlet location type`,`Item Fat Content`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
where `outlet Establishment Year` = 2020
group by `outlet location type`,`Item Fat Content`
order by total_revenue_millions desc;

#D. Fat Content by Outlet for Total Sales
#1nd method 

SELECT 
    `Outlet Location Type`,
    SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` ELSE 0 END) AS Low_Fat,
    SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` ELSE 0 END) AS Regular
FROM blinkit_grocery_data
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;

#2nd method 

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

# E. Total Sales by Outlet Establishment


  select `outlet Establishment Year`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
group by `outlet Establishment Year`
order by total_revenue_millions desc;

select `outlet Establishment Year`,
cast(sum(`Total Sales`) as decimal(10,2)) as total_revenue_millions
from blinkit_grocery_data
group by `outlet Establishment Year`
order by total_revenue_millions desc;


# F. Percentage of Sales by Outlet Size

SELECT `Outlet Size`,CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales,
sum(`Total Sales`) over() as total_sales_
from blinkit_grocery_data
group by `Outlet Size`;
 


SELECT 
  `Outlet Size`,
  Total_Sales,
  Total_Sales_Of_All_Customers,
  CAST((Total_Sales * 100.0 / Total_Sales_Of_All_Customers) AS DECIMAL(5,2)) AS per_centage
FROM (
  SELECT 
    `Outlet Size`,
    CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    cast(SUM(SUM(`Total Sales`)) OVER() as DECIMAL(10,2)) AS Total_Sales_Of_All_Customers
  FROM 
    blinkit_grocery_data
  GROUP BY 
    `Outlet Size`
) AS sales_data;

# Sales by Outlet Location

select * 
from blinkit_grocery_data;

 select `Outlet Location Type`,
cast(sum(`Total Sales`) as decimal(10,0)) as total_revenue_millions,
cast(avg(`Total Sales`) as decimal(10,1)) as avg_revenue,
count(*) as number_of_item,
cast(avg(`rating`)  as decimal(10,2)) as avg_rating 
from blinkit_grocery_data
group by `Outlet Location Type`
order by total_revenue_millions desc;

# Percentage of Sales by Outlet Location

SELECT 
  `Outlet Location Type`,
  total_revenue_millions,
  total_sales_of_all_customers,
  CAST((total_revenue_millions * 100.0 / total_sales_of_all_customers) AS DECIMAL(5,2)) AS per_centage
FROM (
  SELECT 
    `Outlet Location Type`,
    CAST(SUM(`Total Sales`) AS DECIMAL(10,0)) AS total_revenue_millions,
    cast(SUM(SUM(`Total Sales`)) OVER() as decimal(10,0)) AS total_sales_of_all_customers
  FROM 
    blinkit_grocery_data
  GROUP BY 
    `Outlet Location Type`
) AS summary
ORDER BY 
  total_revenue_millions DESC;

# H. All Metrics by Outlet Type:


SELECT 
  `Outlet Type`,
  COUNT(*) AS Total_Orders,
  CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS Total_Sales,
  CAST(AVG(`Total Sales`) AS DECIMAL(10,2)) AS Avg_Sale_Per_Order,
  CAST((SUM(`Total Sales`) * 100.0 / SUM(SUM(`Total Sales`)) OVER()) AS DECIMAL(5,2)) AS Sales_Percentage
FROM 
  blinkit_grocery_data
GROUP BY 
  `Outlet Type`
ORDER BY 
  Total_Sales DESC;

