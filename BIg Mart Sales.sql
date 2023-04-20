show databases;
create database DataBaseRahul;
use DataBaseRahul;

create table sql_project (Item_Identifier varchar(255),
Item_Weight float,Item_Fat_Content char(255),
Item_Visibility float,Item_Type char(255),	
Item_MRP float,	Outlet_Identifier varchar(255),	
Outlet_Establishment_Year int(255),	Outlet_Size char(255),Outlet_Location_Type varchar(255),
Outlet_Type char(255),	
Item_Outlet_Sales float);

select *from  sql_project;


#1 WRITE a query TO  show Item_Identifier
 select Item_Identifier from sql_project;
 
#2 WRITE a query TO  show  count OF total Item_Identifier

select count( Item_Identifier) from sql_project;

#3 WRITE a query TO  show maximum Item Weight
 select * from sql_project;
 
select max(Item_Weight) from sql_project;


#4 WRITE a query TO  show minimun  Item Weight
select min(Item_Weight) from sql_project;

#5 WRITE a query TO  show average Item_Weight
  select avg(Item_Weight) from sql_project;
 
 #6 WRITE a query TO  show count OF Item_Fat_Content WHERE Item_Fat_Content IS Low Fat

 select count(Item_Fat_Content) from sql_project
 where Item_Fat_Content = "Low Fat";

#7 WRITE a query TO  show count OF Item_Fat_Content WHERE Item_Fat_Content IS Regular

 select count(Item_Fat_Content) from sql_project
 where Item_Fat_Content = "Regular";


#8 WRITE a query TO  show maximum Item_MRP
select max(Item_MRP) from sql_project;


#10 WRITE a query TO  show Item_Identifier , Item_Fat_Content ,Item_Type,Item_MRP and  Item_MRP IS greater than 200 and  Item_Fat_Content is regular

select Item_Identifier, Item_Fat_Content,Item_Type,Item_MRP
from sql_project where Item_MRP >= 200
and Item_Fat_Content = "Regular";

select Item_Identifier, Item_Fat_Content,Item_Type,Item_MRP
from sql_project where Item_MRP >= 200;


#11 WRITE a query TO  show maximum Item_MRP WHERE  Item_Fat_Content IS Low Fat

select max(Item_MRP) from sql_project
where Item_Fat_Content = "Low Fat";

#12 WRITE a query TO  show minimum Item_MRp AND Item_Fat_Content IS Low Fat

select min(Item_MRP) from sql_project
where Item_Fat_Content = "Low Fat";

#13 WRITE a query TO  show ALL DATA WHERE item MRP IS BETWEEN 50 TO 100

 select * from sql_project
 where item_MRP between 50 and 100;

#14 WRITE a query TO  show ALL UNIQUE value Item_Fat_Content

 select distinct Item_Fat_Content from sql_project;

#15 WRITE a query TO  show   ALL UNIQUE value Item_Type
select distinct Item_Type from sql_project;

select count(distinct Item_Type) from sql_project;



#16 WRITE a query TO  show ALL DATA IN descending ORDER BY Item MRP

select * from sql_project
order by Item_MRP desc; 


select * from sql_project
order by Item_MRP;


#17 WRITE a query TO  show ALL DATA IN ascending ORDER BY Item_Outlet_Sales


select * from sql_project
order by Item_Outlet_Sales;


#18 WRITE a query TO  show ALL DATA IN ascending BY Item_Type

select * from sql_project
order by Item_Type;


#19 WRITE a query TO  show DATA OF item_type dairy & Meat

select * from sql_project
where item_type in ("dairy","Meat")
;


#20 WRITE a query TO  show ALL UNIQUE value OF Outlet_Size

select distinct Outlet_Size  from sql_project;


#21 WRITE a query TO  show ALL UNIQUE value OF Outlet_Location_Type

select distinct Outlet_Location_Type  from sql_project;


#23 WRITE a query TO  show count NO. OF item BY Item_Type AND ordered it IN descening


select * from sql_project;

select Item_type from sql_project;

select distinct Item_type from sql_project;

select Item_type, count(Item_Identifier) from sql_project
group by Item_Type
order by count(Item_Identifier);

