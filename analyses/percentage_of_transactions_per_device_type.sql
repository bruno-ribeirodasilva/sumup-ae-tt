select
    device_type_id
    , count_transactions
    , (count_transactions::numeric / sum(count_transactions) over ()) * 100 as percentage
from {{ ref('device_transactions_agg') }}
