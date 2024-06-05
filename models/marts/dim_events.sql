with src_events as (

    select * from {{ ref('stg_sql_server_dbo__events') }}

),

renamed_casted as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id_hash,
        session_id,
        created_at,
        order_id_hash,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_events

)

select * from renamed_casted