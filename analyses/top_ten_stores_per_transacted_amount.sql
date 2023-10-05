select
    store_id
    , store_name
    , sum_amount_eur
from {{ ref('store_transactions_agg') }}
order by total_amount desc
limit 10
