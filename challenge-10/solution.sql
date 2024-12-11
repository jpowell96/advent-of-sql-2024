with daily_totals as (
select 
drinks."date",
SUM(CASE WHEN drink_name='Hot Cocoa' THEN drinks.quantity ELSE 0 END) as hot_cocoa,
SUM(case when drink_name='Eggnog' then drinks.quantity else 0 END) as eggnog,
SUM(case when drink_name='Peppermint Schnapps' then drinks.quantity else 0 END) as peppermint
from drinks
group by "date"
order by "date" asc)
select "date" from daily_totals
where hot_cocoa=38
and peppermint=298 and eggnog=198;