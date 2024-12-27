with workshop_hours_utc as (
select
	workshop_name,
	(business_start_time at time zone 'UTC')  as business_start_utc,
	(business_end_time at time zone 'UTC') as business_end_utc
from
	workshops w 
order by business_start_utc asc)
select max(business_start_utc) from workshop_hours_utc;