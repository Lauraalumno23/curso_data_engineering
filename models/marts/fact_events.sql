with 

src_events as (

    select * from {{ ref('stg_sql_server_dbo__events') }}

)


    select
        event_id,
        page_url,
        event_type_id,
        user_id,
        product_id_hash,
        session_id,
        created_at,
        order_id_hash

    from src_events
