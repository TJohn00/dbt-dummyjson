WITH source AS (
    SELECT * FROM {{ source('raw', 'product_reviews') }}
),

renamed AS (
    SELECT
        product_id,
        rating,
        comment,
        CAST(date AS TIMESTAMP) as reviewed_at,
        reviewerName as reviewer_name,
        reviewerEmail as reviewer_email
    from source
)

SELECT * FROM renamed