with products as (
    SELECT
    user_id,
    first_name,
    last_name,
    SUM(total) as lifetime_spend
FROM {{ ref('int_user_cart_activity') }}
group by user_id,first_name,last_name
)
select * from products