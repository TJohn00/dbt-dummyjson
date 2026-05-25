with gender_demographics as (
    select
        gender,
        count(gender) as gender_count
    from {{ref('int_users_with_location')}}
    group by gender
)
select * from gender_demographics


