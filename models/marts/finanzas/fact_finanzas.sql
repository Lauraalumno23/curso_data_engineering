WITH 
vendedores AS(
    SELECT
        vendedores_id,
        first_name,
        last_name,
        salary
    FROM {{ ref("dim_vendedores") }}
),

int_order_items AS(
        SELECT
        order_items_id,
        price_total_order_item,
        vendedores_id
    FROM {{ ref("int_products_items_orders") }}
)

SELECT
    v.vendedores_id,
    v.first_name,
    v.last_name,
    v.salary,
    COUNT(DISTINCT oi.order_items_id) AS TOTAL_ORDER_SELLERS,
    SUM (oi.price_total_order_item) AS TOTAL_SALES_SELLERS
FROM vendedores v
JOIN int_order_items oi 
ON v.vendedores_id = oi.vendedores_id
GROUP BY  
    v.vendedores_id,
    v.first_name,
    v.last_name,
    v.salary
    