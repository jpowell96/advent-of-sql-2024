with average_speeds_by_reindeer_per_activity as (
select 
reindeer_id,
exercise_name,
AVG(speed_record) as average_speed_record
from training_sessions ts 
where reindeer_id != 9 -- not Rudolf
group by reindeer_id, exercise_name
order by reindeer_id, exercise_name asc)
select 
	reindeer_name,
	reindeer_id,
	ROUND(MAX(average_speed_record),2) as highest_average_speed
from reindeers left join average_speeds_by_reindeer_per_activity
using (reindeer_id)
where reindeers.reindeer_id  != 9
group by reindeer_id
order by highest_average_speed desc;