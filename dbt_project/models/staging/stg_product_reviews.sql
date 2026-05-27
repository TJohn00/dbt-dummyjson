{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite'
    )
}}


WITH source AS (
    SELECT 
    product_id,
    rating,
    comment,
    CAST(date AS TIMESTAMP) as reviewed_at,
    reviewerName as reviewer_name,
    reviewerEmail as reviewer_email
    FROM {{ source('raw', 'product_reviews') }}
),

renamed AS (
    SELECT * from source
    
    {% if is_incremental() %}
    WHERE reviewed_at > (SELECT MAX(reviewed_at) FROM {{this}})
    {% endif %}
)

SELECT * FROM renamed