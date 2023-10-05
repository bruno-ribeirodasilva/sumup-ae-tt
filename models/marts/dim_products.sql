{{ config(
    materialized='table',
    tags=['mart']
) }}

with

source as (
    select
        *
    from {{ ref('stg_sumup_transactions') }}
)

select
    distinct
        product_sku
        , product_name
        , product_category_name
from source
