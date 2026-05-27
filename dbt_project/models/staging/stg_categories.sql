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
    SELECT s.* FROM {{ source('raw', 'categories') }} s
    JOIN max_loaded m ON s.LOADED_AT > m.max_loaded_at
),

renamed AS (
    SELECT
        slug,
        name,
        url,
        LOADED_AT AS loaded_at
    from source
)

SELECT * FROM renamed