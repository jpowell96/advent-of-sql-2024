with avg_perf_score as (
select
	ROUND(AVG(last_score),
	2) as average_performance
from
	(
	select
		year_end_performance_scores[cardinality(year_end_performance_scores)] as last_score
	from
		employees) as subquery),
bonus_eligible_employees as (
select
	employee_id,
	salary,
  	year_end_performance_scores[cardinality(year_end_performance_scores)] > avg_perf_score.average_performance as is_bonus_eligible
from
employees,
avg_perf_score)
select
	 SUM (case when is_bonus_eligible then salary * 1.15 else salary end)
from
	bonus_eligible_employees;