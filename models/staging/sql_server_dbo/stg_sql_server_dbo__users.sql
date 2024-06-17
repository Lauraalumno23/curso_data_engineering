{{ config(materialized="view") }}
with

    src_users as (select * from {{ ref("base_sql_server_dbo__users") }}
    
    ),

    renamed_casted as (

        select
            user_id,
            to_date(updated_at) AS updated_at_fecha,
            to_time(updated_at) AS updated_at_hora,
            {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_id,
            last_name,
            first_name,
            to_date(created_at) AS created_at_fecha,
            to_time(created_at) AS created_at_hora,
            phone_number,
            total_orders,
            email,
            COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

        from src_users

    )

select *
from renamed_casted
