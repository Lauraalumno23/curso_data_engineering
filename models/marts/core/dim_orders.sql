
with 

src_orders as (

    select * from {{ ref('stg_sql_server_dbo_orders') }}

),

renamed_casted as (

    select
        order_id,
        shipping_service_id,
        shipping_cost_euros,
        address_id,
        promo_id,
        user_id,
        tracking_id,
        status_orders_id,
        order_cost_euros,
        order_total_euros,
        created_at_fecha,
        created_at_hora,
        estimated_delivery_at_fecha,
        estimated_delivery_at_hora,
        delivered_at_fecha,
        delivered_at_hora,
        vendedores_id,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_orders

)

select * from renamed_casted