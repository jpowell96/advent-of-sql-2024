with complete_list as (
select unnest(email_addresses) as email_address from contact_list cl),
email_to_email_domain as (
	select email_address, SUBSTRING(complete_list.email_address from position('@' in email_address) + 1) as email_domain from complete_list
)
select email_domain,COUNT(email_address) as users_for_domain, array_agg(email_address) as folks from email_to_email_domain
group by email_domain
order by users_for_domain desc;