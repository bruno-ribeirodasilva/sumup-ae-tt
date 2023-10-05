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
    from {{ ref('devices') }}

)

, treated as (

    select 
        id         as device_id
        , type     as device_type_id
        , store_id as store_id
    from source

)


select
    *
from treated
