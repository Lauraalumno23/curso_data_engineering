SELECT *
FROM {{ ref('stg_sql_server_dbo_orders') }}
WHERE estimated_delivery_at_fecha < created_at_fecha
AND estimated_delivery_at_hora < created_at_hora