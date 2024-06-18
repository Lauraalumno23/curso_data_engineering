with 

src_orders as (

    select * from {{ ref('stg_sql_server_dbo_orders') }}

),

renamed_casted as (
select
        o.order_id,
        o.shipping_service_id,
        o.shipping_cost_euros,
        o.address_id,
        o.promo_id,
        o.user_id,
        o.tracking_id,
        p.product_id,
        o.status_orders_id,
        p.quantity,
        o.order_cost_euros,
        o.order_total_euros,
        o.created_at_fecha,
        o.created_at_hora,
        o.estimated_delivery_at_fecha,
        o.estimated_delivery_at_hora,
        o.delivered_at_fecha,
        o.delivered_at_hora,
        o.vendedores_id,
        t.total_orders,
        t.order_cost_by_user,
        t.order_total_by_user,
        t.shipping_cost_by_user,
        t.total_orders_by_user,
        t.total_orders_by_zipcode,
        t.total_orders_by_state,
        t.tiempo_espera_pedido,
        p.item_per_order,
        p.price_product,
        p.shipping_cost_by_item_euros,
        p.order_cost_by_item_euros,
        p.total_order_by_item_euros,
        p.price_per_order,
        p.order_cost_and_shipping_by_item_euros,
        p.total_discount_by_item_euros

from {{ ref('stg_sql_server_dbo_orders') }} o
left join {{ ref('int_users_orders_addresses') }} t
on o.order_id = t.order_id
left join {{ ref('int_products_items_orders') }} p
on o.order_id = p.order_id
)
select * from renamed_casted

