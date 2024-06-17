SELECT *
FROM {{ ref('base_sql_server_dbo__orders') }}
WHERE order_cost < 0