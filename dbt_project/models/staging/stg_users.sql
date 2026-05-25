WITH source AS (
    SELECT * FROM {{ source('raw', 'users') }}
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
        address_country
    from source
)

SELECT * FROM renamed