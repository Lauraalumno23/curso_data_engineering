{{
  config(
    materialized='view'
  )
}}
with 

src_events as (

    select * from {{ ref('base_sql_server_dbo__events') }}

    

),

renamed_casted as (

    select
        event_id,
        page_url,
        {{ dbt_utils.generate_surrogate_key(['event_type']) }} as event_type_id,
        event_type,
        user_id,
        case when product_id = '' then null
        else {{ dbt_utils.generate_surrogate_key(['product_id']) }}
        end as product_id_hash,
        session_id,
        to_date(created_at) AS created_at_fecha,
        to_time(created_at) AS created_at_hora,
        case when order_id = '' then null
        else {{ dbt_utils.generate_surrogate_key(['order_id']) }}
        end as order_id_hash,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC
        
        

    from src_events

)

select * from renamed_casted
