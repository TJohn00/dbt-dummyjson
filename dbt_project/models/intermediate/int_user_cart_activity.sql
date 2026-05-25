with carts as (
    select * from {{ref('stg_carts')}}
),
users AS (
    SELECT * FROM {{ ref('stg_users') }}
),
cart_summary AS (
    SELECT * FROM {{ ref('int_cart_summary') }}
),
joined AS (
    select
    u.user_id,
    u.first_name,
    u.last_name,
    c.cart_id,
    cs.total
    from users u
    inner join carts c on c.user_id=u.user_id
    inner join cart_summary cs on cs.cart_id=c.cart_id
)
select * from joined