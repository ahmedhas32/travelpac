with series as (select year , purpose , country , sum(visits) as total_visits from {{ref('stg_model__first')}} 
where country in ('Romania', 'Bulgaria', 'Poland') and year >=2013 and year <= 2017
group by year , purpose , country
order by purpose , year , country)

select * , total_visits / sum(case when year=2013   then total_visits else 0 end) over (partition by country , purpose) as change_from_2013 FROM series    

