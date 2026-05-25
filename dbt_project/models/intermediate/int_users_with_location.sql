with transform as (
    select 
        user_id,
        concat(first_name,' ',last_name) as full_name,
        maiden_name,
        age,
        gender,
        email,
        phone,
        username,
        birth_date,
        image,
        blood_group,
        height,
        weight,
        eye_color,
        hair,
        ip,
        mac_address,
        university,
        company,
        ein,
        user_agent,
        role,
        address_city as city,
        address_state as state,
        address_country as country
    from {{ref('stg_users')}}
)

select * from transform