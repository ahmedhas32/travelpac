with subset as (select year , country , purpose , sum(outbound_total_visits) as outbound_total_visits , sum(inbound_total_visits) as inbound_total_visits from {{ref('marts_tourism_balance_per_country')}} where country in ('Romania', 'Bulgaria', 'Poland') and year >=2013 and year <= 2017
group by year , country , purpose)

, comparison as (select year , country , purpose , outbound_total_visits , sum(case when year = 2013 then outbound_total_visits else 0 end) over (partition by country , purpose) as outbound_total_visits_2013 , inbound_total_visits , sum(case when year = 2013 then inbound_total_visits else 0 end) over (partition by country , purpose) as inbound_total_visits_2013 
from subset where country in ('Romania') and year >=2013 and year <= 2017
order by year , purpose , country )

select year , country , purpose , outbound_total_visits , outbound_total_visits / outbound_total_visits_2013 as outbound_change_from_2013 , inbound_total_visits / inbound_total_visits_2013 as inbound_change_from_2013 from comparison