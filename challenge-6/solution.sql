with avg_gift_price as (
	select AVG(price) as avg_price from gifts g 
)
select children."name", gifts."name", gifts.price from gifts inner join children
on gifts.child_id  = children.child_id 
left join avg_gift_price on 1=1
where gifts.price > avg_gift_price.avg_price
order by gifts.price asc;