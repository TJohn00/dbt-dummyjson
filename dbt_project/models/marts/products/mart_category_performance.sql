with category as(SELECT
    category,
    COUNT(product_id)        as total_products,
    ROUND(AVG(price), 2)     as avg_price,
    ROUND(AVG(rating), 2)    as avg_rating,
    SUM(stock)               as total_stock
FROM {{ ref('int_products_enriched') }}
GROUP BY category)

select * from category