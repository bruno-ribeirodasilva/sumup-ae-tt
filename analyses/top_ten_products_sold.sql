select
    product_sku
    , count_transactions
from {{ ref('product_transactions_agg') }}
order by count_transactions desc
limit 10
