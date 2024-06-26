{{ config(materialized="view") }}
with

    src_users as (select * from {{ source("sql_server_dbo", "users") }}),

    renamed_casted as (

        select
            user_id,
            updated_at,
            address_id,
            last_name,
            first_name,
            created_at,
            phone_number,
            total_orders,
            email,
            _fivetran_deleted,
            _fivetran_synced

        from src_users

    )

select *
from renamed_casted
