WITH source AS (
    SELECT * FROM {{ source('raw', 'carts') }}
),

renamed AS (
    SELECT
        id as cart_id,
        total,
        discountedTotal as discounted_total,
        userId as user_id,
        totalProducts as total_products,
        totalQuantity as total_quantity
    from source
)

SELECT * FROM renamed