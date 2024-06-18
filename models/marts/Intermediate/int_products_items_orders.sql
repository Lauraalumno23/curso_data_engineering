WITH src_items_orders AS (
    SELECT order_id,
        count(*) as item_per_order
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    group by order_id
    ),

order_items AS (
    SELECT 
        order_id,
        quantity,
        product_id
    FROM 
        {{ ref('stg_sql_server_dbo__order_items') }}
),

products as (
    SELECT price_euro,
    product_id
    FROM {{ ref('stg_sql_server_dbo__products') }}
),

orders as (
    SELECT order_id,
    promo_id,
    order_total_euros,
    order_cost_euros,
    shipping_cost_euros, 
    user_id,
    address_id
    FROM {{ ref('stg_sql_server_dbo_orders') }}
)

SELECT
        oi.order_id,
        o.user_id,
        o.address_id,
        o.order_total_euros,
        oi.quantity,
        oi.product_id,
        soi.item_per_order,
        p.price_euro AS price_product,
        round (o.shipping_cost_euros/soi.item_per_order,2)as shipping_cost_by_item_euros,
        round ((oi.quantity*p.price_euro)/soi.item_per_order,2) as order_cost_by_item_euros,
        round ((o.order_total_euros/soi.item_per_order),2) as total_order_by_item_euros,
        round (sum(oi.quantity/p.price_euro)over(partition by oi.order_id),2) as price_per_order,        
        round ((p.price_euro * oi.quantity) + (o.shipping_cost_euros / soi.item_per_order),2) AS order_cost_and_shipping_by_item_euros,
        round (((o.order_total_euros/soi.item_per_order)-(oi.quantity*p.price_euro)/soi.item_per_order)-(o.shipping_cost_euros/soi.item_per_order),2) as total_discount_by_item_euros

FROM 
    order_items oi
LEFT JOIN src_items_orders soi 
    ON oi.order_id = soi.order_id
LEFT JOIN products p 
    ON oi.product_id = p.product_id
LEFT JOIN orders o 
    ON o.order_id = oi.order_id