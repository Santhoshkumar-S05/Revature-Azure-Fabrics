{{ config(materialized='table') }}

select
    u.country,

    count(distinct f.tweet_id) as total_tweets,
    sum(f.impressions) as total_impressions,
    sum(f.likes) as total_likes,
    sum(f.retweets) as total_retweets,
    sum(f.replies) as total_replies,
    sum(f.engagement_count) as total_engagement,

    round(avg(f.sentiment_score), 3) as avg_sentiment_score,

    round(
        case
            when sum(f.impressions) > 0
            then sum(f.engagement_count) * 100.0 / sum(f.impressions)
            else 0
        end,
        2
    ) as engagement_rate_pct,

    sum(case when f.sentiment_score > 0 then 1 else 0 end) as positive_tweets,
    sum(case when f.sentiment_score < 0 then 1 else 0 end) as negative_tweets,
    sum(case when f.sentiment_score = 0 then 1 else 0 end) as neutral_tweets,

    current_timestamp() as gold_load_time

from {{ ref('fact_social_media') }} f

left join {{ ref('dim_user') }} u
    on f.user_id = u.user_id

group by
    u.country