with

    src_users as (select * from {{ ref('stg_sql_server_dbo__users') }}),

    renamed_casted as (

        select
            user_id,
            updated_at_UTC,
            address_id,
            last_name,
            first_name,
            created_at_UTC,
            phone_number,
            total_orders,
            email,
            is_valid_email_address

        from src_users

    )

select *
from renamed_casted