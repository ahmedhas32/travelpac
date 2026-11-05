select s.year , s.country  ,s.purpose , sum(s.visits) as total_visits , sum(s.expend) as total_expend , sum(s.expend) / sum(s.visits) as SPT ,
 sum(s.nights) / sum(s.visits) as als 
 from {{ref('stg_model__first')}} as s left join {{ref('dim_country')}} c on s.country = c.country
where s.visits is not null and c.is_residual_group = false
group by s.year , s.country  ,s.purpose 
having sum(s.visits) > 50000 and sum(s.sample) > 50
order by SPT desc
