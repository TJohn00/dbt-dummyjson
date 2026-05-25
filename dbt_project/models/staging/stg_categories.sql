WITH source AS (
    SELECT * FROM {{ source('raw', 'categories') }}
),

renamed AS (
    SELECT
        slug,
        name,
        url
    from source
)

SELECT * FROM renamed