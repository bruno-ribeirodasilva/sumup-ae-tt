{{ config(
    materialized='table',
    tags=['mart']
) }}

with

source as (
    select
        *
    from {{ source('sumup_data', 'transactions') }}
)

select
    distinct
        product_sku
        , product_name
        , category_name
from source
