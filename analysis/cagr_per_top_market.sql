with top_10_growth as (select * from {{ref('marts_cagr_per_country')}} limit 5)


 , yearly_pov_top_growth as (select  year , country , purpose , sum(visits) as total_inbound_visits_yearly from {{ref('stg_model__first')}} where country in (select country from top_10_growth) 
 group by    year , country , purpose)

, start_points as (select year , country , purpose ,total_inbound_visits_yearly , lag(total_inbound_visits_yearly , 10) over (partition by country , purpose order by year) as start_point_visits from yearly_pov_top_growth)
select * ,  
 round(power(total_inbound_visits_yearly / start_point_visits , 1.0 / 10) - 1, 4) as cagr   from start_points
where year = 2019 and start_point_visits is not null
order by (total_inbound_visits_yearly-start_point_visits)  desc, cagr desc
