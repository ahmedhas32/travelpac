with balance as (
    select
        sum(inbound_total_visits)  as balance_inbound,
        sum(outbound_total_visits) as balance_outbound
    from {{ ref('marts_tourism_balance_per_country') }}
),

sources as (
    select
        (select sum(total_visits) from {{ ref('marts_inbound_by_country') }})  as source_inbound,
        (select sum(total_visits) from {{ ref('marts_outbound_by_country') }}) as source_outbound
)

select *
from balance, sources
where abs(balance_inbound  - source_inbound)  > 1
   or abs(balance_outbound - source_outbound) > 1