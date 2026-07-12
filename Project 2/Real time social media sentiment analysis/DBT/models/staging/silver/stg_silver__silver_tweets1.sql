with source as (

    select *
    from {{ source('silver','silver_tweets') }}

),

renamed as (

    select *

    from source

)

select *
from renamed