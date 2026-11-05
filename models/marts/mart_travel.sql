with category as (
  select s.* , c.region
  from {{ref('marts_inbound_by_country')}} s left join {{ref('dim_country')}} c
  on s.country = c.country
) 

select year , region , sum(total_visits) as inbound_total_visits from category
group by year , region