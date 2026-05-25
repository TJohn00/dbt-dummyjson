with sales as (
    SELECT
    count(cart_id) as total_orders,
    sum(total) as total_revenue,
    ROUND(AVG(total), 2) as avg_order_value
FROM {{ ref('int_cart_summary') }}
)
select * from sales