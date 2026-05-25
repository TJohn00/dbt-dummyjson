with users as (
    select user_id,
        full_name,
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
        university,
        company,
        role,
        city,
        state,
        country
    from {{ref('int_users_with_location')}}
)
select * from users


