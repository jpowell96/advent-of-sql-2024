with current_and_previous_production as (
select
	production_date,
	toys_produced,
	lag(toys_produced ,
	1) over (
	order by production_date asc) as previous_production
from
	toy_production tp
order by
	production_date asc)
select
	production_date,
	toys_produced,
	previous_production,
	toys_produced - coalesce(previous_production,0) as production_change,
	(toys_produced - previous_production) / previous_production as pct_change
from
	current_and_previous_production
order by
	pct_change desc nulls last;