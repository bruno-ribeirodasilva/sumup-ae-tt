{{
    config(
        materialized='table',
        tags=['stg']
    )
}}


with


source as (

    select
        *
    from {{ source('sumup_data', 'transactions') }}

)

, treated as (

    select 
        id                                                   as transaction_id
        , device_id                                          as device_id
        , product_name                                       as product_name
        , product_sku                                        as product_sku
        , category_name                                      as product_category_name
        , amount                                             as amount_eur
        , status                                             as transaction_status
        , replace(card_number, ' ', '')                      as card_number
        , cvv                                                as card_cvv
        , to_timestamp(created_at, 'MM/DD/YYYY HH12:MI:SS')  as transaction_created_at
        , to_timestamp(happened_at, 'MM/DD/YYYY HH12:MI:SS') as transaction_happened_at
    from source

)


select
    *
from treated
