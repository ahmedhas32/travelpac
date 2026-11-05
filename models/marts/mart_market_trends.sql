select year , region , inbound_total_visits ,
 (inbound_total_visits - lag(inbound_total_visits) over (partition by region order by year )) / lag(inbound_total_visits) over (partition by region order by year ) * 100 as YoY_pct
from {{ref('mart_travel')}}