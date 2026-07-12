{{ config(materialized='view') }}

SELECT

    tweet_id,
    topic_category,
    sentiment_score,
    positive_score,
    negative_score,
    neutral_score

FROM {{ source('silver','silver_sentiment') }}