select Item_type, count(Item_Identifier) as no_of_count from sql_project
group by Item_Type
order by count(Item_Identifier);

select Item_type, count(Item_Identifier) as no_of_count from sql_project
group by Item_Type
order by no_of_count desc;



#24 WRITE a query TO  show  count NO. OF item BY Outlet_Size AND ordered it IN ascening


select Outlet_Size,count(Item_Identifier) from sql_project
group by Outlet_Size
order by count(Item_Identifier);



select Outlet_Size,count(Item_Identifier) from sql_project
group by Outlet_Size
order by count(Item_Identifier) desc;

#25 WRITE a query TO  show  count NO. OF item BY Outlet_Establishment_Year AND ordered it IN ascening

select Outlet_Establishment_Year,count(Item_Identifier) from sql_project
group by Outlet_Establishment_Year
order by count(Item_Identifier) desc;

#26 WRITE a query TO  show  count NO. OF item BY Outlet_Type AND ordered it IN descening


select Outlet_Type,count(Item_Identifier) from sql_project 
group by Outlet_Type
order by count(Item_Identifier) desc;


#27 WRITE a query TO  show ount NO. OF item BY Outlet_Location_Type AND ordered it IN descening


select Outlet_Location_Type,count(Item_Identifier) from sql_project 
group by Outlet_Location_Type
order by count(Item_Identifier) desc;



#28 WRITE a query TO  show maximum MRP BY Item_Type

select Item_Type, max(Item_MRP) from sql_project
group by Item_Type;

select Item_Type, max(Item_MRP) from sql_project
group by Item_Type;


#30 WRITE a query TO  show minimum MRP BY Outlet_Establishment_Year AND ordered it IN descending

SELECT  Outlet_Establishment_Year, min(Item_MRP)Min_MRP  
FROM sql_project  
GROUP BY Outlet_Establishment_Year order by Min_MRP desc;


#31 WRITE a query TO  show maximum MRP BY Outlet_Establishment_Year AND ordered IN descending


SELECT  Outlet_Establishment_Year, max(Item_MRP)Min_MRP  
FROM sql_project  
GROUP BY Outlet_Establishment_Year order by Min_MRP desc;


#32 WRITE a query TO  show average MRP BY Outlet_Size AND ordered IN descending


SELECT Outlet_Size, avg(Item_MRP)avg_MRP  
FROM sql_project  
GROUP BY Outlet_Size order by avg_MRP desc;



#33 WRITE a query TO  show average MRP BY Outlet_Size
 select  Outlet_Size, avg(Item_MRP) from sql_project
 group by Outlet_Size;


#36 WRITE a query TO  show maximum  Item_Weight BY Item_Type 

 select   Item_Type, max(Item_Weight) from sql_project
 group by  Item_Type;


 select   Item_Type, max(Item_Weight) from sql_project
 group by  Item_Type
order by max(Item_Weight) desc;



 select   Item_Type, max(Item_Weight) from sql_project
 group by  Item_Type
order by max(Item_Weight);

#37 WRITE a query TO  show maximum  Item_Weight BY Outlet_Establishment_Year 


 select Outlet_Establishment_Year ,max(Item_Weight) from sql_project
 group by  Outlet_Establishment_Year 
order by max(Item_Weight);

#38 WRITE a query TO  show minimum  Item_Weight BY Outlet_Type 

 select  Outlet_Type ,min(Item_Weight) from sql_project
 group by  Outlet_Type 
order by max(Item_Weight);


#39 WRITE a query TO  show average Item_Weight BY  Outlet_Location_Type ORDER BY descending

 select   Outlet_Location_Type ,avg(Item_Weight) from sql_project
 group by  Outlet_Location_Type  
order by avg(Item_Weight) desc;

#40 WRITE a query TO  show maximum  Item_Outlet_Sales BY  Item_Type


select Item_Type, max(Item_Outlet_Sales) from sql_project
group by Item_Type 
order by max(Item_Outlet_Sales); 



select Item_Type, max(Item_Outlet_Sales) from sql_project
group by Item_Type 
order by max(Item_Outlet_Sales) desc; 


