SELECT *
FROM {{ ref('stg_sql_server_dbo_orders') }}
WHERE  status ='preparing' 
    and tracking_id is null
    and delivered_at_hora is null
    and delivered_at_fecha is null
    and estimated_delivery_at_hora is null
    and estimated_delivery_at_fecha is null
    and shipping_service = 'unknown'