with source AS (
    select *
    from {{ref('stg_products')}} p
    inner join {{ref('stg_categories')}} c ON p.category=c.slug
),
transform as (
    select 
        *,
        case when stock<10 then true else false end as is_low_stock,
        round(price-(price*discount_percentage/100),2) as discount_price
    from source
)

select * from transform