create database rahul;
use rahul;



select * from noc_regions;
select * from athlete_events;  



#1. How many olympics games have been held?

select count(distinct games) as total_olympic_games
    from athlete_events;
   
#2 how many different athletes have participated in the olympics

select distinct name from athlete_events

select count(distinct name) from athlete_events

select nr.region, count(distinct name) as participate_player  from athlete_events ae
join noc_regions nr
on ae.NOC = nr.NOC
group by region
order by  participate_player desc;

#3 how many of them won a medal.

SELECT COUNT(DISTINCT(name)) FROM athlete_events  
WHERE medal IS NOT NULL
   
#4 Write a SQL query to list down all the Olympic Games held so far.
   
 select distinct year ,season, city from athlete_events order by year;

#5 SQL query to fetch total no of countries participated in each olympic games

select games,count(NOC) as no_of_country from athlete_events
group by games
order by no_of_country desc;

#second method

select games,count(*) as no_of_country from athlete_events
group by games
order by no_of_country;

#4 Which year saw the highest and lowest no of countries participating in olympics

# lowest country

select games, count(DISTINCT r.region) AS B
from athlete_events oly
JOIN noc_regions r 
  ON oly.noc = r.noc
GROUP BY games
ORDER BY  B asc
LIMIT 1 

select games, count(*) AS B
from athlete_events oly
JOIN noc_regions r 
  ON oly.noc = r.noc
GROUP BY games
ORDER BY  B asc
LIMIT 1 

# highest country 

 select games, count(DISTINCT r.region) AS B
from athlete_events oly
JOIN noc_regions r 
  ON oly.noc = r.noc
GROUP BY games
ORDER BY B 
desc 
LIMIT 1; 



#5.SQL query to return the list of countries who have been part of every Olympics games.


select * from noc_regions;
select * from athlete_events; 

select r.region, count(distinct games) as no_of_year
from athlete_events o, noc_regions r
where o.noc=r.noc
group by region
order by 2 desc;

SELECT COUNT(DISTINCT games) AS no_of_years, team FROM athlete_events 
GROUP BY team
ORDER BY no_of_years DESC;

#6.Identify the sport which was played in all summer olympics.

select sport,count(distinct(games)) as Total_games
from athlete_events
where season= "summer"
group by sport
order by 2 desc ;
 

#7.Identify the sport which was played in all summer olympics.


select c1.sport, count(distinct c1.Games) as Total_games
from athlete_events c1
join athlete_events c2
on c1.ID > c2.ID 
where c1.season= 'Winter'
group by c1.Sport;


#8.Which Sports were just played only once in the olympics.

select c1.Sport ,c1.Games, count(*) as no0f_games 
from athlete_events c1
join athlete_events c2
on c1.Sport = c2.Sport 
where c1.ID > c2.ID 
group by c1.Sport,c1.Games
having count(*)=1;


#9.Fetch the total no of sports played in each olympic games.
     
select * from noc_regions;
select * from athlete_events; 
     
select games, count(distinct sport) as no_of_sports
from athlete_events
group by games
order by  no_of_sports desc;


#10 Fetch details of the oldest athletes to win a gold medal.  

select age,name,medal 
from(select *,
	rank() over (order by age desc) as rnk
	from athlete_events 
	where medal= "gold") as x
where rnk=1;

#second method

SELECT DISTINCT name, Age , sport, event, noc, games, city, medal FROM athlete_events 
where Medal = 'Gold'
ORDER BY age desc
limit 1;

# third method

SELECT 
    name, sex, age, medal, team, games, city, sport, event, medal
FROM
    athlete_events
WHERE age IN (SELECT MAX(age) FROM athlete_events WHERE age NOT LIKE 'NA' AND medal = 'Gold')
    AND medal = 'Gold'

# 11 Find the Ratio of male and female athletes participated in all olympic games

select * from noc_regions;
select * from athlete_events;

select sum(if(sex="M",1,0))/sum(if(sex="F",1,0)) as ratio
from athlete_events;

#second method


SELECT
    COUNT(IF(sex = 'M', 1, NULL)) count_male,
    COUNT(IF(sex = 'F', 1, NULL)) count_female,
    COUNT(IF(sex = 'M', 1, NULL))/COUNT(IF(sex = 'F', 1, NULL)) as ratio
FROM athlete_events ae ;


#12 Fetch the top 5 athletes who have won the most gold medals.

select name,count(*)as noof_goldmedal from athlete_events
where Medal = "gold"
group by name
order by noof_goldmedal desc;

# add only region so use of join but result is same

Select O.Name,OH.Region,Count(1) As Total_Medal From athlete_events O
Join noc_regions  OH ON OH.NOC = O.NOC
Where O.Medal = 'Gold'
Group By O.Name,OH.Region Order By Count(1) desc

#13 Fetch the top 5 athletes who have won the most bronze medals.

select name,count(*) as noof_goldmedal from athlete_events
where Medal = 'Bronze' 
group by name
order by noof_goldmedal desc
limit 5;


#14 Fetch the top 5 athletes who have won the most silver medals.

select name,count(*) as noof_goldmedal from athlete_events
where Medal = 'silver' 
group by name
order by noof_goldmedal desc;

#15 SQL Query to fetch the top 5 athletes who have won the most medals (Medals include gold, silver and bronze).

