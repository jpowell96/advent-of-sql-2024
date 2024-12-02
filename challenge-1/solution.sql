select
	name,
	wishes->>'first_choice' as primary_wish,
	wishes->>'second_choice' as backup_wish,
	wishes->'colors'->> 0 as favorite_color,
	json_array_length(wishes->'colors') as color_count,
	case
		when difficulty_to_make <= 1 then 'Simple Gift'
		when difficulty_to_make = 2 then 'Moderate Gift'
		else 'Complex Gift'
	end as gift_complexity,
	case
		when category = 'outdoor' then 'Outside Workshop'
		when category = 'educational' then 'Learning Workshop'
		else 'General Workshop'
	end as workshop
from
	children c
left join wish_lists wl 
on
	c.child_id = wl.child_id
left join toy_catalogue tc 
on
	wl.wishes->>'first_choice' = tc.toy_name
order by
	name asc
limit 5;