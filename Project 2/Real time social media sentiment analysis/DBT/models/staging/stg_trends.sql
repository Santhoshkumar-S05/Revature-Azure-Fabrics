{{ config(materialized='view') }}

SELECT

    topic_category,
    country,
    tweet_volume,
    mention_count,
    trend_score,
    sentiment_index,
    impressions,
    engagement_count

FROM {{ source('silver','silver_trends') }}