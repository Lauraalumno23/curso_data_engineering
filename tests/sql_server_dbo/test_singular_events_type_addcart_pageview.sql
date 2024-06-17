SELECT *
FROM {{ ref('stg_sql_server_dbo__events') }}
WHERE event_type ='add_to_cart'
    and order_id_hash is not null
    and event_type ='page_view'