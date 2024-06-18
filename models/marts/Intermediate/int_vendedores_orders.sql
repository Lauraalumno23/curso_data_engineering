WITH src_items_orders AS (
    SELECT order_id,
        count(*) as item_per_order
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    group by order_id
    ),

order_items AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    ),

vendedores as (
    SELECT vendedores_id,
    salary,
    address_id
    FROM {{ ref('stg_sql_server_dbo__vendedores') }}
),

sales_summary as (
    SELECT o.vendedores_id,
    sum(oi.quantity) as total_products_sold
    FROM    {{ ref('stg_sql_server_dbo_orders') }} o
    LEFT JOIN {{ ref('stg_sql_server_dbo__order_items') }} oi
        ON o.order_id = oi.order_id
    group by o.vendedores_id
),

orders as (
    SELECT order_id,
    promo_id,
    order_total_euros,
    order_cost_euros,
    shipping_cost_euros, 
    user_id,
    address_id,
    vendedores_id
    FROM {{ ref('stg_sql_server_dbo_orders') }}
)

SELECT
    o.order_id,
    o.address_id as address_pedido,
    o.promo_id,
    o.vendedores_id,
    oi.product_id,
    oi.quantity,
    v.salary,
    v.address_id as address_vendedor,
    soi.item_per_order,
    ss.total_products_sold
FROM orders o
LEFT JOIN vendedores v
    ON o.vendedores_id = v.vendedores_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN src_items_orders soi
    ON o.order_id = soi.order_id
LEFT JOIN sales_summary ss
    ON o.vendedores_id = ss.vendedores_id