WITH source AS (
    SELECT 
        ci.cart_id,
        ci.product_id,
        ci.title,
        ci.price,
        ci.quantity,
        ci.total,
        ci.discount_percentage,
        ci.discounted_total,
        p.category,
        p.brand
    FROM {{ ref('stg_cart_items') }} ci 
    INNER JOIN {{ ref('stg_products') }} p ON ci.product_id = p.product_id
)
SELECT * FROM source