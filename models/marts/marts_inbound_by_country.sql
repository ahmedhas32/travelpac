select  year ,  mode , country , round(sum(visits) , 0)  as total_visits , round(sum(nights) , 0) as total_nights
 from {{ref('stg_model__first')}}
where ukos = 'Overseas residents'
 group by year ,  mode , country
