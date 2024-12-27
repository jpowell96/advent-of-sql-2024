with workshop_hours_utc as (
select
	workshop_name,
	(business_start_time at time zone w.timezone) at time zone 'UTC'  as business_start_utc,
	(business_end_time at time zone w.timezone) at time zone 'UTC' as business_end_utc
from
	workshops w 
order by business_start_utc asc),
enumerated_schedule_hours as (
select workshop_hours_utc.workshop_name, generate_series(date_part('hour', workshop_hours_utc.business_start_utc) :: INTEGER, date_part('hour', workshop_hours_utc.business_end_utc) :: INTEGER, 1) as workshop_hour from workshop_hours_utc)
select workshop_hour, COUNT(workshop_name) from enumerated_schedule_hours group by workshop_hour
order by workshop_hour asc;