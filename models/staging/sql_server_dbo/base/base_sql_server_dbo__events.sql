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
        product_id,
        session_id,
        created_at,
        order_id,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_events

)

select * from renamed_casted
