
with 

src_events as (

    select * from {{ ref('stg_sql_server_dbo__events') }}

),

renamed_casted as (

    select
        event_id,
        event_type_id,
        page_url,
        user_id,
        session_id,
        product_id_hash,
        order_id_hash,
        created_at_fecha,
        created_at_hora,
        _fivetran_deleted,
        _fivetran_synced_UTC
        
        

    from src_events

)

select * from renamed_casted