with source as (
    select * from {{ref('stg_cart_items')}} c inner join  {{ref('stg_products')}} p ON c.product_id=p.product_id
)

select * from source