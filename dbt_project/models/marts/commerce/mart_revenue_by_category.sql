with products as (
    SELECT
    category,
    SUM(total) as revenue,
    COUNT(product_id) as items_sold
FROM {{ ref('int_cart_items_with_product') }}
group by category
)
select * from products