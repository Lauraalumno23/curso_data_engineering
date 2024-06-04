{{ config(materialized="view") }}
with

    src_users as (select * from {{ source("sql_server_dbo", "users") }}),

    renamed_casted as (

        select
            user_id,
            convert_timezone('UTC', updated_at) as updated_at_UTC,
            address_id,
            last_name,
            first_name,
            convert_timezone('UTC', created_at) as created_at_UTC,
            phone_number,
            total_orders,
            email,
            coalesce(
                regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
                = true,
                false
            ) as is_valid_email_address,
            COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

        from src_users

    )

select *
from renamed_casted
