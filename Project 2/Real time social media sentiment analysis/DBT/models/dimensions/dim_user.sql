{{ config(
    materialized='table'
) }}

WITH user_data AS (

    SELECT *

    FROM {{ ref('stg_user_metadata') }}

),

final AS (

SELECT

    user_id,

    country,

    topic_category,

    verified,

    account_created_date,

    followers_count,

    following_count,

    likes_count,

    shares_count,

    posts_count

FROM user_data

)

SELECT *
FROM final