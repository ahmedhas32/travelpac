select i.year, i.country , d.region ,o.total_visits as outbound_total_visits , i.total_visits as inbound_total_visits , round(o.total_expand, 2) as outbound_total_expand , round(i.total_expand, 2) as inbound_total_expand
from {{ref('marts_inbound_by_country')}} i left join {{ref('marts_outbound_by_country')}} o
on i.country = o.country  left join {{ref('dim_country')}} d on i.country = d.country