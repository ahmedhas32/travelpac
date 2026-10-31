select *
from {{ ref('stg_model__first') }}
where year < 2009
   or year > year(TODAY())