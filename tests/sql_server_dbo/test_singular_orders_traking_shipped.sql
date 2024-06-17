SELECT *
FROM {{ ref('stg_sql_server_dbo_orders') }}
WHERE  status='shipped' 
    and delivered_at_hora is not null
    and delivered_at_fecha is not null