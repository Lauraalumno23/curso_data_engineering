WITH src_orders AS (
    SELECT order_id,
        count(order_id) as count_orders
    FROM {{ ref('stg_sql_server_dbo_orders') }}
    group by order_id
    ),

src_orders_users AS (
    SELECT user_id,
        count(order_id) as orders_by_users
    FROM {{ ref('stg_sql_server_dbo_orders') }}
    group by user_id
    ),

scr_users AS (
    SELECT user_id,
        count(user_id) as count_users
    FROM 
        {{ ref('stg_sql_server_dbo__users') }}
    group by user_id
),

users AS (
    SELECT *
    FROM 
        {{ ref('stg_sql_server_dbo__users') }}
),

addresses as (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
),

scr_zipcode as (
    SELECT address_id,
        count(distinct zipcode) as count_zipcode
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    group by address_id
),

scr_state as (
    SELECT address_id,
        count(distinct state_id) as count_state
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    group by address_id
),

total_orders_cte AS (
    SELECT 
        COUNT(order_id) AS total_orders
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),


orders as (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_orders') }}
)

SELECT
        o.user_id,
        o.order_id,
        o.shipping_service_id,
        o.address_id as address_order,
        o.promo_id,
        a.zipcode,
        a.state_id,
        u.address_id as address_user,
        so.count_orders,
        su.count_users,
        sou.orders_by_users,
        sz.count_zipcode,
        ss.count_state,
        t.total_orders,
        round(((o.order_cost_euros)/sou.orders_by_users),2) as order_cost_by_user,
        round(((o.order_total_euros)/sou.orders_by_users),2) as order_total_by_user,
        round((order_total_by_user-order_cost_by_user),2) as shipping_cost_by_user,
        round(((t.total_orders)/sou.orders_by_users),2) as total_orders_by_user,
        (t.total_orders/sz.count_zipcode) as total_orders_by_zipcode,
        (t.total_orders/ss.count_state) as total_orders_by_state,
        (o.delivered_at_fecha-o.created_at_fecha) as tiempo_espera_pedido
        
FROM 
    orders o
LEFT JOIN src_orders so
    ON o.order_id = so.order_id
LEFT JOIN src_orders_users sou
    ON o.user_id = sou.user_id
LEFT JOIN scr_users su
    ON o.user_id = su.user_id
LEFT JOIN addresses a
    ON o.address_id = a.address_id
LEFT JOIN users u
    ON o.user_id = su.user_id
LEFT JOIN scr_zipcode sz
    ON o.address_id = sz.address_id
LEFT JOIN scr_state ss
    ON o.address_id = ss.address_id
CROSS JOIN total_orders_cte t