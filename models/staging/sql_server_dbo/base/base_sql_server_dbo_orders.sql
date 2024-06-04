{{
  config(
    materialized='view'
  )
}}
with 

src_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_casted as (

    select
        order_id,
        case when shipping_service = '' then 'unknown'
        else shipping_service
        end as shipping_service_bien,
        shipping_cost as shipping_cost_euros,
        address_id,
        convert_timezone('UTC', created_at) as created_at_UTC,
        case when promo_id = '' then md5('unknown')
        else md5(promo_id)
        end as promo_id_hash,
        convert_timezone('UTC', estimated_delivery_at) as estimated_delivery_at_UTC,
        order_cost as order_cost_euros,
        user_id,
        order_total as order_total_euros,
        convert_timezone('UTC', delivered_at) as delivered_at_UTC,
        tracking_id,
        status,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_orders

)

select * from renamed_casted
