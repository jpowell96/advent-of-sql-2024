with requests_per_gift as (
select 
gifts.gift_name,
gifts.gift_id,
COUNT(gift_id) as request_count
from gifts left join gift_requests 
using(gift_id)
group by gift_id
order by gift_name asc)
select 
gift_name,
round(percent_rank() over (order by request_count) :: numeric, 2) as pct_rank
from requests_per_gift
order by pct_rank desc, gift_name asc;
