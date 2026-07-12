{{ config(materialized='table') }}

with countries as (

    select distinct
        country
    from {{ ref('stg_user_metadata') }}
    where country is not null

    union

    select distinct
        country
    from {{ ref('stg_trends') }}
    where country is not null

)

select
    row_number() over (order by country) as country_key,
    country
from countries