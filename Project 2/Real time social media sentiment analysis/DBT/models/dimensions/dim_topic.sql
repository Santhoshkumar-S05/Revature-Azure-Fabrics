{{ config(
    materialized='table'
) }}

WITH topic_data AS (

    SELECT DISTINCT
        topic_category
    FROM {{ ref('stg_user_metadata') }}
    WHERE topic_category IS NOT NULL
      AND UPPER(REPLACE(TRIM(topic_category), '"', '')) <> 'NAN'

),

final AS (

SELECT
    ROW_NUMBER() OVER (ORDER BY topic_category) AS topic_key,
    topic_category
FROM topic_data

)

SELECT *
FROM final