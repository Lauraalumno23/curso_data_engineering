SELECT *
FROM {{ ref('stg_sql_server_dbo__users') }}
WHERE updated_at_fecha < created_at_fecha
AND updated_at_hora < created_at_hora