#42 WRITE a query TO  show minimum Item_Outlet_Sales BY Outlet_Establishment_Year


select Outlet_Establishment_Year, min(Item_Outlet_Sales) from sql_project
group by Outlet_Establishment_Year
order by min(Item_Outlet_Sales) desc; 


#43 WRITE a query TO  show maximum Item_Outlet_Sales BY Outlet_Establishment_Year ordered BY descending

select Outlet_Establishment_Year, max(Item_Outlet_Sales) from sql_project
group by Outlet_Establishment_Year
order by max(Item_Outlet_Sales) desc;



##44 WRITE a query TO  show average Item_Outlet_Sales BY  Outlet_Size AND ORDER it itn descending

select Outlet_Size, avg(Item_Outlet_Sales) from sql_project
group by Outlet_Size
order by avg(Item_Outlet_Sales) desc;


 #45 WRITE a query TO  show average Item_Outlet_Sales BY Outlet_Size 
select Outlet_Size , avg( Item_Outlet_Sales) from sql_project
group by Outlet_Size;

#46 WRITE a query TO  show average Item_Outlet_Sales BY Outlet_Type

select Outlet_Type,avg( Item_Outlet_Sales) from sql_project
group by Outlet_Type;

select Outlet_Type,avg( Item_Outlet_Sales) from sql_project
group by Outlet_Type
order by avg( Item_Outlet_Sales);

select Outlet_Type,avg( Item_Outlet_Sales) from sql_project
group by Outlet_Type
order by avg( Item_Outlet_Sales) desc;


#48 WRITE a query TO  show total Item_Outlet_Sales BY Outlet_Establishment_Year

select Outlet_Establishment_Year,sum( Item_Outlet_Sales) from sql_project
group by Outlet_Establishment_Year
order by sum( Item_Outlet_Sales);

select Outlet_Establishment_Year,sum( Item_Outlet_Sales) from sql_project
group by Outlet_Establishment_Year
order by sum( Item_Outlet_Sales)desc;

#50 WRITE a query TO  show  total Item_Outlet_Sales BY Outlet_Location_Type


select Outlet_Location_Type,sum( Item_Outlet_Sales) from sql_project
group by Outlet_Location_Type
order by sum( Item_Outlet_Sales)desc;


#51 WRITE a query TO  show total Item_Outlet_Sales BY Item_Fat_Content


select Item_Fat_Content,sum(Item_Outlet_Sales ) from sql_project
group by  Item_Fat_Content
order by sum(Item_Outlet_Sales );

select Item_Fat_Content,sum(Item_Outlet_Sales ) from sql_project
group by  Item_Fat_Content
order by sum(Item_Outlet_Sales );

#52 WRITE a query TO  show maximum  Item_Visibility BY  Item_Type

select Item_Type, max( Item_Visibility) from sql_project
group by  Item_Type
order by max( Item_Visibility);

select Item_Type, max( Item_Visibility) from sql_project
group by  Item_Type
order by max( Item_Visibility)desc;


#53 WRITE a query TO  show Minimum Item_Visibility BY Item

select Item_Type, min( Item_Visibility) from sql_project
group by  Item_Type
order by min( Item_Visibility)desc;


#54 WRITE a query TO  show total  Item_Outlet_Sales BY Item_Type but ONLY WHERE  Outlet_Location_Type IS Tier 1

select Item_Type,sum( Item_Outlet_Sales), Outlet_Location_Type from sql_project
where Outlet_Location_Type = "Tier 1"
group by Item_Type
order by sum( Item_Outlet_Sales);



select Item_Type,sum( Item_Outlet_Sales), Outlet_Location_Type from sql_project
where Outlet_Location_Type = "Tier 1"
group by Item_Type
order by sum( Item_Outlet_Sales) desc;


#55 WRITE a query TO  show total Item_Outlet_Sales BY Item_Type WHERE Item_Fat_Content IS ONLY Low Fat & LF

select Item_Type, sum(Item_Outlet_Sales)Total_sales
from sql_project  where Item_Fat_Content in ('Low Fat', 'LF')
group by Item_Type 
order by Total_sales desc; 






