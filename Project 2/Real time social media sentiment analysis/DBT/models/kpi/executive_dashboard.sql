{{ config(materialized='table') }}

with overall_metrics as (

    select
        count(distinct tweet_id) as total_tweets,
        sum(impressions) as total_impressions,
        sum(likes) as total_likes,
        sum(retweets) as total_retweets,
        sum(replies) as total_replies,
        sum(engagement_count) as total_engagement,

        round(avg(sentiment_score), 3) as avg_sentiment_score,

        round(
            case
                when sum(impressions) > 0
                then sum(engagement_count) * 100.0 / sum(impressions)
                else 0
            end,
            2
        ) as overall_engagement_rate_pct,

    sum(case when sentiment_score > 0 then 1 else 0 end) as positive_tweets,

    sum(case when sentiment_score < 0 then 1 else 0 end) as negative_tweets,

    sum(case when sentiment_score = 0 then 1 else 0 end) as neutral_tweets,

        count(distinct topic_key) as active_topics,
        0 as active_countries,
        count(distinct user_id) as mapped_users

    from {{ ref('fact_social_media') }}

),

top_topic as (

    select
        tp.topic_category as top_topic_by_engagement
    from {{ ref('topic_summary') }} ts
    left join {{ ref('dim_topic') }} tp
        on ts.topic_key = tp.topic_key
    order by ts.total_engagement desc
    limit 1

),

top_country as (

    select
        country as top_country_by_engagement
    from {{ ref('country_summary') }}
    order by total_engagement desc
    limit 1

)

select
    om.*,
    tt.top_topic_by_engagement,
    tc.top_country_by_engagement,
    current_timestamp() as gold_load_time

from overall_metrics om
cross join top_topic tt
cross join top_country tc