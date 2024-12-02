with filtered_binky_table as
(
select
	id,
	chr(value) as decoded_char
from
	letters_a la
where
	chr(value) ~ '^[a-zA-Z]'
	or chr(value) in ('!', '"', '''', '(', ')', ',', '-', '.', ':', ';', '?',' ')),
filtered_blinky_table as (
select
	id,
	chr(value) as decoded_char
from
	letters_b lb
where
	chr(value) ~ '^[a-zA-Z]'
		or chr(value) in ('!', '"', '''', '(', ')', ',', '-', '.', ':', ';', '?',' ')
	order by
		id asc),
combined_tables as (
	select
		*
	from
		filtered_binky_table
union 
select
	*
from
	filtered_blinky_table
order by
id asc)
select string_agg(decoded_char,'') from combined_tables;