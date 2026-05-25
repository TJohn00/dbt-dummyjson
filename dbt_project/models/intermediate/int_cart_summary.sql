with source as (
    select 
    cart_id,
    round(sum(total),0) as total,
    sum(quantity) as quantity,
    count(product_id) as item_count
    from {{ref('stg_cart_items')}}
    group by cart_id
)
select * from source