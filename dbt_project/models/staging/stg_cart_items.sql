WITH source AS (
    SELECT * FROM {{ source('raw', 'cart_items') }}
),

renamed AS (
    SELECT
        cart_id,
        id as product_id,
        title,
        price,
        quantity,
        total,
        discountPercentage as discount_percentage,
        discountedTotal as discounted_total,
        thumbnail
    from source
)

SELECT * FROM renamed