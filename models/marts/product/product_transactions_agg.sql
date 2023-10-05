{{
    config(
        materialized='view',
        tags=['mart']
    )
}}


with


metrics as (

    select
        product_name
        , product_sku
        , product_category_name
        , count(*)        as count_transactions
        , sum(amount_eur) as sum_amount_eur
    from {{ ref('transactions_enriched') }}
    group by 1, 2, 3

)

select
    *
from metrics
