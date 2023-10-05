{{
    config(
        materialized='table',
        tags=['mart']
    )
}}


with


stores as (

    select
        *
    from {{ ref('stg_sumup_stores') }}

)


select
    *
from stores
