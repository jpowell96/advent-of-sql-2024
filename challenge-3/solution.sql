with menus_with_more_than_78_guests as (
	select id from christmas_menus cm 
		where xpath_exists('//attendance_record[total_guests>78]', cm.menu_data) 
	or xpath_exists('//headcount[total_present>78]', cm.menu_data)
	or xpath_exists('//guest_registry[total_count>78]', cm.menu_data)
),
all_menu_items as (
	select unnest(xpath('//food_item_id/text()', cm.menu_data))::text::int as food_item_id from christmas_menus cm
	where id in (select id from menus_with_more_than_78_guests)
)
select food_item_id, COUNT(*) 
from all_menu_items 
group by food_item_id 
order by COUNT(*) desc 
limit 1;