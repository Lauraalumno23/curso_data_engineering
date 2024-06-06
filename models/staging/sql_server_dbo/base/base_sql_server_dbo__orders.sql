{{
  config(
    materialized='view'
  )
}}
with 

src_base_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_casted as (

    select
        order_id,
        COALESCE(NULLIF(shipping_service,''),'unknown') AS shipping_service,
        md5(COALESCE(NULLIF(shipping_service,''),'unknown')) AS shipping_service_id,
        shipping_cost as shipping_cost_euros,
        address_id,
        convert_timezone('UTC', created_at) as created_at_UTC,
        COALESCE(NULLIF(promo_id,''),'unknown') AS promo_id,
        convert_timezone('UTC', estimated_delivery_at) as estimated_delivery_at_UTC,
        order_cost as order_cost_euros,
        user_id,
        order_total as order_total_euros,
        convert_timezone('UTC', delivered_at) as delivered_at_UTC,
        COALESCE(NULLIF(tracking_id,''),'unknown') AS tracking_id,
        status,
        md5(status) as status_id,
        case 
            when status = 'delivered' then 2
            when status = 'preparing' then 0
            when status = 'shipped' then 1
            end as status_tipo,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_base_orders

)

select * from renamed_casted
