-- Note this is a partial solution. The query for added tags is correct
-- But there's a small error with removed tags around the where condition
with existing_tags_by_toy as (
select
	toy_id,
	toy_name,
	unnest(previous_tags) as tag
from
	toy_production tp
),
new_tags_by_toy as (
select
	toy_id,
	toy_name,
	unnest(new_tags) as tag
from
	toy_production tp),
unchanging_tags as (
select
	existing_tags_by_toy.toy_id,
	array_agg(tag) as unchanged_tags
from
	existing_tags_by_toy
inner join new_tags_by_toy
using(toy_id,tag)
group by
	existing_tags_by_toy.toy_id),
added_tags as (
	-- tags that are in new but not previous
	select new_tags_by_toy.toy_id,
		array_agg(tag) as added_tags
		from existing_tags_by_toy right join new_tags_by_toy
		using (toy_id, tag)
		where existing_tags_by_toy.toy_name is null
		group by new_tags_by_toy.toy_id
),
removed_tags as (
	select existing_tags_by_toy.toy_id, array_agg(tag) as removed_tags
	from existing_tags_by_toy left join new_tags_by_toy
	using(toy_id,tag)
	where new_tags_by_toy.toy_name is null
		group by existing_tags_by_toy.toy_id
)
select added_tags.toy_id, added_tags, removed_tags, unchanged_tags
from added_tags left join removed_tags
on added_tags.toy_id = removed_tags.toy_id
left join unchanging_tags on unchanging_tags.toy_id = removed_tags.toy_id
order by array_length(added_tags, 1) desc;