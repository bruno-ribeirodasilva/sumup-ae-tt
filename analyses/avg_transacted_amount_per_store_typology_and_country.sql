select
    store_typology
    , store_country
    , avg_amount_eur
from {{ ref('store_transactions_agg') }}
