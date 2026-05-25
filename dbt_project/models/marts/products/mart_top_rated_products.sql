WITH ranked AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY category ORDER BY average_rating DESC) as rank
    FROM {{ ref('int_products_with_avg_rating') }}
),
top_rated AS (
    SELECT * FROM ranked WHERE rank = 1
)
SELECT * FROM top_rated