with products as (
    SELECT
    product_id,
    product_title,
    description,
    category,
    price,
    discount_percentage,
    discount_price,
    rating,
    stock,
    is_low_stock,
    brand,
    sku
FROM {{ ref('int_products_enriched') }}
where is_low_stock=true
)
select * from products