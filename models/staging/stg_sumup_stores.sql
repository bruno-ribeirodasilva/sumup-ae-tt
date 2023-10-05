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
    from {{ ref('stores') }}

)

, treated as (

    select 
        id                                                  as store_id
        , name                                              as store_name
        , address                                           as store_address
        , city                                              as store_city
        , country                                           as store_country
        , to_timestamp(created_at, 'MM/DD/YYYY HH12:MI:SS') as store_created_at
        , typology                                          as store_typology
        , customer_id                                       as customer_id
    from source

)


select
    *
from treated
