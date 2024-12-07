-- Get the Maximum Years of Experience an elf has for the given skills
with max_years_exp_by_skill as (
select
	primary_skill,
	MAX(years_experience) as years_experience
from
	workshop_elves we
group by
	primary_skill
),
-- Find all the elves that have the maximum years of experience
max_exp_elves as (
select * from workshop_elves we inner join max_years_exp_by_skill
using (primary_skill, years_experience)
order by primary_skill, elf_id asc),
-- Find the minimum years of experience an elf has for a skill
min_years_exp_by_skill as (
select
	primary_skill,
	MIN(years_experience) as years_experience
from
	workshop_elves we
group by
	primary_skill
),
-- Find the elves that have the minimum amount of experience for a skill
min_exp_elves as (
select * from workshop_elves we inner join min_years_exp_by_skill
using (primary_skill, years_experience)
order by primary_skill, elf_id asc
),
-- Pair up the elves with maximum experience, with the elves with minimal experience
-- Use row_number() so we can easily return 1 row for each skill later
pairs as (
select 
max_exp_elves.elf_id as elf_id_1,
min_exp_elves.elf_id as elf_id_2,
max_exp_elves.primary_skill as shared_skill,
max_exp_elves.years_experience - min_exp_elves.years_experience as difference,
row_number () over (partition by max_exp_elves.primary_skill order by max_exp_elves.years_experience - min_exp_elves.years_experience desc)
from max_exp_elves inner join min_exp_elves
	using (primary_skill)
order by primary_skill asc, difference desc)
-- Filter each skill for 1 row
select * from pairs where row_number = 1;