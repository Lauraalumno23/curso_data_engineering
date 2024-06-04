{{
  config(
    materialized='view'
  )
}}
with 

src_events as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed_casted as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        case when product_id = '' then null
        else md5(product_id)
        end as product_id_hash,
        session_id,
        created_at,
        case when order_id = '' then null
        else md5(order_id)
        end as order_id_hash,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_events

)

select * from renamed_casted
