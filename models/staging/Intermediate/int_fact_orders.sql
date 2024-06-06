with scr_orders_items_products as (
    select
        o.ORDER_ID,
        o.SHIPPING_SERVICE_ID,
        o.ADDRESS_ID,
        o.CREATED_AT_UTC,
        o.PROMO_ID,
        o.ORDER_COST_EUROS,
        o.USER_ID,
        o.ORDER_TOTAL_EUROS,
        o.TRACKING_ID,
        o.STATUS_ID,
        o._FIVETRAN_DELETED as order_fivetran_deleted,
        o._FIVETRAN_SYNCED_UTC as order_fivetran_synced_utc,
        oi.PRODUCT_ID,
        oi.QUANTITY,
        oi._FIVETRAN_DELETED as order_items_fivetran_deleted,
        oi._FIVETRAN_SYNCED_UTC as order_items_fivetran_synced_utc,
        p.PRICE_EURO,
        p.NAME as product_name,
        p.INVENTORY,
        p._FIVETRAN_DELETED as products_fivetran_deleted,
        p._FIVETRAN_SYNCED_UTC as products_fivetran_synced_utc
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
