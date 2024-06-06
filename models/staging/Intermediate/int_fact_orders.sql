with scr_orders_items_products as (
    select
        o.ORDER_ID,
        o.SHIPPING_SERVICE_ID,
        o.ADDRESS_ID,
        o.CREATED_AT_UTC::date as CREATED_AT_UTC,
        o.PROMO_ID,
        o.ORDER_COST_EUROS,
        o.USER_ID,
        o.ORDER_TOTAL_EUROS,
        o.TRACKING_ID,
        o.STATUS_ID,
        oi.PRODUCT_ID,
        oi.QUANTITY,
        p.PRICE_EURO,
        p.NAME as product_name,
        p.INVENTORY,
        p.PRICE_EURO * oi.QUANTITY AS TOTAL_PRECIO_CANTIDAD
    from 
        {{ ref('stg_sql_server_dbo_orders') }} as o
    left join 
        {{ ref('stg_sql_server_dbo__order_items') }} as oi
        on o.order_id = oi.order_id
    left join 
        {{ ref('stg_sql_server_dbo__products') }} as p
        on oi.product_id = p.product_id
)

select * from scr_orders_items_products
