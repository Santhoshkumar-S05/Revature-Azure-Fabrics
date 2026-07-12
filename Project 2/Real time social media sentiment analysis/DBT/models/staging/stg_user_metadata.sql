{{ config(materialized='view') }}

SELECT
    CAST(TRY_CAST(user_id AS DOUBLE) AS BIGINT) AS user_id,
    country,

    CASE
        WHEN UPPER(REPLACE(TRIM(topic_category), '"', '')) = 'NAN' THEN NULL
        ELSE UPPER(TRIM(topic_category))
    END AS topic_category,

    verified,
    account_created_date,
    followers_count,
    following_count,
    likes_count,
    shares_count,
    posts_count

FROM {{ source('silver','silver_user_metadata') }}

WHERE TRY_CAST(user_id AS DOUBLE) IS NOT NULL