select name,count(*) as noof_goldmedal from athlete_events
where Medal in ('Gold','Silver','Bronze') 
group by name
order by noof_goldmedal desc
limit 5;

# with join when region is displyed

Select O.Name,OH.Region,Count(1) As Total_Medal From athlete_events O
Join noc_regions OH ON OH.NOC = O.NOC
Where O.Medal In ('Silver','Bronze','Gold')
Group By O.Name,OH.Region Order By Count(1) desc
limit 5;


#16 Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.

select noc_regions.region as country ,count(Medal) no_medal
from athlete_events
join noc_regions 
on noc_regions.NOC = athlete_events.NOC
Where athlete_events.Medal In ('Silver','Bronze','Gold')
group by country 
order by  no_medal desc;

# 17 List down total gold, silver and bronze medals won by each country.

Select OH.Region,
Count(Case When O.Medal='Gold' Then 1 End) AS Gold,
Count(Case When O.Medal='Silver' Then 1 End) AS Silver,
Count(Case When O.Medal='Bronze' Then 1 End) AS Bronze
from athlete_events  O
Join noc_regions OH On OH.NOC = O.NOC
Group by OH.Region
Order By Gold Desc,Silver Desc,Bronze Desc

# 18 List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

select games, region as country,
		SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals,
        SUM(CASE WHEN medal IN ('Gold','Silver','Bronze') THEN 1 ELSE 0 END) AS total_medals
from athlete_events  as o, noc_regions as r 
where o.noc= r.noc
group by region, games
Order By Games,Region;

#19 Identify which country won the most gold, most silver and most bronze medals in each olympic games.


 select region as country,
	    SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals,
        SUM(CASE WHEN medal IN ('Gold','Silver','Bronze') THEN 1 ELSE 0 END) AS total_medals
from athlete_events  as o, noc_regions as r 
where o.noc= r.noc
group by region
order by total_medals desc;



#20.Which countries have never won gold medal but have won silver/bronze medals?*/


select region as country,
	count(case when medal= "gold" then null end )as Gold_medal,
    count(case when medal= "silver" then "silver" end )as silver_medal,
    count(case when medal= "bronze" then "bronze" end )as bronze_medal
from athlete_events  as o,noc_regions  as r 
where o.noc= r.noc
group by region
order by region;


 #21.In which Sport/event, USA has won highest medals.


select * from noc_regions;
select * from athlete_events; 

select sport, count(*) as total_medal from athlete_events ae
join noc_regions nr
where ae.NOC = nr.NOC
and region = "USA"
and medal <> "NA"
group by sport
limit 1;

select name,sport,medal,event,nr.region, count(*) as total_medal from athlete_events ae
join noc_regions nr
where ae.NOC = nr.NOC
and region = "USA"
and medal <> "NA"
group by sport,medal,event,name ; 

select name,sport,medal,event,nr.region, count(*) as total_medal, left(games,4) as year_ from athlete_events ae
join noc_regions nr
where ae.NOC = nr.NOC
and region = "USA"
and medal <> "NA"
group by sport,medal,event,name, year_; 

   
 #20 Break down all olympic games where USA won medal for Athletics and how many medals in each olympic games

SELECT nr.region ,sport,Games,count(medal) as total_medals
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
where medal <> 'NA'And Sport = 'Athletics' And region = 'USA'
GROUP BY nr.Region,Games,sport order BY total_medals desc;

#21 find the top 3 countries in terms of the total number of medals.

#without join first method

SELECT team, COUNT(medal) AS medal_won
FROM athlete_events 
WHERE medal IS NOT NULL
GROUP BY team
ORDER BY medal_won desc
LIMIT 3;

# with join second method

SELECT bs.region , COUNT(medal) AS medal_won
FROM athlete_events cs
join noc_regions bs
on cs.NOC = bs.NOC 
WHERE medal IS NOT NULL
GROUP BY region
ORDER BY medal_won desc
LIMIT 3;

 #22 average age of female and male athletes who won a medal

SELECT sex, AVG(age) AS avg_age
FROM athlete_events
where medal is not null
GROUP BY sex;


SELECT sex, count(Medal),AVG(age) AS avg_age
FROM athlete_events 
where Medal = "Gold"
GROUP BY sex;

SELECT sex, count(Medal),AVG(age) AS avg_age
FROM athlete_events 
where Medal = "silver"
GROUP BY sex;

SELECT sex, count(Medal),AVG(age) AS avg_age
FROM athlete_events 
where Medal = 'Bronze' 
GROUP BY sex;


SELECT sex, count(Medal),AVG(age) AS avg_age
FROM athlete_events 
where Medal in ("Gold","Bronze","silver")
GROUP BY sex;


# 23 creates a new table using data in the olympics table.

CREATE TABLE olympics_after_1952 AS
SELECT * FROM athlete_events 
WHERE LEFT(games, 4)  > 1950

select * from olympics_after_1952; 

# 24 creates a new table using without data in the olympics table.

CREATE TABLE olympics_after_1951 
SELECT * FROM athlete_events 
WHERE LEFT(games, 4)  > 1950 and 1=2

select * from olympics_after_1951;
#truncate table olympics_after_1950 


 # 24 delete the rows before 1970 in the new table

select * from olympics_after_1950; 

delete from olympics_after_1952
where LEFT(games, 4)  > 1970








