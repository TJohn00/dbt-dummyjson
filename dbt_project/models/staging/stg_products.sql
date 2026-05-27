{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite'
    )
}}
WITH max_loaded AS (
    {% if is_incremental() %}
        SELECT MAX(LOADED_AT) AS max_loaded_at FROM {{ this }}
    {% else %}
        SELECT CAST('2026-01-01' AS TIMESTAMP) AS max_loaded_at
    {% endif %}
),
 source AS (
    SELECT s.* FROM {{ source('raw', 'products') }} s
    JOIN max_loaded m ON s.LOADED_AT > m.max_loaded_at
),

renamed AS (
    SELECT
        id AS product_id,
        title AS product_title,
        description,
        category,
        price,
        discountPercentage AS discount_percentage,
        rating,
        stock,
        tags,
        brand,
        sku,
        weight,
        dimensions,
        warrantyInformation AS warranty_information,
        shippingInformation as shipping_information,
        availabilityStatus as availability_status,
        returnPolicy as return_policy,
        minimumOrderQuantity as minimum_order_quantity,
        meta,
        images,
        thumbnail,
        LOADED_AT AS loaded_at
    from source
)

SELECT * FROM renamed