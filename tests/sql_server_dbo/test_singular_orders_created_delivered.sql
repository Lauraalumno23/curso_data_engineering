SELECT *
FROM {{ ref('stg_sql_server_dbo_orders') }}
WHERE delivered_at_fecha < created_at_fecha
AND delivered_at_hora < created_at_hora
