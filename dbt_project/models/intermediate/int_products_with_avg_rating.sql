with source as (
    select 
    product_id,
    count(*) as review_count,
    round(avg(rating),1) as average_rating
    from {{ref('stg_product_reviews')}}
    group by (product_id)

),
transform as (
    select 
    p.*,
    r.review_count,
    r.average_rating
    from source r 
    inner join {{ref('stg_products')}} p ON r.product_id=p.product_id
)

select * from transform