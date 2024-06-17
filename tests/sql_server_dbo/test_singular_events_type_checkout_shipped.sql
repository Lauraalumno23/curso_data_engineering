SELECT *
FROM {{ ref('stg_sql_server_dbo__events') }}
WHERE event_type ='checkout'
    and product_id_hash is not null
    and event_type ='package_shipped'