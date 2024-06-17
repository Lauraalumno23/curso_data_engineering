
with

    src_users as (select * from {{ ref('stg_sql_server_dbo__users') }}
    
    ),

    renamed_casted as (

        select
            user_id,
            first_name,
            last_name,
            address_id,
            phone_number,
            email,
            created_at_fecha,
            created_at_hora,
            updated_at_fecha,
            updated_at_hora,
            total_orders,
            _fivetran_deleted,
            _fivetran_synced_UTC

        from src_users

    )

select *
from renamed_casted