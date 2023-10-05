{{
    config(
        materialized='table',
        tags=['mart']
    )
}}


with


devices as (

    select
        *
    from {{ ref('stg_sumup_devices') }}

)


select
    *
from devices
