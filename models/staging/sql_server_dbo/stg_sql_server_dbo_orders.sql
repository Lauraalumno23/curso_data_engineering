{{
  config(
    materialized='view'
  )
}}
with 

src_orders as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed_casted as (

    select
        order_id,
        COALESCE(NULLIF(shipping_service,''),'unknown') AS shipping_service,
        {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} as shipping_service_id,
        shipping_cost as shipping_cost_euros,
        address_id,
        to_date(created_at) AS created_at_fecha,
        to_time(created_at) AS created_at_hora,
        COALESCE(NULLIF(promo_id,''),'unknown') AS promo_id,
        to_date(estimated_delivery_at) AS estimated_delivery_at_fecha,
        to_time(estimated_delivery_at) AS estimated_delivery_at_hora,
        order_cost as order_cost_euros,
        user_id,
        order_total as order_total_euros,
        to_date(delivered_at) AS delivered_at_fecha,
        to_time(delivered_at) AS delivered_at_hora,
        COALESCE(NULLIF(tracking_id,''),'unknown') AS tracking_id,
        status,
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_orders_id,
        {{ dbt_utils.generate_surrogate_key(['vendedores_id']) }} as vendedores_id,
        case 
            when status = 'delivered' then 2
            when status = 'preparing' then 0
            when status = 'shipped' then 1
            end as status_tipo,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_orders

)

select * from renamed_casted

