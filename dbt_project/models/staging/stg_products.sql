WITH source AS (
    SELECT * FROM {{ source('raw', 'products') }}
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
        thumbnail
    from source
)

SELECT * FROM renamed