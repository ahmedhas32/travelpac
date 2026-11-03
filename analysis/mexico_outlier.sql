with cases as (select year , country , purpose , sum(expend) as total_expend , sum(visits) as total_visits
 , sum(expend) / sum(visits) as SPT , sum(sample) as sample_size from {{ref('stg_model__first')}} 
  group by year , country , purpose order by year desc , SPT desc)

, median as (select * , median(SPT) over (partition by country , purpose) as median_SPT from 
cases g)
select * from median where (SPT > 5*median_SPT) or (SPT < 0.2*median_SPT) 