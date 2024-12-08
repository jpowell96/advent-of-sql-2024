-- Solution Based on Postgres Docs on Recursive CTEs: https://www.postgresql.org/docs/current/queries-with.html#QUERIES-WITH-RECURSIVE
-- With clause defines all the fields you want to return
with recursive manager_chain(original_staff_id, original_staff_name, staff_id, manager_id, depth, chain) as (
	select staff.staff_id, staff.staff_name, staff.staff_id, staff.manager_id, 1, array[staff.staff_id]
	from staff
	union all
	-- Union All Clause has our recursive definition - telling us how things change. In this case, depth + 1, and add manager to path
		select manager_chain.original_staff_id, manager_chain.original_staff_name, staff.staff_id, staff.manager_id, depth + 1, chain || staff.staff_id 
		from manager_chain, staff
		-- Where clause defines how to recur. In this case we move up the manager chain
		where staff.staff_id = manager_chain.manager_id
)
select * from manager_chain order by depth desc;