with markets as (select s.year , s.country ,sum(s.visits) as total_inbound_visits_yearly from {{ref('stg_model__first')}} as s left join {{ref('dim_country')}} c on s.country = c.country
where c.is_residual_group is false
 group by s.country  , s.year )

, start_points as (select country , year ,total_inbound_visits_yearly , lag(total_inbound_visits_yearly , 10) over (partition by country order by year) as start_point_visits from markets)

select year , country , total_inbound_visits_yearly , start_point_visits ,
 round(power(total_inbound_visits_yearly / start_point_visits , 1.0 / 10) - 1, 4) as cagr from start_points where start_point_visits is not null
 order by cagr desc