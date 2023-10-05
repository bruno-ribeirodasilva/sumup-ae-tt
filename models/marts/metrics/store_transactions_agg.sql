{{
    config(
        materialized='view',
        tags=['mart']
    )
}}


with


fct_transactions_enriched as (

    select 
        *
    from {{ ref('fct_transactions_enriched') }}

)

, first_five_transactions as (

    select
        store_id,
        transaction_happened_at
    from fct_transactions_enriched
    where true
        and store_transaction_rank < 6

)

, time_to_five_transactions as (

    select
        store_id,
        max(transaction_happened_at)-min(transaction_happened_at) as time_to_five_transactions
    from first_five_transactions
    group by 1

)

, metrics as (

    select
        t.store_id
        , t.store_name
        , t.store_address
        , t.store_city
        , t.store_country
        , t.store_created_at
        , t.store_typology
        , t.customer_id
        , tt.time_to_five_transactions      as time_to_five_transactions
        , count(*)                          as count_transactions
        , sum(t.amount_eur)                 as sum_amount_eur
        , avg(t.amount_eur)                 as avg_amount_eur
    from fct_transactions_enriched t
    left join time_to_five_transactions tt
        on t.store_id = tt.store_id
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9

)

select
    *
from metrics
