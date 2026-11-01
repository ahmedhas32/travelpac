select  year ,  mode , country , round(sum(visits) , 0)  as total_visits , round(sum(nights) , 0) as total_nights , sum(expend) as total_expand
 from {{ref('stg_model__first')}}
 group by year ,  mode , country
