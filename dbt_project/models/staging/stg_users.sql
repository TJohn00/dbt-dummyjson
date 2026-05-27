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
    SELECT s.* FROM {{ source('raw', 'users') }} s
    JOIN max_loaded m ON s.LOADED_AT > m.max_loaded_at
),

renamed AS (
    SELECT
        id as user_id,
        firstName as first_name,
        lastName as last_name,
        maidenName as maiden_name,
        age,
        gender,
        email,
        phone,
        username,
        CAST(birthDate AS DATE) as birth_date,
        image,
        bloodGroup as blood_group,
        height,
        weight,
        eyeColor as eye_color,
        hair,
        ip,
        macAddress as mac_address,
        university,
        company,
        ein,
        userAgent as user_agent,
        role,
        address_city,
        address_state,
        address_country,
        LOADED_AT AS loaded_at
    from source
)

SELECT * FROM renamed