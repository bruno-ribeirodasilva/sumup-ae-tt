{{
    config(
        materialized='view',
        tags=['mart']
    )
}}


with


metrics as (

    select
        device_id
        , device_type_id
        , count(*)        as count_transactions
        , sum(amount_eur) as sum_amount_eur
    from {{ ref('fct_transactions_enriched') }}
    group by 1, 2

)

select
    *
from metrics
