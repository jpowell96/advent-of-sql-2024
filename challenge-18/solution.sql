-- Note: This is not the correct final answer. The complete solution
-- was done after consulting folks on reddit, but am including the original for posterity.
WITH RECURSIVE search_tree(original_staff_id, id, original_manager_id, manager_id, path, level) AS (
-- Base Case of the recursive query. All the defaults for the employee - path starts with themselves, initial level is 1, etc.
    SELECT t.staff_id, t.staff_id, t.manager_id, t.manager_id, ARRAY[t.staff_id], 1
    FROM staff t
  UNION all
-- Defines how to update levels as you recur.In this case, add the current staff person to the path, and increase the level by 1
    SELECT st.original_staff_id, t.staff_id, st.original_manager_id, t.manager_id, path || t.staff_id, level + 1
    FROM staff t, search_tree st
    -- Move up the chain by going to the manager
    WHERE t.staff_id = st.manager_id
)
-- order by level (depth of reporting chain)
SELECT original_staff_id,
original_manager_id,
path,
level,
COUNT(manager_id) over (partition by level, original_manager_id) as peers
FROM search_tree ORDER by level desc, peers desc, original_manager_id desc;