with encoded_seasons as(
select 
field_name,
harvest_year,
season,
case
	when season = 'Spring' then 1
	when season = 'Summer' then 2
	when season = 'Fall' then 3
	when season = 'Winter' then 4
end as season_encoding,
trees_harvested 
from treeharvests)
select
field_name,
harvest_year,
season,
ROUND(AVG(trees_harvested) over (partition by field_name order by harvest_year, season_encoding rows between 2 preceding and current row),2) as three_season_moving_avg
from encoded_seasons
order by three_season_moving_avg desc;