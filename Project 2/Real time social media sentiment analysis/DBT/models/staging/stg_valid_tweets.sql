{{ config(materialized='view') }}

SELECT

    tweet_id,
    topic_category,
    tweet_text,
    tweet_timestamp,
    impressions,
    likes,
    retweets,
    replies,
    engagement_count,
    sentiment_score

FROM {{ source('silver','silver_valid_tweets') }}