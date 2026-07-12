{{ config(materialized='view') }}

SELECT

    tweet_id,

    CAST(CAST(user_id AS DOUBLE) AS BIGINT) AS user_id,

    tweet_text,

    timestamp_1,

    tweet_date,

    likes,

    retweets,

    replies,

    impressions,

    engagement

FROM {{ source('silver','silver_tweets') }}