{{
    config(
        materialized='incremental',
        tags=['mart']
    )
}}


with


transactions as (

    select
        *
    from {{ ref('stg_sumup_transactions') }}

    {% if is_incremental() %}
        where transaction_created_at > (select max(transaction_created_at) from {{ this }})
    {% endif %}

)

, stores as (

    select 
        *
    from {{ ref('stg_sumup_stores') }}

)

, devices as (

    select 
        *
    from {{ ref('stg_sumup_devices') }}

)

, transactions_with_devices as (

        select
            t.*
            , d.device_type_id
            , d.store_id
        from transactions t
        left join devices d
            on t.device_id = d.device_id

    )

, combined as (

        select
            t.*
            , s.store_name
            , s.store_address
            , s.store_city
            , s.store_country
            , s.store_created_at
            , s.store_typology
            , s.customer_id
            , row_number() over (partition BY s.store_id order by t.transaction_happened_at) as store_transaction_rank
        from transactions_with_devices t
        left join stores s
            on t.store_id = s.store_id

    )

select
    *
from combined
