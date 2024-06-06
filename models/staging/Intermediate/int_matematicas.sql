with scr_matematicas as (
    select
        o.ORDER_ID,
        oi.PRODUCT_ID,
        o.USER_ID,
        p.NAME as product_name,
        o.ORDER_COST_EUROS,
        o.ORDER_TOTAL_EUROS,
        p.PRICE_EURO * oi.QUANTITY AS TOTAL_PRECIO_CANTIDAD,
        oi.QUANTITY,
        p.PRICE_EURO,
        pr.DISCOUNT,
        t.shipping_cost_euros
    from 
        {{ ref('stg_sql_server_dbo_orders') }} as o
    left join 
        {{ ref('stg_sql_server_dbo__order_items') }} as oi
        on o.order_id = oi.order_id
    left join 
        {{ ref('stg_sql_server_dbo__products') }} as p
        on oi.product_id = p.product_id
    left join 
        {{ ref('stg_sql_server_dbo__promos') }} as pr
        on o.promo_id = pr.promo_id
    left join 
        {{ ref('stg_sql_server_dbo__tracking') }} as t
        on o.tracking_id = t.tracking_id
    left join 
        {{ ref('stg_google_sheets__budget') }} as b
        on oi.product_id = b.product_id
)

select * from scr_matematicas