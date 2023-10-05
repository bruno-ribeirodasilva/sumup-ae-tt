select
  store_id
  , store_name
  , avg(time_to_five_transactions) as average_time_to_five_transactions
from {{ ref('store_transactions_agg') }}
where true
    time_to_five_transactions is not null
group by 1, 2
